class VideoDecorator < Draper::Decorator
  delegate_all

  def average_rating
    if object.reviews.size > 0
      ugly_result = total_sum_of_reviews / reviews.size
      "Average Rating: #{make_decimals_pretty(ugly_result)} / 5"
    else
      "No Reviews"
    end
  end

  private
  def total_sum_of_reviews
    count = 0.0
    object.reviews.each { |review| count += review.rating }
    count
  end

  def make_decimals_pretty(ugly_decimal)
    ugly_decimal.round(1)
  end
end