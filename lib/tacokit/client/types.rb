module Tacokit
  class Client
    module Types

      # GET /1/types/[id]
      def type(model_id)
        get path_join "types", model_id
      end
    end
  end
end
