class RelationshipsController < ApplicationController

	before_filter :signed_in_user

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
			# In the case of an Ajax request, Rails automatically calls a
			# JavaScript Embedded Ruby (.js.erb) file with the same name as
			# the action. It is these files that we need to create and edit
			# in order to update the user profile page upon being followed
			# or unfollowed. The files are located in the views.
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end