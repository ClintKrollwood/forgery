require File.dirname(__FILE__) + '/../spec_helper'

describe InternetForgery do
  describe ".user_name" do
    it "should return a username that is lowercase" do
      InternetForgery.user_name.should only_contain(BasicForgery::LOWER_ALPHA)
    end
  end

  it "should return a top level domain" do
    InternetForgery::TOP_LEVEL_DOMAINS.should include(InternetForgery.top_level_domain)
  end

  describe ".domain_name" do
    it "should return a domain name that contains a lowercase company name" do
      downcase_company_name = InternetForgery.domain_name.split('.').first
      InternetForgery::COMPANY_NAMES.any?{ |cn| cn =~ /#{downcase_company_name}/i }
    end

    it "should return a domain name that contains a top level domain" do
      InternetForgery::TOP_LEVEL_DOMAINS.should include(InternetForgery.domain_name.split('.').last)
    end
  end

  describe ".email_address" do
    it "should match the email format" do
      InternetForgery.email_address.should match(/.+@.+\.(#{InternetForgery::TOP_LEVEL_DOMAINS.join("|")})/)
    end
  end
end