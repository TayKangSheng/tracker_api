module TrackerApi
  module Endpoints
    class IterationAnalyticsCycleTimeDetails
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, iteration_number)
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
