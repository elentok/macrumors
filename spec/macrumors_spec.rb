require_relative 'vcr_helper'
require_relative '../macrumors'

describe MacRumors do
  describe "#news" do
    it "returns the macbook air and pro news" do
      VCR.use_cassette('macrumors') do
        news = MacRumors.news()
        news['MacBook_Pro'].should == [
          '04/11: Updated MacBook Pro to See Significant Performance Boost with Ivy Bridge',
          '04/10: Reseller Shortages Hint at Forthcoming Update for 15-Inch MacBook Pro',
          '03/16: Slimmer 13-Inch and 15-Inch MacBook Pros Reportedly in Production',
          '02/29: Thinner MacBook Pro Models in 13-Inch and 15-Inch Sizes Coming in April?',
          "02/20: Most of Intel's Ivy Bridge CPUs Not Actually Delayed Until June"
        ]

        news['MacBook_Air'].should == [
          '02/29: Apple Considering 14-Inch MacBook Air to Focus on Asian Markets?',
          '02/23: Apple Seriously Considered Switching to AMD in 2011 MacBook Air',
          '02/07: Apple Brings Lion Internet Recovery to More 2010 Macs',
          '12/28: Ivy Bridge Processors Launching as Early as April 8?',
          '12/06: Ivy Bridge to Bring Triple Display Support to MacBook Air'
        ]
      end
    end
  end
end

