class PagesController < ApplicationController
  def home
  end

  def bedroom
    @bedroom_json = File.read(Rails.root.join("lib/assets/bedroom.json"))
  end
end
