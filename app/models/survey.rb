class Survey < ApplicationRecord
  has_many :operational_surveys, inverse_of: :survey, dependent: :destroy
  has_many :reading_surveys, inverse_of: :survey, dependent: :destroy

  has_many :operational_questions, through: :operational_surveys
  has_many :reading_questions, through: :reading_surveys

  has_many :equations, through: :operational_questions
  has_many :sentences, through: :reading_questions

  def self.to_csv(options = {})

    CSV.generate(options) do |csv|
      csv << column_headings

      all.each do |survey|
        operational_surveys(survey, csv)
        reading_surveys(survey, csv)
      end
    end
  end

  private

  def self.column_headings
    [
      'user.name',
      'user.yearOfBirth',
      'user.sex',
      'user.osName',
      'module.name',
      'module.version',
      'session.id',
      'session.index',
      'session.startTime',
      'session.endTime',
      'session.completed',
      'session.subject.subject-code',
      'trial.id',
      'trial.index',
      'trial.name',
      'trial.digit_span.answer',
      'trial.digit_span.durationTime',
      'trial.digit_span.endTime',
      'trial.digit_span.load',
      'trial.digit_span.maxPoints',
      'trial.digit_span.minPoints',
      'trial.digit_span.outcome',
      'trial.digit_span.points',
      'trial.digit_span.question',
      'trial.digit_span.response',
      'trial.digit_span.result',
      'trial.digit_span.startTime',
      'trial.digit_span.trialNo',
      'trial.operation_processing.answer',
      'trial.operation_processing.durationTime',
      'trial.operation_processing.endTime',
      'trial.operation_processing.maxPoints',
      'trial.operation_processing.minPoints',
      'trial.operation_processing.outcome',
      'trial.operation_processing.points',
      'trial.operation_processing.question',
      'trial.operation_processing.response',
      'trial.operation_processing.result',
      'trial.operation_processing.startTime',
    ]
  end

  def self.digit_span(type, survey, question)
    type == 'Operation Span (digits)' ? key = 'equation' : key = 'sentence'

    if key == 'equation'
      count = question.operational_survey.operational_questions.count
    else
      count = question.reading_survey.reading_questions.count
    end

    [
      'N/A',
      'N/A',
      'N/A',
      'N/A',
      type,
      'N/A',
      'N/A',
      'N/A',
      survey.created_at,
      survey.updated_at,
      survey.completed?,
      survey.survey.subject,
      'N/A',
      'N/A',
      'module.list.comp.digit_span',
      question.memory,
      elapsed_time(question),
      question.updated_at,
      count,
      1,
      0,
      'FINISHED',
      question.memory == question.recall ? 1 : 0,
      question.memory,
      question.recall,
      question.memory == question.recall ? 'success' : 'failure',
      question.created_at,
      'N/A',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ]
  end

  def self.elapsed_time(question)
    (question.updated_at - question.created_at) * 1.days
  end

  def self.operational_processing(type, survey, question)
    type == 'Operation Span (digits)' ? key = 'equation' : key = 'sentence'

    if key == 'equation'
      question.veracity == question.equation.veracity ? score = 1 : score = 0
      challenge = question.equation.equation
      veracity = question.equation.veracity
      question.veracity == question.equation.veracity ? result = 'success' : result = 'failure'
    else
      question.veracity == question.sentence.veracity ? score = 1 : score = 0
      challenge = question.sentence.sentence
      veracity = question.sentence.veracity
      question.veracity == question.sentence.veracity ? result = 'success' : result = 'failure'
    end

    [
      'N/A',
      'N/A',
      'N/A',
      'N/A',
      type,
      'N/A',
      'N/A',
      'N/A',
      survey.created_at,
      survey.updated_at,
      survey.completed?,
      survey.survey.subject,
      'N/A',
      'N/A',
      'module.list.comp.exec.operation_processing',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      question.veracity ? true : false,
      elapsed_time(question),
      question.updated_at,
      1,
      0,
      'FINISHED',
      score,
      challenge,
      veracity,
      result,
      question.created_at,
    ]
  end


  def self.operational_surveys(survey, csv)
    operational_surveys = survey.operational_surveys
    type = 'Operation Span (digits)'

    operational_surveys.each do |operational_survey|
      operational_questions = operational_survey.operational_questions

      operational_questions.each do |operational_question|
        row = operational_processing(type, operational_survey, operational_question)
        csv << row

        row = digit_span(type, operational_survey, operational_question)
        csv << row
      end
    end
  end

  def self.reading_surveys(survey, csv)
    reading_surveys = survey.reading_surveys
    type = 'Reading Span (digits)'

    reading_surveys.each do |reading_survey|
      reading_questions = reading_survey.reading_questions

      reading_questions.each do |reading_question|
        row = operational_processing(type, reading_survey, reading_question)
        csv << row

        row = digit_span(type, reading_survey, reading_question)
        csv << row
      end
    end
  end
end
