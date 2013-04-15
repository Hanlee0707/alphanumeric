class ListController < ApplicationController
  def index
    if params[:tag]
      @tag = params[:tag]
      @articles = Article.tagged_with(params[:tag]).where("status = ? OR status = ?", "Published", "Archived").paginate page: params[:page], order: 'created_at desc', per_page: 20
      objects = []
      @articles.map { |article| 
        object = {}
        object[:article]=article
        object[:image]=article.images
        object[:numbers]=article.numbers
        object[:extra_informations]=article.extra_informations
        object[:additional_texts]=article.additional_texts
        objects.append(object)
      }
      respond_to do |format| 
        format.html 
        format.json { render json: objects }
      end
    else
      @back_path = request.env["HTTP_REFERER"]
      respond_to do |format| 
        format.html {redirect_to @back_path, notice: "Wrong way to access this page." }
      end
    end
  end
end
