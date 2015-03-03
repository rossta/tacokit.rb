module Tacokit
  class Client
    module Labels
      # Retrieve a label
      #
      # @see https://trello.com/docs/api/label/index.html#get-1-labels-idlabel
      def label(label_id, options = nil)
        get label_path(label_id), options
      end

      # Update a label
      #
      # @see https://trello.com/docs/api/label/index.html#put-1-labels-idlabel
      def update_label(label_id, options = {})
        put label_path(label_id), options
      end

      # Create a label
      #
      # @see https://trello.com/docs/api/label/index.html#post-1-labels
      def create_label(board_id, name, color)
        post "labels",
          board_id: board_id,
          name: name,
          color: color
      end

      # Delete a label
      #
      # @see https://trello.com/docs/api/label/index.html#delete-1-labels-idlabel
      def delete_label(label_id)
        delete label_path(label_id)
      end

      private

      def label_path(label_id, *paths)
        resource_path "labels", label_id, *paths
      end
    end
  end
end
