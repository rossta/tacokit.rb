module Tacokit
  class Client
    module Members

      # GET /1/members/[idMember or username]
      def member(username = 'me', options = nil)
        get "members/#{username}", options
      end

      # GET /1/members/[idMember or username]/[field]
      def member_field(username, field, options = nil)
        get "members/#{username}/#{to_path(field)}", options
      end

      # GET /1/members/[idMember or username]/[resource]
      # actions
      # boardBackgrounds
      # boardBackgrounds/[idBoardBackground]
      # boardStars
      # boardStars/[idBoardStar]
      # boards/[filter]
      # boardsInvited
      # boardsInvited/[field]
      # cards
      # cards/[filter]
      # customBoardBackgrounds
      # customBoardBackgrounds/[idBoardBackground]
      # customEmoji
      # customEmoji/[idCustomEmoji]
      # customStickers
      # customStickers/[idCustomSticker]
      # deltas
      # notifications
      # notifications/[filter]
      # organizations
      # organizations/[filter]
      # organizationsInvited
      # organizationsInvited/[field]
      # savedSearches
      # savedSearches/[idSavedSearch]
      # tokens
      def member_resource(username, resource, options = nil)
        get "members/#{username}/#{to_path(resource)}", options
      end

      # POST /1/members/[idMember or username]/[resource]
      # avatar
      # boardBackgrounds
      # boardStars
      # customBoardBackgrounds
      # customEmoji
      # customStickers
      # oneTimeMessagesDismissed
      # savedSearches

      # PUT /1/members/[idMember or username]
      def update_member(username, options = {})
        put "members/#{username}", options
      end

      # PUT /1/members/[idMember or username]/[field]
      # avatarSource
      # fullName
      # initials
      # username
      # boardBackgrounds/[idBoardBackground]
      # boardStars/[idBoardStar]
      # boardStars/[idBoardStar]/idBoard
      # boardStars/[idBoardStar]/pos
      # customBoardBackgrounds/[idBoardBackground]
      # prefs/colorBlind
      # prefs/minutesBetweenSummaries
      # savedSearches/[idSavedSearch]
      # savedSearches/[idSavedSearch]/name
      # savedSearches/[idSavedSearch]/pos
      # savedSearches/[idSavedSearch]/query

      # DELETE /1/members/[idMember or username]/[resource]/[resource_id]
      # boardBackgrounds/[idBoardBackground]
      # boardStars/[idBoardStar]
      # customBoardBackgrounds/[idBoardBackground]
      # customStickers/[idCustomSticker]
      # savedSearches/[idSavedSearch]
    end
  end
end
