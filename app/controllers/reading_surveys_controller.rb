class ReadingSurveysController < ApplicationController
  before_action :set_sentences, only: [:new]
  before_action :set_subject, only: [:index, :new, :create]
  before_action :set_survey, only: [:index, :new, :create]

  def index
    @possible_spans = reading_spans

    if @possible_spans.empty?
      redirect_to controller: 'surveys', action: 'new'
    end

    @initial = @survey.reading_instructions
    @setting = Setting.first

    @radius = 90.0
    @surveys = ReadingSurvey.where(:survey => @survey.id).count
    @percentage = (@surveys.to_f / (6 * @setting.surveys) * 100).round(0)
    @offset = (100.0 - @percentage) / 100 * Math::PI * @radius * 2
  end

  def new
    @reading_survey = ReadingSurvey.new
    @span = reading_spans.sample

    @span.to_i.times do
      unused_sentences = Sentence.where.not(:id => @sentences)
      sentence = unused_sentences.sample
      @reading_survey.reading_questions.build(:sentence => sentence)
      @sentences << @reading_survey.reading_questions.last.sentence.id
    end

    session[:sentences] = @sentences
  end

  def create
    @reading_survey = ReadingSurvey.new(reading_survey_params)
    @reading_survey.survey = @survey

    respond_to do |format|
      if @reading_survey.save
        if @survey.reading_instructions == true
          @survey.reading_instructions = false
          @survey.save
        end

        format.html { redirect_to controller: 'reading_surveys', action: 'index' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def reading_spans
      possible_spans = []

      (2..7).each do |span|
        count = ReadingSurvey.where(:survey => @survey.id, :span => span).count

        if count < Setting.first.surveys
          possible_spans << span
        end
      end

      possible_spans
    end

    def reading_survey_params
      params.require(:reading_survey).permit(
        :span,
        :survey,
        reading_questions_attributes: [
          :id,
          :sentence,
          :memory,
          :recall,
          :veracity,
          :_destroy,
        ],
      )
    end

    def set_sentences
      @sentences = session[:sentences]

      unless @sentences
        @sentences = []
      end

      unless @sentences.any?
          @sentences = []
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
