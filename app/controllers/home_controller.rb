class HomeController < ApplicationController
  layout "admin", only: [:dashboard]

  def index
    @events = Event.order(date: :desc)


    if current_user
      @appointments = current_user&.appointments
      @registered_events = Array.new
      @join_urls = Array.new

      @appointments.each do |appointment|
        @registered_events << appointment[:event_id]
        @join_urls << appointment[:join_url]
      end
    end

  end
  

  def dashboard
    @events = Event.order(date: :desc)
    @users = User.order(created_at: :desc)
  end

end
