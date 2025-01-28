class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile || redirect_to(new_profile_path)
  end

  def new
    @profile = Profile.new(user_id: current_user.id)
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      if params[:profile][:picture].present?
        @profile.create_picture(image: params[:profile][:picture])
      end
      redirect_to profile_path, notice: 'Profile created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      if params[:profile][:picture].present?
        @profile.create_picture(image: params[:profile][:picture])
      end
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :age, :date_of_birth, :city, :pincode, :phone_number)
  end
  
end
