class OperationalQuestion < ApplicationRecord
  belongs_to :operational_survey
  belongs_to :equation

  accepts_nested_attributes_for :equation

  after_initialize :default_values

  private
    def default_values
      self.memory ||= memory_range
      self.equation ||= fetch_equation
    end

    def fetch_equation
      puts 'hereeeee'
      Equation.offset(rand(Equation.count)).first
    end

    def memory_range
      @minimum_value ||= Setting.first.minimum_value
      @maximum_value ||= Setting.first.maximum_value

      [*@minimum_value..@maximum_value].sample
    end
end
