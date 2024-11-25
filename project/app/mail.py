import smtplib
from django.conf import settings
import schedule
import time
from datetime import datetime, timedelta
from email.mime.text import MIMEText
import threading

def validate_email(email):
    import re
    email_regex = re.compile(
        r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)"
    )
    return re.match(email_regex, email) is not None

def send_email(to_email, subject, body):
    from_email = "pravaspedia@gmail.com"  # Replace with your email address
    from_password = "osua ienz rpcs memj"  # Replace with your email password or app password

    print(f"Attempting to send email to: {to_email}")
    if not validate_email(to_email):
        print(f"Invalid recipient email: {to_email}")
        return

    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    try:
        with smtplib.SMTP('smtp.gmail.com', 587) as server:  # Gmail SMTP server and port
            print("Connecting to SMTP server...")
            server.starttls()
            server.login(from_email, from_password)
            print("Logged in to SMTP server.")
            server.send_message(msg)
            print(f"Email sent to {to_email}")
    except smtplib.SMTPAuthenticationError:
        print("SMTP Authentication Error: Check your username and password.")
    except smtplib.SMTPConnectError:
        print("SMTP Connection Error: Could not connect to the SMTP server.")
    except smtplib.SMTPException as e:
        print(f"SMTP Error: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

def schedule_emails(email, days):
    start_of_trip_date = datetime.now() + timedelta(days=days)
    reminder_date = start_of_trip_date - timedelta(days=1)
    feedback_date = start_of_trip_date + timedelta(days=1)
    
    reminder_subject = "Reminder: Your Trip Starts Tomorrow!"
    reminder_body = "This is a reminder that your trip starts tomorrow. We hope you have a great time!"
    reminder_time = reminder_date.strftime("%H:%M")
    print(f"Scheduling reminder email for {reminder_time} on {reminder_date.strftime('%Y-%m-%d')}")
    schedule.every().day.at(reminder_time).do(send_email, email, reminder_subject, reminder_body)

    feedback_subject = "Feedback Request: How Was Your Trip?"
    feedback_body = "We hope you had a great trip! We would love to hear your feedback. Please let us know how your experience was by writing a feedback @Pravaspedia."
    feedback_time = feedback_date.strftime("%H:%M")
    print(f"Scheduling feedback email for {feedback_time} on {feedback_date.strftime('%Y-%m-%d')}")
    schedule.every().day.at(feedback_time).do(send_email, email, feedback_subject, feedback_body)

def run_scheduler():
    while True:
        schedule.run_pending()
        print("Checking for scheduled tasks...")
        time.sleep(30)  # Wait for 30 seconds

def start_scheduler_thread():
    print("Starting scheduler thread...")
    scheduler_thread = threading.Thread(target=run_scheduler)
    scheduler_thread.daemon = True
    scheduler_thread.start()
    print("Scheduler thread started.")
