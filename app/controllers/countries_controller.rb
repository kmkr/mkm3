class CountriesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :except => :index

  def index
    countries = Country.all

    respond_with countries
  end

  def create
    country = Country.new(params[:country])
    country.save
    respond_with country
  end

  def destroy
    country = Country.find(params[:id])
    country.destroy
    respond_with country
  end
end
