module TrackerApi
  module Endpoints
    class Iteration
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, iteration_number)
        data = client.get("/projects/#{project_id}/iterations/#{iteration_number}").body

        Resources::Iteration.new({ client: client, project_id: project_id }.merge(data))
      end

      def get_analytics_cycle_time_details(project_id, iteration_number)
        data = client.paginate("/projects/#{project_id}/iterations/#{iteration_number}/analytics/cycle_time_details")
        raise Errors::UnexpectedData, 'Array of comments expected' unless data.is_a? Array

        data.map do |cycle_time_details|
          Resources::CycleTimeDetails.new({
                                  project_id: project_id,
                                  iteration_number: iteration_number }.merge(cycle_time_details))
        end
      end
    end
  end
end
