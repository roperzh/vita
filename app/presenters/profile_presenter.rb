class ProfilePresenter
  attr_reader :client, :profile

  def initialize()
    @client  = LinkedIn::Client.new(ENV['CONSUMER_KEY'],ENV['CONSUMER_SECRET'])
    @client.authorize_from_access(ENV['CLIENT_TOKEN'], ENV['CLIENT_ACCESS'])

    @profile = @client.profile(fields:
      %w(languages skills certifications educations courses volunteer first_name
         last_name headline location summary positions picture-url publications projects))
  end

  def get(value)
    profile.send(value)
  end

  def full_name
    "#{profile.first_name} #{profile.last_name}"
  end

  def avatar
    profile['picture-url']
  end

  def skills
    profile.skills.all.map { |s| s.skill }
  end

  def educations
    profile.educations.all.map do |education|
      Hashie::Mash.new({
        school_name: education.school_name,
        start_date: parse_date(education.start_date),
        end_date: parse_date(education.end_date)
      })
    end
  end

  def positions
    profile.positions.all.map do |position|
      Hashie::Mash.new({
        company: position.company.name,
        title: position.title,
        start_date: parse_date(position.start_date)
      })
    end
  end

  def projects
    profile.projects.all
  end

  def courses
    profile.courses.all
  end

private
  def parse_date(ln_date)
    return "" unless ln_date.month && ln_date.year
    Date.strptime("#{ln_date.month}-#{ln_date.year}", "%m-%Y")
  end
end
