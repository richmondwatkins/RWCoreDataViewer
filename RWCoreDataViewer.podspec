Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "RWCoreDataViewer"
  s.version      = "0.0.9"
  s.authors      = "Richmond Watkins"
  s.summary      = "Simple, in app, core data viewer"
  s.homepage      = "http://www.richmondwatkins.com"
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/richmondwatkins/RWCoreDataViewer.git", :tag => "#{s.version}" }


 s.ios.deployment_target = '8.0'
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "RWCoreDataViewer/**/*.{swift}"

  s.resources = "RWCoreDataViewer/**/*.{png,jpeg,jpg,storyboard,xib,lproj,xcdatamodeld,plist,xcassets}"

end

