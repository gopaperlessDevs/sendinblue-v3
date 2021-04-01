module SendInBlue
  class Config
    attr_accessor :contact_model, :env, :test_mode

    def initialize
      @contact_model = nil
      @env = nil
      @test_mode = false
    end
  end
end
