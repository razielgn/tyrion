module Tyrion
  module Connection
    extend self

    def path= folder_path
      @folder_path = folder_path
    end

    def path
      @folder_path || raise("No path set!")
    end
  end
end
