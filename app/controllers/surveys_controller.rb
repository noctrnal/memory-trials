class SurveysController < ApplicationController
  def index
    @subject = params[:subject]

    if @subject.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    else
      session[:subject] = @subject
    end
  end

  def new
    @subject = session[:subject]

    if @subject.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

    @survey = Survey.find_by(:subject => @subject)

    if @survey.nil?
      @survey = Survey.create(:subject => @subject)
    end

    @trial = select_trial

    unless @trial.blank?
      redirect_to controller: "#{@trial}_surveys", action: 'index'
    else
      @survey.touch
      redirect_to controller: 'drawings', action: 'new'
    end
  end

  private
    def select_trial
      trials = []

      if @survey.operational_instructions
        trials << 'operational'
      end
      if @survey.reading_instructions
        trials << 'reading'
      end

      trials.sample
    end
end
