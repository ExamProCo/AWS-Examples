require 'em/pure_ruby'
require 'appium_lib_core'
require 'test/unit'

CAPABILITIES = {
  platformName: 'Android',
  automationName: 'UiAutomator2',
  deviceName: 'Android',
  appPackage: 'co.exampro.helloworld',
  appActivity: 'co.exampro.helloworld.MainActivity',
  language: 'en',
  locale: 'US'
}

SERVER_URL = 'http://localhost:4723'

class AppiumTest < Test::Unit::TestCase
  def setup
    @core = ::Appium::Core.for(capabilities: CAPABILITIES)
    @driver = @core.start_driver(server_url: SERVER_URL)
  end

  def teardown
    @driver&.quit
  end

  def wait_for_element(accessibility_id, timeout: 2)
    wait = Selenium::WebDriver::Wait.new(timeout: timeout)
    wait.until { @driver.find_element(:id, accessibility_id) }
  end

  def test_click_button_world
    # Wait for the button, click it, then check the text
    wait_for_element('button_world').click
    changed_text_element = wait_for_element('text_hello')
    assert_equal("Hello World!", changed_text_element.text, "Text did not change to 'Hello World!' as expected.")
  end
end
