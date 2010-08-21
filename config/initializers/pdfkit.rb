require 'rbconfig'

PDFKit.configure do |config|
  if RbConfig::CONFIG['host_os'] =~ /darwin/
    config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-osx').to_s
  else
    config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s
  end
end  
