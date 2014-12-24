module Tacokit
  class Client
    module Organizations

      # GET /1/organizations/[idOrg or name]
      def organization(org_id, options = nil)
        get "organizations/#{org_id}", options
      end

      # GET /1/organizations/[idOrg or name]/[field]
      def organization_field(org_id, field, options = nil)
        get "organizations/#{org_id}/#{to_path(field)}", options
      end

      # GET /1/organizations/[idOrg or name]/[resource]
      # actions
      # boards
      # boards/[filter]
      # deltas
      # members
      # members/[filter]
      # members/[idMember]/cards
      # membersInvited
      # membersInvited/[field]
      # memberships
      # memberships/[idMembership]
      def organization_resource(org_id, resource, options = nil)
        get "organizations/#{org_id}/#{to_path(resource)}", options
      end

      # PUT /1/organizations/[idOrg or name]
      def update_organization(org_id, options = {})
        put "organizations/#{org_id}", options
      end

      # PUT /1/organizations/[idOrg or name]/[field]
      # desc
      # displayName
      # members
      # members/[idMember]
      # members/[idMember]/deactivated
      # memberships/[idMembership]
      # name
      # prefs/associatedDomain
      # prefs/boardVisibilityRestrict/org
      # prefs/boardVisibilityRestrict/private
      # prefs/boardVisibilityRestrict/public
      # prefs/externalMembersDisabled
      # prefs/googleAppsVersion
      # prefs/orgInviteRestrict
      # prefs/permissionLevel
      # website

      # POST /1/organizations
      def create_organization(display_name, options = {})
        post "organizations", options.merge(display_name: display_name)
      end

      # POST /1/organizations/[idOrg or name]/logo

      # DELETE /1/organizations/[idOrg or name]
      def delete_organization(organization_id)
        delete "organizations/#{organization_id}"
      end

      # DELETE /1/organizations/[idOrg or name]/[resource]
      # logo
      # members/[idMember]
      # members/[idMember]/all
      # prefs/associatedDomain
      # prefs/orgInviteRestrict
    end
  end
end
