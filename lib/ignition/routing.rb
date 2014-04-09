module Ignition
  class PageExistsConstraint
    def self.matches?(request)
      id = request.symbolized_path_parameters[:id]
      return exists_and_valid?(id)
    end

    private
      def self.exists_and_valid?(id)
        view_prefix = Rails.application.config.ignition.view_prefix

        Rails.application.config.paths['app/views'].each do |path|
          base = File.expand_path(view_prefix, File.expand_path(path, Rails.root))
          file = File.expand_path(id, base)
          return false if not file.starts_with? base

          templates = Dir.glob("#{file}.*")
          return true if not templates.empty?
        end

        return false
      end
  end
end
