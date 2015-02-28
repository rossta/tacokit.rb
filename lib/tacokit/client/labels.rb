module Tacokit
  class Client
    module Labels
      # GET /1/labels/[idLabel]
      def label(label_id, options = nil)
        get label_path(label_id), options
      end

      # GET /1/labels/[idLabel]/[resource]
      # board
      # board/[field]
      def label_resource(label_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get label_path(label_id, *paths), options
      end

      # PUT /1/labels/[idLabel]
      def update_label(label_id, options = {})
        put label_path(label_id), options
      end

      # PUT /1/labels/[idLabel]/color
      # PUT /1/labels/[idLabel]/name

      # POST /1/labels
      def create_label(board_id, name, color)
        post label_path,
          board_id: board_id,
          name: name,
          color: color
      end

      # DELETE /1/labels/[idLabel]
      def delete_label(label_id)
        delete label_path(label_id)
      end

      def label_path(*paths)
        path_join "labels", *paths
      end
    end
  end
end
