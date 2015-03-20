module DialogsHelper
	def spokesman_in(dialog)
		unless dialog.users.include?(current_user)
			redirect_to dialogs_url
		end
	end
end
