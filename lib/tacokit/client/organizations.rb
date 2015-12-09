module Tacokit
  class Client
    module Organizations
      # Retrieve an organization
      # @param organization_id [String] the organization identifier
      # @param options [Hash] options to fetch the organization with
      # @return [Tacokit::Resource] the organization resource
      # @see https://developers.trello.com/advanced-reference/organization
      def organization(org_id, options = nil)
        get organization_path(org_id), options
      end

      # Update an organization
      # @param organization_id [String] the organization identifier
      # @param options [Hash] options to update the organization with
      # @return [Tacokit::Resource] the organization resource
      # @see https://developers.trello.com/advanced-reference/organization#put-1-organizations-idorg-or-name
      def update_organization(org_id, options = {})
        put organization_path(org_id), options
      end

      # Create an organization
      # @param display_name [String] a name for the organization
      # @param options [Hash] options to create the organization with
      # @return [Tacokit::Resource] the organization resource
      # @see https://developers.trello.com/advanced-reference/organization#post-1-organizations
      def create_organization(display_name, options = {})
        post "organizations", options.merge(display_name: display_name)
      end

      # Delete an organization
      # @param organization_id [String] the organization identifier
      # @see https://developers.trello.com/advanced-reference/organization#delete-1-organizations-idorg-or-name
      def delete_organization(org_id)
        delete organization_path(org_id)
      end

      # @private
      def organization_resource(org_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get organization_path(org_id, *paths), options
      end

      private

      def organization_path(org_id, *paths)
        resource_path "organizations", org_id, *paths
      end
    end
  end
end
