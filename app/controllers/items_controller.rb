class ItemsController < ApplicationController
	def index
			@items = Item.where(enabled: true)
	end

	def edit
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def show
		@item = Item.find(params[:id])
	end

	def create

	end

end
