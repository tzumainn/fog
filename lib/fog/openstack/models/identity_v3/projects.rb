require 'fog/core/collection'
require 'fog/openstack/models/identity_v3/project'

module Fog
  module Identity
    class OpenStack
      class V3
        class Projects < Fog::Collection
          model Fog::Identity::OpenStack::V3::Project

          def all params={}
            load(service.list_projects(params).body['projects'])
          end

          def auth_projects params={}
            load(service.auth_projects(params).body['projects'])
          end

          def find_by_id(id)
            cached_project = self.find { |project| project.id == id }
            return cached_project if cached_project
            project_hash = service.get_project(id).body['project']
            Fog::Identity::OpenStack::V3::Project.new(
                project_hash.merge(:service => service))
          end

        end
      end
    end
  end
end