class Subject < ActiveRecord::Base
  #implementing 1:1 to test only
  #has_one :page #when 1:1
  has_many :pages
  #Validations
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  
  scope :visible, lambda {where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}
  scope :sorted, lambda { order("subjects.position ASC")}
  scope :newest_first, lambda {order("subjects.created_at DESC")}
  scope :search, lambda {|query| where(["name like ?", "%#{query}%"])}
end
