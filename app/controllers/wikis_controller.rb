class WikisController < ApplicationController


    def index
        @wikis = Wiki.all
        authorize @wikis
    end

    def show
        @wiki = Wiki.friendly.find(params[:id])
        @users = User.find_by(id: params[:id])
        @collaborators = @wiki.collaborators
        authorize @wiki
    end

    def new
        @wiki = Wiki.new
        authorize @wiki
    end

    def create
        @user = current_user

        @wiki = Wiki.new(user: current_user)
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.private = params[:wiki][:private]

        if @wiki.save
          flash[:notice] = "Wiki was saved successfully."
          redirect_to @wiki
        else
          flash.now[:alert] = "There was an error saving the wiki. Please try again."
          render :new
        end
        authorize @wiki
    end

    def update
        @wiki = Wiki.friendly.find(params[:id])
        @wiki.assign_attributes(wiki_params)

        if @wiki.save
          flash[:notice] = "You wiki has been updated."
          redirect_to @wiki
        else
          flash.now[:alert] = "There was an Error editing your Wiki."
          render :edit
        end
        authorize @wiki
    end

    def edit
        @wiki = Wiki.friendly.find(params[:id])
        @users = User.where.not(id: current_user.id)
        @collaborators = @wiki.collaborators
        authorize @wiki
    end

    def destroy
        @wiki = Wiki.friendly.find(params[:id])

        if @wiki.destroy
          redirect_to wikis_path
        else
          render :show
        end
        authorize @wiki
    end

    private

    def wiki_params
      params.require(:wiki).permit(:title, :body, :private, :user_id, :user_ids => [])
    end


end
