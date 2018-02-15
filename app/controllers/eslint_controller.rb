class EslintController < ActionController::Base

  before_action :set_options

  def show
    @warnings = ESLintRails::Runner.new(@filename).run(@should_autocorrect)
  end

  def source
    @source = Rails.application.assets[@filename].to_s
  end

  def config_file
    render json: ESLintRails::Config.read(force_default: params[:force_default] || false)
  end

  private

  def set_options
    @filename = params[:filename] || 'application'
    @should_autocorrect = ['true'].include?(params[:should_autocorrect]) ? true : false
  end
end
