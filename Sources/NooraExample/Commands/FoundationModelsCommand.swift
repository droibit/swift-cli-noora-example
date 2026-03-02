import ArgumentParser
import Noora
import FoundationModels

struct FoundationModelsCommand: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "ai",
    abstract: "Example command to demonstrate Foundation Models"
  )

  mutating func run() async throws {
    print("Running Foundation Models command...")

    if #available(macOS 26.0, *) {
      let session = LanguageModelSession()
      guard SystemLanguageModel.default.isAvailable else {
        print("No available language models on this system.")
        return
      }

      let answer = try await Noora().progressStep(
          message: "What's a good name for a trip to Japan? Respond only with a title",
          successMessage: "Successfully got a response from the language model",
          errorMessage: "Failed to get a response from the language model",
          showSpinner: true,
      ) { updateMessage in
          let response = try await session.respond(to: "What's a good name for a trip to Japan? Respond only with a title")
          return response.content
      }
      print("Answer: \(answer)")
    } else {
      print("Foundation Models are not available on this version of macOS.")
    }
  }
}
