require 'csv'
require 'action_mailer'

class CsvMailer < ApplicationMailer
  def send_csv(data, recipient_email)
    # Generate CSV data and save to temporary file
    csv_data = generate_csv(data)
    temp_file = Tempfile.new('csv_attachment.csv')
    temp_file.write(csv_data)
    temp_file.close

    # Prepare and send email
    mail(to: recipient_email, subject: 'CSV Data Attachment') do
      attach filename: 'data.csv', content: File.read(temp_file.path)
    end

    # Remove temporary file
    temp_file.unlink
  end

  private

  def generate_csv(data)
    # Implement CSV generation logic (as explained in previous response)
  end
end
