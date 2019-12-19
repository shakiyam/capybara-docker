require 'capybara/mechanize'
require 'capybara/rspec'

Capybara.app = proc do
  ['200', { 'Content-Type' => 'text/html' }, ['This is a dummy app.']]
end
Capybara.default_driver = :mechanize
if ENV['HTTP_PROXY']
  proxy = URI.parse(ENV['HTTP_PROXY'])
  Capybara.current_session.driver.browser.agent.set_proxy(proxy.host, proxy.port)
end
Capybara.run_server = false
