class Product < ActiveRecord::Base
  has_many    :product_assets, :dependent => :destroy
  has_many    :emails, :as => :mediator

  has_attached_file :avatar, :styles => { :medium => "50x50>", :thumb => "30x30>" }, :default_url => "/images/:style/missing.png"

  acts_as_paranoid

  has_ransackable_associations %w(tags comments emails)

  serialize :subscribed_users, Set

  scope :my, -> { accessible_by(User.current_ability) }

  acts_as_commentable
  uses_comment_extensions
  acts_as_taggable_on :tags
  has_paper_trail

  sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "created_at DESC"

  validates_presence_of :name

  def self.per_page ; 20                  ; end
  def self.first_name_position ; "before" ; end

end
