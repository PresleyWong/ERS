class EventsController < ApplicationController
  before_action :check_if_admin, only: %i[ show index new edit ]
  before_action :set_event, only: %i[ show edit update destroy ]
  layout "admin", only: [:index, :show, :new, :edit]

  # GET /events or /events.json
  def index
    @events = Event.order(params[:sort]).order(date: :desc)
  end

  # GET /events/1 or /events/1.json
  def show
    if query_params.empty?
      @users = User.none
    else
      @users =  User.filtered(query_params)
    end

    registrants = Array.new  
    appointments = Array.new  
    @event.appointments.each do |a|
      registrants << User.find(a.user_id)
      appointments << a
    end

    @regis = registrants.zip(appointments) 
  end


  def register_user
    CreateRegistrantJob.perform_later(params[:user_id], params[:event_id], params[:events][:register_language])     
    redirect_to event_path(params[:event_id])
  end


  def remove_register_user   
    Appointment.where(user_id: params[:user_id], event_id: params[:event_id]).destroy_all
    redirect_to event_path(params[:event_id])
  end


  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :date, :start_time, :end_time, :user_id, :event_id, :meeting_id1, :attachment_url1, :attachment_url2, :attachment_url3)
    end

    def query_params
      query_params = params[:query]
      query_params ? query_params.permit(:search_item) : {}
    end

end
