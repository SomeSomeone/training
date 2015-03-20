class AdaptersController < ApplicationController
	
	def create
		@adapter=Adapter.new(adapter_params)
		@dialog=Dialog.find(params[:dialog_id])
		@adapter.dialog=@dialog
		respond_to do |format|
			if @adapter.save
				format.html { redirect_to @dialog , notice: 'User was successfully add.' }
			else
				format.html { redirect_to @dialog , alert: "User wasn't successfully add." }
			end
		end
	end
	private
	def adapter_params
		params.require(:adapter).permit(:user_id , :dialog_id )
	end

end
