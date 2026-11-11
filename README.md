# interactive-concept-lab

A Claude Code plugin that builds **interactive concept labs**: small, runnable React + WebGL apps that teach one concept through experiments the learner runs.

A lab is not a static explainer page. It works like a PhET simulation: the learner changes the inputs to a faithful model of the concept, predicts what will happen, and checks whether they were right. The concept can be a mechanism in the codebase you're working in or a general topic.

## Install

In Claude Code:

```
/plugin marketplace add mgonday/interactive-concept-lab
/plugin install interactive-concept-lab@mattias-plugins
```

The skill is available as `interactive-concept-lab:interactive-concept-lab`.

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

To release a change, bump `version` in `plugins/interactive-concept-lab/.claude-plugin/plugin.json` and push. Users can pick up the change with `/plugin marketplace update mattias-plugins`.
