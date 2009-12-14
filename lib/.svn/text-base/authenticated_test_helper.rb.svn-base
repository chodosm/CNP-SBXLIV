module AuthenticatedTestHelper
  # Sets the current agent in the session from the agent fixtures.
  def login_as(agent)
    @request.session[:agent] = agent ? agents(agent).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? "Basic #{Base64.encode64("#{users(user).login}:test")}" : nil
  end
end