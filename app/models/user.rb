require 'digest/sha1'
#require 'RFC822'


class User < ActiveRecord::Base
  include RFC822

  has_and_belongs_to_many :roles
  has_one :user_attribute

  # abbreviated for clarity

  validates_presence_of     :name
  validates_uniqueness_of   :name

validates_format_of :name,
   :with => EmailAddress,
   :message=> 'must be a valid email address. i.e. user@doman.com'

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

#accepts_nested_attributes_for :user_attribute, :allow_destroy => true

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def full_name
    #user_attributes=UserAttribute.where(:user_id => self.id)
    if self.user_attribute.nil? then
      return(self.name)
    else if self.user_attribute.first_name.nil? or self.user_attribute.last_name.nil? then
      return(self.name)
    else
      return(self.user_attribute.first_name + " " + self.user_attribute.last_name)
    end
  end
  end

  def create_reset_code
    @reset = true
    self.attributes = {:password_reset_code => Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )}
    save(false)
  end

  def create_activation_code
    @created=true
    self.attributes = {:activation_code => Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )}
    save(false)
  end

  def not_activated?
    not self.activation_code.nil?
  end

  def recently_reset?
    @reset
  end

  def recently_activated?
    @activated
  end

  def recently_created?
    @created
  end

  def lost_activation_code?
    @lost_activation_code
  end

  def reset_activation_code
    @lost_activation_code=true
    save(false)
  end

  def delete_reset_code
    self.attributes = {:password_reset_code => nil}
    save(false)
  end

def delete_activation_code
    @activated=true
    self.attributes = {:activation_code => nil, :activated_at=>  Time.now}
    save(false)
  end
  # 'password' is a virtual attribute
  def password
    @password
  end

  def reset
    @reset
  end

  def activated
    @activated
  end

  def created
    @created
  end

  def lost_activation_code
    @lost_activation_code
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end


def after_destroy
  if User.count.zero?
    raise "Can't delete last user"
  end
end


private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end



  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end



  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end


end