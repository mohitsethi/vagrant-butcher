module Vagrant
  module Butcher
    class Config < ::Vagrant.plugin('2', :config)
      attr_accessor :enabled
      attr_accessor :guest_key_path
      attr_reader   :cache_dir
      attr_accessor :verify_ssl
      attr_accessor :retries
      attr_accessor :retry_interval
      attr_accessor :proxy
      attr_accessor :client_name
      attr_accessor :client_key

      def initialize
        super
        @enabled = UNSET_VALUE
        @guest_key_path = UNSET_VALUE
        @cache_dir = UNSET_VALUE
        @verify_ssl = UNSET_VALUE
        @retries = UNSET_VALUE
        @retry_interval = UNSET_VALUE
        @proxy = UNSET_VALUE
        @client_name = UNSET_VALUE
        @client_key = UNSET_VALUE
      end

      def cache_dir=(value)
        @cache_dir = File.expand_path(value)
      end

      def finalize!
        @enabled = true if @enabled == UNSET_VALUE
        @guest_key_path = '/etc/chef/client.pem' if @guest_key_path == UNSET_VALUE
        @cache_dir = File.expand_path ".vagrant/butcher" if @cache_dir == UNSET_VALUE
        @verify_ssl = true if @verify_ssl == UNSET_VALUE
        @retries = 0 if @retries == UNSET_VALUE
        @retry_interval = 0 if @retry_interval == UNSET_VALUE
        @proxy = nil if @proxy == UNSET_VALUE
        @client_name = nil if @client_name == UNSET_VALUE
        @client_key = nil if @client_key == UNSET_VALUE
      end
    end
  end
end
