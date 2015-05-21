class ReRatingsController < ApplicationController
  unloadable

  def create
    @rap = ReArtifactProperties.find_by_id(params[:re_artifact_properties_id])
    @rating = ReRating.find_or_create_by_re_artifact_properties_id(params[:re_artifact_properties_id])
    @rating.value = params[:re_rating][:value]
    @rating.user_id = User.current.id

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rap, :notice => t(:rating_saved).html_safe }
        format.js
      else
        format.html { redirect_to @rap, :notice => t(:re_could_not_be_rated).html_safe }
      end
    end
  end

  def update
    @rap = ReArtifactProperties.find_by_id(params[:re_artifact_properties_id])
    @rating = User.current.re_ratings.find_by_re_artifact_properties_id(@rap.id)
    if @rating.update_attributes(params[:re_rating])
      respond_to do |format|
        format.html { redirect_to @rap, :notice => t(:re_rating_updated).html_safe }
        format.js
      end
    end
  end
end
