class UpdatePictureController < ApplicationController
  def update
    uploaded_file = params[:picture]
    user = User.find(params[:user][:id])
    filename = "#{user.username}#{File.extname(uploaded_file.original_filename)}"
    File.open(Rails.root.join('app', 'assets', 'images', filename), 'wb') do |f|
      f.write(uploaded_file.read)
    end
    user.picture = filename
    user.save
    redirect_to edit_user_registration_path
  end
end
