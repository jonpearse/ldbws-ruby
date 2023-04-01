require "ldbws/response_types/base"

module Ldbws::ResponseTypes
  # The loading category of a train
  #
  # === Properties
  # code::
  # colour::
  # image::
  class LoadingCategory < Base
    property :code, String
    property :colour, String
    property :image, String
  end

  # The availability of an individual toilet on a train
  #
  # === Properties
  # type:: the type of toilet
  # status:: whether the toilet is in- or out of service
  class ToiletAvailability < Base
    property :type, String, selector: "."
    property :status, String, selector: "@status", default: "InService"
  end

  # Information about an individual coach in the train.
  #
  # === Properties
  # number:: the coach number or identifier
  # class:: the class of the coach—usually ‘standard’ or ‘first’
  # toilet:: information about {toilets}[rdoc-ref:ToiletAvailability] in the carriage
  # loading:: the loading of the carriage, as a percentage from 0–100.
  class Coach < Base
    property :number, String, selector: "@number"
    property :class, String, selector: "coachClass"
    property :toilet, ToiletAvailability
    property :loading, Integer
  end

  # Information about the formation of a train
  #
  # === Properties
  # loading_category:: how heavily-loaded the train is. Provided as as LoadingCategory
  # coaches:: descriptions of each of the {carriages}[rdoc-ref:Coach] in the train
  class Formation < Base
    property :loading_category, LoadingCategory
    collection :coaches, "coach", Coach
  end
end
