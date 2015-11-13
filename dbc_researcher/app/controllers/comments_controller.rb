class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    # @comment = Proposal.find_by(id: params[:proposal_id]).comments.create(comment_params.merge({user_id: current_user.id}))

    @observation = Observation.find_by(id: params[:observation_id])
    @experiment = Experiment.find_by(id: params[:experiment_id])
    @proposal = Proposal.find_by(id: params[:proposal_id])

    if @observation
      @comment = @observation.comments.create(comment_params.merge({user_id: current_user.id}))
      render json:  {comment_text: @comment.comment_text, name: @comment.user.name}
      # redirect_to proposal_experiment_observation_path(@proposal, @experiment, @observation)

    elsif @experiment
      @comment = @experiment.comments.create(comment_params.merge({user_id: current_user.id}))
      render json:  {comment_text: @comment.comment_text, name: @comment.user.name}
      # redirect_to proposal_experiment_path(@proposal, @experiment)

    elsif @proposal
      p params
      @comment = @proposal.comments.create(comment_params.merge({user_id: current_user.id}))
      render json:  {comment_text: @comment.comment_text, name: @comment.user.name}
      # redirect_to proposal_path(@proposal)
    end


  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text)
  end

  def valid_comment?
    if @comment.valid?
     true
    else
      flash[:error] = "Please enter a valid comment"
      false
    end

  end
end
