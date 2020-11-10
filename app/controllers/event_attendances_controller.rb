class EventAttendancesController < ApplicationController
  def create
    event = Event.find(params[:attended_event_id])
    params = { event_attendee_id: params[:event_attendee_id], attended_event_id: params[:attended_event_id] }
    attendance = EventAttendance.new(params)

    if attendance.save
      attendance.invited!
      flash[:notice] = 'Invitation sent!'
      redirect_to users_path(attended_event_id: event.id)
    else
      flash[:alert] = 'Invitation failed. Please try again'
      redirect_to event_path(event)
    end
  end

  def destroy
    event = Event.find(params[:attended_event_id])
    attendance = EventAttendance.find(params[:id])
    if current_user == event.creator
      attendance.destroy
      flash[:notice] = 'Invitation is cancelled successfully'
      redirect_to users_path(attended_event_id: event.id, id: attendance.id)
    else
      attendance.invitation_status = 'invited'
      attendance.save
      flash[:notice] = "You have rejected the invitation for the #{event.title}"
      redirect_to events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    @attendance = EventAttendance.find_by(event_attendee_id: current_user.id, attended_event_id: params[:id])
    # byebug
    if @attendance&.invited?
      @attendance.accepted!
      flash[:notice] = 'Your have successfully registered.'
    else
      flash[:alert] = 'You need to be invited to perform that action'
    end

    redirect_to event_path(@event)
  end
end
