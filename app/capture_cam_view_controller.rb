class CaptureCamViewController < UIViewController
  def viewDidAppear(animated)
    super
    @cam_service = CameraService.new
    @cam_service.preview_layer.frame = view.frame
    view.layer.addSublayer(@cam_service.preview_layer)
  end

  def viewDidLayoutSubviews
    if @cam_service
      @cam_service.preview_layer.frame = view.frame
    end
  end
end
