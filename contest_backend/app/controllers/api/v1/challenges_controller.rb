module Api
    module V1
        class ChallengesController < ApplicationController
            before_action :set_challenge, only: %i[show update destroy]
            def index
                @challenges = Challenge.all
                render json: @challenges
            end
            def show
                if @challenge
                    render json: @challenge
                else
                    render json: { message: 'Challenge not found' }, status: :not_found
                end
            end
            def create
                if @challenge.save
                    render json: { message: 'Challenge created successfully', data: @challenge }
                else
                    render json: { message: 'Failed to create challenge', data: @challenge.errors.full_messages }, status: :unprocessable_entity
                end
            end
            def update
                if @challenge.update(challenges_params)
                    render json: { message: 'Challenge updated successfully', data: @challenge }
                else
                    render json: { message: 'Failed to update challenge', data: @challenge.errors.full_messages }, status: :unprocessable_entity
                end
            end
            def destroy
               
                if @challenge.destroy
                    render json: { message: 'Challenge deleted successfully' }
                else
                    render json: { message: 'Failed to delete challenge' }, status: :unprocessable_entity
                end
            end
            private
            def set_challenge
                @challenge = Challenge.find(params[:id])
            end

            def challenges_params
                params.require(:challenge).permit(:title, :description, :start_date, :end_date)
            end
        end
    end
end