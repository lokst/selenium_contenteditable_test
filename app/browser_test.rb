require 'capybara'
require 'capybara/dsl'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'os'

Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:3000'
Capybara.run_server = false
Capybara.save_path = "tmp"

include Capybara::DSL

visit '/test.html'
sleep(5)
element = find("div", :id => "myeditablediv1")
if OS.mac?
    element.send_keys("mac OS detected")
    element.send_keys [:meta, :shift, :arrow_left]
else
    element.send_keys("Linux OS detected")
    element.send_keys [:shift, :home]
end
print("Sent keys to editable div")
screenshot_and_save_page
sleep(10)

element = find("input", :id => "mytextfield1")
if OS.mac?
    element.send_keys("mac OS detected")
    element.send_keys [:meta, :shift, :arrow_left]
else
    element.send_keys("Linux OS detected")
    element.send_keys [:shift, :home]
end
print("Sent keys to text field")
screenshot_and_save_page
sleep(10)