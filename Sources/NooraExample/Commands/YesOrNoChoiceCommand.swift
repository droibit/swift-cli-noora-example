import ArgumentParser
import Noora

struct YesOrNoChoiceCommand: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "yesno",
    abstract: "Example command with a yes/no choice",
  )

  @Flag(
    name: .shortAndLong,
    help: "Show a deletion confirmation prompt instead of authentication prompt",
  )
  var delete: Bool = false

  mutating func run() {
    let noora = Noora()

    let result: Bool = if delete {
      noora.yesOrNoChoicePrompt(
        title: "Delete",
        question: "Are you sure you want to delete the selected item?",
        defaultAnswer: false,
        description: "This action cannot be undone.",
      )
    } else {
      noora.yesOrNoChoicePrompt(
        title: "Authentication",
        question: "Would you like to authenticate?",
        defaultAnswer: true,
        description: "Authentication is required to use some CLI features.",
      )
    }

    // Human-friendly context and outcome
    let contextLabel = delete ? "Delete confirmation" : "Authentication"
    let outcome = result ? "Confirmed" : "Cancelled"
    let message: TerminalText = "\(contextLabel): \(.accent("\(outcome)"))"
    let takeaways: [TerminalText] = if delete {
      result ? ["The item will be deleted."] : ["Deletion canceled."]
    } else {
      result ? ["You are now authenticated."] : ["Authentication skipped."]
    }
    noora.success(.alert(message, takeaways: takeaways))
  }
}
