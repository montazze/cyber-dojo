
class Avatars

  def self.names
    %w(alligator buffalo cheetah deer
       elephant frog gorilla hippo
       koala lion moose panda
       raccoon snake wolf zebra
    )
  end

  def self.valid?(name)
    names.include?(name)
  end

  def initialize(kata)
    @parent = kata
  end

  def each
    return enum_for(:each) unless block_given?
    # Could do kata.exists?('started_avatars.json')
    # and use that if it exists
    Avatars.names.each do |name|
      avatar = self[name]
      yield avatar if avatar.exists?
    end
  end

  def [](name)
    Avatar.new(@parent, name)
  end

  def active
    select(&:active?)
  end

  def names
    collect(&:name)
  end

  private

  include Enumerable

end
