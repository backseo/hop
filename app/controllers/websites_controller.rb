class WebsitesController < ApplicationController
  layout 'builder'

  def index
    @websites = current_user.websites
  end

  def edit
    @templates = Template.all
    @website = Website.find(params[:id])
  end

  def update
    @website = Website.find(params[:id])
    @website.update(website_params)
    redirect_to edit_website_path(@website)
  end

  def create
    @website = current_user.websites.create(template: random_template)
    redirect_to edit_website_path(@website)

    # if @website.save
    #   respond_to do |format|
    #     format.html { redirect_to root_path }
    #     format.js
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render 'new' }
    #     format.js
    #   end
    # end
  end

  private

  def website_params
    params.require(:website).permit(:template_id)
  end

  def random_template
    Template.all.sample
  end
end
