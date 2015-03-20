class DialogMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :dialog
  default_scope -> { order(created_at: :desc) }
end
