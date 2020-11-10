module EventsHelper
  def user_hosted_events(user)
    if user.events.count.positive?
      render 'user_hosted_events'
    else
      render 'no_user_hosted_events'
    end
  end

  def user_upcoming_events(user)
    if user.attended_events.upcoming.count.positive?
      render 'user_upcoming_events'
    else
      render 'no_user_upcoming_events'
    end
  end

  def user_past_events(user)
    if user.attended_events.past.count.positive?
      render 'user_past_events'
    else
      render 'no_user_past_events'
    end
  end
end
