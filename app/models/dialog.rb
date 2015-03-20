class Dialog < ActiveRecord::Base
	has_many :dialog_messages, dependent: :destroy
	has_many :adapters , dependent: :destroy
	has_many :users , through: :adapters

	default_scope -> { order(updated_at: :desc) }
end
