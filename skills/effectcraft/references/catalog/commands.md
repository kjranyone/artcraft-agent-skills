# EffectCraft command catalog (734 commands)

| namespace | n |
|---|---|
| `anim` | 9 |
| `app` | 12 |
| `cache` | 1 |
| `camera` | 19 |
| `command` | 2 |
| `comp` | 31 |
| `contentFill` | 2 |
| `edit` | 27 |
| `editor` | 1 |
| `effect` | 21 |
| `effects` | 1 |
| `engine` | 1 |
| `essential` | 22 |
| `expr` | 2 |
| `face` | 5 |
| `file` | 61 |
| `footage` | 12 |
| `help` | 13 |
| `item` | 1 |
| `jobs` | 3 |
| `keys` | 36 |
| `layer` | 122 |
| `learn` | 5 |
| `light` | 3 |
| `liquify` | 2 |
| `markers` | 5 |
| `mask` | 17 |
| `material` | 4 |
| `mediaBrowser` | 7 |
| `motion` | 1 |
| `objectMatte` | 5 |
| `paint` | 6 |
| `path` | 6 |
| `paths` | 3 |
| `playback` | 6 |
| `prefs` | 5 |
| `project` | 13 |
| `prop` | 18 |
| `puppet` | 10 |
| `render` | 4 |
| `renderQueue` | 20 |
| `roto` | 14 |
| `scopes` | 1 |
| `script` | 4 |
| `scriptui` | 6 |
| `shape` | 8 |
| `shortcuts` | 7 |
| `storage` | 3 |
| `templates` | 5 |
| `text` | 13 |
| `time` | 17 |
| `track` | 22 |
| `view` | 78 |
| `warp` | 3 |
| `window` | 9 |

439 of 734 enabled in a fresh headless context (context-dependent commands show enabled: false until the selection / active comp / tool mode exists).

## Commands

### anim

- `anim.addKeyframe` *(context)* {} — keys the selected properties at the CTI
- `anim.applyBuiltinPreset` *(context)* {preset: id|name (see anim.builtinPresets), layers?}
- `anim.applyPreset` *(context)* {path | preset, layers?}
- `anim.applyRecentPreset` *(context)* {index? | path?, layers?}  (Cmd+Alt+Shift+F)
- `anim.browsePresets` 
- `anim.builtinPresets` {category?}
- `anim.clearRecentPresets` *(context)* 
- `anim.reveal` {kind: keyframes|animation|modified}
- `anim.savePreset` *(context)* {path (.ecpreset), name?} — saves the selected properties/effects

### app

- `app.about` 
- `app.capabilities` {} → version, command/effect counts, export formats, parity summary
- `app.commandPalette` {query?}  (Cmd+Shift+Space)
- `app.find` {query?}  (Cmd+F)
- `app.gpuInfo` 
- `app.hide` 
- `app.hideOthers` 
- `app.keyboardShortcuts`   (Cmd+Alt+')
- `app.quit`   (Cmd+Q)
- `app.settings` {page?: general|startup|project|composition|previews|appearance|grids|labels|type|import|export|audio|disk|memory|video|3d|scripting}
- `app.showAll` 
- `app.templates` {kind: renderSettings|outputModule}

### cache

- `cache.diskStats` 

### camera

- `camera.analyze` {layer?, effect?: uid|name|index, wait?: block until done}
- `camera.cancel` *(context)* 
- `camera.create` {layer?, effect?}
- `camera.createFromSolve` {kind: text|solid|null|shadowCatcher|camera, points?: [id] (default: selected), target?: {center, normal, size?} (comp world), multiple?, layer?, effect?}
- `camera.deletePoints` {points?: [id] (default: selected), layer?, effect?, wait?}
- `camera.dolly` {amount (px, + = forward), layer?, merge?}
- `camera.fromModel` {comp?, layers?: 3D model layers (default selected)}
- `camera.fromView` {comp?}
- `camera.linkFocusToLayer` *(context)* {comp?, camera?, layer?}
- `camera.linkFocusToPoi` *(context)* {comp?, camera?}
- `camera.orbit` {yaw|dx deg, pitch|dy deg, layer?, merge?} — current 3D view (camera layer in Active Camera)
- `camera.orbitNull` {comp?, layer?: camera (default selected/active)}
- `camera.pan` {dx, dy (comp px), layer?, merge?}
- `camera.points` {layer?, effect?, time?: comp seconds} → visible solved points
- `camera.selectPoints` {points: [id], add?, toggle?}
- `camera.setFocusToLayer` *(context)* {comp?, camera?, layer?}
- `camera.setGroundPlane` {points?: [id] (default: selected), layer?, effect?}
- `camera.solveStatus` {layer?, effect?}
- `camera.stereoRig` {comp?, configuration?: stereoPair|centerRight|centerLeft, sceneDepth? (% of comp width, default 3), convergence?: bool, convergenceOf?: poi|zoom, zOffset?, view3d?: 3D Glasses view index (default 5 Balanced Colored Red Blue)}

### command

- `command.describe` {command} → id, label, menu, shortcut, params doc, JSON `schema`, enabled
- `command.list` {filter?, enabledOnly?, schemas? (add each command's params JSON Schema)}

### comp

- `comp.activateRecent` {comp?}  (Shift+Escape)
- `comp.addMarker` {time?, comment?}  (Num*)
- `comp.close` {comp?}
- `comp.copyFrame` {comp?, time?, scale?}
- `comp.cropToLayerBounds` *(context)* {layers?}
- `comp.cropToRegionOfInterest` *(context)* {comp?}
- `comp.deletePreset` {name}
- `comp.flowchart`   (Cmd+Shift+F11)
- `comp.info` {comp?}
- `comp.miniFlowchart`   (Tab)
- `comp.new` {name?, width?, height?, frameRate?, duration? (s), startTime? (s) | startTimecode?, background? [r,g,b]|#hex, pixelAspect?, shutterAngle?, shutterPhase?, motionBlurSamples?, adaptiveSampleLimit? (16–256), preserveFrameRate?: bool, preserveResolution?: bool, renderer?: classic3D|advanced3D, anchor?, open?}  (Cmd+N)
- `comp.open` {comp: id|name}
- `comp.openInEssentialGraphics` {comp?} → makes it the Essential Graphics panel's Primary composition and shows the panel
- `comp.presets` 
- `comp.renderer` {renderer?: advanced3d|classic3d (omit to read), value?}
- `comp.responsiveTime` {op: intro|outro|workArea}
- `comp.revealInProject` {comp?}
- `comp.saveFrameAs` {path (.png; with queue: an output path or template), time?, scale?, queue?: bool (add a Render Queue item from the Frame Default templates instead of writing now)}  (Cmd+Alt+S)
- `comp.saveFrameAsExr` {path (.exr), comp?, time?, scale?} → a multi-layer OpenEXR: composite R,G,B,A + `<layer>.R/G/B/A` per layer (linear, premultiplied)
- `comp.saveFrameAsPsd` {path (.psd), comp?, time?, scale?} → a layered PSD: one layer per visible comp layer (blend mode, opacity) + the merged frame
- `comp.savePreset` {name, width, height, pixelAspect, frameRate} (replaces a saved preset with the same name)
- `comp.setPosterTime` 
- `comp.setSwitch` {switch: hideShy|motionBlur|frameBlending|draft3d, value?}
- `comp.settings` {comp?, name?, width?, height?, anchor? 0-8 (resize anchor, 4 = center), frameRate?, duration?, startTime? (s) | startTimecode?, background?, shutterAngle?, shutterPhase?, motionBlurSamples?, adaptiveSampleLimit? (16–256), preserveFrameRate?: bool (nested or in the render queue it shows only its own frames), preserveResolution?: bool (nested, it renders at full size), pixelAspect?, renderer?: classic3D|advanced3D}  (Cmd+K)
- `comp.trimToWorkArea` {comp?}  (Cmd+Shift+X)
- `comp.vr.createEnvironment` {comp?, size?: face pixels (1024), position?: [x,y,z]}
- `comp.vr.environments` {} → [{output, name, cubeMap, faces: [{face, comp, camera}], view: [x, y, z]}]
- `comp.vr.extractCubemap` {comp?, faceSize?}
- `comp.vr.setView` {comp? (an environment's output / cube map / face comp), orientation?: [x, y, z] degrees, pan?, tilt?, roll?} → turns the six face cameras together
- `comp.workArea` {start?, end?, set?: begin|end (at CTI)}
- `comp.workAreaToSelection` {comp?, layers? (default the selected layers; the whole composition with none)}  (Cmd+Alt+B)

### contentFill

- `contentFill.generate` *(context)* {layer?, method?: object|surface|edgeBlend, range?: workArea|entire, alphaExpansion? (px), lightingCorrection?: none|subtle|moderate|strong, referenceLayer?, referenceTime? (s), outputDir?, wait?: bool}
- `contentFill.set` {method?: object|surface|edgeBlend, range?: workArea|entire, alphaExpansion? (px), lightingCorrection?: none|subtle|moderate|strong, referenceLayer?: layer|null, referenceTime? (s)}

### edit

- `edit.clear` *(context)* {layers?}  (Delete)
- `edit.copy` *(context)* {layers?} (keyframes, effects or shape items when they are selected)  (Cmd+C)
- `edit.copyExpressionOnly` *(context)* 
- `edit.copyWithPropertyLinks` *(context)* {layers?} (selected properties, or layers, as expressions linking to the originals)  (Cmd+Alt+C)
- `edit.copyWithRelativePropertyLinks` *(context)* {layers?} (like Copy with Property Links, using thisComp)
- `edit.cut` *(context)* {layers?} (keyframes, effects or shape items when they are selected)  (Cmd+X)
- `edit.deselectAll`   (Cmd+Shift+A)
- `edit.duplicate` *(context)* {layers?} (effects or shape items when they are selected)  (Cmd+D)
- `edit.editOriginal` *(context)*   (Cmd+E)
- `edit.extractWorkArea` {layers?}
- `edit.history` *(context)* {steps?: n (undo n steps), redo?: n}
- `edit.history.goto` {index? (from edit.history.list) | id? | steps? (negative = back along the line)}
- `edit.history.list` {} → {states: [{index, id, label, parent, depth, current, line, future}], current, branches}
- `edit.label` {label: Red|Yellow|Aqua|…, layers?, keys?, target?: layers}
- `edit.liftWorkArea` {layers?}
- `edit.paste` *(context)* {} (layers, keyframes at the CTI, effects, shape items into the selected shape layers, or property links / expressions)  (Cmd+V)
- `edit.pasteReversedKeyframes` *(context)* {layers?, prop?|path?, time?}  (Cmd+Shift+V)
- `edit.pasteSvg` {svg: SVG markup, name?, comp?} → {layer, skipped} (Edit ▸ Paste runs it for SVG on the system clipboard)
- `edit.pasteTextFormattingOnly` *(context)* {layer?} (the copied text's formatting on the selected text or text layers)
- `edit.pasteTextMatchFormatting` *(context)* {text?} (the clipboard's text in the style at the caret)
- `edit.purge` {what?: all|memoryAndDisk|memory|disk|3d|image|snapshot}
- `edit.purgeUndo` 
- `edit.redo` *(context)*   (Cmd+Shift+Z)
- `edit.selectAll`   (Cmd+A)
- `edit.selectLabelGroup` *(context)* 
- `edit.splitLayer` *(context)* {layers?}  (Cmd+Shift+D)
- `edit.undo` *(context)*   (Cmd+Z)

### editor

- `editor.state` 

### effect

- `effect.apply` *(context)* {effect: id|name (e.g. Gaussian Blur), layers?}
- `effect.applyLast` *(context)* {layers?}  (Cmd+Alt+Shift+E)
- `effect.copy` *(context)* {layer?, effect? | effects?: [uid|name|index]} (default: the selected effects)
- `effect.cryptomatteAt` {layer?, effect?: index|uid|name, x, y (effect space), scale?, time?} → {name, hash, layer, selected} | null — the Cryptomatte ID under the point
- `effect.duplicate` *(context)* {layer?, effect}
- `effect.editDropdown` {layer, path?|prop?, items: [string]}
- `effect.list` {filter?} → [{params: [{id, name, type, default, options?, min?, max?, sliderMin?, sliderMax?, decimals?}]}]; popup indices are zero-based (JSX uses one-based values)
- `effect.manage` 
- `effect.paste` *(context)* {layers?} — adds the copied effects to the layers
- `effect.pickColor` *(context)* {layer?, effect?: index|uid|name, param: id (e.g. screenColour) | prop: uid, x, y (effect space), average?: bool (5×5), time?} — the colour of the effect's input there
- `effect.pickCryptomatte` *(context)* {layer?, effect?: index|uid|name, x, y (effect space), mode?: replace|add|remove (default replace), scale? (preview resolution, default 1), time?} → {name, hash, layer, selection, changed, selected} — edits the Cryptomatte effect's Selection with the ID under the point
- `effect.plugins.list` {} → {api, wasm, plugins: [{id, name, category, version, author, source, params}]}
- `effect.plugins.load` {path (.wasm / .wat plug-in, API v1) | folder (loads every .wasm in it)}
- `effect.remove` *(context)* {layer?, effect: index|uid|name}
- `effect.removeAll` *(context)* {layers?}  (Cmd+Shift+E)
- `effect.reorder` *(context)* {layer?, effect, index}
- `effect.reset` *(context)* {layer?, effect}
- `effect.setLabel` *(context)* {layer?, effect, label: name|index 0-16 (None clears)}
- `effect.swapTintColors` *(context)* {comp?, layer?, effect?: index|uid|name} — swaps Tint's Map Black To and Map White To at the current layer time in one undo step
- `effect.toggle` *(context)* {layer?, effect, value?}
- `effect.warning` {layer?, effect?: index|uid|name (default: the selected effect), time?} → {effect, warning: string|null} — what Effect Controls warns about (an OCIO config it can't read, transforms it passes through)

### effects

- `effects.copyPresetsFolderPath` 

### engine

- `engine.batch` {steps: [{command, params?}], label? (undo step name, default Batch), atomic?: bool (default true: a failing step rolls the whole batch back)} → {steps, results: [each step's result]}; a string param "$N" or "$N.key.0" is step N's result (1-based), e.g. {"layer": "$1.layer"}

### essential

- `essential.addComment` {comp?, text?, group?}
- `essential.addGroup` {comp?, name?, index?}
- `essential.addMedia` {layer, name?, group?}
- `essential.addMirror` *(context)* {comp?, control, name?, group?, index?}
- `essential.addProperty` *(context)* {comp?, layer?, path?|prop?: uid (default: the selected properties), name?, group?: control id, index?, as?: font (Source Text font family/style/size) | scale (uniform Scale), mirror?: bool (a property already present is added as a mirror; default true)}
- `essential.canAdd` {layer, path|prop, as?} → {ok, type?, reason?}
- `essential.exportTemplate` *(context)* {comp?, path (.ectemplate), name?}
- `essential.importTemplate` {path (.ectemplate), comp?, addToComp?: bool}
- `essential.instance` {layer}
- `essential.linkProperty` *(context)* {comp?, control, layer?, path?|prop? (default: the selected property)}
- `essential.list` {comp?, supported?: bool}
- `essential.move` {comp?, control, group?: id (null = top level), index?}
- `essential.pushToComp` *(context)* {layer, control? (default: all overridden)}
- `essential.remove` {comp?, control}
- `essential.rename` {comp?, control, name}
- `essential.revert` *(context)* {layer, control? (default: all overridden)}
- `essential.set` *(context)* {layer, control: id|name, value | item (media)}
- `essential.setName` {comp?, name}
- `essential.setPrimary` {comp}
- `essential.soloSupported` {on?}
- `essential.templateInfo` {path}
- `essential.unlinkProperty` *(context)* {comp?, control, layer?, path?|prop? (default: the selected property)}

### expr

- `expr.errors` {comp?, time? (s)}
- `expr.languageMenu` 

### face

- `face.model.download` {id, wait?} — the official model, verified (desktop; uses the system curl)
- `face.model.install` {path: model file, id?, wait?} — verified against the registry's SHA-256
- `face.model.remove` {id}
- `face.model.select` {id: classical|mediapipe-face, wait?} (face tracking uses it; wait: loaded before returning)
- `face.models` 

### file

- `file.applyInterpretation` *(context)* {items?}  (Cmd+Alt+V)
- `file.autoSave` 
- `file.clearRecent` *(context)* 
- `file.clearRecentFootage` *(context)* 
- `file.close` {comp?}  (Cmd+W)
- `file.closeProject` 
- `file.collectFiles` {folder}
- `file.consolidateFootage` 
- `file.createProxy` {kind: still|movie, comp?|item?, path?|output? (template), resolution? (default 0.5)}
- `file.cycleBitDepth` 
- `file.executeFile` {path, confirmed?}
- `file.exportLottie` {comp?, path (.json or .lottie), includeExpressions?: bool, textAsShapes?: bool}
- `file.exportTimeline` {comp?, path (Final Cut Pro XML .xml for Premiere Pro or .fcpxml .otio .edl .aaf .omf), format?: xml|fcpxml|otio|edl|aaf|omf, prerender?: none|unsupported|all, precomps?: nest|prerender}
- `file.findMissing` {what: footage|effects|fonts}
- `file.import` {paths: [string] (files or folders), sequence?: bool (the Sequence checkbox: true imports numbered stills of one run as one image sequence, one picked file bringing its whole run and several picked files that range; default: a numbered still brings its run, except dropped files (drag), which import as stills as in After Effects; folders' runs import as sequences; false imports stills and a folder's files individually), alphabetical?: bool (Force Alphabetical Order: every image of that type in the folder, by name), frameRate?: fps (image sequences; default Settings ▸ Import ▸ Sequence Footage), importAs?: footage|composition|compositionLayerSizes (Photoshop, PDF, Illustrator and EPS files), layer?: name|index (footage of one Photoshop layer), page?: number from 1 (PDF / Illustrator page), drag?: bool (dropped files: Settings ▸ Import ▸ Default Drag Import As; files import as stills unless sequence), addToComp?: bool (also add them to the active comp, at time?, index?, position? as in layer.addItem), background?: bool (probe the files in a background job, jobs.list / jobs.wait; returns {job})}  (Cmd+I)
- `file.importLottie` {path (.json or .lottie)}
- `file.importMultiple` {paths: [string]}  (Cmd+Alt+I)
- `file.importPlaceholder` {name?, width?, height?, frameRate?, duration? (s)}
- `file.importProject` {path (.ecproj or .ecprojx)} — merges the project into a folder named after the file; returns {folder, items, comps, rootComps, primaryComp (the only root comp, else null), missingMedia, warnings}
- `file.importRecent` *(context)* {index? | path?}
- `file.importSolid` {name?, color?, width?, height?}
- `file.importTimeline` {path (.xml Final Cut Pro XML from Premiere Pro or .fcpxml .otio .edl .aaf .omf), format?: auto|xml|fcpxml|otio|edl|aaf|omf, edlFrameRate?: number}
- `file.importVanishingPoint` *(context)* {} (always disabled: undocumented format)
- `file.incrementAndSave` *(context)*   (Cmd+Alt+Shift+S)
- `file.installScript` {path (.jsx / .js)} → copies it to the Scripts folder; it appears in File ▸ Scripts
- `file.installScriptUIPanel` {path (.jsx / .js)} → copies it to the ScriptUI Panels folder; it appears in the Window menu
- `file.interpretFootage` *(context)* {items?, frameRate?: fps|"file", alpha?: straight|premultiplied|ignore|guess, guessAlpha?, matteColor?, invertAlpha?, loop?, pixelAspect?, fields?: off|upper|lower, colorProfile?: srgb|rec709|rec2020|p3|auto, linearLight?, preserveRgb? (the file's values unconverted), overrideStart?: bool (false: Use Source File Timecode), startTimecode?: timecode|frame (Override Start)}  (Cmd+Alt+G)
- `file.interpretProxy` *(context)* {items?|item?, alpha?, matteColor?, invertAlpha?, frameRate?, loop?, pixelAspect?, fields?, colorProfile?, linearLight?}
- `file.newCompFromSelection` *(context)* {duration? (s, for stills), single?: bool (one comp for all), dimensionsFrom?: index, sequence?: bool, overlap?: bool, overlapDuration? (s), transition?: off|dissolveFront|crossDissolve, addToRenderQueue?: bool} → {comps}  (Cmd+Alt+\)
- `file.newFromTemplate` {} → the Home screen's Templates tab
- `file.newProject`   (Cmd+Alt+N)
- `file.open` {path}  (Cmd+O)
- `file.openDemoProject` 
- `file.openRecent` *(context)* {index? | path?}  (Cmd+Alt+Shift+P)
- `file.projectSettings` {bitDepth?: 8|16|32, colorEngine?: adobe|ocio, workingSpace?: none|srgb|rec709|rec2020|p3|acescg|aces2065, workingGamma?: 2.2|2.4 (with no working space), linearize?, blendLinear?, hdr?: clip|compand|toneMap, outputSpace?: srgb|rec709|rec2020|p3|rec2100pq|rec2100hlg, renderer?: gpu|software, timeDisplay?: timecode|frames|feet35|feet16, frameStart?: 0|1 (Frame Count: Start at 0 / Start at 1)}  (Cmd+Alt+Shift+K)
- `file.recoveryInfo` 
- `file.reduceProject` *(context)* {} (keeps the selected comps and what they use)
- `file.relinkFootage` {folder: string (recursive desktop search, no symlinks; max 100000 entries), dryRun?: bool (report only), wait?: bool (return results inline; otherwise jobs.list/jobs.wait)} — relinks only unique exact filenames with compatible metadata; preserves interpretation and sequence ranges. Reports high/low confidence and ambiguous, incompatible, unsupported or notFound items.
- `file.reloadFootage` *(context)* {items?}  (Cmd+Alt+L)
- `file.rememberInterpretation` *(context)* {item?}
- `file.removeUnusedFootage` 
- `file.replaceFootage` *(context)* {path, item?, sequence?: bool (default true: a numbered still brings its image sequence), alphabetical?: bool}  (Cmd+H)
- `file.replaceWithLayeredComp` *(context)* {item?}
- `file.replaceWithPlaceholder` *(context)* {item?, width?, height?, frameRate?, duration?}
- `file.replaceWithPrecomp` *(context)* {item?}
- `file.replaceWithSolid` *(context)* {item?, color?, width?, height?}
- `file.revealInFinder` *(context)* {item?}
- `file.revert` *(context)* 
- `file.runScript` {path (.jsx/.js JavaScript, or a .jsonl/.json command script) | name (an installed or sample script, see file.scripts.list) | steps: [{command, params}]}
- `file.save` {path?}  (Cmd+S)
- `file.saveAs` {path}  (Cmd+Shift+S)
- `file.saveCopy` {path}
- `file.saveCopyAsXml` {path: .ecprojx}
- `file.scripts.list` {} → [{name, panel, source: installed|sample|extension}]
- `file.setProxy` *(context)* {path, items?|item?}  (Cmd+Alt+P)
- `file.setProxyNone` *(context)* {items?|item?}
- `file.timelineFormats` 
- `file.uninstallScript` {name}
- `file.useProxy` *(context)* {items?|item?, on?}
- `file.watchFolder` {folder, stop?: bool} → watches the folder for .ecproj files with queued renders, renders them and writes `<project>.status.json`
- `file.watchFolder.poll` *(context)* {folder? (default: the watched one)} → renders new projects now: {watching, rendered: [{project, state: done|failed, items: [{comp, status, output}]}]}

### footage

- `footage.check` {items?: [id], wait?} — look for every footage file (in the background unless `wait`) and flag missing items
- `footage.clearInOut` *(context)* 
- `footage.info` 
- `footage.missing` {} → {missing: [{item, name, path}]}
- `footage.open` {item: id|name}
- `footage.overlayEdit` *(context)* {item?, comp?, in? (s), out? (s), at? (comp s; default the current time)}
- `footage.relink` *(context)* {item, path} — point a footage item at its file's new location (keeps the interpretation) and relink the other missing files found in the same place
- `footage.reloadChanged` {} — reload the footage whose file changed on disk since it was last seen (size or modification time; Settings ▸ Import ▸ Automatically Reload Footage runs this in the background; image sequences only with All Footage); files seen for the first time are only remembered. Returns {files, reloaded}
- `footage.rippleInsertEdit` *(context)* {item?, comp?, in? (s), out? (s), at? (comp s; default the current time)}
- `footage.setIn` *(context)* {time? | frame? (default: the panel's time)}
- `footage.setOut` *(context)* {time? | frame? (default: the panel's time)}
- `footage.setTime` *(context)* {time? (s, source) | frame?}

### help

- `help.appPage` 
- `help.discord` 
- `help.docs` {page?: help|scripting|expressions|effects|agents}  (F1)
- `help.enableLogging` {on?}
- `help.github` 
- `help.inAppTutorials` {} → the Home screen's Learn tab
- `help.onlineTutorials` 
- `help.reportIssue` 
- `help.revealLogFile` 
- `help.sibling` {app: photocraft|vectorcraft|filmcraft|lightcraft|pdfcraft|designcraft, kind?: page|github}
- `help.systemInfo` 
- `help.systemReport` {quiet?}
- `help.website` 

### item

- `item.metadata` {item?: id|name}

### jobs

- `jobs.cancel` {job?: render|track|maskTrack|warp|camera|roto|task:<n>|all}
- `jobs.list` 
- `jobs.wait` 

### keys

- `keys.audioToKeyframes` {comp?}
- `keys.copy` *(context)* 
- `keys.delete` *(context)* 
- `keys.deselectAll`   (Shift+F2)
- `keys.easyEase` *(context)* {which?: both|in|out}  (F9)
- `keys.easyEaseIn` *(context)*   (Shift+F9)
- `keys.easyEaseOut` *(context)*   (Cmd+Shift+F9)
- `keys.exponentialScale` *(context)* {} — two selected Scale keys
- `keys.info` {keys?: [{layer, prop, time}]}
- `keys.interpolation` *(context)* {interpolation?: linear|bezier|continuousBezier|autoBezier|hold, in?|out?: linear|bezier|hold, autoBezier?, continuous?, spatial?: linear|bezier|continuousBezier|autoBezier, roving?}  (Cmd+Alt+K)
- `keys.move` *(context)* {delta (s), merge?}
- `keys.nudge` *(context)* {frames, merge?}
- `keys.nudgeBackward` *(context)*   (Alt+ArrowLeft)
- `keys.nudgeBackward10` *(context)*   (Alt+Shift+ArrowLeft)
- `keys.nudgeForward` *(context)*   (Alt+ArrowRight)
- `keys.nudgeForward10` *(context)*   (Alt+Shift+ArrowRight)
- `keys.paste` *(context)* {layers?, prop?|path?, time?}
- `keys.quickOffset` *(context)* {delta (comp s: the last layer's keys' move), merge?, fromStart?: bool (with merge: delta is the whole drag)}
- `keys.rpfCameraImport` {path: .json|.csv camera data, comp?}
- `keys.select` {keys: [{layer, prop: uid | path (or `path`), time (layer s by default)}], timeBase?: layer|comp, add?, toggle?: bool (Shift+click: in or out of the selection), selectProperties?: bool (their properties and layers too, as a Timeline click does)}
- `keys.selectAll` {layers?, visible?: [{layer, prop}] (every key of these properties)}  (Cmd+Alt+A)
- `keys.selectEqual` *(context)* 
- `keys.selectFollowing` *(context)* 
- `keys.selectLabelGroup` {scope: selected|all|visibleSelected|visibleAll, visible?: [prop uid]}
- `keys.selectPrevious` *(context)* 
- `keys.set` {layer?, path|prop, time (layer s by default), newTime? (same base), timeBase?: layer|comp, value?, merge?}
- `keys.setEase` {layer?, path|prop, time (layer s), side: in|out, dim?, speed?, influence? %, merge?}
- `keys.setLabel` *(context)* {label: name|none|0–16}
- `keys.setSpatialTangents` {layer?, path|prop, time (layer s), in?: [dx,dy,dz?], out?, break?, merge?}
- `keys.smooth` *(context)* {tolerance? (property units, 1)}
- `keys.timeReverse` *(context)* 
- `keys.toggleHold` *(context)*   (Cmd+Alt+H)
- `keys.toggleTransform` *(context)* {layers?, prop: anchor|position|scale|rotation|opacity} (Alt+Shift+A/P/S/R/T)
- `keys.transform` *(context)* {timeScale?, timeAnchor? (comp s), timeOffset? (s), valueScale?, valueAnchor?, valueOffset?, dim? | dims?: [d…], merge?, fromStart?: bool (with merge: values are the whole transform since the drag started)}
- `keys.velocity` *(context)* {inSpeed?, inInfluence? %, outSpeed?, outInfluence? % (numbers or per-dimension arrays), continuous?}  (Cmd+Shift+K)
- `keys.wiggle` *(context)* {apply?: spatial|temporal, noise?: smooth|jagged, dimensions?: one|same|independent, dimension? (index for `one`), frequency? (keys/s, 5), magnitude?, seed?}

### layer

- `layer.addItem` {item: id|name, time? (s, the In point), index? (1-based stack position; default above the selected layer), position? ([x, y] comp px; default the centre), duration? (s, for a still)}  (Cmd+/)
- `layer.addMarker` {layers?, time?, comment?}
- `layer.addMask` *(context)* {layer?, shape?: rect|ellipse|rounded|polygon|star, rect? [x,y,w,h] (layer space; a polygon or star fits its width), mode?}  (Cmd+Shift+N)
- `layer.addShapeItem` *(context)* {layer?, kind: group|rect|ellipse|star|polygon|path|fill|stroke|gfill|gstroke|trim|repeater|round|offset|pucker|twist|zigzag|wiggle|merge|frontColor|bevelColor|sideColor|backColor, group?: uid|path} → {uid, path} (frontColor…backColor: the group's Front / Bevel / Side / Back item, which colours that surface of every extruded paint in the group in Advanced 3D)
- `layer.addTextAnimator` *(context)* {layer?, properties: [anchor|position|scale|skew|rotation|opacity|transformAll|lineAnchor|lineSpacing|characterOffset|characterValue|blur|fillColor|fillHue|fillSaturation|fillBrightness|fillOpacity|strokeColor|strokeHue|strokeSaturation|strokeBrightness|strokeOpacity|strokeWidth|tracking|frontColor|bevelColor|sideColor|backColor|perChar3d], name?}
- `layer.addTextAnimatorProperty` *(context)* {layer?, animator?: uid|index, property: (see layer.addTextAnimator)}
- `layer.addTextSelector` *(context)* {layer?, animator?: uid|index, kind: range|wiggly|expression}
- `layer.align` *(context)* {edge: left|hcenter|right|top|vcenter|bottom, to?: composition|selection (default composition), layers?}
- `layer.alignVideoToData` *(context)* {layer?, data?: data footage id|name, key?: time field, videoStart?: ISO date-time | hh:mm:ss | timecode | seconds (default: file creation time), dataStart? (comp s of the first sample, 0)}
- `layer.applyTextPreset` *(context)* {layer?, preset: typewriter|fadeUpCharacters|bounceInWords|trackingIn|scramble|blurIn|jitter|dropInLines}
- `layer.arrange` *(context)* {layers?, to: front|forward|backward|back, index?, above?: layer}
- `layer.autoOrient` *(context)* {mode: off|alongPath|towardsCamera|towardsPointOfInterest, layers?}  (Cmd+Alt+O)
- `layer.autoTrace` *(context)* {layer?, timeSpan?: currentFrame|workArea, channel?: alpha|red|green|blue|luminance, invert?, blur? (px, 1), tolerance? (px, 1), threshold? (%, 50), minimumArea? (px, 10), cornerRoundness? (%, 50), applyToNewLayer?}
- `layer.cameraSettings` {layer?, name?, type?, preset?, zoom?, focalLength?, angleOfView?, dof?, focusDistance?, aperture?, fStop?, blurLevel?, position?, poi?}
- `layer.castsShadows` *(context)* {layers?, value?}  (Alt+Shift+C)
- `layer.centerAnchor` *(context)* {layers?}  (Cmd+Alt+Home)
- `layer.channels` {layer?} → {channels: [name], layers: [{name, rgba: [r, g, b, a channel]}]} — a multi-layer OpenEXR layer's channels (EXtractoR's red / green / blue / alpha take these names)
- `layer.create` *(context)* {op: editableText|shapesFromText|masksFromText|shapesFromVector, layers?}
- `layer.deleteAllMarkers` *(context)* {layers?}
- `layer.distribute` *(context)* {mode: left|hcenter|right|top|vcenter|bottom (edges or centres), layers?}
- `layer.enablePerChar3D` *(context)* {layer?, enabled?: bool, toggle?: bool}
- `layer.enableTimeRemap` *(context)* {layers?, value?}  (Cmd+Alt+T)
- `layer.environment` *(context)* {layers?, on?}
- `layer.expressions` *(context)* {layers?, enabled: bool}
- `layer.extendSelectionNext`   (Cmd+Shift+ArrowDown)
- `layer.extendSelectionPrevious`   (Cmd+Shift+ArrowUp)
- `layer.frameBlending` *(context)* {layers?, mode: off|frameMix|pixelMotion}
- `layer.freezeFrame` *(context)* {layers?}
- `layer.freezeOnLastFrame` *(context)* {layers?}
- `layer.hideOtherVideo` *(context)* {layers?}  (Cmd+Alt+Shift+V)
- `layer.lightSettings` {layer?, name?, kind?: Parallel|Spot|Point|Ambient|Environment, color?, intensity?, coneAngle?, coneFeather?, falloff?, radius?, falloffDistance?, castsShadows?, shadowDarkness?, shadowDiffusion?, position?, poi?}
- `layer.markersLock` *(context)* {layers?, value?}
- `layer.mask.featherFalloff` *(context)* {layer?, mask?, mode: smooth|linear}
- `layer.mask.hideLocked` {value?}
- `layer.mask.invert` *(context)* {layer?, mask?, value?}  (Cmd+Shift+I)
- `layer.mask.lock` *(context)* {layer?, mask?, value?}
- `layer.mask.lockOthers` *(context)* {layer?, mask?}
- `layer.mask.mode` *(context)* {layer?, mask?, mode: None|Add|Subtract|Intersect|Lighten|Darken|Difference}
- `layer.mask.motionBlur` *(context)* {layer?, mask?, mode: sameAsLayer|on|off}
- `layer.mask.remove` *(context)* {layer?, mask?}
- `layer.mask.removeAll` *(context)* {layers?}
- `layer.mask.reset` *(context)* {layer?, mask?}
- `layer.mask.selectNext` *(context)* {layer?}  (Alt+`)
- `layer.mask.selectPrevious` *(context)* {layer?}  (Alt+Shift+`)
- `layer.mask.set` *(context)* {layer?, mask?, field: feather|opacity|expansion, value}
- `layer.mask.shape` *(context)* {layer?, mask?, rect: [x, y, w, h], shape?: rect|ellipse}  (Cmd+Shift+M)
- `layer.mask.unlockAll` *(context)* {layers?}
- `layer.moveEarlier` *(context)* {layers?}  (Alt+PageUp)
- `layer.moveEarlier10` *(context)* {layers?}  (Alt+Shift+PageUp)
- `layer.moveInToStart` *(context)* {layers?}  (Alt+Home)
- `layer.moveLater` *(context)* {layers?}  (Alt+PageDown)
- `layer.moveLater10` *(context)* {layers?}  (Alt+Shift+PageDown)
- `layer.moveOutToEnd` *(context)* {layers?}  (Alt+End)
- `layer.new3dPrimitive` {kind: cube|sphere|plane|torus|cone|cylinder, name?, width?, height?, depth?, radius?, tubeRadius?, segments?, rings?, position? [x,y,z], baseColor?, metallic?, roughness?, emissive?, castsShadows?, acceptsShadows?, acceptsLights?}; switches a Classic 3D comp to Advanced 3D
- `layer.newAdjustment` {name?}  (Cmd+Alt+Y)
- `layer.newCamera` {name?, type?: oneNode|twoNode (default twoNode), preset?: 15mm|20mm|24mm|28mm|35mm|50mm|80mm|135mm|200mm, zoom?, focalLength? mm, angleOfView? deg, dof?, focusDistance?, aperture?, fStop?, blurLevel?, lockToZoom?, position? [x,y,z], poi? [x,y,z]}  (Cmd+Alt+Shift+C)
- `layer.newContentAwareFill` {layer?, method?: object|surface|edgeBlend, range?: workArea|entire, alphaExpansion? (px), lightingCorrection?: none|subtle|moderate|strong, referenceLayer?, referenceTime? (s), outputDir?, wait?: bool}
- `layer.newLight` {kind?: Parallel|Spot|Point|Ambient|Environment (default Spot; Environment lights and reflects from an equirectangular image layer: prop.set its lightOptions/source to that layer's id, or leave it empty for the comp's Environment Layer, see layer.environment), name?, color?, intensity?, coneAngle?, coneFeather?, falloff?: None|Smooth|Inverse Square Clamped, radius?, falloffDistance?, castsShadows?, shadowDarkness?, shadowDiffusion?, position? [x,y,z], poi? [x,y,z]}  (Cmd+Alt+Shift+L)
- `layer.newModel` {item?: id or name of a 3D model footage item, path?: a .gltf, .glb, .obj, .stl or .fbx file to import, name?, time? (s), index? (1-based stack position), position? ([x, y] comp px)}; switches a Classic 3D comp to Advanced 3D
- `layer.newNull` {name?}  (Cmd+Alt+Shift+Y)
- `layer.newPrimitive` {kind: cube|sphere|plane|torus|cone|cylinder, name?, width?, height?, depth?, radius?, tubeRadius?, segments?, rings?, position? [x,y,z], baseColor?, metallic?, roughness?, emissive?, castsShadows?, acceptsShadows?, acceptsLights?}; switches a Classic 3D comp to Advanced 3D
- `layer.newShape` {kind?: rect|rounded|ellipse|star|polygon|none, name?, size?, fill?, fillType?, fillBlend?, fillOpacity?, stroke?, strokeType?, strokeBlend?, strokeOpacity?, strokeWidth?, position?}
- `layer.newSolid` {name?, color? #hex|[r,g,b], width?, height?, pixelAspect?}  (Cmd+Y)
- `layer.newText` {text?, name? (layer name; default the text), position? [x,y], box? [x,y,w,h] (paragraph text, comp space), vertical?, edit? (start editing), font?, style?, size?, fill?, stroke?, applyFill?, applyStroke?, strokeWidth?, tracking?, leading?, baselineShift?, hScale?, vScale?, tsume?, fauxBold?, fauxItalic?, allCaps?, smallCaps?, baseline?, superscript?, subscript?, kerning?, ligatures?, justify?, indentLeft?, indentRight?, indentFirst?, spaceBefore?, spaceAfter?, direction?, composer?, hangingPunctuation?, strokeOverFill?} (attributes as layer.setText)  (Cmd+Alt+Shift+T)
- `layer.nudge` *(context)* {x?, y? (comp pixels), layers?, merge?}
- `layer.openLayer` *(context)* {layer?}
- `layer.openSource` *(context)* {layer?}
- `layer.precompose` *(context)* {layers?, name?, mode?: move|leave, adjustDuration?, open?}  (Cmd+Shift+C)
- `layer.quality` *(context)* {layers?, quality: best|draft|wireframe}
- `layer.quickOffset` *(context)* {delta (comp s: the last layer's move), layers? (in order; default the selection), merge?, fromStart?: bool (with merge: delta is the whole drag)}
- `layer.rename` *(context)* {layer?, name}  (Enter)
- `layer.replaceSource` *(context)* {comp?, layers?, layer?, item?: id|name (default the Project panel selection), fixExpressions?: bool (accepted for After Effects compatibility)} → {layers, item}  (Cmd+Alt+/)
- `layer.revealExpressionErrors` {comp?}
- `layer.revealInFinder` *(context)* {layer?}
- `layer.revealSource` *(context)* {layers?}
- `layer.sampling` *(context)* {layers?, sampling: bilinear|bicubic, toggle?}
- `layer.sceneEditDetection` *(context)* {layer?, mode?: markers|split|splitPrecompose, threshold? (0…1, 0.25), wait?: bool}
- `layer.select` {layers: [id|name|#n], add?, toggle?}
- `layer.selectNext` {add?}  (Cmd+ArrowDown)
- `layer.selectPrevious` {add?}  (Cmd+ArrowUp)
- `layer.sequence` *(context)* {layers? (in order), overlap?: bool, duration? (s), transition?: off|dissolveFront|crossDissolve}
- `layer.setBlendMode` *(context)* {layers?, mode?: Normal|Multiply|Screen|…, step?: ±1}
- `layer.setComment` *(context)* {layers?, comment}
- `layer.setMask` *(context)* {layer?, mask: index|uid|name, mode?, inverted?}
- `layer.setParent` *(context)* {layers?, parent: layer|null, compensate?: bool}
- `layer.setSwitch` *(context)* {layers?, switch: video|audio|solo|lock|shy|collapse|quality|fx|frameBlend|motionBlur|adjustment|threeD|guide|preserveTransparency, value?, merge?, others? (the named layers alone: the other layers get the opposite state, or come back)}
- `layer.setText` *(context)* {layer?, range?: [start, end] (characters; default all), text?, font?, style?, size?, fill?, stroke?, applyFill?, applyStroke?, strokeWidth?, tracking?, leading?: px|"auto", baselineShift? px, hScale? %, vScale? %, tsume? %, fauxBold?, fauxItalic?, allCaps?, smallCaps?, baseline?: normal|superscript|subscript, superscript?, subscript?, kerning?: metrics|optical|number, ligatures?, discretionaryLigatures? (OpenType), contextualAlternates?, stylisticAlternates?, stylisticSets?: [1–20], ss01?, ss02?, ss03?, ss04?, ss05?, ss06?, ss07?, ss08?, ss09?, ss10?, ss11?, ss12?, ss13?, ss14?, ss15?, ss16?, ss17?, ss18?, ss19?, ss20?, swash?, titling?, ordinals?, fractions?, allSmallCaps?, figureStyle?: default|lining|oldStyle, figureWidth?: default|proportional|tabular, figures?, variations?: {tag: value} (variable font axes; null resets), justify?: left|center|right|justifyLeft|justifyCenter|justifyRight|justifyAll, indentLeft?, indentRight?, indentFirst?, spaceBefore?, spaceAfter?, direction?: ltr|rtl, composer?: everyLine|singleLine, hangingPunctuation?, strokeOverFill?, box?: [x,y,w,h]|null (layer space), vertical?}
- `layer.setTrackMatte` *(context)* {layer?, matte: layer|null, kind?: alpha|alphaInverted|luma|lumaInverted}
- `layer.setTransform` *(context)* {layers?, prop: anchor|position|scale|orientation|rotation|opacity, value}
- `layer.settings` *(context)* {layer?, name?, color?, width?, height?, pixelAspect?, affectAll?: bool (default true; false gives this layer its own copy of a solid other layers use)} → {layer, solid?}  (Cmd+Shift+Y)
- `layer.showAllVideo` {comp?}
- `layer.slip` *(context)* {layers?, delta? (seconds) | frames?, merge?}
- `layer.slipBack` *(context)* {layers?}
- `layer.slipForward` *(context)* {layers?}
- `layer.stretchInToTime` *(context)* {layers?}  (Cmd+Shift+,)
- `layer.stretchOutToTime` *(context)* {layers?}  (Cmd+Alt+,)
- `layer.style.add` *(context)* {style: dropShadow|innerShadow|outerGlow|innerGlow|bevelEmboss|satin|colorOverlay|gradientOverlay|stroke (or display name), layers?}
- `layer.style.bevelEmboss` *(context)* {layers?}
- `layer.style.colorOverlay` *(context)* {layers?}
- `layer.style.convertToEditable` *(context)* {layers?}
- `layer.style.dropShadow` *(context)* {layers?}
- `layer.style.globalLight` {comp?, angle? (deg), altitude? (deg, 0..90), time? (s)} — no values returns the current setting
- `layer.style.gradientOverlay` *(context)* {layers?}
- `layer.style.innerGlow` *(context)* {layers?}
- `layer.style.innerShadow` *(context)* {layers?}
- `layer.style.list` {layer?}
- `layer.style.options` *(context)* {layer?, style?: blendingOptions|dropShadow|…}
- `layer.style.outerGlow` *(context)* {layers?}
- `layer.style.remove` *(context)* {layer?, style: id|name|uid|layerStyles}
- `layer.style.removeAll` *(context)* {layers?}
- `layer.style.satin` *(context)* {layers?}
- `layer.style.showAll` *(context)* {layers?}
- `layer.style.stroke` *(context)* {layers?}
- `layer.style.toggle` *(context)* {layer?, style: id|name|uid|layerStyles, value?}
- `layer.timeReverse` *(context)* {layers?}  (Cmd+Alt+R)
- `layer.timeStretch` *(context)* {layers?, percent?|duration? (s), hold?: in|current|out, op?: reverse}
- `layer.timing` *(context)* {layers?, op?: moveInToTime|moveOutToTime|moveInToStart|moveOutToEnd|trimInToTime|trimOutToTime, delta?, start?, in?, out?, inDelta?, outDelta? (seconds, per layer), merge?}
- `layer.trackMatte` *(context)* {layers?, op: none|alpha|alphaInverted|luma|lumaInverted|above|below}
- `layer.transform` *(context)* {layers?, op: reset|center|fit|fitWidth|fitHeight|flipH|flipV}
- `layer.tree` {layer?, comp?, depth?, time? (comp s)} → nodes with `path`
- `layer.unlockAll` {comp?}  (Cmd+Shift+L)
- `layer.updateMarkersFromSource` *(context)* {layers?}

### learn

- `learn.list` {} → [{id, title, summary, minutes, steps}]
- `learn.start` {id}
- `learn.state` {} → {tutorial, step, steps, done, current: {title, text, target, accepts}} | null
- `learn.step` {action?: next|back|showMe|goto, index?}
- `learn.stop` 

### light

- `light.controlWithCamera` {comp?, layers?: lights (default selected), camera? (default active), on?: bool (default toggle)}
- `light.environmentBackground` {comp?, layer?: environment light (default selected / first)}
- `light.fromModel` {comp?, layers?: 3D model layers (default selected)}

### liquify

- `liquify.clear` {layer?, effect?: uid}
- `liquify.stroke` {layer?, effect?: uid, tool?: warp|turbulence|twirlClockwise|twirlCounterclockwise|pucker|bloat|shiftPixels|reflection|clone|reconstruction|freeze|thaw, points: [[x,y],…] (effect space), size?, pressure? (1-100), jitter? (1-100), cloneOffset?: [dx,dy], time? (s) | frame?}

### markers

- `markers.convert` {layer? (layer marker → comp marker), index? | at?, toLayer? (comp marker → layer marker)}
- `markers.delete` {layer?, index? | at? (comp s)}
- `markers.list` {layer? (omit for composition markers)}
- `markers.nested` {layer: a precomp layer, comp?} — its comp's markers at their times in this comp (as on the layer bar)
- `markers.set` {layer? (omit: comp marker), index? (0-based) | at? (comp s) | new?: true, time? (comp s), duration? (s), comment?, chapter?, url?, frameTarget?, cuePoint?: {name, navigation?, params?: [[name, value]…]} | null, protected?, label?}

### mask

- `mask.addVertex` *(context)* {layer?, mask, point: [x,y], in?, out?, index?}
- `mask.convertVertex` {layer?, mask: uid (mask or shape Path item), index, smooth?}
- `mask.deleteVertices` *(context)* {vertices?}
- `mask.featherPoint.add` {layer?, mask, segment?, t?: 0..1, point?: [x,y] (layer space), radius? (px, negative = inner), tension? (%)} → {index}
- `mask.featherPoint.list` {layer?, mask}
- `mask.featherPoint.remove` {layer?, mask, index? | all?}
- `mask.featherPoint.set` {layer?, mask, index, segment?, t?, point? (slide along the path), radius?, toward?: [x,y] (radius from the drag point, layer space), tension? (%), merge?}
- `mask.insertVertex` {layer?, mask: uid (mask or shape Path item), segment, t?: 0..1}
- `mask.interpolate` {layer?, mask?, times?: [from, to] (s; default the selected Mask Path keys), keyframeRate?: n|auto, keyframeFields?, linearVertexPaths?, bendingResistance? (0-100), quality? (0-100), addVertices?: n|false, addVerticesUnit?: pixels|total|percent, matchingMethod?: auto|curve|polyline, oneToOne?, firstVerticesMatch?}
- `mask.interpolationOptions` {keyframeRate?: n|auto, keyframeFields?, linearVertexPaths?, bendingResistance?, quality?, addVertices?: n|false, addVerticesUnit?: pixels|total|percent, matchingMethod?: auto|curve|polyline, oneToOne?, firstVerticesMatch?}
- `mask.moveVertices` *(context)* {vertices?: [{layer, mask, index}], delta: [dx,dy], merge?}
- `mask.new` *(context)* {layer?, vertices: [[x,y]…], inTangents?, outTangents?, closed?, mode?}
- `mask.remove` *(context)* {layer?, mask}
- `mask.removeAll` *(context)* {layer?}
- `mask.selectVertices` {vertices: [{layer, mask, index}], add?, toggle?}
- `mask.setClosed` *(context)* {layer?, mask, closed?}
- `mask.setVertex` *(context)* {layer?, mask, index, point?, in?, out?, merge?}

### material

- `material.duplicateAssign` *(context)* {layers? (first = source)}
- `material.reset` *(context)* {layers?}
- `material.revealSource` *(context)* {layer?}
- `material.set` *(context)* {layers?, castsShadows?: off|on|only, acceptsShadows?: off|on|only, acceptsLights?, appearsInReflections?, lightTransmission?, ambient?, diffuse?, specularIntensity?, specularShininess?, metal?, baseColor?, metallic?, roughness?, emissive?, time?}

### mediaBrowser

- `mediaBrowser.action` {action}: an action from mediaBrowser.list's `actions` (web: openFolder, addFiles, uploadFolder)
- `mediaBrowser.addFavorite` {path?}
- `mediaBrowser.fileInfo` {path}
- `mediaBrowser.go` {path?: folder | "..", importableOnly?}
- `mediaBrowser.import` {paths, sequence? (default true: a numbered still brings its image sequence), addToComp?, time?, index?, position? (where the layers go, as in layer.addItem)}
- `mediaBrowser.list` {path?, importableOnly?}
- `mediaBrowser.removeFavorite` {path?}

### motion

- `motion.sketch` {layer?, points: [[t, x, y]…] (t = capture seconds) | [[x, y]…] (one per frame), start? (s, default current time), captureSpeed? (%, 100), smoothing? (px, 1)}

### objectMatte

- `objectMatte.apply` {layer?, effect? (uid: re-prompt this Object Matte instead of adding one), point: [x, y] (layer pixels: the object), box?: [x0, y0, x1, y1] (layer pixels, around the object), frame? (reference layer frame; default current), track?: follow the object from that frame (default true), before?, after? (frames to follow it; default 30, up to 600)}
- `objectMatte.freeze` {layer?, effect?, wait?}
- `objectMatte.propagate` {layer?, effect?, direction?: forward|backward|both, wait?: block until done} (a background job like Roto Brush propagation; roto.cancel stops it)
- `objectMatte.status` {layer?, effect?}: the job's progress, whether the instance is frozen, its frames and which are computed
- `objectMatte.unfreeze` {layer?, effect?}

### paint

- `paint.brushPreset` {preset?: index | name}
- `paint.options` {color?, background?, opacity?, flow?, mode?, channels?, durationMode?, customFrames?, eraseMode?, diameter?, angle?, roundness?, hardness?, spacing?, preset?, sizePressure?, minSize?, opacityPressure?, flowPressure?, clonePreset?, cloneSource?, clonePoint?, cloneOffset?, aligned?, lockSourceTime?, cloneTimeShift?, cloneTime?, showOverlay?, overlayOpacity?, overlayDifference?, reset?}
- `paint.presets` 
- `paint.removeStroke` {layer?, stroke: uid | name}
- `paint.setCloneSource` {layer?, point: [x,y]}
- `paint.stroke` {layer?, kind?: brush|clone|eraser, points: [[x,y,pressure?],…] (effect space), time? (s) | frame?, duration? (s, drawing time for Write On), color?: [r,g,b,a], diameter?, angle?, hardness?, roundness?, spacing?, opacity?, flow?, mode?, channels?: RGBA|RGB|Alpha, durationMode?: constant|writeOn|singleFrame|custom, customFrames?, eraseMode?: layerSourceAndPaint|paintOnly|lastStrokeOnly, cloneSource?: layer id, clonePosition?: [x,y], cloneTimeShift? (s), lockSourceTime?, cloneTime? (s), sizePressure?, minSize?, opacityPressure?, flowPressure?}

### path

- `path.convertToBezier` *(context)* {layer?, mask?}
- `path.freeTransform` *(context)* {layer?, mask?, scale?: % | [x%, y%], rotation?: deg, offset?: [dx, dy], anchor?: [x, y]}
- `path.groupShapes` *(context)* {layer?, items?: [uid]}  (Cmd+G)
- `path.rotoBezier` *(context)* {layer?, mask?, value?}
- `path.setFirstVertex` *(context)* {layer?, mask?: uid, index?}
- `path.ungroupShapes` *(context)* {layer?, items?: [group uid]}  (Cmd+Shift+G)

### paths

- `paths.nullsFollowPoints` *(context)* {layer?, path?|prop?, pins?: [uid | name…]} → a null per vertex (or puppet pin) following it (Position expressions)
- `paths.pointsFollowNulls` *(context)* {layer?, path?|prop?, pins?: [uid | name…]} → a null per vertex (or Position / Advanced puppet pin); the path (pins) follow them (expressions)
- `paths.tracePath` *(context)* {layer?, path?|prop?, loop?: bool} → a null moving along the path (Progress slider)

### playback

- `playback.audio` {value?: include audio in previews}
- `playback.cacheWhenIdle` {value?}
- `playback.scrubAudio` {time? (s, default the current time)} — plays one frame of the comp's audio there (Ctrl/Cmd-drag the current time)
- `playback.settings.get` {shortcut?: spacebar|shiftSpacebar|numpad0|shiftNumpad0|altNumpad0 (default: the one shown in the Preview panel)} → options + plan {start, end, first, step, fps}
- `playback.settings.set` {shortcut?, current?: shortcut shown in the panel, reset?: bool, values?: {…}, includeVideo?, includeAudio?, includeOverlays?, includeLayerControls?, loop?, cacheBeforePlayback?, range?: workArea|workAreaExtended|entireDuration|aroundCurrentTime, preRoll?, postRoll?: seconds, playFrom?: rangeStart|currentTime, frameRate?: fps|"auto", skip?, resolution?: auto|full|half|third|quarter|custom, customResolution?, fullScreen?, playCachedFrames?, moveTimeToPreviewTime?}
- `playback.toggle` {shortcut?: spacebar|shiftSpacebar|numpad0|shiftNumpad0|altNumpad0 (whose Preview panel options to use; default spacebar)}  (Space)

### prefs

- `prefs.get` {key?: e.g. general.undoLevels (omit for all settings)}
- `prefs.open` {page?: general|startup|project|composition|previews|appearance|grids|labels|type|import|export|audio|disk|memory|video|3d|scripting}
- `prefs.pages` 
- `prefs.reset` {page?: general|labels|project|…}
- `prefs.set` {key, value, values?: {key: value}}

### project

- `project.delete` {items?: [id|name] (default: selected)} (folders with their contents; layers using the items go too)
- `project.deleteWithoutConfirmation` {} — the Project panel's selection, with the layers that use it; one undo step  (Shift+Delete)
- `project.duplicate` {items?: [id|name] (default: selected)} → {items}
- `project.move` {items?: [id|name] (default: selected), folder: id|name|null (root)}
- `project.newFolder` {name?, parent?}  (Cmd+Alt+Shift+N)
- `project.rename` {item?: id|name (default: selected), name}
- `project.select` {items: [id|name], add?}
- `project.setComment` {items?, comment}
- `project.setLabel` {items?, label: name|index}
- `project.setProjectComment` {comment}
- `project.summary` 
- `project.usage` {items?: [id|name] (default: selected)} → {items, layers, comps} that deleting them removes
- `project.usedIn` {item?: id|name (default: selected)} → {item, count, comps: [{id, name, layers}]}

### prop

- `prop.addKey` *(context)* {layer?, path|prop, time? (layer s by default), timeBase?: layer|comp, value?}
- `prop.convertExpressionToKeyframes` *(context)* {layer?, path|prop}
- `prop.deselect` *(context)* {layer?, path|prop}
- `prop.duplicateGroup` *(context)* {layer?, prop: uid} → {prop: new uid}
- `prop.editGradient` *(context)* {layer?, path|prop, comp?} — a gradient property; opens the Gradient Editor at the current time
- `prop.get` {layer?, path|prop, time? (comp s)}
- `prop.moveGroup` *(context)* {layer?, prop: uid, index (1-based among its siblings)}
- `prop.pickWhip` *(context)* {layer?, path|prop, target: {layer, path|prop, dimension?}, expression?, range?: [start, end]} → sets an AE reference expression (`dimension`: one of the target's values, `position[0]`; with `expression`: inserts it there, replacing the characters in `range`, default the end)
- `prop.removeGroup` *(context)* {layer?, prop: uid}
- `prop.renameGroup` *(context)* {layer?, prop: uid, name}
- `prop.reset` *(context)* {layer?, path|prop, default?} → removes the expression; the value becomes `default`, else the property's own (an effect parameter's, a Transform property's), as a keyframe at the current time when the property is animated
- `prop.select` *(context)* {layer?, path|prop, add?, selectKeys?}
- `prop.separateDimensions` *(context)* {layer?, value?}
- `prop.set` *(context)* {layer?, path|prop, value, time? (layer s by default), timeBase?: layer|comp, merge?, selected? (also the other selected layers), offset? (them by the same change), proportional? (with offset: Proportional Scrubbing, each layer by its share in selection order, the first none, the last all), dims? (with selected, a typed value: the components edited, e.g. [2] for Z; the other layers keep the rest of their own value)}
- `prop.setExpression` *(context)* {layer?, path|prop?, expression?, enabled?} (no path/prop: the selected properties)  (Alt+Shift+=)
- `prop.setGroupEnabled` *(context)* {layer?, prop: uid, value?}
- `prop.toggleAnimation` *(context)* {layer?, path|prop, value?, merge?, selected?}
- `prop.toggleKey` *(context)* {layer?, path|prop, selected?}

### puppet

- `puppet.addPin` {layer?, kind?: position|advanced|bend|starch|overlap, position: [x,y] (effect space), time? (s) | frame?, mesh?: uid, newMesh?, density?, expansion?, triangles?}
- `puppet.follow` {layer?, leader?: uid | name (default: the first selected pin), pins?: [uid | name…] (default: the other selected pins), delay? (s, 0.1), amount? (%, 100), cascade? (true: the k-th nearest pin trails k × delay)}
- `puppet.info` {layer?, time? | frame?}
- `puppet.mesh` {layer?, mesh?: uid, density?, expansion?, triangles?, showMesh?, time?, merge?}
- `puppet.movePin` {layer?, pin: uid | name, position: [x,y], time? | frame?, merge?}
- `puppet.recordOptions` {speed? (%, 100), smoothing? (0-100), useDraftDeformation?, showMesh?}
- `puppet.recordPin` {layer?, pin: uid | name, samples: [[t, x, y]…] (t = seconds since the drag began, effect space), pins?: [uid | name…] (more pins that move by the same displacement), start? (s, default current time), speed? (%, Record Options), smoothing? (Record Options)}
- `puppet.removePin` {layer?, pin?: uid | name, pins?: [uid | name…]} (default: the selected pins)
- `puppet.selectPins` {layer?, pins: [uid | name…] ([] deselects), add?, toggle?}
- `puppet.setPin` {layer?, pin: uid | name, position?, scale? (%), rotation? (°), amount? (%), extent? (px), inFront?, time? | frame?, merge?}

### render

- `render.addOutputModule` *(context)* {item?|index? (default: the last item), format?, output?, channels?, quality?, bitrate?, proresProfile?, audio?}
- `render.backend` {backend?: gpu|cpu}
- `render.preRender` {comp?, output?: path|template, format?}
- `render.saveCurrentPreview` {comp?, path}

### renderQueue

- `renderQueue.add` {comp?: id|name, template?: Render Settings template, format?: h264|hevc|av1|prores|uncompressed|webm|png|jpeg|tiff|exr|gif|wav|aiff, output?: path|template, log?: errorsOnly|plusSettings|plusPerFrameInfo, quality?: best|draft|1-100 (jpeg, webm), resolution?: full|half|third|quarter|scale, proxyUse?, effects?, solo?, guideLayers?, colorDepth?, frameBlending?, fieldRender?, pulldown?, motionBlur?, timeSpan?: workArea|comp|custom, start?: s, end?: s, duration?: s, frameRate?: fps|null, skipExisting?: bool, storageOverflow?: bool, channels?: rgb|rgba|alpha, color?, bitrate?: kbps, webmBitrate?, keyframeInterval?, proresProfile?, profile?, level?, rateControl?, webmCodec?, audioBitrate?, opusApplication?, crop?, resize?, includeProjectLink?, audio?: auto|on|off, sampleRate?, audioChannels?, audioFormat?, loop?: bool (values as in setRenderSettings / setOutputModule)}  (Cmd+M)
- `renderQueue.applyTemplate` *(context)* {item?|index?, renderSettings?: template name, outputModule?: template name, module?: n}
- `renderQueue.deleteTemplate` {kind: renderSettings|outputModule, name}
- `renderQueue.duplicate` *(context)* {item?|index?}
- `renderQueue.formats` 
- `renderQueue.list` 
- `renderQueue.move` *(context)* {item?|index?, to: n (1-based)}
- `renderQueue.remove` *(context)* {item?: id, index?: n}
- `renderQueue.render` *(context)* {wait?: bool (default true; the UI renders in the background)}
- `renderQueue.saveTemplate` {kind: renderSettings|outputModule, name, item?|index? (save from this item), from?: template to copy, module?, params?: {setRenderSettings / setOutputModule keys}}
- `renderQueue.setLog` *(context)* {item?|index?, log: errorsOnly|plusSettings|plusPerFrameInfo}
- `renderQueue.setNotify` {notify?: bool (toggles)}
- `renderQueue.setOutput` *(context)* {item?|index?, module?: n, path: file path or template like [compName].[fileExtension]}
- `renderQueue.setOutputModule` *(context)* {item?|index?, module?: n (1 = first), template?: name, format?: h264|hevc|av1|prores|uncompressed|webm|png|jpeg|tiff|exr|gif|wav|aiff, channels?: rgb|rgba|alpha, color?: straight|premultiplied, quality?: 1-100, bitrate?: kbps, webmBitrate?: bool, keyframeInterval?: frames (0 = auto), proresProfile?: proxy|lt|standard|hq|4444|4444xq, profile?: main|main10 (HEVC/AV1), level?: auto|4.1, rateControl?: bitrate|quality, webmCodec?: vp9|av1, audioBitrate?: Opus kbps, opusApplication?: audio|voice, crop?: bool|{useRoi?, roi?, top?, left?, bottom?, right?}, cropTop?, cropLeft?, cropBottom?, cropRight?, resize?: bool|{preset?, width?, height?, lockAspect?, quality?: low|high}, resizeWidth?, resizeHeight?, postRenderAction?: none|import|importAndReplace|setProxy, includeProjectLink?: bool, audio?: auto|on|off, sampleRate?, audioChannels?: mono|stereo, audioFormat?: 16|24|32, loop?: bool, output?}
- `renderQueue.setOverflowFolders` {folders: [path, …] (used in order when the output volume is full)}
- `renderQueue.setRender` *(context)* {item?|index?, render?: bool (toggles)}
- `renderQueue.setRenderSettings` *(context)* {item?|index?, template?: name, quality?: best|draft, resolution?: full|half|third|quarter|scale, proxyUse?: current|all|comp|none, effects?: current|allOn|allOff, solo?: current|allOff, guideLayers?: current|allOff, colorDepth?: current|8|16|32, frameBlending?: current|onForChecked|offForAll, fieldRender?: off|upper|lower, pulldown?: off|WSSWW|SSWWW|SWWWS|WWWSS|WWSSW, motionBlur?: bool|current|onForChecked|offForAll, timeSpan?: workArea|comp|custom, start?: s, end?: s, duration?: s, frameRate?: fps|null, skipExisting?: bool, storageOverflow?: bool}
- `renderQueue.setTemplateDefault` {kind: renderSettings|outputModule, slot: movie|still|preRender|movieProxy|stillProxy, name}
- `renderQueue.stop` *(context)* 
- `renderQueue.templates` 

### roto

- `roto.cancel` *(context)* 
- `roto.clearStrokes` {layer?, effect?, frame? (only this layer frame), kind?}
- `roto.freeze` {layer?, effect?, wait?}
- `roto.model.download` {id, wait?} — the official weights, verified (desktop; uses the system curl)
- `roto.model.install` {path: weights file, id?, wait?} — verified against the registry's SHA-256
- `roto.model.remove` {id}
- `roto.model.select` {id: classical|mobilesam, wait?} (Roto Brush 2.0 / 3.0 use it; wait: loaded before returning)
- `roto.models` 
- `roto.options` {diameter?, refineDiameter?, view?: alphaBoundary|alpha|alphaOverlay|none, overlayColor?: [r,g,b], overlayOpacity?, boundaryColor?: [r,g,b], autoPropagate?}
- `roto.propagate` {layer?, effect?, direction?: forward|backward|both, to? (layer frame: extend the span), wait?: block until done}
- `roto.span` {layer?, effect?, start?, end? (layer frames)}
- `roto.status` {layer?, effect?, frame? (layer frame: also report its matte), matte?: include the matte (RLE, base64), compute?: compute the frame if needed, compareTo?: RLE matte to report the IoU against}
- `roto.stroke` {layer?, kind?: fg|bg|refine|refineErase, points: [[x, y], …] (layer pixels), frame? (layer frame; default current), radius? (layer px; default the tool's diameter / 2), effect?}
- `roto.unfreeze` {layer?, effect?}

### scopes

- `scopes.analyze` {comp?, time?|frame?, scope?: waveformRgb|waveformLuma|waveformYc|vectorscopeYuv|vectorscopeHls|histogram|paradeRgb|paradeYuv, standard?: rec601|rec709|rec2020, float?, clamp?, size?}

### script

- `script.run` {code (JavaScript: app, app.project, CompItem, Layer, Property… like After Effects scripting), name?, console? (Script Console context)} → {ok, result, output, error: {message, line, column} | null}
- `script.runTasks` {} → runs the app.scheduleTask tasks that are due (frontends do it every frame) → {ran, output, errors, next (ms until the next task, or null)}
- `script.settings.get` {section, key} → {have, value} (app.settings.haveSetting / getSetting)
- `script.settings.save` {section, key, value (text)} → kept in the settings store (app.settings.saveSetting)

### scriptui

- `scriptui.click` {window?: id | title, widget: id | "#id" | properties.name | text} (buttons, checkboxes, radio buttons, tabs)
- `scriptui.close` {window?, result? (a dialog's show() returns it; default 2 = Cancel)}
- `scriptui.get` {window?: id | title} → {id, title, kind, root: {id, type, name, text, value, checked, items, selection, bounds, enabled, draw (onDraw paint list), children…}}
- `scriptui.list` {} → [{window, title, kind: dialog|palette|window|panel, script, modal, size}]
- `scriptui.mouse` {window?, widget, type: mousedown | mouseup | mousemove | mouseover | mouseout | click (default), x?, y? (relative to the control; default its centre), button? (0 left, 1 middle, 2 right), detail? (click count), screenX?, screenY?, altKey?, ctrlKey?, metaKey?, shiftKey?} → the script's addEventListener listeners on the control and its containers receive a MouseEvent
- `scriptui.set` {window?, widget, value: text | number | bool | item index | item text, changing?: bool (a live update: each keystroke / slider step; fires onChanging only)} (edit text, sliders, checkboxes, lists) → fires onChanging / onChange

### shape

- `shape.dashes.add` *(context)* {layer?, prop?: stroke uid}
- `shape.dashes.remove` *(context)* {layer?, prop?: stroke uid}
- `shape.fillStroke` *(context)* {layers?, fillType?: none|solid|linear|radial, strokeType?, fill?: color, stroke?: color, strokeWidth?, merge?} → {fill, stroke, strokeWidth, fillType, strokeType} (first layer)
- `shape.newPath` {layer?, vertices: [[x,y]…], inTangents?, outTangents?, closed?, space?: comp|layer, fill?: [r,g,b]|#hex|false, fillType?, fillBlend?, fillOpacity?, stroke?, strokeType?, strokeBlend?, strokeOpacity?, strokeWidth? (default the Tools bar's, shape.toolOptions), name?}
- `shape.newShape` {layer?, kind?: rect|rounded|ellipse|polygon|star, size? [w,h], position? [x,y] (the centre), space?: comp|layer, name? (a new layer's), fill?, fillType?, fillBlend?, fillOpacity?, stroke?, strokeType?, strokeBlend?, strokeOpacity?, strokeWidth? (default the Tools bar's, shape.toolOptions)} → {layer, group}
- `shape.stroke.taper` *(context)* {layer?, prop?: stroke uid, units?: pixels|percent, startLength?, endLength?, startWidth? (%), endWidth? (%), startEase? (%), endEase? (%)}
- `shape.stroke.wave` *(context)* {layer?, prop?: stroke uid, amount? (%), units?: pixels|cycles, wavelength?, cycles?, phase? (°)}
- `shape.toolOptions` {createsMask?: bool (Tool Creates Mask with a shape layer selected), fill?: [r,g,b]|#hex|false, fillType?: none|solid|linear|radial, fillBlend?: blend mode, fillOpacity? %, stroke?, strokeType?, strokeBlend?, strokeOpacity?, strokeWidth? px, reset?} → the options

### shortcuts

- `shortcuts.conflicts` 
- `shortcuts.export` {preset?, path?}
- `shortcuts.import` {path? | preset?: exported document, name?}
- `shortcuts.list` {query?, keys?, assigned?: bool}
- `shortcuts.preset` {op: select|new|duplicate|delete|rename, name?, from?, newName?}
- `shortcuts.reset` {command?, params?}
- `shortcuts.set` {command, params?, keys: "Cmd+Shift+K" | [keys] | null}

### storage

- `storage.clear` *(context)* {what: diskCache|media|projects|autoSaves|all} → {cleared, entries, bytes}
- `storage.info` {} → {available, backend, usage, quota, persisted, files: {count, bytes, media, projects, autoSaves}, diskCache: {enabled, entries, bytes, maxBytes, hits, misses, writes, evictions}}
- `storage.persist` *(context)* {} → {requested, persisted}

### templates

- `templates.create` {id (templates.list) | path (.ectemplate), projectPath? (save the new project there; embedded footage goes to `<stem> Footage/` next to it), footageDir?} → an untitled copy (embedded footage extracted: `footage` lists the files)
- `templates.delete` {id: user/<file>}
- `templates.list` {thumbnails?: bool} → [{id, name, description, category, builtin, width, height, frameRate, duration, controls, thumbnail? (hex RGB 256×144)}]
- `templates.saveAs` {name, description?, category?, overwrite?: bool (default true), embedFootage?: bool (default true: the footage files go into the template), embedLimitMB? (default 256: footage beyond it stays linked, with a warning)} → {id, path, embedded, embeddedBytes, linked: [{item, name, reason}], warning?}
- `templates.thumbnail` {id} → {id, width, height, rgb (hex)}

### text

- `text.addSelector` *(context)* {layer?, animator?: uid|index, kind: range|wiggly|expression}
- `text.animatorFontAxes` *(context)* {layer?, axis?: tag|name (omit to list the font's axes), animator?: uid|index}
- `text.animatorProperties` 
- `text.delete` *(context)* {layer?, direction?: backward|forward, word?, range?: [start, end], merge?}
- `text.edit` *(context)* {layer?, select?: [anchor, caret]|"none", caret?, created?} → {layer, anchor, caret}
- `text.endEdit` 
- `text.fontFeatures` {layer?, font?, style?} → {family, style, features: [tags], options: {smallCaps, superscript, stylisticSets: [n], fractions, …}} (what the font sets with its own glyphs)
- `text.fonts` {query?, variable?, rescan?} → {count, families: [{family, styles, origin: bundled|system|user, variable, nativeName?}], added} (variable: only variable fonts; rescan picks up fonts installed since launch)
- `text.insert` *(context)* {layer?, text, range?: [start, end], merge?} (replaces the selection)
- `text.moveCaret` *(context)* {to: left|right|wordLeft|wordRight|lineStart|lineEnd|up|down|paraStart|paraEnd|start|end, extend?}
- `text.presets` 
- `text.removeAllAnimators` *(context)* {layers?}
- `text.setSelection` *(context)* {layer?, start, end?} | {anchor, caret} | {select: "all"} (character indices)

### time

- `time.back10`   (Shift+PageUp)
- `time.end`   (End)
- `time.forward10`   (Shift+PageDown)
- `time.go` {to: start|end|workStart|workEnd|layerIn|layerOut|nextInOut|prevInOut|nextKey|prevKey, prop?: uid, visible?: [{layer, prop}]}
- `time.layerIn`   (I)
- `time.layerOut`   (O)
- `time.nextFrame`   (PageDown)
- `time.nextInOut`   (Cmd+Alt+Shift+ArrowRight)
- `time.nextKey` {visible?: [{layer, prop}] (only these properties' keys, as the Timeline shows them)}  (K)
- `time.previousFrame`   (PageUp)
- `time.previousInOut`   (Cmd+Alt+Shift+ArrowLeft)
- `time.previousKey` {visible?: [{layer, prop}]}  (J)
- `time.set` {time? (s) | frame? | timecode?}  (Alt+Shift+J)
- `time.start`   (Home)
- `time.step` {frames}
- `time.workAreaEnd`   (Shift+End)
- `time.workAreaStart`   (Shift+Home)

### track

- `track.analyze` *(context)* {layer?, tracker?, direction?: forward|backward|frameForward|frameBackward, start? (s), end? (s), wait?: block until done}
- `track.apply` *(context)* {layer?, tracker?, dimensions?: xy|x|y}
- `track.camera` *(context)* {layer?, shotType?: fixed|variable|specify, aov?: degrees, solveMethod?: auto|typical|flat|tripod, detailed?, lensDistortion?: solve k1/k2, undistort?: render undistorted, wait?}
- `track.delete` *(context)* {layer?, tracker?}
- `track.editTargetDialog` *(context)* 
- `track.extractFaceMeasurements` *(context)* {layer?} → keys a Face Measurements effect from the layer's Face Track Points (one key per tracked frame) and copies those keys
- `track.mask` *(context)* {layer?, mask?: uid|index|name, method?: position|positionScale|positionScaleRotation|positionScaleRotationSkew|perspective|faceOutline|faceDetailed, direction?: forward|backward|frameForward|frameBackward, start? (s), end? (s), wait?: block until done}
- `track.maskMethod` {method: position|positionScale|positionScaleRotation|positionScaleRotationSkew|perspective|faceOutline|faceDetailed}
- `track.motion` *(context)* {layer?}
- `track.new` *(context)* {layer?, kind?: transform|stabilize|affine|perspective|raw, position?, rotation?, scale?, target?: layer}
- `track.options` *(context)* {layer?, tracker?, name?, channel?: rgb|luminance|saturation, blur? (px, 0 = off), enhance?, subpixel?, adaptEveryFrame?, threshold? (%), action?: continue|stop|extrapolate|adapt, trackShape?}
- `track.optionsDialog` *(context)* 
- `track.property` *(context)* {layer?, source?: layer}
- `track.reset` *(context)* {layer?, tracker?}
- `track.select` {layer?, tracker?: uid|name|#n}
- `track.setPoint` *(context)* {layer?, tracker?, point: n (1-based), center?: [x,y], featureSize?: [w,h], searchOffset?: [x,y], searchSize?: [w,h], attachOffset?: [x,y], move?: [dx,dy], time? (s)}
- `track.setTarget` *(context)* {layer?, tracker?, target: layer|null}
- `track.setType` *(context)* {layer?, tracker?, kind?: transform|stabilize|affine|perspective|raw, position?, rotation?, scale?}
- `track.stabilize` *(context)* {layer?}
- `track.status` {layer?, tracker?}
- `track.stop` *(context)* 
- `track.warpStabilizer` *(context)* {layer?, wait?}

### view

- `view.3d.activeCamera` {comp?}  (F12)
- `view.3d.back` {comp?}
- `view.3d.bottom` {comp?}
- `view.3d.custom1` {comp?}  (F11)
- `view.3d.custom2` {comp?}
- `view.3d.custom3` {comp?}
- `view.3d.default` {comp?}
- `view.3d.front` {comp?}  (F10)
- `view.3d.last` {comp?}
- `view.3d.left` {comp?}
- `view.3d.right` {comp?}
- `view.3d.top` {comp?}
- `view.addGuide` {orientation?: vertical|horizontal, position? (comp px, or percent with percent: true), percent?: bool}
- `view.addPercentGuide` {orientation?: vertical|horizontal, position? (percent of the comp)}
- `view.assign3dShortcut` {slot: F10|F11|F12, comp?}
- `view.channel` {channel: rgb|red|green|blue|alpha|rgbStraight, colorized?, toggle?}
- `view.channel.alpha`   (Alt+4)
- `view.channel.blue`   (Alt+3)
- `view.channel.blueColorized`   (Alt+Shift+3)
- `view.channel.green`   (Alt+2)
- `view.channel.greenColorized`   (Alt+Shift+2)
- `view.channel.red`   (Alt+1)
- `view.channel.redColorized`   (Alt+Shift+1)
- `view.channel.rgbStraight`   (Alt+Shift+4)
- `view.clearGuides` *(context)* {comp?}
- `view.closeLockedViewer` *(context)* 
- `view.convertGuides` *(context)* {comp?, to?: percent|pixels, index?}
- `view.customRgb` {name?, red?/green?/blue?/white?: [x, y] (CIE xy), gamma?, srgbCurve?: bool, icc?: path (RGB ICC profile, matrix/TRC or LUT-based A2B0: read when it changes, "" clears; a LUT profile simulates through its tables, `lutProfile` in the reply; typed-in numbers replace it), reload?, from?: a Simulate Output profile to start from, reset?, preserveRgb?, apply?: bool (default true: simulate it)} → the definition (kept in Settings)
- `view.displayColor` {} → display colour management, output simulation, display profile, locked viewer
- `view.displayColorManagement` {value?}
- `view.exportGuides` *(context)* {path}
- `view.exposure` {stops? | delta?}
- `view.extendedViewer` {value?}
- `view.fastPreviewMode` {mode: off|adaptive|draft|fastDraft|wireframe}
- `view.fastPreviews.adaptive`   (Cmd+Alt+2)
- `view.fastPreviews.draft`   (Cmd+Alt+3)
- `view.fastPreviews.fastDraft`   (Cmd+Alt+4)
- `view.fastPreviews.off`   (Cmd+Alt+1)
- `view.fastPreviews.wireframe`   (Cmd+Alt+5)
- `view.fullScreen` 
- `view.get3D` {comp?} → current 3D view, view camera, active camera layer, lights
- `view.grid` {value?}  (Cmd+')
- `view.guides` {value?}  (Cmd+;)
- `view.importGuides` {path}
- `view.layerControls` {value?}  (Cmd+Shift+H)
- `view.layout` {views: 1|2|4}
- `view.lockGuides` {value?}  (Cmd+Alt+Shift+;)
- `view.lookAtAll` {comp?}
- `view.lookAtSelected` *(context)* {comp?, layers?}  (Cmd+Alt+Shift+\)
- `view.moveGuide` {comp?, index, position (comp px), merge?}
- `view.newViewer` {} — another Composition viewer of the active comp; the one in use is locked  (Alt+Shift+N)
- `view.options`   (Cmd+Alt+U)
- `view.panelBackground` {color?: black|darkGray|mediumGray|lightGray|white|custom|#hex, pick?: true}
- `view.removeGuide` {comp?, index}
- `view.res.auto` {comp?}
- `view.res.custom` {factor?: 1..40 (render every n-th pixel), comp?}  (Cmd+Alt+J)
- `view.res.full` {comp?}  (Cmd+J)
- `view.res.half` {comp?}  (Cmd+Shift+J)
- `view.res.quarter` {comp?}  (Cmd+Alt+Shift+J)
- `view.res.third` {comp?}
- `view.reset3DView` {comp?}
- `view.resetExposure` 
- `view.rulers` {value?}  (Cmd+R)
- `view.set3DView` {view: activeCamera|default|front|left|top|back|right|bottom|custom1|custom2|custom3, comp?}
- `view.set3DViewCamera` {view, eye? [x,y,z], poi? [x,y,z], zoom?}
- `view.setPaneView` {pane: 0 (main) | 1 | 2 | 3, view: activeCamera|default|front|left|top|back|right|bottom|custom1|custom2|custom3, comp?}
- `view.setRegionOfInterest` {rect?: [x, y, w, h] | null}
- `view.shareViewOptions` {value?}
- `view.showSnapshot` *(context)* {value?}
- `view.simulateOutput` {profile: none|rec709|ntsc|pal|mac18|srgb|rec2020|p3|linear|myCustom|custom, preserveRgb?, space? (custom)}
- `view.snapToGrid` {value?}  (Cmd+Shift+')
- `view.snapToGuides` {value?}  (Cmd+Shift+;)
- `view.snapping` {value?}
- `view.snappingOptions` {edgesExtended? (Snap Edges Extended), collapsedFeatures? (Snap to Features in Collapsed Compositions and Text Layers): bool, toggle?: one of those keys} → the options
- `view.splitLockedViewer` {comp?, view?: 3D view id}
- `view.takeSnapshot` {comp?, scale?: 0.05..1}  (Shift+F5)
- `view.zoomIn`   (.)
- `view.zoomOut`   (,)

### warp

- `warp.analyze` {layer?, effect?: uid|name|index, wait?: block until done}
- `warp.cancel` *(context)* 
- `warp.status` {layer?, effect?}

### window

- `window.assignWorkspaceShortcut` {slot: Shift+F10|Shift+F11|Shift+F12, workspace?}
- `window.editWorkspaces` {name, rename?: new name, delete?: bool}
- `window.panel` {panel: project|effectControls|composition|layer|timeline|info|audio|preview|effectsPresets|properties|character|paragraph|align|tracker|wiggler|smoother|motionSketch|paint|brushes|renderQueue|flowchart|history|markers|tools|lumetriScopes|footage|mediaBrowser|metadata|progress|contentAwareFill|createNullsFromPaths|vrCompEditor}
- `window.resetWorkspace` 
- `window.restoreScriptPanels` {} → reopens the ScriptUI panels open when EffectCraft last quit (frontends call it at launch) → {opened: [name], failed: [{name, error}]}
- `window.saveWorkspace` 
- `window.saveWorkspaceAs` {name}
- `window.scriptPanel` {name (a script in the ScriptUI Panels folder, e.g. `Layer Tools.jsx`)} → opens it as a dockable panel
- `window.workspace` {name: Default|Standard|Small Screen|Animation|Effects|Motion Tracking|Paint|Text|Minimal|All Panels}
