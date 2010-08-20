require 'helper'

class ConfigurationTest < Test::Unit::TestCase
  should "provide default values" do
    assert_config_default :account_key,       nil
    assert_config_default :api_key,           nil
    assert_config_default :secure,            false
  end

  context "incomplete configuration" do
    setup do
      @config = Whistle::Configuration.new
    end

    should "not be valid by default" do
      assert !@config.valid?
    end

    should "raise Incomplete exception when used while invalid" do
      assert_raise(Whistle::Configuration::Incomplete) { @config.url }
    end
  end

  context "complete configuration" do
    setup do
      @config = Whistle::Configuration.new
      @config.account_key = 'whistle'
      @config.api_key = 'asdf1234'
      @config.environment_name = 'test'
    end

    should "be valid" do
      assert @config.valid?
    end

    should "provide a complete url" do
      assert_nothing_raised { @config.url }
      assert_match /^http:.*whistleapp\.com\//, @config.url
    end
  end

  should "switch protocols when secure is true" do
    config = Whistle::Configuration.new
    config.account_key = 'whistle'
    config.api_key = 'asdf1234'
    config.environment_name = 'test'
    config.secure = true

    assert_match /^https:.*whistleapp\.com\//, config.url
  end

  def assert_config_default(option, default_value, config = nil)
    config ||= Whistle::Configuration.new
    assert_equal default_value, config.send(option)
  end
end
