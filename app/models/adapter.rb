class Adapter < ActiveRecord::Base
	belongs_to :user
	belongs_to :dialog
	validates :user_id ,presence: true
	validates :dialog_id ,presence: true
end
