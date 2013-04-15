require 'test_helper'

class EmployeeMailerTest < ActionMailer::TestCase
  test "create_account" do
    mail = EmployeeMailer.create_account
    assert_equal "Create account", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
