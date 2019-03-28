class ReportsController < ApplicationController
  def index
    @surveys = Survey.all

    @surveys.each do |survey|
    end
  end
end
