import threading
import time
from datetime import datetime, timedelta
from django.core.mail import send_mail
from django.conf import settings

def send_feedback_email(to_email):
    subject = "Feedback Request: How Was Your Trip?"
    body = "We hope you had a great trip! We would love to hear your feedback. Please let us know how your experience was by writing a feedback @Pravaspedia."
    from_email = settings.EMAIL_HOST_USER
    
    try:
        send_mail(subject, body, from_email, [to_email])
        print(f"Feedback email sent to {to_email}")
    except Exception as e:
        print(f"An error occurred while sending email: {e}")

def schedule_email_after_trip(to_email, days_after_trip):
    trip_end_date = datetime.now() + timedelta(days=days_after_trip)
    delay_seconds = (trip_end_date - datetime.now()).total_seconds()
    
    # Wait until the scheduled time to send the email
    print(f"Scheduling feedback email to be sent at {trip_end_date.strftime('%Y-%m-%d %H:%M:%S')}")
    threading.Timer(delay_seconds, send_feedback_email, args=[to_email]).start()

# Example usage
if __name__ == "__main__":
    user_email = "kashishsavaliya10@gmail.com"  # Replace with a valid email address
    days_after_trip = 1  # Number of days after the trip ends to send the email

    # Schedule the email
    schedule_email_after_trip(user_email, days_after_trip)

    # Keep the script running
    while True:
        time.sleep(1)
