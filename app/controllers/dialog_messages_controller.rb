class DialogMessagesController < ApplicationController
	before_action :log_into_the_system 
	include DialogsHelper
	def create
		@dialog=Dialog.find(params[:dialog_id])
		
		spokesman_in(@dialog)

		@dialog_message = DialogMessage.new(dialog_message_params)

		@dialog_message.user=current_user
		@dialog_message.dialog=@dialog

		respond_to do |format|
			if @dialog_message.save
				@dialog.updated_at=Time.now
				@dialog.save
				format.html { redirect_to @dialog, notice: 'message was successfully created.' }
			else
				format.html { redirect_to @dialog, alert: "message wasn't successfully created." }
			end
		end

	end

	private
	
	def dialog_message_params
		params.require(:dialog_message).permit(:message)
	end


end
