class CharactersController < ApplicationController
    before_action :find_character, only: [:show, :edit, :update, :destroy]

    def index
    end

    def new
        @character = Character.new(campaign_id: params[:campaign_id])
        redirect_if_player_already_joined
    end

    def create
        @character = Character.new(character_params)
        if @character.save
            redirect_to campaign_character_path(@character.campaign, @character)
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def find_character
        @character = Character.find_by(id: params[:id])
    end

    def redirect_if_player_already_joined 
        if Campaign.find_by(id: params[:campaign_id]).players.include?(helpers.current_user)
            redirect_to campaign_path(Campaign.find_by(id: params[:campaign_id]))
        end
    end

    def character_params
        params.require(:character).permit(:name, :bio, :campaign_id, :player_id)
    end
    
end
