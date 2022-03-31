Pod::Spec.new do |s|
  s.name             = 'CUID-Swift5'
  s.version          = '1.0.0'
  s.summary          = 'Collision resistent UUID'
  s.description      = 'A Swift 5 port of the javascript CUID package.'
  s.homepage         = 'https://github.com/LucasAssisRo/cuid'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas Assis Rodrigues' => 'lucas.assis.ro@gmail.com' }
  s.source           = { :git => 'https://github.com/LucasAssisRo/cuid.git', :tag => s.version.to_s }

  s.swift_versions = ['5.0']
  s.ios.deployment_target = '10.0'
  s.source_files = 'Sources/CUID/**/*'
end
