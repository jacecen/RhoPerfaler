class String

  def inside_html(label)
    closeLabel = label[0, 1] + "/" + label[1, label.length]
    content = self
    if content.end_with?(closeLabel)
      content = content[0, content.length - closeLabel.length]
    end
    if content.end_with?("\n")
      content = content[0, content.length - 1]
    end
    if content.start_with?(label)
      content = content[label.length, content.length]
    end
    return content
  end
end

module BrowserHelper

  def placeholder(label=nil)
    "placeholder='#{label}'" if platform == 'apple'
  end

  def platform
    System::get_property('platform').downcase
  end

  def selected(option_value,object_value)
    "selected=\"yes\"" if option_value == object_value
  end

  def checked(option_value,object_value)
    "checked=\"yes\"" if option_value == object_value
  end

  def is_bb6
    platform == 'blackberry' && (Rho::System.getProperty('os_version').split('.')[0].to_i >= 6)
  end
end