module Base = struct
  module Tag = struct
    type t = string * string (** (tag-name, value) *)
  end

  (** https://docs.datadoghq.com/developers/dogstatsd/#metrics *)
  module Metric = struct
    module Counter = struct
      type t =
        [ `Increment (** Increments by 1 *)
        | `Decrement (** Decrements by 1 *)
        | `Value of int ] (** Decrements or Increments by the given value *)
    end

    type typ =
      [ `Counter of Counter.t
      | `Gauge of float
      | `Timer of float
      | `Histogram of int
      | `Set of string ]

    type t =
      { metric_name : string
      ; metric : typ
      ; sample_rate : float option
      (** Sample rates only work with `Counter, `Histogram and `Timer typ
          metrics *)
      ; tags : Tag.t list }
  end

  (** https://docs.datadoghq.com/developers/dogstatsd/#service-checks *)
  module ServiceCheck = struct
    type status =
      [ `Ok
      | `Warning
      | `Critical
      | `Unknown ]

    type t =
      { name : string
      ; status : status
      ; timestamp : int option
      ; hostname : string option
      ; tags : Tag.t list
      ; message: string option }
  end

  (** https://docs.datadoghq.com/developers/dogstatsd/#events *)
  module Event = struct
    type priority = [ `Normal | `Low ]

    type alert =
      [ `Error
      | `Warning
      | `Info
      | `Success ]

    type t =
      { title : string
      ; text : string
      ; timestamp : int option
      ; hostname : string option
      ; aggregation_key : string option
      ; priority : priority option (** defaults to `Normal *)
      ; source_type_name : string option
      ; alert_type : alert option (** defaults to `Info *)
      ; tags: Tag.t list }
  end
end

module IO = struct

  module Metric = struct
    let t_send t = t |> ignore; failwith "not yet implemented"
    let send ?tags ?sample_rate typ metric_name =
      (tags, sample_rate, typ, metric_name) |> ignore;
      failwith "not yet implemented"
  end

  module ServiceCheck = struct
    let t_send t = t |> ignore; failwith "not yet implemented"
    let send ?tags ?message ?hostname ?timestamp status check =
      (tags, message, hostname, timestamp, status, check) |> ignore;
      failwith "not yet implemented"
  end

  module Event = struct
    let t_send t = t |> ignore; failwith "not yet implemented"
    let send ?tags ?hostname ?timestamp ?aggregation_key ?source_type_name
        ?alert_type ~title ~text =
      (tags, hostname, timestamp, aggregation_key, source_type_name,
       alert_type, title, text) |> ignore;
      failwith "not yet implemented"
  end
end
