module Vagrant
  module Butcher
    module Action
      class Cleanup
        include ::Vagrant::Butcher::EnvHelpers

        def initialize(app, env)
          @app = app
          @delete_all_success = true
        end

        def delete_resource(resource, env)
          begin
            @conn.send(resource.to_sym).delete(victim(env))
            env[:butcher].ui.success "Chef #{resource} '#{victim(env)}' successfully butchered from the server..."
          rescue Exception => e
            env[:butcher].ui.warn "Could not butcher #{resource} #{victim(env)}: #{e.message}"
            @delete_all_success = false
          end
        end

        def cleanup_cache_dir(env)
          if @delete_all_success
            File.delete(host_key_path(env))
            begin
              Dir.delete(cache_dir(env))
            rescue
              # The dir wasn't empty.
            end
          else
            env[:butcher].ui.warn "Client and/or node not butchered from the Chef Server. Client key was left at #{host_key_path(env)}"
          end
        end

        def call(env)
          setup_connection(env)

          if butcher_config(env).enabled
            if chef_client?(env)
              %w(node client).each { |resource| delete_resource(resource, env) }
              cleanup_cache_dir(env)
            end
          else
            env[:butcher].ui.warn "Vagrant::Butcher disabled, not cleaning up Chef server!"
          end

          @app.call(env)
        end
      end
    end
  end
end
