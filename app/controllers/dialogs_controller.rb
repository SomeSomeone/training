class DialogsController < ApplicationController
	before_action :log_into_the_system 
	include DialogsHelper
	def index
		@dialogs=current_user.dialogs
		@dialog=Dialog.new
	end
	def show
		@dialog=Dialog.find(params[:id])

		spokesman_in(@dialog)
		
		@users=@dialog.users
		@messages=@dialog.dialog_messages
		@message=DialogMessage.new
		@adapter=Adapter.new
	end
	def create
		@dialog=Dialog.create
		Adapter.create(user_id: current_user.id , dialog_id: @dialog.id)
		redirect_to @dialog
	end
end
