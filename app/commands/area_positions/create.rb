module AreaPositions
  class Create < AreaPositions::Build
    def run
      result = AreaPositions::Build.call(model, initial)
      if result.success?
        model.save!
        success!
      else
        self.response = result.response
        self.errors.merge!(result.errors)
        fail!
      end
    end
  end
end
