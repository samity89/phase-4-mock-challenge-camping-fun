class ActivitiesController < ApplicationController
    
    def index
        activies = Activity.all
        render json: activies, include: :signups
    end

    def destroy
        activity = find_activity
        activity.destroy
    rescue ActiveRecord::RecordNotFound
        render_not_found_response
    end

    private

    def find_activity
        Activity.find(params[:id])
    end 

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
    end
end

