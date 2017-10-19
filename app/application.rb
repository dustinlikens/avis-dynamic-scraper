require 'capybara'
# require 'poltergeist'
require 'capybara/poltergeist'
# require 'concurrent'
# require 'open-uri'
require 'phantomjs'
require 'rack'
require 'json'

require "selenium/webdriver"

# http://localhost:9292/?awd=A359807&pickup=12%2F02%2F2017&dropoff=12%2F10%2F2017

class Application
  def call(env)
    t1 = Time.now
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    Capybara.register_driver(:poltergeist) { |app| Capybara::Poltergeist::Driver.new(app, js_errors: false, debug: false, phantomjs_options: ['--debug=false', '--load-images=false', '--disk-cache=false', '--ssl-protocol=any'] ) }
    Capybara.default_driver = :poltergeist

    puts 'initializing new session'
    page = Capybara::Session.new(:poltergeist)
    puts 'session created'
    # page = Capybara.current_session # if !page


# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     'chromeOptions:' => { args: %w(headless disable-gpu) }
#   )

#   Capybara::Selenium::Driver.new app,
#     browser: :chrome,
#     desired_capabilities: capabilities
# end

# Capybara.javascript_driver = :headless_chrome
# page = Capybara::Session.new(:headless_chrome)


#     Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: { args: %w(headless disable-gpu) }
#   )

#   Capybara::Selenium::Driver.new app,
#     browser: :chrome,
#     desired_capabilities: capabilities
# end

# Capybara.javascript_driver = :headless_chrome

# page = Capybara::Session.new(:headless_chrome)


    # page.driver.headers = { 'User-Agent' => 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Mobile/9A334 Safari/7534.48.3' }
    # page.driver.headers = { 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36' }
    # page.driver.headers = { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A' }

    # page.driver.browser.url_blacklist = ['https://cm.g.doubleclick.net', 'http://doubleclick.net', 'https://doubleclick.net', 'https://www.enterprise.com/etc/designs/ecom/dist/fonts/', 'https://cdnssl.clicktale.net', 'https://static.ads-twitter.com', 'https://developers.google.com', 'https://maps.googleapis.com', 'https://www.googleadservices.com']
    # page.driver.browser.url_whitelist = ['https://avis.com', 'https://www.avis.com']
    # page.driver.browser.url_blacklist = ['https://avis.com/etc/designs/avis/clientlib/images/favicon.png']
    # page.driver.browser.url_blacklist = ['https://www.bing.com', 'https://www.avis.com/content/dam/avis/na/us/common/offers/monument-valley-hp-2440x1000.jpg/jcr:content/renditions/cq5dam.web.375.375.jpg', 'https://www.avis.com/content/dam/avis/na/us/common/offers/monument-valley-hp-2440x1000.jpg', 'https://www.facebook.com','https://www.avis.com/content/', 'https://www.avis.com/content/dam/avis/na/us/common/campaigns/']

    # url = 'https://avis.com'
    # url = 'http://avis.com/en/locations/us/ca/oceanside/ocn'
    url = 'https://www.avis.com/en/reservation#/oneclick?PICKUP_YEAR=2018&PICKUP_MONTH=00&PICKUP_DAY=14&PICKUP_HOUR=12&PICKUP_MINUTE=0&PICKUP_AM_PM=PM&RETURN_YEAR=2018&PICKUP_LOCATION_CODE=OCN&RETURN_MONTH=00&RETURN_DAY=17&RETURN_HOUR=12&RETURN_MINUTE=0&RETURN_AM_PM=PM&RETURN_LOCATION_CODE=LAX&COUNTRY_OF_RESIDENCE_CODE=US&STEP_CODE=3&AWD_NUMBER=A359807'
    # url = 'https://www.hertz.com'
    # url = 'https://avis.com/etc/designs/avis/clientlib/images/favicon.png'
    # url = 'https://www.avis.com.au/en/home'
    puts 'loading first page'
    page.visit url
    puts 'first page loaded'
    # puts page.driver.network_traffic.inspect

    # Capybara.using_wait_time(120) { page.body.include?('Select My Car') }
    # puts 'first page loaded'
    # sleep(0.1)

    # # puts page.driver.network_traffic(:blocked)

    # # page.find('close-icon-black').click if page.body.include? 'close-icon-black pull-right gap-btwn-two-close'

    # # if page.body.include? 'modal-backdrop'
    # #     page.visit url 
    # #     Capybara.using_wait_time(120) { page.body.include?('Select My Car') }
    # # end


    # element = page.find('input[id=PicLoc_value]')
    # element.click
    # # 100.times { element.native.send_key(:backspace) }
    # # element.native.send_key('OCN')
    # # sleep(1)
    # # element.native.send_key(:Down)
    # # element.native.send_key(:Enter)
    # # sleep(0.1)

    # element = page.find('input[id=from]').click
    # # sleep(0.1)
    # 10.times { element.native.send_key(:backspace) }
    # element.native.send_key(req.params['pickup'])
    # puts 'pickup'
    # # element.native.send_key('12/01/2017')
    # sleep(0.5)
    # element = page.find('input[id=to]')
    # element.click
    # puts 'id=to'
    # sleep(0.1)
    # 10.times { element.native.send_key(:backspace) }
    # # element.native.send_key('12/03/2017')
    # element.native.send_key(req.params['dropoff'])
    # puts 'dropoff'
    # sleep(0.1)
    # page.find('div[title="Discount Codes"]').click
    # puts 'discount codes'
    # # sleep(0.1)
    # # page.find('input[id=awd]').native.send_key('A359807')
    # page.find('input[id=awd]').native.send_key(req.params['awd'])
    # # sleep(0.1)
    # puts "awd entered"
    # # page.find('input[id=coupon]').native.send_key('A359807')
    # # sleep(0.1)
    # page.find('button[id="res-home-select-car"]').click
    # puts 'select car pressed'
  

    Capybara.using_wait_time(120) { page.body.include?('or similar') }
    # while !page.body.include?('currency') do 
    #     # puts "loading results"
    # end
    sleep(0.5)
    # # puts page.body

    noko = Nokogiri::HTML(page.body)

    results = []
    noko.css('.available-car-box').each do |div|
        attrs = {}
        # puts div.css('h3')[0].text
        # puts div.css('p.payamntr')[0].text
        # puts div.css('p.similar-car')[0].text.strip.chomp(" or Similar")


        klass = div.css('h3')[0].text.to_sym

        attrs[:class] = div.css('h3')[0].text
        attrs[:amount] = div.css('p.payamntr')[0].text.gsub('$', '')
        attrs[:car] = div.css('p.similar-car')[0].text.strip.chomp(" or Similar")
        results << attrs

    end

    puts page.body if results.count == 0

    page.driver.quit
    # page.execute_script "window.close();"
    # page.open_new_window
    # page.clearMemoryCache
    # results.to_json
    t2 = Time.now
    delta = t2 - t1
    puts delta
    resp.write results.to_json
    resp.finish
  end
end