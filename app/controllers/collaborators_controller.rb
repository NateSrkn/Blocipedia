class CollaboratorsController < ApplicationController
    def create
      @wiki = Wiki.friendly.find(params[:wiki_id])
      current_collaborators = @wiki.users
      @user = User.find_by(email: params[:collaborator][:user])
  
      if User.exists?(@user)
        if current_collaborators.include?(@user) || @user == current_user
          flash[:error] = "User is already a collaborator."
          redirect_to @wiki
        else
          @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)
  
          if @collaborator.save
            flash[:notice] = "Collaborator has been added!"
          else
            flash[:error] = "Error adding collaborator, please try again."
          end
          redirect_to @wiki
        end
      else
        flash[:error] = "Sorry, no such user exists. "
        redirect_to @wiki
      end
    end
  
    def destroy
      @wiki = Wiki.friendly.find(params[:wiki_id])
      @collaborator = Collaborator.find(params[:id])
  
      if @collaborator.destroy
        flash[:notice] = "Collaborator has been successfully removed. "
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error removing this collaborator."
        redirect_to @wiki
      end
    end
  end
  