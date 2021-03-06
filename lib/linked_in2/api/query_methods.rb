module LinkedIn2
  module API

    module QueryMethods

      def profile(options={})
        options = coalition(options)
        
        path = person_path(options)
        simple_query(path, options)
      end

      def connections(options={})
        options = coalition(options)

        path = "#{person_path(options)}/connections"
        simple_query(path, options)
      end

      def network_updates(options={})
        options = coalition(options)

        path = "#{person_path(options)}/network/updates"
        simple_query(path, options)
      end

      def company(options = {})
        options = coalition(options)

        path   = company_path(options)
        simple_query(path, options)
      end

      def job(options = {})
        options = coalition(options)

        path = jobs_path(options)
        simple_query(path, options)
      end

      def job_bookmarks(options = {})
        options = coalition(options)

        path = "#{person_path(options)}/job-bookmarks"
        simple_query(path, options)
      end

      def job_suggestions(options = {})
        options = coalition(options)

        path = "#{person_path(options)}/suggestions/job-suggestions"
        simple_query(path, options)
      end

      def group_memberships(options = {})
        options = coalition(options)

        path = "#{person_path(options)}/group-memberships"
        simple_query(path, options)
      end

      def shares(options={})
        options = coalition(options)

        path = "#{person_path(options)}/network/updates?type=SHAR&scope=self"
        simple_query(path, options)
      end

      def share_comments(update_key, options={})
        options = coalition(options)

        path = "#{person_path(options)}/network/updates/key=#{update_key}/update-comments"
        simple_query(path, options)
      end

      def share_likes(update_key, options={})
        options = coalition(options)

        path = "#{person_path(options)}/network/updates/key=#{update_key}/likes"
        simple_query(path, options)
      end

      private

        def coalition(options)
          {format: 'json'}.merge(options)
        end

        def simple_query(path, options={})
          fields = options.delete(:fields) || LinkedIn2.default_profile_fields

          if options.delete(:public)
            path +=":public"
          elsif fields
            path +=":(#{fields.map{ |f| f.to_s.gsub("_","-") }.join(',')})"
          end

          headers = options.delete(:headers) || {}
          params  = to_query(options)
          path   += "?#{params}" if !params.empty?

          Mash.from_json(get(path, headers))
        end

        def person_path(options)
          path = "/people/"
          if id = options.delete(:id)
            path += "id=#{id}"
          elsif url = options.delete(:url)
            path += "url=#{CGI.escape(url)}"
          else
            path += "~"
          end
        end

        def company_path(options)
          path = "/companies"
          
          if domain = options.delete(:domain)
            path += "?email-domain=#{CGI.escape(domain)}"
          elsif id = options.delete(:id)
            path += "/id=#{id}"
          elsif url = options.delete(:url)
            path += "/url=#{CGI.escape(url)}"
          elsif name = options.delete(:name)
            path += "/universal-name=#{CGI.escape(name)}"
          else
            path += "/~"
          end
        end

        def jobs_path(options)
          path = "/jobs"
          if id = options.delete(:id)
            path += "/id=#{id}"
          else
            path += "/~"
          end
        end

    end

  end
end
