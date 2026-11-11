# interactive-concept-lab

A Claude Code plugin that builds **interactive concept labs**: small, runnable React + WebGL apps that teach one concept through experiments the learner runs.

A lab is not a static explainer page. It works like a PhET simulation: the learner changes the inputs to a faithful model of the concept, predicts what will happen, and checks whether they were right. The concept can be a mechanism in the codebase you're working in or a general topic.

## Install

In Claude Code, add the marketplace and install the plugin in one step:

```
/plugin install interactive-concept-lab --marketplace mgonday/interactive-concept-lab
```

Or do it in two steps:

```
/plugin marketplace add mgonday/interactive-concept-lab
/plugin install interactive-concept-lab@mattias-plugins
```

From a shell, use `claude plugin marketplace add mgonday/interactive-concept-lab` and `claude plugin install interactive-concept-lab@mattias-plugins`. Add `--scope user|project|local` to choose where the plugin is installed. The default is `user`.

Claude invokes the skill automatically when your request matches it. You can also call it directly as `/interactive-concept-lab:interactive-concept-lab`.

### Update

Third-party marketplaces don't auto-update by default. To update the plugin:

```sh
claude plugin update interactive-concept-lab@mattias-plugins
```

Or open `/plugin` and choose **Update now** on the Installed tab. To get updates automatically, open `/plugin` and choose **Enable auto-update** for `mattias-plugins` on the Marketplaces tab.

### Team setup

To recommend the plugin to everyone working in a repository, run this in that repository and commit the `.claude/settings.json` it writes:

```sh
claude plugin marketplace add mgonday/interactive-concept-lab --scope project
```

To also enable the plugin for the project, add `enabledPlugins` so the file looks like this:

```json
{
  "extraKnownMarketplaces": {
    "mattias-plugins": {
      "source": { "source": "github", "repo": "mgonday/interactive-concept-lab" }
    }
  },
  "enabledPlugins": {
    "interactive-concept-lab@mattias-plugins": true
  }
}
```

`enabledPlugins` doesn't install anything. Each contributor still runs `claude plugin install interactive-concept-lab@mattias-plugins --scope project` once per clone.

## Usage

Ask Claude for an interactive app, simulation, explorer, or playground to understand a concept. For example:

- "Build me an interactive explorer for how range selection works in this codebase"
- "Make a playground that teaches how a low-pass filter shapes a signal"
- "I want a simulation to understand consistent hashing"

Claude then:

1. **Pins down the concept.** It writes a `CONCEPT.md` with the learning objectives, the misconceptions to break, the variables and observables, and the model's simplifications. For codebase concepts, the model comes from the real source.
2. **Designs the experiments and views.** It picks a visual representation that fits the concept and lays out a progression: engage → build intuition → explore → predict → explain → apply.
3. **Builds and tests the model.** It writes plain TypeScript in `src/model/`, with Vitest tests that assert every challenge answer.
4. **Builds the views and the learning layer.** WebGL is used where it carries information and DOM for text and controls. Predict-then-reveal challenges and the explanations quote the live state.
5. **Verifies the project.** It installs, type-checks, tests, builds, and smoke-tests the dev server.
6. **Hands over.** It writes a README for the lab and gives you the URL, the objectives, and one experiment to try first.

The lab is created as a sibling project (`~/GitProjects/<slug>-explorer/` by default), never inside the repo being explained. To run it, use `npm install && npm run dev`.

## Stack used in generated labs

- Vite + React + TypeScript
- Three.js via React Three Fiber + Drei for 3D or spatial scenes; raw WebGL2 with instancing for dense 2D views
- Zustand (or a small store) for state
- Vitest for model tests

## Repository layout

```
.claude-plugin/marketplace.json          # marketplace "mattias-plugins"
plugins/interactive-concept-lab/
├── .claude-plugin/plugin.json           # plugin manifest
└── skills/interactive-concept-lab/
    ├── SKILL.md                         # the skill's instructions
    ├── references/
    │   ├── codebase-concepts.md         # modelling concepts from real source code
    │   ├── learning-design.md           # objectives, challenges, progression
    │   └── visualization-patterns.md    # choosing a representation
    └── scripts/
        └── validate-project.sh          # install, type-check, test, build a lab
```

## Development

Test local changes without installing:

```sh
claude --plugin-dir ./plugins/interactive-concept-lab
```

Validate the manifests:

```sh
claude plugin validate .
claude plugin validate plugins/interactive-concept-lab
```

To release a change, bump `version` in `plugins/interactive-concept-lab/.claude-plugin/plugin.json` and push. Users only receive a new copy when the version changes, so commits pushed without a bump don't reach them. Don't also set `version` in the marketplace entry.
