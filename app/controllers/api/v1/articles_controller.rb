module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Articles List loaded', data: articles }, status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Article loaded', data: article }, status: :ok
      end

      def create
        article = Article.new(article_params)

        if article.save
          render json: { status: 'SUCCESS', message: 'Article is created', data: article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article cannot be created', data: article.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        article = Article.find(params[:id])

        if article.update_attributes(article_params)
          render json: { status: 'SUCCESS', message: 'Article is updated', data: article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article cannot be updated', data: article.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        article.destroy
        render json: { status: 'SUCCESS', message: 'Article deleted', data: article }, status: :ok
      end

      private

      def article_params
        params.permit(:title, :body)
      end
    end
  end
end