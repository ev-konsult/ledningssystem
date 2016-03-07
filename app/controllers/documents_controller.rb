class DocumentsController < ApplicationController
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(document_params)

    if @document.save
      flash[:success] = "Dokument sparades!"
      redirect_to @document
    else
      render 'new'
    end
  end

  def delete
  end

  def destroy
  end

  private
    def document_params
      params.require(:document).permit(:title, :file, :category)
    end
end
