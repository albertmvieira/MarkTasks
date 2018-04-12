require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'site_prism'
require 'faker'

#variavel env grava o valor de variavel de ambiente BROWSER
$env = ENV['BROWSER']
$headless = ENV['HEADLESS']

#config para usar poltergeist como driver do capybara e selenium caso seja setado como headless
if $headless
    Capybara.register_driver :selenium do |app|
        Capybara::Poltergeist::Driver.new(app, js_errors: false)
    end
end

Capybara.configure do |config|
    if $env == 'chrome'
        config.default_driver = :selenium_chrome
    elsif $env == 'chrome_headless'
        config.default_driver = :selenium_chrome_headless   
    else
        config.default_driver = :selenium
    end
    #definindo URl padrão
    config.app_host = 'https://marktasks.herokuapp.com'
end

Capybara.default_max_wait_time = 5


#Para configuração default_driver podemos utilizar os paramtros:
# :selenium => Firefox
# :selenium_chorme => Chrome
# :selenium_chorme_headless => Chrome Headless