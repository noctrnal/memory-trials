class ReportsController < ApplicationController
  def index
    respond_to do |format|
      format.csv { send_data Survey.to_csv }
    end
  end
end
