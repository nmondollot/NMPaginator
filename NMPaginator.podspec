Pod::Spec.new do |s|
  s.name         = "NMPaginator"
  s.version      = "1.1.0"
  s.summary      = "NMPaginator is a simple Objective-C class that handles pagination for you."
  s.homepage     = "http://www.nicolasmondollot.com"
 
  s.license      = {
		:type => 'Free',
		:text => <<-LICENSE
				Do whatever you want with this piece of code (commercially or free). Attribution would be nice though.
	LICENSE
	}
  s.author       = "Nicolas Mondollot"

  s.source       = { :git => "https://github.com/nmondollot/NMPaginator.git", :tag => "1.1.0" }

  s.platform     = :ios, '6.0'

  s.source_files = 'NMPaginator/NMPaginator'
  s.requires_arc = true

end
