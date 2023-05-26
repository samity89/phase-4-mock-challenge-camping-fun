class CampersController < ApplicationController
    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = find_camper
        render json: camper, include: :activities
    rescue ActiveRecord::RecordNotFound
        render_not_found_response
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: ["validation errors"] }, status: :unprocessable_entity
    end
    
    private
    
    def camper_params
        params.permit(:name, :age)
    end

    def find_camper
        Camper.find(params[:id])
    end
    
    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end
end
