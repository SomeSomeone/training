module DesignHelper
	def color(defalt)
		cookies.permanent[:color].nil? ? defalt : cookies.permanent[:color] ;
	end

end
