# frozen_string_literal: true

module SEO
  module IndexEntry
    class OasPage < Base
      def indexable?(_pages_index)
        index? || @page.data['is_latest']
      end

      def key
        @key ||= @page.data['permalink']
      end

      def attributes
        attrs = { 'url' => @page.url, 'page' => @page }
        attrs.merge!('version' => version) unless index?
        attrs
      end

      def version
        # (\d+ match or /latest/)
        segments = @page.url.split('/')

        # Remove the errors page segment
        segments.pop if segments.last == 'errors'

        @version ||= Utils::Version.to_version(
          segments.last
        )
      end

      def index?
        @page.url == '/api/'
      end
    end
  end
end
