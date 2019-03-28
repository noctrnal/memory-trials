class DrawingsController < ApplicationController
  def new
    @drawing = Drawing.new
  end

  def create
    @drawing = Drawing.new(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to 'http://www.msstate.edu' }
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
