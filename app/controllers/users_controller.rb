class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    redirect_to home_index_path
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to home_index_path
  end

  # GET /users/new
  def new
    session[:prev_url] = request.referer
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create

    @user = User.new(user_params)

    respond_to do |format|
      if verify_recaptcha(model: @user) && @user.save

        #flash[:notice] = 'Account was successfully created. Plase log in'
        sign_in(@user)
        @current_user = @user
        format.html { redirect_to session[:prev_url] }
        format.json { render :show, status: :created, location: @user }


      else
        flash[:notice] = 'Email already exists or Passwords do not match.' #rendering code in views/users/new Paul Ancajima 8/2/18
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #Added uploads for active:storage
      #

      params.require(:user).permit(:is_admin, :cart_id, :album_list, :friend_list, :email, :password, :password_confirmation, :first_name, :last_name, images_attributes: [:upload],uploads:[])
    end
end
