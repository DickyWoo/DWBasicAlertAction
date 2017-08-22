Pod::Spec.new do |s|
  s.name         = "DWBasicAlertAction"
  s.version      = "1.0.1"
  s.summary      = "A Library for iOS to use for show alert, automatic choose UIAlert And UIActionSheet below iOS8.0, otheriwse choose UIAlertViewController."
  s.description  = "A Library for iOS to use for show alert, automatic choose UIAlert And UIActionSheet below iOS8.0, otheriwse choose UIAlertViewController.系统弹窗，根据版本自动选择调用UIAlertView、UIActionSheet还是UIAlertController."
  s.homepage     = "https://github.com/DickyWoo/DWBasicAlertAction"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" } 
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author       = { "DickyWoo" => "https://github.com/DickyWoo" }
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios
  s.platform     = :ios, "6.0"
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/wujiandongxq/DWBasicAlertAction.git", :tag => "#{s.version}" }
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "DWBasicAlertAction/*.{h,m}"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true
end
