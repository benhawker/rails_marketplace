class FeedbackPresenter
	include ActionView::Helpers::FormOptionsHelper
	
  attr_reader :feedback

  def initialize(listing, current_user = nil)
    @listing = listing
    @current_user = current_user
  end

  def feedback_options
    options_for_select( [["Positive"], ["Neutral"], ["Negative"]] )
  end
end