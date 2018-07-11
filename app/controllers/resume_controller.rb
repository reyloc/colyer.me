# frozen_string_literal: true

# Defines resume controller
class ResumeController < ApplicationController
  def index; end

  def download
    send_file("#{Rails.root}/public/resume.pdf",
              filename: 'Jason_Colyer_Resume.pdf',
              type: 'application/pdf')
  end
end
