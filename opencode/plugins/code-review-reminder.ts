import type { Plugin } from "@opencode-ai/plugin"

const TARGET_AGENT = "deep-build"
const MUTATION_TOOLS = new Set(["edit", "write", "bash", "patch", "multiedit"])
const REVIEW_TOOLS = new Set(["task"])
const REVIEW_INTERVAL = 10

const REMINDER = `

[SYSTEM: You have made ${REVIEW_INTERVAL}+ mutation tool calls since your last code review. Pause and delegate to code-reviewer via task tool to review changes after completing this feature/todo.]`

export const CodeReviewReminder: Plugin = async () => {
  const counters = new Map<string, number>()
  const agents = new Map<string, string>()

  return {
    "chat.message": async (input) => {
      if (!input.sessionID || !input.agent) return
      agents.set(input.sessionID, input.agent)
    },
    "tool.execute.after": async (input, output) => {
      const { tool, sessionID } = input

      if (agents.get(sessionID) !== TARGET_AGENT) return

      if (REVIEW_TOOLS.has(tool)) {
        counters.set(sessionID, 0)
        return
      }

      if (!MUTATION_TOOLS.has(tool)) return

      const count = (counters.get(sessionID) ?? 0) + 1

      if (count >= REVIEW_INTERVAL) {
        output.output += REMINDER
        counters.set(sessionID, 0)
        return
      }
      counters.set(sessionID, count)
    },
    event: async ({ event }) => {
      if (event.type !== "session.deleted") return
      const props = event.properties as { info?: { id?: string } } | undefined
      const id = props?.info?.id
      if (!id) return
      counters.delete(id)
      agents.delete(id)
    },
  }
}
