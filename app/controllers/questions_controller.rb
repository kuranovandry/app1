class QuestionsController < ApplicationController

# belongs_to :user

	def new
		@question = Question.new
	end

 	def index
 		@question = Question.all
    end
end
