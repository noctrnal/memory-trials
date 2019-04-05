class DrawingsController < ApplicationController
  def new
    @drawing = Drawing.new
  end

  def create
    subject = session[:subject]

    if subject.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

    @drawing = Drawing.new(drawing_params)
    @drawing.subject = subject

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to 'https://www.ise.msstate.edu' }
      else
        puts 'not saved!'
        format.html { render :new }
      end
    end
  end

  private
    def drawing_params
      params.require(:drawing).permit(
        :email,
      )
    end
end
