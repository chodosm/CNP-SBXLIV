require File.dirname(__FILE__) + '/../test_helper'
require 'flow_controller'

# Re-raise errors caught by the controller.
class FlowController; def rescue_action(e) raise e end; end

class FlowControllerTest < Test::Unit::TestCase
  def setup
    @controller = FlowController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
