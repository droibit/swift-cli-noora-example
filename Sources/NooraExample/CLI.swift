// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser

@main
struct NooraExampleCLI: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Example CLI for Swift",
    version: "0.0.1",
    subcommands: [
      SingleChoiceCommand.self,
      YesOrNoChoiceCommand.self,
      SubprocessCommand.self,
    ],
    defaultSubcommand: SingleChoiceCommand.self
  )
}
