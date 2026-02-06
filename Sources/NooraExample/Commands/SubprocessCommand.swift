import ArgumentParser
import Subprocess

struct SubprocessCommand: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "subprocess",
    abstract: "Example command to demonstrate Subprocess",
    aliases: ["subp"],
  )

  mutating func run() async throws {
    print("Running subprocess...")

    do {
      _ = try Executable.path("/usr/bin/xcrun")
        .resolveExecutablePath(in: .inherit)
      print("Successfully resolved xcrun executable path")
    } catch {
      print("Failed to resolve xcrun executable path: \(error)")
      return
    }

    let result = try await Subprocess.run(
      .path("/usr/bin/xcrun"),
      arguments: ["simctl", "list", "devices", "-j"],
      output: .string(limit: .max),
    )

    if let output = result.standardOutput {
      print("\(output)")
    } else {
      print("No output from subprocess.")
    }
  }
}
