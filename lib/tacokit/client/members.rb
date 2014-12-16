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
        to_value(get "members/#{username}/#{field.camelize(:lower)}", options)
      end

      # GET /1/members/[idMember or username]/actions
      #
      def member_actions(username, options = nil)
        get "members/#{username}/actions", options
      end

      # GET /1/members/[idMember or username]/boardBackgrounds
      # GET /1/members/[idMember or username]/boardBackgrounds/[idBoardBackground]
      # GET /1/members/[idMember or username]/customBoardBackgrounds
      # GET /1/members/[idMember or username]/customBoardBackgrounds/[idBoardBackground]
      # PUT /1/members/[idMember or username]/boardBackgrounds/[idBoardBackground]
      # PUT /1/members/[idMember or username]/customBoardBackgrounds/[idBoardBackground]
      # POST /1/members/[idMember or username]/boardBackgrounds
      # POST /1/members/[idMember or username]/customBoardBackgrounds
      # DELETE /1/members/[idMember or username]/boardBackgrounds/[idBoardBackground]
      # DELETE /1/members/[idMember or username]/customBoardBackgrounds/[idBoardBackground]

      # GET /1/members/[idMember or username]/boardStars
      # GET /1/members/[idMember or username]/boardStars/[idBoardStar]

      # PUT /1/members/[idMember or username]/boardStars/[idBoardStar]
      # PUT /1/members/[idMember or username]/boardStars/[idBoardStar]/idBoard
      # PUT /1/members/[idMember or username]/boardStars/[idBoardStar]/pos
      # POST /1/members/[idMember or username]/boardStars
      # DELETE /1/members/[idMember or username]/boardStars/[idBoardStar]

      # GET /1/members/[idMember or username]/boards
      # GET /1/members/[idMember or username]/boards/[filter]
      # GET /1/members/[idMember or username]/boardsInvited
      # GET /1/members/[idMember or username]/boardsInvited/[field]

      # GET /1/members/[idMember or username]/cards
      # GET /1/members/[idMember or username]/cards/[filter]

      # GET /1/members/[idMember or username]/customEmoji
      # GET /1/members/[idMember or username]/customEmoji/[idCustomEmoji]
      # GET /1/members/[idMember or username]/customStickers
      # GET /1/members/[idMember or username]/customStickers/[idCustomSticker]
      # POST /1/members/[idMember or username]/customEmoji
      # POST /1/members/[idMember or username]/customStickers
      # DELETE /1/members/[idMember or username]/customStickers/[idCustomSticker]

      # GET /1/members/[idMember or username]/deltas

      # GET /1/members/[idMember or username]/notifications
      # GET /1/members/[idMember or username]/notifications/[filter]

      # GET /1/members/[idMember or username]/organizations
      # GET /1/members/[idMember or username]/organizations/[filter]
      # GET /1/members/[idMember or username]/organizationsInvited
      # GET /1/members/[idMember or username]/organizationsInvited/[field]

      # GET /1/members/[idMember or username]/savedSearches
      # GET /1/members/[idMember or username]/savedSearches/[idSavedSearch]
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]/name
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]/pos
      # PUT /1/members/[idMember or username]/savedSearches/[idSavedSearch]/queryg
      # POST /1/members/[idMember or username]/savedSearches
      # DELETE /1/members/[idMember or username]/savedSearches/[idSavedSearch]

      # GET /1/members/[idMember or username]/tokens

      # PUT /1/members/[idMember or username]/prefs/colorBlind
      # PUT /1/members/[idMember or username]/prefs/minutesBetweenSummaries

      # POST /1/members/[idMember or username]/oneTimeMessagesDismissed

      private

      def to_value(response_json)
        response_json['_value']
      end

    end
  end
end