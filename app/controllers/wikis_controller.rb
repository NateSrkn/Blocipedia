class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
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
    @wiki = Wiki.find(params[:id])
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
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:id])

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
