module Tacokit
  class Client
    module Organizations

      # GET /1/organizations/[idOrg or name]
      def organization(org_id, options = nil)
        get "organizations/#{org_id}", options
      end

      # GET /1/organizations/[idOrg or name]/[field]
      def organization_field(org_id, field, options = nil)
        get "organizations/#{org_id}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/organizations/[idOrg or name]/actions
      # GET /1/organizations/[idOrg or name]/boards
      # GET /1/organizations/[idOrg or name]/boards/[filter]
      # GET /1/organizations/[idOrg or name]/deltas
      # GET /1/organizations/[idOrg or name]/members
      # GET /1/organizations/[idOrg or name]/members/[filter]
      # GET /1/organizations/[idOrg or name]/members/[idMember]/cards
      # GET /1/organizations/[idOrg or name]/membersInvited
      # GET /1/organizations/[idOrg or name]/membersInvited/[field]
      # GET /1/organizations/[idOrg or name]/memberships
      # GET /1/organizations/[idOrg or name]/memberships/[idMembership]
      def organization_resource(org_id, resource, options = nil)
        get "organizations/#{org_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # PUT /1/organizations/[idOrg or name]
      # PUT /1/organizations/[idOrg or name]/desc
      # PUT /1/organizations/[idOrg or name]/displayName
      # PUT /1/organizations/[idOrg or name]/members
      # PUT /1/organizations/[idOrg or name]/members/[idMember]
      # PUT /1/organizations/[idOrg or name]/members/[idMember]/deactivated
      # PUT /1/organizations/[idOrg or name]/memberships/[idMembership]
      # PUT /1/organizations/[idOrg or name]/name
      # PUT /1/organizations/[idOrg or name]/prefs/associatedDomain
      # PUT /1/organizations/[idOrg or name]/prefs/boardVisibilityRestrict/org
      # PUT /1/organizations/[idOrg or name]/prefs/boardVisibilityRestrict/private
      # PUT /1/organizations/[idOrg or name]/prefs/boardVisibilityRestrict/public
      # PUT /1/organizations/[idOrg or name]/prefs/externalMembersDisabled
      # PUT /1/organizations/[idOrg or name]/prefs/googleAppsVersion
      # PUT /1/organizations/[idOrg or name]/prefs/orgInviteRestrict
      # PUT /1/organizations/[idOrg or name]/prefs/permissionLevel
      # PUT /1/organizations/[idOrg or name]/website
      def update_organization(org_id, options = {})
        put "organizations/#{org_id}", options
      end

      # POST /1/organizations
      # POST /1/organizations/[idOrg or name]/logo
      # DELETE /1/organizations/[idOrg or name]
      # DELETE /1/organizations/[idOrg or name]/logo
      # DELETE /1/organizations/[idOrg or name]/members/[idMember]
      # DELETE /1/organizations/[idOrg or name]/members/[idMember]/all
      # DELETE /1/organizations/[idOrg or name]/prefs/associatedDomain
      # DELETE /1/organizations/[idOrg or name]/prefs/orgInviteRestrict
    end
  end
end
