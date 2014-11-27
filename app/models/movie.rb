class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: {only_integer: true}
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future

  mount_uploader :poster_image_url, AvatarUploader

  scope :search_movie_by_title, ->(title) {where('title like ?', "%#{title}%")}
  scope :search_movie_by_director, ->(director) {where('director like ?', "%#{director}%")}

  # scope :search_movie_by_all_categories, ->(title,director,runtime) do
  #   if runtime == 1
  #     where('title like "%#{title}%" AND director like "%#{director}%" AND runtime_in_minutes < 90')
  #   elsif runtime == 2
  #     where('title like "%#{title}%" AND director like "%#{director}%" AND runtime_in_minutes BETWEEN "90" AND "120"')
  #   elsif runtime == 3
  #     where('title like "%#{title}%" AND director like "%#{director}%" AND runtime_in_minutes > 120')
  #   end
  # end

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size 
    else
      return 0
    end
  end

  def self.search_movie_by_runtime(runtime)
    if runtime == "1"
     where('runtime_in_minutes < 90')
    elsif runtime == "2"
      where('runtime_in_minutes BETWEEN "90" AND "120"')
    elsif runtime == "3"
      where('runtime_in_minutes > 120')
    end
  end

  def self.search_movie_by_all_categories(title,director,runtime)
    if runtime == "1"
      where("title like '%#{title}%' AND director like '%#{director}%' AND runtime_in_minutes < 90")
    elsif runtime == "2"
      where("title like '%#{title}%' AND director like '%#{director}%' AND runtime_in_minutes BETWEEN '90' AND '120'")
    elsif runtime == "3"
      where("title like '%#{title}%' AND director like '%#{director}%' AND runtime_in_minutes > 120")
    end
  end

  protected
  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
