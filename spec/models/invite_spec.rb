require 'spec_helper'

describe Invite do
  it {should belong_to(:inviter)}
end