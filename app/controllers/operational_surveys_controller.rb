class OperationalSurveysController < ApplicationController
  before_action :set_equations, only: [:new]
  before_action :set_subject, only: [:index, :new, :create]
  before_action :set_survey, only: [:index, :new, :create]

  def index
    @possible_spans = operational_spans

    if @possible_spans.empty?
      redirect_to controller: 'surveys', action: 'new'
    end

    @initial = @survey.operational_instructions
    @setting = Setting.first

    @radius = 90.0
    @surveys = OperationalSurvey.where(:survey => @survey.id).count
    @percentage = (@surveys.to_f / (6 * @setting.surveys) * 100).round(0)
    @offset = (100.0 - @percentage) / 100 * Math::PI * @radius * 2
  end

  def new
    @operational_survey = OperationalSurvey.new
    @span = operational_spans.sample

    @span.to_i.times do
      unused_equations = Equation.where.not(:id => @equations)
      equation = unused_equations.sample
      @operational_survey.operational_questions.build(:equation => equation)
      @equations << @operational_survey.operational_questions.last.equation.id
    end

    session[:equations] = @equations
  end

  def create
    @operational_survey = OperationalSurvey.new(operational_survey_params)
    @operational_survey.survey = @survey

    respond_to do |format|
      if @operational_survey.save
        if @survey.operational_instructions == true
          @survey.operational_instructions = false
          @survey.save
        end

        format.html { redirect_to controller: 'operational_surveys', action: 'index' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def operational_spans
      possible_spans = []

      (2..7).each do |span|
        count = OperationalSurvey.where(:survey => @survey.id, :span => span).count

        if count < Setting.first.surveys
          possible_spans << span
        end
      end

      possible_spans
    end

    def operational_survey_params
      params.require(:operational_survey).permit(
        :span,
        :survey,
        operational_questions_attributes: [
          :id,
          :equation,
          :memory,
          :recall,
          :veracity,
          :_destroy,
        ],
      )
    end

    def set_equations
      @equations = session[:equations]

      unless @equations.any?
        @equations = []
      end
    end

    def set_subject
      @subject = session[:subject]

      if @subject.nil?
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      end
    end

    def set_survey
      @survey = Survey.find_by(:subject => @subject)

      if @survey.nil?
        redirect_to controller: 'surveys', action: 'new'
      end
    end
end
