class NotionService
  DATABASE_ID = '205348404aeb48219ce9d2f88514e349'

  def fetch_contributions
    # Make a request to Notion API to fetch database entries
    uri = URI("https://api.notion.com/v1/databases/#{DATABASE_ID}/query")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = 'Bearer secret_omb4krPGPAcALWsENutWUSBLPW5eg4MqVS6AagNvZPB'
    request['Content-Type'] = 'application/json'
    request['Notion-Version'] = '2021-05-11'
    request.body = {
    }.to_json

    response = http.request(request)
    data = JSON.parse(response.body)

    # Extract user contributions from the response
    data['results'].map do |entry|
      name = entry['properties']['Name']['title'][0]['text']['content']
      contribution = entry['properties']['Contribution']['number']
      { 'name' => name, 'contribution' => contribution }
    end
  end

  def fetch_contributions_by_user
    contributions = fetch_contributions

    # Display the contributions of each user
    contributions.each do |contribution|
      puts "User: #{contribution['name']}"
      puts "Contribution: #{contribution['contribution']}"
      puts
    end
  end
end
