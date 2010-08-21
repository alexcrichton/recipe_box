if defined?(PDFKit)
  PDFKit.configure do |config|
    if Rails.env.development?
      config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-osx').to_s
    else
      config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s
    end
  end  
end