class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
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
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "You wiki has been updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an Error editing your Wiki."
      render :edit
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      redirect_to wikis_path
    else
      render :show 
    end
  end
  

  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id, :user_ids => [])
  end

end
