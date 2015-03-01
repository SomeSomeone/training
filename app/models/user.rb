class User < ActiveRecord::Base
	has_many :posts
	attr_accessor :remember_token
	validates :name ,presence: true,	length: {maximum:50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,	length: {maximum:255},
										format:{with: VALID_EMAIL_REGEX},
										uniqueness: true
	validates :password, length: {minimum:6}
	has_secure_password
	before_save :downcase_email


	has_attached_file :avatar, :styles => { :standart => "240x300>", :small => "50x50#" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


#	validates_attachment :avatar,
#	:content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }


	#для запоминающей галочки
	def remember
		self.remember_token=User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end


	def forget
		update_attribute(:remember_digest,nil)
	end
	
	# для зашифровки (типа как пароль)
	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
	end
	#генерация случайного набора
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	#как я понимаю вещь для сверки верности заколировки тем самым захода через печенье
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	private

	def downcase_email
		self.email.downcase!
	end
end

