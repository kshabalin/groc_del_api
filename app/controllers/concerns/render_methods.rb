# Controllers' concern to share the methods needed for render
module RenderMethods
  SERIALIZER_SUFFIX = "Serializer".freeze

  protected

  def render_json_success(data)
    render json: { data: data }, status: :ok
  end

  def render_success(resource, serializer: nil, **options)
    serializer ||= fetch_serializer!(resource)

    render_json_success serializer.render_as_json(
      resource,
      view: serializer_view,
      controller: self,
      **options
    )
  end

  def render_collection_success(resources, serializer: nil, **options)
    serializer ||= fetch_serializer!(resources.model)

    render_json_success serializer.render_as_json(
      resources,
      view: serializer_view,
      controller: self,
      **options
    )
  end

  private

  def serializer_view
    @serializer_view ||= params[:serializer_view].presence&.to_sym
  end

  def fetch_serializer!(resource)
    (identifier(resource) + SERIALIZER_SUFFIX).safe_constantize
  end

  def identifier(resource)
    @identifier ||=
      case resource
      when String, Symbol
        resource.to_s.classify
      when Class
        resource.name
      else
        resource.class.name
      end
  end
end
