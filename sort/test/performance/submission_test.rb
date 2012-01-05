require File.dirname(__FILE__) + '/../test_helper'
require 'rails/performance_test_help'

class SubmissionTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { :runs => 2, :metrics => [:process_time, :memory, :objects],
                            :output => 'tmp/performance', :formats => [:flat, :graph_html, :call_tree] }

  def setup
    # TODO Application requires logged-in user
    # login_as(:lifo)
  end

  def test_new_submission
    get '/submissions/new'
  end
end
