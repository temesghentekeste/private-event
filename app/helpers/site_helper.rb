module SiteHelper
  def member_or_guest
    if user_signed_in?
      render '/layouts/member_menu'
    else
      render '/layouts/guest_menu'
    end
  end

  def member_or_guest_action
    if user_signed_in?
      render '/layouts/member_action'
    else
      render '/layouts/guest_action'
    end
  end

  def flash_message(name)
    if name == 'notice'
      render 'layouts/notice'
    elsif name == 'alert'
      render 'layouts/alert'
    end
  end

  def welcome
    if user_signed_in?
      flash[:notice] = "You are successfully signen in #{current_user.name}"
      controller.redirect_to posts_path
    else
      render 'home/welcome'
    end
  end

  def render_event_actions(event)
    if user_signed_in? and event.start_datetime < DateTime.now
      render 'shared/past_due_render', event: event
    elsif user_signed_in? and event.creator == current_user
      render 'shared/creator_render', event: event
    elsif user_signed_in?
      render 'shared/invitee_render', event: event
    end
  end

  def browse_resources
    if user_signed_in?
      render 'shared/member_resources'
    else
      render 'shared/guest_resources'
    end
  end

  def render_homepage
    if user_signed_in?
      render 'shared/member_homepage'
    else
      render 'shared/guest_homepage'
    end
  end

  def render_invitees(obj)
    invitees = Event.invitees(obj.id)
    if invitees.is_a? Array
      render 'events/render_invitees', invitees: invitees
    else
      render 'events/render_no_invitees'
    end
  end

  def render_attendees(obj)
    attendees = Event.attendees(obj.id)
    if attendees.is_a? Array
      render 'events/render_attendees', attendees: attendees
    else
      render 'events/render_no_attendees'
    end
  end

  def render_invitation_action(obj)
    attendance = EventAttendance.find_by(event_attendee_id: current_user.id, attended_event_id: obj.id)

    if obj.start_datetime < DateTime.now
      render 'events/render_past_due_invitation'
    elsif obj.creator == current_user
      render 'render_send_invitation', obj: obj
    elsif attendance&.accepted?
      view = 'events/render_cancel_invitation'
      render view, { id: attendance.id, attended_event_id: obj.id, event_attendee_id: current_user.id }
    else attendance&.invited?
         render 'events/render_accept_invitation', obj: obj
    end
  end
end
