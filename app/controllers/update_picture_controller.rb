# frozen_string_literal: true

# Defines update_picture controller
class UpdatePictureController < ApplicationController
  before_action :set_user, only: :update
  def update
    filename = file_name
    File.open(Rails.root.join('app', 'assets', 'images', filename), 'wb') do |f|
      f.write(params[:picture].read)
    end
    @user.picture = filename
    @user.save
    redirect_to edit_user_registration_path
  end

  private

  def set_user
    @user = User.find(params[:user][:id])
  end

  def file_name
    "#{@user.username}#{File.extname(params[:picture].original_filename)}"
  end
end
