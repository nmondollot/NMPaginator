Pod::Spec.new do |s|
  s.name = "NMPaginator"
  s.version = "1.0.0"
  s.summary = "NMPaginator is a simple Objective-C class that handles pagination for you."
  s.homepage = "https://github.com/nmondollot/NMPaginator"
  s.license = {
    :type=>'Free',
    :text =>'              Do whatever you want with this piece of code (commercially or free). Attribution would be nice though.\n'
  }
  s.authors  = "Nicolas Mondollot"
  s.source ={
    :git=> "https://github.com/nmondollot/NMPaginator.git",
    :tag=> "1.0.0"
  }
  s.platforms = {
    "ios" => null
  }
  s.frameworks = [
    "Foundation",
    "UIKit",
    "CoreGraphics"
  ]
  s.source_files = "NMpaginator/NMpaginator.{m,h}"
  s.requires_arc = false
end
