class ProfileParser

  attr_reader :data, :profile

  def initialize(profile)
    @profile = profile
    @data    = client.profile(fields:
      %w(languages skills certifications educations courses volunteer first_name
         last_name headline location summary positions picture-urls::(original)
         publications projects))
  end

  def parse
    profile.full_name  = "#{data.first_name} #{data.last_name}"
    profile.avatar     = data["picture-urls"].all.first
    profile.headline   = data.headline
    profile.skills     = parsed_skills
    profile.educations = parsed_educations
    profile.positions  = parsed_positions
    profile.projects   = parsed_projects
    profile.courses    = parsed_courses
    profile.save
  end

protected
  def client
    client  = LinkedIn::Client.new(ENV['CONSUMER_KEY'],ENV['CONSUMER_SECRET'])
    client.authorize_from_access(ENV['CLIENT_TOKEN'], ENV['CLIENT_ACCESS'])
    client
  end

  def parsed_skills
    return [] unless data.skills

    data.skills.all.map { |s| s.skill }
  end

  def parsed_educations
    return [] unless data.educations

    data.educations.all.map do |education|
      {
        school_name: education.school_name,
        start_date:  parse_date(education.start_date),
        end_date:    parse_date(education.end_date)
      }
    end
  end

  def parsed_positions
    return [] unless data.positions

    data.positions.all.map do |position|
      {
        company:    position.company.name,
        title:      position.title,
        start_date: parse_date(position.start_date)
      }
    end
  end

  def parsed_projects
    data.projects ? data.projects.all : []
  end

  def parsed_courses
    data.courses ? data.courses.all : []
  end

  def parse_date(ln_date)
    return "" unless ln_date.month && ln_date.year
    Date.strptime("#{ln_date.month}-#{ln_date.year}", "%m-%Y")
  end

end
