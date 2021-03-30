module SendInBlue
  class Config
    attr_accessor :contact_model, :env

    def initialize
      @contact_model = nil
      @env = nil
    end
  end
end
