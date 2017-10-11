class EarthquakesController < ApplicationController

  def search
    if params[:start_date].present? && params[:end_date].present?
      @start_date = DateTime.parse(params[:start_date]).beginning_of_day
      @end_date = DateTime.parse(params[:end_date]).end_of_day
      @earthquakes = Earthquake.where(felt_in_la: true, time_of: @start_date..@end_date)
                         .order(time_of: :asc)
                         .limit(10)
    else
      flash[:alert] = 'There was an error performing this search'
      redirect_to root_path
    end
  end
end