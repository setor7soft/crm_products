class Product < ActiveRecord::Base
  has_many    :product_assets, :dependent => :destroy
  has_many    :emails, :as => :mediator

  has_one     :avatar, :as => :entity, :dependent => :destroy  # Personal avatar.
  has_many    :avatars                                         # As owner who uploaded it, ex. Contact avatar.

  acts_as_paranoid

  has_ransackable_associations %w(tags comments emails)

  serialize :subscribed_users, Set

  acts_as_commentable
  uses_comment_extensions
  acts_as_taggable_on :tags
  has_paper_trail

  sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "created_at DESC"

  validates_presence_of :name

  def self.per_page ; 20                  ; end
  def self.first_name_position ; "before" ; end

end
