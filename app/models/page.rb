class Page < ActiveRecord::Base

  belongs_to :subject
  #has_and_belongs_to_many :admin_users
  # or you can call admin_users 'editors'
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  has_many :sections #to count how many sections per page

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink, :within => 3..255
  # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink
  #for unique values by subject use  ":scope :subject_id"
  
  scope :visible, lambda {where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}
  scope :sorted, lambda { order("pages.position ASC")}
  scope :newest_first, lambda {order("pages.created_at DESC")}
  scope :search, lambda {|query| where(["name like ?", "%#{query}%"])}

end