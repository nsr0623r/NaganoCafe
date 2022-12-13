class Admin::GenresController < ApplicationController
  # ジャンル管理画面(一覧・追加を兼ねる)
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  # ジャンルデータ登録
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  # ジャンル編集画面
  def edit
    @genre = Genre.find(params[:id])
  end

  # ジャンルデータ更新
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
