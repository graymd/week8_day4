require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  it 'should return the active link' do
    # current_page = "/"
    # Object.new.extend(ApplicationHelper).stub!("current_page?").and_return(true)
    allow(helper).to receive('current_page?').and_return(true)
    expect(helper.active_link("")).to eq(:active)
  end

end