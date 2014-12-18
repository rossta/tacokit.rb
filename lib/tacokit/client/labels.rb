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
      def update_label(label_id, options = {})
        put "labels/#{label_id}", options
      end

      # POST /1/labels
      def create_label(board_id, name, color)
        post "labels", 'idBoard' => board_id, name: name, color: color
      end

      # DELETE /1/labels/[idLabel]
      def delete_label(label_id)
        delete "labels/#{label_id}"
      end
    end
  end
end
