require 'capybara/mechanize'
require 'capybara/rspec'

Capybara.app = proc do
  ['200', { 'Content-Type' => 'text/html' }, ['This is a dummy app.']]
end
Capybara.default_driver = :mechanize
if ENV.include?('HTTP_PROXY')
  driver = Capybara.current_session.driver
  proxy = URI.parse(ENV.fetch('HTTP_PROXY'))
  driver.browser.agent.set_proxy(proxy.host, proxy.port)
end
Capybara.run_server = false
