require 'active_record'

class ActiveRecord::Reflection::AssociationReflection
  class AmbiguousAssociationClassError < Exception
    def initialize results
      super "Could not guess association, please specify using class_name. Likely options: #{results.join(', ')}"
    end
  end

  def klass
    super
  rescue NameError
    @klass ||= ActiveRecord::Base.descendants.select do |model|
      model.name.demodulize.parameterize('_') == class_name.parameterize('_')
    end.tap do |results|
      if results.map(&:name).uniq.many?
        raise AmbiguousAssociationClassError.new(results.map(&:name).uniq)
      end
    end.first
  end
end
