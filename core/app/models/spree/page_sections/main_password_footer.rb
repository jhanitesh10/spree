module Spree
  module PageSections
    class MainPasswordFooter < Spree::PageSection
      alias logo asset

      BACKGROUND_COLOR_DEFAULT = '#F5F5F4'
      TOP_PADDING_DEFAULT = 32
      BOTTOM_PADDING_DEFAULT = 32

      def self.role
        'footer'
      end

      def icon_name
        'layout-bottombar'
      end
    end
  end
end
