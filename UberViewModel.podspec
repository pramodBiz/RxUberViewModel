Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "UberViewModel"
s.summary = "UberViewModel lets a user select an ice cream flavor."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Pramod Biz" => "pramod@biz4solutions.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/pramodBiz/RxUberViewModel"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/pramodBiz/RxUberViewModel.git",
:tag => "0.1.0" }

# 7
s.framework = "UIKit"
s.dependency 'UberRides', '~> 0.11'
s.dependency 'RxSwift',    '~> 4.0'
s.dependency 'RxCocoa',    '~> 4.0'

# 8
#s.source_files = "*UberViewModel/*.{swift}"


# 10
s.swift_version = "4.2"

end
