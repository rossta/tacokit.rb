module Tacokit
  class Client
    module Labels
      # GET /1/labels/[idLabel]
      def label(label_id, options = nil)
        get "labels/#{label_id}", options
      end

      # GET /1/labels/[idLabel]/board
      # GET /1/labels/[idLabel]/board/[field]
      def label_resource(label_id, resource, options = nil)
        get "labels/#{label_id}/#{resource}", options
      end

      # PUT /1/labels/[idLabel]
      # PUT /1/labels/[idLabel]/color
      # PUT /1/labels/[idLabel]/name
      # POST /1/labels
      # DELETE /1/labels/[idLabel]
    end
  end
end
