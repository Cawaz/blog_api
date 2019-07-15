module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show update destroy]
      def index
        posts = Post.order(:created_at: :desc)
        render json: { status: 'SUCCESS', message: 'loaded psots', data: posts }
      end

      def show
        render json: { status: 'SUCCESS', message: 'loaded the post', data: post }
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { status: 'SUCCESS', message: 'loaded the post', data: post }
        else
          render json: { status: 'ERROR', message: 'post not saved', data: post.errors }
        end
      end

      def destroy
        post.destroy
        render json: { status: 'SUCCESS', message: 'deleted the post', data: post }
      end

      def update
        if post.update(post_params)
          render json: { status: 'SUCCESS', message: 'updated the post' data: post }
        else
          render json: { status: 'SUCCESS', message: 'loaded the post', data: post }
        end
      end

      private

      def post_parmas
        parmas.require(:post).permit(:title)
      end
    end
  end
end

