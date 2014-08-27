Pod::Spec.new do |s|
  s.name         = 'MHNotificationHelper'
  s.version      = '0.9'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/mariohahn/MHNotificationHelper'
  s.author = {
    'Mario Hahn' => 'mario_hahn@me.com'
  }
  s.summary      = 'ViewController to describe the User how to turn on the Notifications.'
  s.platform     =  :ios
  s.source = {
    :git => 'https://github.com/mariohahn/MHNotificationHelper.git',
    :tag => 'v0.9'
  }

  s.dependency "Masonry"

  s.resources = "MHNotificationHelper/MHNotificationHelper/**/*.png"

  s.source_files = ['MHNotificationHelper/MHNotificationHelper/**/*.{h,m}']
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
end