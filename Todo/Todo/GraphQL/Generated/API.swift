//  This file was automatically generated and should not be edited.

import Apollo

public final class AllTasksQuery: GraphQLQuery {
  public let operationDefinition =
    "query AllTasks {\n  allTasks {\n    __typename\n    ...ListTask\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ListTask.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allTasks", type: .list(.object(AllTask.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allTasks: [AllTask?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allTasks": allTasks.flatMap { (value: [AllTask?]) -> [ResultMap?] in value.map { (value: AllTask?) -> ResultMap? in value.flatMap { (value: AllTask) -> ResultMap in value.resultMap } } }])
    }

    /// Returns all tasks for a user identified by accessKey. Tasks are sorted by a creation timestamp.
    public var allTasks: [AllTask?]? {
      get {
        return (resultMap["allTasks"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllTask?] in value.map { (value: ResultMap?) -> AllTask? in value.flatMap { (value: ResultMap) -> AllTask in AllTask(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllTask?]) -> [ResultMap?] in value.map { (value: AllTask?) -> ResultMap? in value.flatMap { (value: AllTask) -> ResultMap in value.resultMap } } }, forKey: "allTasks")
      }
    }

    public struct AllTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(ListTask.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, note: String? = nil, isDone: Bool) {
        self.init(unsafeResultMap: ["__typename": "Task", "id": id, "name": name, "note": note, "isDone": isDone])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var listTask: ListTask {
          get {
            return ListTask(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class CreateTaskMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CreateTask($name: String!, $note: String, $isDone: Boolean) {\n  createTask(name: $name, note: $note, isDone: $isDone) {\n    __typename\n    ...ListTask\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ListTask.fragmentDefinition) }

  public var name: String
  public var note: String?
  public var isDone: Bool?

  public init(name: String, note: String? = nil, isDone: Bool? = nil) {
    self.name = name
    self.note = note
    self.isDone = isDone
  }

  public var variables: GraphQLMap? {
    return ["name": name, "note": note, "isDone": isDone]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createTask", arguments: ["name": GraphQLVariable("name"), "note": GraphQLVariable("note"), "isDone": GraphQLVariable("isDone")], type: .object(CreateTask.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createTask: CreateTask? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createTask": createTask.flatMap { (value: CreateTask) -> ResultMap in value.resultMap }])
    }

    /// Creates a new task. Returns newly created task.
    /// Default value for parameter "isDone" is false. Default value for "note" is null.
    public var createTask: CreateTask? {
      get {
        return (resultMap["createTask"] as? ResultMap).flatMap { CreateTask(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createTask")
      }
    }

    public struct CreateTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(ListTask.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, note: String? = nil, isDone: Bool) {
        self.init(unsafeResultMap: ["__typename": "Task", "id": id, "name": name, "note": note, "isDone": isDone])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var listTask: ListTask {
          get {
            return ListTask(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct ListTask: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment ListTask on Task {\n  __typename\n  id\n  name\n  note\n  isDone\n}"

  public static let possibleTypes = ["Task"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("note", type: .scalar(String.self)),
    GraphQLField("isDone", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String, note: String? = nil, isDone: Bool) {
    self.init(unsafeResultMap: ["__typename": "Task", "id": id, "name": name, "note": note, "isDone": isDone])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var note: String? {
    get {
      return resultMap["note"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "note")
    }
  }

  public var isDone: Bool {
    get {
      return resultMap["isDone"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isDone")
    }
  }
}