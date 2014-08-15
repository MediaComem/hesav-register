require 'test_helper'
 
class GouveoleRegistrationTest < ActiveSupport::TestCase
  
  test "should save registration with all required fields" do
    registration = baseRegistration
    assert registration.save
  end

  test "should not save registration without any associated EVENT" do
    registration = baseRegistration
    registration.event = nil
    assert_not registration.save
  end

  test "should not save registration without TITLE" do
    registration = baseRegistration
    registration.title = nil
    assert_not registration.save
  end

  test "should not save registration without LASTNAME" do
    registration = baseRegistration
    registration.last_name = nil
    assert_not registration.save
  end

  test "should not save registration without FIRSTNAME" do
    registration = baseRegistration
    registration.first_name = nil
    assert_not registration.save
  end

  test "should not save registration without PHONE" do
    registration = baseRegistration
    registration.phone = nil
    assert_not registration.save
  end

  test "should not save registration without AFFILIATION" do
    registration = baseRegistration
    registration.affiliation = nil
    assert_not registration.save
  end

  test "should not save registration without AFFILIATION ADDRESS" do
    registration = baseRegistration
    registration.affiliation_address = nil
    assert_not registration.save
  end

  test "should not save registration without JOB" do
    registration = baseRegistration
    registration.job = nil
    assert_not registration.save
  end

  test "should not save registration without EXPECTATIONS" do
    registration = baseRegistration
    registration.expectations = nil
    assert_not registration.save
  end

  test "should not save registration without ACTIVITIES" do
    registration = baseRegistration
    registration.activities = nil
    assert_not registration.save
  end

  test "should not save registration without RULES ACCEPTED" do
    registration = baseRegistration
    registration.rules_accepted = false
    assert_not registration.save
  end

  test "should not save registration without any KNOWLEDGE" do
    registration = baseRegistration
    registration.theorical_knowledge = false;
    registration.practical_p_knowledge = false;
    registration.practical_o_knowledge = false;
    registration.no_knowledge = false;
    assert_not registration.save
  end
  
private
  def baseRegistration
    registration = GouveoleRegistration.new
    registration.event = Event.new
    registration.title = "m"
    registration.last_name = "Le Glaunec"
    registration.first_name = "Julien"
    registration.phone = "004178 705 36 65"
    registration.affiliation = "entreprise"
    registration.affiliation_address = "Avenue des Sports 21, CH-1400 Yverdon-les-Bains"
    registration.job = "Developer"
    registration.expectations = "expectations..."
    registration.activities = "activities..."
    registration.remarks = "remarks..."
    registration.price = "500"
    registration.paid = true
    registration.rules_accepted = true
    registration.email = "jleglaunec@gmail.com"
    registration.theorical_knowledge = true;
    registration.practical_p_knowledge = true;
    registration.practical_o_knowledge = true;
    registration.no_knowledge = true;
    return registration
  end
end