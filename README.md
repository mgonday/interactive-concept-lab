# interactive-concept-lab

A Claude Code plugin that builds **interactive concept labs**: small, runnable Preact + TypeScript apps that teach one concept through experiments the learner runs. Each lab also builds to a single HTML file you can share.

A lab is not a static explainer page. It works like a PhET simulation: the learner changes the inputs to a faithful model of the concept, tries guided experiments, and sees each result explained from the live state. There are no quizzes or right answers. The concept can be a mechanism in the codebase you're working in or a general topic.

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
2. **Designs the experiments and views.** It picks a visual representation that fits the concept and lays out a progression: hook → first tweak → guided experiments → free play → push it.
3. **Builds and tests the model.** It writes plain TypeScript in `src/model/`, with Vitest tests that assert every result the guide explains.
4. **Builds the views and the learning layer.** Canvas 2D draws most views, WebGL or Three.js only where they're needed, and the DOM holds text and controls. A guide suggests "try this" experiments, and its explanations quote the live state.
5. **Verifies the project.** It installs, type-checks, tests, builds, checks that the build is one self-contained `dist/index.html`, and smoke-tests the dev server.
6. **Hands over.** It writes a README for the lab and gives you the URL, the objectives, and one experiment to try first.

The lab is created as a sibling project (`~/GitProjects/<slug>-explorer/` by default), never inside the repo being explained. To run it, use `npm install && npm run dev`. To share it, run `npm run build` and send `dist/index.html`. It opens by double-click with no server or internet.

## Stack used in generated labs

- Vite + TypeScript, with `vite-plugin-singlefile` so the build is one self-contained `index.html`
- Preact + `@preact/signals` for the UI
- A small hand-written store for state (no state library)
- Canvas 2D for views by default; raw WebGL2 with instancing only for very dense views; plain Three.js only for real 3D
- Plain CSS
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
    │   ├── learning-design.md           # objectives, guided experiments, progression
    │   └── visualization-patterns.md    # choosing a representation
    └── scripts/
        └── validate-project.sh          # install, type-check, test, build, check single-file output
```

## Updating the plugin

Edit the source in this repository. Don't edit the installed copy under `~/.claude/plugins/`: it's a cache, and the next update overwrites it.

### 1. Edit the skill

The skill lives in `plugins/interactive-concept-lab/skills/interactive-concept-lab/`.

### 2. Test locally (optional)

```sh
claude --plugin-dir ./plugins/interactive-concept-lab
```

This loads the plugin straight from your working copy for one session. Run `/reload-plugins` after further edits.

### 3. Bump the version

Change `version` in `plugins/interactive-concept-lab/.claude-plugin/plugin.json`:

- patch (`1.0.0` → `1.0.1`) for fixes and wording tweaks
- minor (`1.0.0` → `1.1.0`) for new behaviour or references
- major (`1.0.0` → `2.0.0`) for changes that alter how the skill is used

Installed copies only update when the version changes, so commits pushed without a bump don't reach users. Don't also set `version` in the marketplace entry.

### 4. Validate, commit and push

```sh
claude plugin validate .
claude plugin validate plugins/interactive-concept-lab
git add -A
git commit -m "Describe the change"
git push
```

### 5. Update the installed copy

```sh
claude plugin update interactive-concept-lab@mattias-plugins
```

Then run `/reload-plugins` in any open session. Other users run the same command, or enable auto-update in `/plugin` → Marketplaces.
