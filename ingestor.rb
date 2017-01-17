require 'rest_client'

File.readlines("sample_syslog.txt").each do |l|
  RestClient.post("http://localhost:4000/api/logs", log: l)
end
