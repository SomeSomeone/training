class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true

	has_attached_file :image, :styles => { :standart => "300x300>"}, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
