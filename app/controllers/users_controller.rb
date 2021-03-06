class UsersController < ApplicationController

    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user, only: [:edit]

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        session[:user_id] = @user.id
        if @user.save
            flash[:success] = "Success in creating your user"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        # @user = Defined in correct_user
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to root_url
            flash[:success] = "User updated"
        else
            render 'edit'
        end
    end

    private

        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end

        def correct_user
            @user = User.find(params[:id])
            if current_user?(@user)
                return true
            else
                flash[:warning] = "Action denied"
                redirect_to(edit_user_path(current_user))
            end
        end

end
