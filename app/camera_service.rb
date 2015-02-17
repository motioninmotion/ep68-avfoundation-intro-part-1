class CameraService
  attr_reader :preview_layer

  def initialize
    configure
    start
  end

  def session
    @session ||= AVCaptureSession.new
  end

  private

  def start
    session.startRunning
  end

  def configure
    session.beginConfiguration

    if session.canSetSessionPreset(AVCaptureSessionPresetHigh)
      session.sessionPreset = AVCaptureSessionPresetHigh
    end

    acceptableVideoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).select do |device|
      device.position == AVCaptureDevicePositionBack
    end

    if acceptableVideoDevices.count > 0
      input = AVCaptureDeviceInput.deviceInputWithDevice(acceptableVideoDevices.first, error: nil)

      session.addInput(input) if session.canAddInput(input)
    end

    @preview_layer = AVCaptureVideoPreviewLayer.alloc.initWithSession(session)

    session.commitConfiguration
  end
end
