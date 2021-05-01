class UsersController < ApplicationController
    before_action :check_if_admin, only: %i[index]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    layout "admin", only: [:index]

    def index
      @users = User.all
    end

    def show  
    end  

    def edit  
    end
  
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
  
    private
      def set_user
        begin
          @user = User.friendly.find(params[:id])
        rescue ActiveRecord::RecordNotFound  
          redirect_to "/page_not_found"
        end        
      end
  
      def user_params
        params.require(:user).permit(:gender, :eng_name, :chn_name, :gender, :phone_no, :language, :locality, :email)
      end
end
