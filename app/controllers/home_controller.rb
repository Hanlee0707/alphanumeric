class HomeController < ApplicationController
  before_filter :logged_in?

  def show
    @articles = Article.where("status = ? OR status = ? OR status =?","Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
  end 

end
