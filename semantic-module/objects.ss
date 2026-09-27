;;; -*- Gerbil -*-
;;; SPDX-FileCopyrightText: 2026 tao3k team and Contributors
;;;
;;; SPDX-License-Identifier: Apache-2.0 AND LGPL-2.1-or-later

;;; Core owns the semantic Module value; a product supplies its authoring Profile.
(import (only-in :clan/poo/object .o .ref)
        (only-in :clan/poo/mop validate)
        (only-in :core/module-schema/relations
                 poo-flow-empty-imports poo-flow-empty-capabilities
                 poo-flow-empty-profiles)
        :core/semantic-module/types)

(export SemanticModule. ModuleSourceRole. ModuleAuthoringProfile.
        make-semantic-module)

(def SemanticModule. (.ref SemanticModuleContract 'proto))
(def ModuleSourceRole. (.ref ModuleSourceRoleContract 'proto))
(def ModuleAuthoringProfile. (.ref ModuleAuthoringProfileContract 'proto))

(def (make-semantic-module identity-value authoring-value
                           imports: (imports-value (poo-flow-empty-imports))
                           capabilities: (capabilities-value (poo-flow-empty-capabilities))
                           profiles: (profiles-value (poo-flow-empty-profiles)))
  (validate SemanticModuleContract
    (.o (:: @ SemanticModule.)
        identity: identity-value
        imports: imports-value
        capabilities: capabilities-value
        profiles: profiles-value
        authoring: authoring-value)))
