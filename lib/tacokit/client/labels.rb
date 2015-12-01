module Tacokit
  class Client
    module Labels
      # Retrieve a label
      # @param label_id [String] the label identifier
      # @param options [Hash] options to fetch the label with
      # @return [Tacokit::Resource] the label resource
      # @see https://developers.trello.com/advanced-reference/label#get-1-labels-idlabel
      def label(label_id, options = nil)
        get label_path(label_id), options
      end

      # Update a label
      # @param label_id [String] the label identifier
      # @param options [Hash] the options to update the label with
      # @return [Tacokit::Resource] the label resource
      # @see https://developers.trello.com/advanced-reference/label#put-1-labels-idlabel
      def update_label(label_id, options = {})
        put label_path(label_id), options
      end

      # Create a label
      # @param board_id [String] the board identifier
      # @param name [String] the label name
      # @param color [String] the label color
      # @return [Tacokit::Resource] the label resource
      # @see https://developers.trello.com/advanced-reference/label#post-1-labels
      def create_label(board_id, name, color)
        post "labels",
          board_id: board_id,
          name: name,
          color: color
      end

      # Delete a label
      # @param label_id [String] the label identifier
      # @see https://developers.trello.com/advanced-reference/label#delete-1-labels-idlabel
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
