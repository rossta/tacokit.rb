module Tacokit
  class Client
    module Members

      # GET /1/members/[idMember or username]
      #
      def member(username = 'me', options = nil)
        get "members/#{username}", options
      end
      # PUT /1/members/[idMember or username]
      # PUT /1/members/[idMember or username]/avatarSource
      # PUT /1/members/[idMember or username]/fullName
      # PUT /1/members/[idMember or username]/initials
      # PUT /1/members/[idMember or username]/username
      # POST /1/members/[idMember or username]/avatar

      # GET /1/members/[idMember or username]/[field]
      #
      def member_field(username, field, options = nil)
        get "members/#{username}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/members/[idMember or username]/actions
      # GET /1/members/[idMember or username]/boardBackgrounds
      # GET /1/members/[idMember or username]/boardBackgrounds/[idBoardBackground]
      # GET /1/members/[idMember or username]/boardStars
      # GET /1/members/[idMember or username]/boardStars/[idBoardStar]
      # GET /1/members/[idMember or username]/boards/[filter]
      # GET /1/members/[idMember or username]/boardsInvited
      # GET /1/members/[idMember or username]/boardsInvited/[field]
      # GET /1/members/[idMember or username]/cards
      # GET /1/members/[idMember or username]/cards/[filter]
      # GET /1/members/[idMember or username]/customBoardBackgrounds
      # GET /1/members/[idMember or username]/customBoardBackgrounds/[idBoardBackground]
      # GET /1/members/[idMember or username]/customEmoji
      # GET /1/members/[idMember or username]/customEmoji/[idCustomEmoji]
      # GET /1/members/[idMember or username]/customStickers
      # GET /1/members/[idMember or username]/customStickers/[idCustomSticker]
      # GET /1/members/[idMember or username]/deltas
      # GET /1/members/[idMember or username]/notifications
      # GET /1/members/[idMember or username]/notifications/[filter]
      # GET /1/members/[idMember or username]/organizations
      # GET /1/members/[idMember or username]/organizations/[filter]
      # GET /1/members/[idMember or username]/organizationsInvited
      # GET /1/members/[idMember or username]/organizationsInvited/[field]
      # GET /1/members/[idMember or username]/savedSearches
      # GET /1/members/[idMember or username]/savedSearches/[idSavedSearch]
      # GET /1/members/[idMember or username]/tokens
      #
      def member_resource(username, resource, options = nil)
        get "members/#{username}/#{resource.to_s.camelize(:lower)}", options
      end

      # POST /1/members/[idMember or username]/boardBackgrounds
      # POST /1/members/[idMember or username]/boardStars
      # POST /1/members/[idMember or username]/customBoardBackgrounds
      # POST /1/members/[idMember or username]/customEmoji
      # POST /1/members/[idMember or username]/customStickers
      # POST /1/members/[idMember or username]/oneTimeMessagesDismissed
      # POST /1/members/[idMember or username]/savedSearches

      # PUT /1/members/[idMember or username]/boardBackgrounds/[idBoardBackground]
      # PUT /1/members/[idMember or username]/boardStars/[idBoardStar]
      # PUT /1/members/[idMember or username]/boardStars/[idBoardStar]/idBoard
      # PUT /1/members/[idMember or username]/boardStars/[idBoardStar]/pos
      # PUT /1/members/[idMember or username]/customBoardBackgrounds/[idBoardBackground]
      # PUT /1/members/[idMember or username]/prefs/colorBlind
      # PUT /1/members/[idMember or username]/prefs/minutesBetweenSummaries
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]/name
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]/pos
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]/queryg
      def update_member(username, options = {})
        put "members/#{username}", options
      end

      # DELETE /1/members/[idMember or username]/boardBackgrounds/[idBoardBackground]
      # DELETE /1/members/[idMember or username]/boardStars/[idBoardStar]
      # DELETE /1/members/[idMember or username]/customBoardBackgrounds/[idBoardBackground]
      # DELETE /1/members/[idMember or username]/customStickers/[idCustomSticker]
      # DELETE /1/members/[idMember or username]/savedSearches/[idSavedSearch]
    end
  end
end
