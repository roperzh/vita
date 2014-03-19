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
    profile.full_name      = "#{data.first_name} #{data.last_name}"
    profile.avatar         = data["picture-urls"].all.first
    profile.headline       = data.headline
    profile.skills         = parsed_skills
    profile.educations     = parsed_educations
    profile.positions      = parsed_positions
    profile.projects       = parsed_projects
    profile.courses        = parsed_courses
    profile.certifications = parsed_certifications
    profile.volunteer      = parsed_volunteer_experiences
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
        summary:     education.summary,
        degree:      education.degree,
        notes:       education.notes,
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
        summary:    position.summary,
        start_date: parse_date(position.start_date),
        end_date:   parse_date(position.end_date)
      }
    end
  end

  def parsed_projects
    data.projects ? data.projects.all : []
  end

  def parsed_courses
    data.courses ? data.courses.all : []
  end

  def parsed_certifications
    data.certifications ? data.certifications.all : []
  end

  def parsed_volunteer_experiences
    data.volunteer.volunteer_experiences.all.map do |experience|
      {
        role:         experience.role,
        organization: experience.organization.name
      }
    end
  end

  def parse_date(ln_date)
    return "today" unless ln_date
    if ln_date.month
      "#{ln_date.month}/#{ln_date.year}"
    else
      "#{ln_date.year}"
    end
  end

end
