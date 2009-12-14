require File.dirname(__FILE__) + '/../test_helper'

class AgentTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :agents

  def test_should_create_agent
    assert_difference 'Agent.count' do
      agent = create_agent
      assert !agent.new_record?, "#{agent.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference 'Agent.count' do
      u = create_agent(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Agent.count' do
      u = create_agent(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Agent.count' do
      u = create_agent(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Agent.count' do
      u = create_agent(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    agents(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal agents(:quentin), Agent.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    agents(:quentin).update_attributes(:login => 'quentin2')
    assert_equal agents(:quentin), Agent.authenticate('quentin2', 'test')
  end

  def test_should_authenticate_agent
    assert_equal agents(:quentin), Agent.authenticate('quentin', 'test')
  end

  def test_should_set_remember_token
    agents(:quentin).remember_me
    assert_not_nil agents(:quentin).remember_token
    assert_not_nil agents(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    agents(:quentin).remember_me
    assert_not_nil agents(:quentin).remember_token
    agents(:quentin).forget_me
    assert_nil agents(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    agents(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil agents(:quentin).remember_token
    assert_not_nil agents(:quentin).remember_token_expires_at
    assert agents(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    agents(:quentin).remember_me_until time
    assert_not_nil agents(:quentin).remember_token
    assert_not_nil agents(:quentin).remember_token_expires_at
    assert_equal agents(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    agents(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil agents(:quentin).remember_token
    assert_not_nil agents(:quentin).remember_token_expires_at
    assert agents(:quentin).remember_token_expires_at.between?(before, after)
  end

protected
  def create_agent(options = {})
    Agent.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
