class AdminUser < ActiveRecord::Base
  # to configure a different table name:
  # self.table_name = "admin_users"
  has_secure_password	
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  #long method
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDEN_USERNAMES= ['enanocacon', 'loscojones', 'rompecreta']
  #validates_presence_of :first_name
  #validates_length_of :first_name, :maximum => 25
  #validates_presence_of :last_name
  #validates_length_of :last_name, :maximum => 50
  #validates_presence_of :username
  #validates_length_of :username, :within => 8..25
  #validates_uniqueness_of :username
  #validates_presence_of :email
  #validates_length_of :email, :maximum => 100
  #validates_format_of :email, :with => EMAIL_REGEX
  #validates_confirmation_of :email
  
  #short method or sexy
  validates :first_name, :presence => true,
            :length => {:maximum => 25}
  validates :last_name, :presence => true,
            :length => {:maximum => 50 }
  validates :username, :length => {:within => 8..25 },
            :uniqueness => true
  validates :email, :presence => true,
                  :length => { :maximum => 50 },
                  :uniqueness => true,
                  :format => { :with => EMAIL_REGEX },
                  :confirmation => true
  # Custom validation.  You need to use validate, not validates
  validate :username_is_allowed

  def username_is_allowed
  	if FORBIDEN_USERNAMES.include?(username)
  		errors.add(:username, 'has been restricted from use')
    end
  end  		
  
  # Error not related to specific attribute
  # can be added to errors[:base]
  def no_new_users_on_saturday
    if Time.now.wday==6
      errors[:base] << "No new users on Saturday"
    end
  end

end
