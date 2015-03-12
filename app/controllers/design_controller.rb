class DesignController < ApplicationController
	include DesignHelper
	def new
	end
	def create
		cookies.permanent[:color]=params[:design][:color]
		redirect_to current_user
	end
end
