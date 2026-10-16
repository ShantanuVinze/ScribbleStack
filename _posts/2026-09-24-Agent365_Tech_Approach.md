---
title: "Agent 365: A Technical Approach with Entra, Purview and Defender"
date: 2026-09-24 09:00:00 +0800
categories: [Agents]
tags: [agent365, entra, purview, defender, governance, security]
description: "An illustrative enterprise approach to Agent 365 identity governance, data protection and security, with prerequisites and non-blocking enablement boundaries."
---

**Scribblestack is a fictitious company used to illustrate the planning decisions in this article. This is an example technical approach, not a customer deployment report or evidence of completed implementation.**

**Sections 1-3: Microsoft Entra, Microsoft Purview and Microsoft Defender | 24 September 2026**

The example assumes approximately **10,000 agents visible in Agent 365**, CrowdStrike as the endpoint-security platform, and no existing Entra Global Secure Access deployment. The proof of concept (PoC) focuses on supported cloud-agent capabilities and non-blocking evaluation. Local business unit (LBU) requirements, data access and change approvals remain explicit planning inputs.

Feature availability, licensing, preview status and portal paths can change. Confirm the current Microsoft documentation and the capabilities exposed in your tenant before implementation. Expected outcomes below describe what a supported, approved configuration is intended to provide; they are not measured results.

## 1. Microsoft Entra: Give Agents an Identity, an Accountable Owner and Governed Access

Entra adds the identity-governance foundation around supported agents: who is accountable, how each identity is classified, how access policy applies, how resource access is approved, and how responsibilities are maintained when people change roles.

**Agent 365 is the agent-management context; Microsoft Entra supplies these identity and access capabilities.** Existing registry visibility does not prove that every agent has an Entra agent identity, uses the same authentication flow, or is covered by the same controls. The example reuses existing identities and governance configurations where suitable, rather than recreating or bulk-changing the estate.

### What Scribblestack Gains

| Ref | Capability | Benefit to Scribblestack |
| --- | --- | --- |
| **1.a** | Agent identity ownership and sponsorship | Identify who maintains an agent identity and who is accountable for its business use. |
| **1.b** | Custom security attributes | Express business-approved classifications consistently and make them available for supported policy targeting. |
| **1.c** | Agent Conditional Access | Understand which supported access requests would be affected by risk-based or approval-based policies. |
| **1.d** | Entitlement management and access packages | Replace ad hoc, permanent access with request, approval, expiry and review arrangements for supported resources. |
| **1.e** | Lifecycle workflows | Coordinate sponsor transitions, notifications and supported ownership/access follow-up when people leave or change roles. |
| **1.f** | Global Secure Access for supported cloud-agent traffic | Add visibility and, when separately enabled, destination-based controls to supported agent network requests. |

These are **capability options and expected benefits**, not completed outcomes or a recommendation to deploy every option. Capability selection and authorization come before implementation. A validation plan should follow the agreed design; test cases and measured results are outside this article's scope.

In this example, a discovery workshop would help the identity, security and business teams assess each capability's relevance and agree the policy configurations worth evaluating in the PoC.

**Planning note:** The following sections describe selected Entra capabilities, not an exhaustive product catalogue. Whether to enable a capability depends on its business purpose, prerequisites and approved change scope.

### Scribblestack Environment and Common Prerequisites

- **CrowdStrike remains the endpoint-security platform.** This section does not propose activating Defender for Endpoint, replacing CrowdStrike or using unavailable Defender local-agent inventory. Cloud identity controls do not require that endpoint-discovery path.
- Confirm the actual runtime authentication pattern, supported agent types, tenant/region availability and applicable Agent 365, Entra ID, Identity Governance and Global Secure Access entitlements. Product documentation does not establish that a feature is licensed or enabled in a particular tenant.
- Nominate the Entra identity owner, policy administrator, identity-governance owner and business sponsors. Attribute and network capabilities need their own administrative roles; one administrator role does not confer all permissions. 
- Agree least-privilege access, any required admin consent, approved directory attributes, handling of identity/log data and the organization's change process during design. Preserve existing production enforcement and shared configurations.

### 1.a. Establish Owners and Sponsors for Agent Identities

**Capability**  
Associate accountability with both an agent identity blueprint and its linked agent identity instances. An **owner** maintains the identity object; a **sponsor** represents the business/lifecycle accountability defined by Scribblestack. A blueprint-to-instance relationship is identity lineage, not automatically a parent-child relationship between business agents.

**Customer benefit**  
An agent is no longer just an entry in a catalogue: there is a known party to contact for access decisions, changes and lifecycle follow-up. This also supplies the accountability information needed by access packages and sponsor workflows.

**Prerequisites**

- Existing blueprint/agent identity IDs and the relevant Agent 365 record; an agreed provisioning route if a required identity does not yet exist.
- Business-approved owner and sponsor assignments, including responsibilities at blueprint and instance level.
- An administrator authorized to manage the specific Agent ID objects. Confirm current availability, any preview conditions and supported assignment types for the blueprint and linked-identity experiences.

**Enablement steps**

1. In **Entra ID > Agents > Agent blueprints**, open the existing blueprint and its **Owners and sponsors** view. Use the linked identity view or **Agents > Agent identities** for each selected instance.
2. Retain valid existing assignments. Add or correct only the approved owner/sponsor entries on the intended object, including the blueprint principal where the tenant exposes it.
3. Record the blueprint-to-instance mapping and the business owner responsible for keeping it current. Do not assume that an assignment on one layer automatically updates all other layers.

**Expected outcome**  
The selected Entra identity records carry clear technical ownership and business sponsorship. This supports identity governance; it does not itself implement Scribblestack's full AI risk-approval workflow or guarantee that every portal uses the same owner field.

**Change boundary:** Owner/sponsor assignments are effective changes. Maintain existing valid ownership; do not remove the last valid owner or alter every descendant of a shared blueprint without approval.

**Microsoft reference:** [Agent identity blueprint, owners and sponsors](https://learn.microsoft.com/en-us/graph/api/resources/agentidentityblueprint?view=graph-rest-beta&preserve-view=true).

### 1.b. Classify Agent Identities Using Custom Security Attributes

**Capability**  
Create or reuse governed attributes on supported agent identity objects, such as `ApprovalStatus`, `AgentType` or `DataSensitivity`. Values are defined by Scribblestack rather than inferred from an agent's name or publisher.

**Customer benefit**  
Administrators can distinguish approved from pending agents and apply supported policy-targeting rules consistently. For example, `ApprovalStatus=Approved` can be an input to an approval-based access policy; it is not itself an access grant.

**Prerequisites**

- An agreed attribute set, definitions, allowed values and authoritative business process for approving/changing them.
- **Attribute Definition Administrator** for definitions and **Attribute Assignment Administrator** for assignments, scoped appropriately. Global Administrator does not automatically have these attribute permissions.
- Supported target objects and confirmation that the intended policy feature can consume the selected attributes. Agent 365 tags and Entra custom security attributes are different mechanisms.

**Enablement steps**

1. Open **Entra ID > Custom security attributes**. Reuse a suitable set or create an approved, durably named set.
2. Define the required attributes, data types and permitted values. Prefer controlled values for policy decisions; the example names above are proposals, not required Scribblestack terminology.
3. Assign the approved values to the selected supported agent identity enterprise-application/service-principal objects using the available assignment experience.
4. Assign responsibility for updating classifications when an approval or business context changes. Limit attribute writers because an assignment can affect existing attribute-based policies.

**Expected outcome**  
Scribblestack has a consistent classification foundation for the selected identities and supported policy targeting. It does not create automatic business-risk scoring, an approval workflow or LBU data isolation.

**Change boundary:** Attribute changes are live. Attribute sets cannot be renamed or deleted after creation; definitions/values may instead be deactivated. Agree names before creating them, and avoid a bulk classification change across the estate.

**Microsoft reference:** [Add or deactivate custom security attribute definitions](https://learn.microsoft.com/en-us/entra/fundamentals/custom-security-attributes-add).

### 1.c. Evaluate Agent Access Through Conditional Access

**Capability**  
Apply Conditional Access logic to the identity and resource involved in an agent's request. The example PoC calls for policies in **Report-only** so that Scribblestack could assess their potential effect without activating new deny controls.

**Customer benefit**  
Scribblestack can assess two useful governance questions: which requests would be affected when an autonomous agent is considered high-risk, and which would be affected when the agent lacks the approved classification.

| Access pattern | Identity evaluated | Meaning for policy design |
| --- | --- | --- |
| Autonomous / app-only agent | Supported Entra agent identity | Use supported agent-targeted conditions and controls. |
| On-behalf-of / delegated flow | Signed-in user | Existing user policies may already apply. A user-policy result is not agent-identity enforcement. |
| Agent user account | The relevant agent user account | Treat it as a separate targeting pattern with its own supported controls; do not assume identity/blueprint targeting includes it. |
| API-key or other non-Entra access | No applicable Entra token decision on that request | This Conditional Access design does not govern that access path. |

**Prerequisites**

- Known authentication flow, selected agent identities, target resources and existing policies that may also apply.
- Conditional Access administrator and applicable licences; supported agent-risk signals for a risk-based design. Confirm the current availability and preview conditions of agent-risk targeting. Missing activity or risk data must not be interpreted as proof that an agent is safe.
- Approved classifications from 1.b if attribute targeting is used; clear behavior for missing or unapproved values.

**Enablement steps**

1. Open **Entra ID > Conditional Access > Policies > New policy** and select the appropriate **Users or agents** target for the identified flow.
2. Set the agreed identities and resources. Do not adopt all-agent/all-resource targeting by default; use a supported, approved scope and resolve any targeting limitation before creation.
3. Configure the selected pattern:
   - **1.c.i - Risk-based evaluation:** supported agent identity target, `Agent risk = High` where available, and `Block access` as the proposed grant decision.
   - **1.c.ii - Approval-based evaluation:** supported identity inclusion and attribute-based exclusion for approved identities, with `Block access` as the proposed decision for the remaining scope.
4. Save the proposed policies with **Enable policy = Report-only**. Retain that state throughout this PoC direction; no step here promotes them to On.

**Expected outcome**  
Supported sign-in records can show whether the proposed policies apply and what their effect would be. **A configured Block access decision in a Report-only policy does not block the request.** Exclusion from one policy does not grant access or bypass other enforced policies, resource permissions or security controls. Access evaluation is not inspection of prompt content or arbitrary tool actions.

**Change boundary:** Existing enforced policies remain unchanged. No tenant-wide deny policy, identity disablement, synthetic compromise marking or new blocking is introduced by this narrative.

**Microsoft references:** [Conditional Access for agents](https://learn.microsoft.com/en-us/entra/identity/conditional-access/agent-id) and [Report-only mode](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-report-only).

### 1.d. Govern Resource Access Through Access Packages

**Capability**  
Use Entitlement Management to package supported resource access with a request process, justification, approver, expiry and, where supported, periodic review. This can serve agent builders/operators and supported agent identities, with different eligibility rules for each.

**Customer benefit**  
Access can be tied to an approved purpose and duration rather than accumulated through permanent manual grants. Sponsors and resource owners have a defined route for deciding who or what should receive access.

**Prerequisites**

- Applicable Entra Identity Governance entitlement and confirmed support for the intended agent/requester/resource combination.
- An authorized catalog/access-package administrator, resource-owner permission, named approvers and a fallback approver.
- Approved resource roles, eligibility, justification, expiry, extension and review requirements; usable owner/sponsor information from 1.a.

**Enablement steps**

1. Open **ID Governance > Entitlement management > Access packages**. Reuse an appropriate package/catalog or create a narrowly defined package.
2. Add only the supported resources and roles required for the chosen purpose. Separate builder/operator access from agent runtime permissions where they require different approval decisions.
3. Define eligible requesters, justification, approvals and fallback handling. Configure duration, extension approval and supported review settings.
4. For the current planning/non-enforcing stage, leave live request/assignment activation pending approval. Do not grant access or allow automatic assignment merely to show that a package exists.

**Expected outcome**  
A configured access-governance route is available for the selected resources. Once separately activated and used, it can maintain approval and time-bound assignment records. It does not replace the agent runtime's permissions model or govern resources outside the supported package scope.

**Change boundary:** Access packages do not have a universal audit-only mode. Granting an assignment provides real access; expiry/removal can revoke it. These effects require separate authorization before use. 

### 1.e. Maintain Accountability Through Lifecycle Workflows

**Capability**  
Configure supported lifecycle tasks around a sponsor's departure or job-profile change, such as notifications, sponsorship transfer and approved follow-up activities.

**Customer benefit**  
Agent accountability can stay current as people leave or move roles. This reduces reliance on manual follow-up and gives administrators a consistent process for sponsor transitions.

**Prerequisites**

- Applicable lifecycle-workflow licensing, available agent-related templates/tasks and an authorized workflow administrator.
- Reliable HR/directory trigger attributes, manager information and sponsor relationships; an agreed fallback when these are missing or unsuitable.
- Approved workflow population, task order, recipients, transfer rules, error handling and named process owner.

**Enablement steps**

1. Open **ID Governance > Lifecycle workflows > Workflows** and review existing workflows before creating another.
2. Where available, select the **Offboard agent sponsors** or **Agent sponsor job profile change** template. Configure the relevant time-based or attribute-change trigger for the approved population.
3. Include only the required supported notification/transfer tasks and define recipients and failure handling. Do not assume a manager is automatically the appropriate successor.
4. Keep scheduling disabled and do not run the workflow against live users during this planning stage. Unsupported tasks or external-system actions remain implementation dependencies rather than claimed native capability.

**Expected outcome**  
A defined, customer-owned workflow is prepared for the selected sponsor-transition process. Actual task execution and its effects are a later approval decision; the mere existence of a workflow does not mean sponsorship has changed.

**Change boundary:** An on-demand run is a real execution, not audit mode. Notifications, sponsorship transfers and access cleanup must not be triggered on the production population without authorization. 

**Microsoft reference for 1.d-1.e:** [Identity Governance for agents](https://learn.microsoft.com/en-us/entra/id-governance/agent-id-governance-overview).

### 1.f. Extend Network Visibility to Supported Cloud-Agent Traffic

**Included for completeness: Scribblestack does not use Entra Global Secure Access in this example. This capability remains informational unless a separate network-design decision approves it.**

**Capability**  
Use Global Secure Access for Agents to route supported Copilot Studio network requests through Entra's network-security capability. This is separate from Conditional Access token evaluation and separate from endpoint EDR discovery.

**Customer benefit**  
Scribblestack can gain destination/traffic visibility for supported agent requests and a foundation for future network policies. **CrowdStrike does not need to be replaced to consider this cloud-agent path.** Feasibility still depends on the actual cloud environment, connectors, entitlements and network design; no endpoint deployment is assumed.

**Prerequisites**

- Applicable Global Secure Access / Entra Internet Access entitlement and tenant feature availability, confirmed with the network/platform owners.
- Power Platform administrator, Global Secure Access administrator, an approved environment with Dataverse, and a known list of supported agent connectors/traffic.
- Assessment of the existing **baseline security profile**, routing, destinations, privacy/cost implications and affected population. Baseline policies apply at tenant level for supported agent traffic; environment selection must not be mistaken for guaranteed per-agent policy isolation.

**Enablement steps**

1. Review the supported cloud-agent traffic paths and the existing Global Secure Access baseline before proposing any routing change.
2. In **Power Platform > Security > Identity & access > Global Secure Access for Agents**, prepare the approved environment/environment-group configuration. Enable forwarding only if a non-blocking route can be established without weakening existing controls and the network owner approves it. Otherwise leave this capability at design stage.
3. For eligible existing custom connectors, an edit/save after enablement is required to adopt the routing path. Include affected connector owners in that change decision.
4. In **Entra > Global Secure Access > Secure**, prepare only the required network-policy/baseline configuration. For the current non-blocking direction, do not add Block actions or attach a new restrictive policy. Default Allow in a new policy does not neutralize other baseline policies. There is no assumed equivalent of Conditional Access Report-only for the whole routing change.

**Expected outcome**  
If supported and approved, selected cloud-agent network requests become visible through **Global Secure Access > Monitor > Traffic logs**. This is traffic visibility, not local-agent inventory or proof of network blocking. Future destination/category filtering is a separate enforcement decision.

**Microsoft reference:** [Global Secure Access for Copilot Studio agents, including supported connectors and limitations](https://learn.microsoft.com/en-us/power-platform/admin/security/secure-web-ai-gateway-agents).

### Entra Planning Decisions for Scribblestack

| Customer input | Enables |
| --- | --- |
| Selected existing agents, identity/blueprint mappings, authentication flows and resources | Applies the narrative to actual supported agents, not the whole registry by assumption. |
| Named technical owners, business sponsors and agreed ownership-update process | 1.a accountability and the dependent 1.d/1.e workflows. |
| Approved attribute definitions, values and assignment authority | 1.b classification and the approval-based option in 1.c. |
| Agreed access-policy objectives and Report-only scope | 1.c without activating new enforcement. |
| Resource bundles, approvers and access-duration requirements | 1.d design; activation and assignments remain separately authorized. |
| Reliable sponsor-transition data and supported task requirements | 1.e design with scheduling disabled. |
| Network/platform decision on supported cloud-agent forwarding | 1.f feasibility and scope; no forwarding change is assumed in this example. |



### Entra Takeaway

Start with identity, ownership and the actual access pattern. Select only the controls that address an agreed requirement, and distinguish configuration from activation. Report-only evaluation, prepared access packages and disabled workflow schedules have different effects; none is evidence of completed governance or tested protection.

## 2. Microsoft Purview: Understand Agent Data Use and Apply Data Protection and Compliance Controls

Scribblestack's agent inventory provides a starting point for governance. Purview adds the data perspective: what sensitive information supported agents interact with, which information they should be allowed to use, and how captured interactions can support compliance review and investigation.

**Agent 365 provides the agent-management context; Microsoft Purview supplies the data security and compliance capabilities.** An agent appearing in the registry does not establish that Purview receives its prompts and responses, that a DLP policy applies, or that its interactions are retained. Coverage depends on the agent platform, integration, policy location and available data.

### What Scribblestack Gains

| Ref | Capability | Benefit to Scribblestack |
| --- | --- | --- |
| **2.a** | AI data visibility and audit | Understand supported agent activity and the sensitive information involved. |
| **2.b** | Interaction collection and custom-agent integration | Extend supported Purview capabilities to selected cloud and custom agents whose interactions are not already captured. |
| **2.c** | Data risk assessments and information protection | Identify oversharing and prepare appropriate protection for agent-accessible and agent-created information. |
| **2.d** | Data Loss Prevention | Define where sensitive data should not be used or shared through supported agent workflows. |
| **2.e** | Communication Compliance | Route selected potentially inappropriate or risky AI interactions to authorized human reviewers. |
| **2.f** | Insider Risk Management for agents | Help investigators prioritize supported agent-related data-risk signals. |
| **2.g** | Retention and eDiscovery | Govern the lifecycle of captured interactions and make supported records available for authorized investigations. |
| **2.h** | Compliance assessments and policy ownership | Organize evidence, improvement actions and ongoing responsibility for the selected controls. |
| **2.i** | Endpoint and browser controls for public AI use | Understand an adjacent capability for staff use of AI websites; included for information, not assumed available or enabled in this PoC. |

These are **capability options and expected benefits**, not completed outcomes or a recommendation to deploy every option. In this example, discovery would establish business relevance, supported coverage and the configurations to evaluate. A separate validation plan should follow the agreed design.

**Planning note:** Use these capabilities to identify stakeholder decisions and required change requests. Enabling collection, granting content access or applying a policy requires approval even when no blocking is involved.

### Scribblestack Environment and Common Prerequisites

- **CrowdStrike remains the endpoint-security platform.** Cloud-based Purview controls are evaluated independently of Defender local-agent discovery. Endpoint DLP and browser-based collection have separate prerequisites and are not assumed to be deployed.
- Confirm the selected agent platforms, authentication flows, data sources, channels, users and existing Purview coverage. Reuse established classifications and policies rather than introducing a parallel governance model.
- Confirm applicable Microsoft 365/Purview and Agent 365 entitlements, tenant/region availability and any preview conditions. Some Foundry, Copilot Studio and non-Microsoft AI scenarios require **pay-as-you-go billing**; obtain approval from the Azure billing owner before enablement.
- Nominate the data-protection owner, agent/platform owners, Purview administrators and relevant compliance, legal and investigation teams. Policy administration, viewing metadata and viewing interaction content require different permissions.
- Agree what may be collected, who may see prompts and responses, storage/retention requirements and LBU access boundaries. A restricted reader role or a policy scope must not be assumed to provide the required regional or organizational separation in every solution.

### 2.a. Establish AI Data Visibility and Audit

**Capability**  
Use Purview Data Security Posture Management (DSPM), AI activity views and Audit to understand supported agent interactions and sensitive-information detections. Activity metadata, classified content and retained prompt/response text are distinct evidence types.

**Customer benefit**  
Scribblestack can identify where supported agents interact with sensitive data and give administrators a starting point for data-risk decisions and investigation.

**Prerequisites**

- Supported agent activity reaching Purview through the relevant native or configured integration; registry visibility alone is insufficient.
- DSPM read access and the appropriate Audit search roles. Viewing actual interaction content requires additional content-viewing permissions.
- Agreed sensitive information types, activity population and time window; confirmation of existing audit configuration and applicable retention.

**Enablement steps**

1. Open **Purview > Data Security Posture Management > AI observability** and identify the available agent and activity views for the selected platforms.
2. In **DSPM > Activity explorer > AI activities**, prepare filters for the selected agents/apps and relevant sensitive-information categories.
3. In **Purview > Audit > Search**, establish the appropriate activity and identity filters. Retain existing auditing; investigate missing ingestion or permissions before proposing a configuration change.
4. Assign responsibility for reviewing visibility gaps and findings. Record which sources provide metadata only and which provide authorized content access.

**Expected outcome**  
Scribblestack has a defined view of supported AI data activity and an audit-search route. Data appears only where the source supplies it and after processing; absence of events does not prove absence of activity or sensitive data.

**Change boundary:** Reading existing records does not activate DLP enforcement. Enabling additional collection or granting content access is a separate privacy and permissions decision.

### 2.b. Extend Coverage Through Interaction Collection and Agent Integration

**Capability**  
Connect supported cloud or custom-agent interactions to Purview using the platform-specific configuration, collection policy or application integration. These are different onboarding routes, not one universal connector.

**Customer benefit**  
Scribblestack can identify the work needed to move a selected agent from inventory visibility to supported data-security and compliance coverage.

**Prerequisites**

- Named platform/development owner, a supported integration route and known Entra application/agent identity mappings.
- Approved interaction data, collection scope, content-capture settings and consumption costs. Detection does not necessarily store the complete prompt and response.
- Applicable permissions and admin consent, reviewed against the current integration requirements. Agent 365 telemetry instrumentation and Purview policy middleware are not interchangeable.

**Enablement steps**

1. Map each selected agent to its actual route: existing Microsoft 365 integration, supported Foundry configuration, enterprise AI collection, or custom-agent middleware/API integration.
2. For supported Foundry scenarios, review **Foundry > Operate > Compliance > Data security and governance** with the platform owner. Prepare the approved Purview configuration rather than assuming an Azure security connector captures agent interactions.
3. For supported enterprise AI sources, review **Purview > DSPM > Recommendations** or **Data Loss Prevention > Collection policies**. Define the users/apps and whether content capture is required before activating collection.
4. For a custom agent, have its developer prepare the supported Purview integration in the agent's execution path, reuse the appropriate identity, and request only the required API permissions and consent. Treat this as a code release, not a portal-only change.
5. Associate supported policies with the correct application identity and assign an owner for ingestion failures, policy-evaluation behavior and consumption monitoring.

**Expected outcome**  
Each selected agent has a documented integration route and, once separately enabled, can supply the data required by the supported Purview solutions. Registry sync alone does not capture interactions or enforce a Purview policy.

**Change boundary:** Collection changes what information is processed and stored; middleware can change runtime behavior. No broad content collection, tenant-wide consent or production code deployment is authorized by this narrative.

**Microsoft references for 2.a-2.b:** [Purview for Agent 365](https://learn.microsoft.com/en-us/purview/ai-agent-365), [Purview for Microsoft Foundry](https://learn.microsoft.com/en-us/purview/ai-azure-foundry) and [Purview integration with Agent Framework](https://learn.microsoft.com/en-us/agent-framework/integrations/purview).

### 2.c. Assess Oversharing and Prepare Information Protection

**Capability**  
Use supported data risk assessments and sensitivity labels to understand exposure in agent-accessible content and prepare protection for both source information and agent-generated output.

**Customer benefit**  
Scribblestack can identify sensitive or over-shared information before expanding agent use and apply its existing classification model to the relevant data locations.

**Prerequisites**

- Agreed SharePoint/data-source scope, data owners and existing sensitivity-label taxonomy.
- Appropriate DSPM, information-protection and resource-administration permissions; additional content/list-viewing roles where assessment details require them.
- Understanding of encryption, the runtime identity that accesses protected content, supported usage rights and where the agent writes its output.

**Enablement steps**

1. Open **Purview > DSPM > Data risk assessments** and review existing results before scheduling any additional supported assessment.
2. Identify the selected repositories, sensitive-data findings and sharing exposures with the data owners. Treat permission correction, content-discovery restrictions and labelling as separate remediation choices.
3. In **Purview > Information Protection > Labels and label policies**, reuse Scribblestack's published labels and confirm the required service support for the selected locations.
4. Where a supported agent identity legitimately needs encrypted content, review the applicable **VIEW** and **EXTRACT** rights and approve only the necessary access. Do not grant broad rights merely to remove an access error.
5. Identify where agent-created content is stored. Prepare supported default-labelling or auto-labelling options; do not assume every agent output inherits the source label.

**Expected outcome**  
Scribblestack has a prioritized view of data exposure and a protection design for the selected repositories and outputs. Assessment coverage is limited to supported locations and is not an estate-wide scan by assumption.

**Change boundary:** Publishing labels, changing encryption rights, auto-labelling and altering sharing can affect existing users and applications. Prepare these changes for approval; do not activate broad remediation or modify shared labels without their owners.

### 2.d. Define Data Loss Prevention for Supported Agent Workflows

**Capability**  
Apply DLP at supported data and application boundaries, such as restricting use of labelled content in the supported Copilot location, inspecting Exchange email, or evaluating custom-agent content through a supported Purview integration.

**Customer benefit**  
Scribblestack can express where sensitive information must not be used or disclosed, with rules tied to the actual workflow rather than an assumption that one policy covers every agent action.

**Prerequisites**

- DLP administration permissions, approved sensitivity labels/sensitive information types, and a supported policy location for the intended activity.
- Known agent access and output paths, selected users/accounts/apps, approved exceptions and existing overlapping policies.
- A policy owner responsible for matches and operational impact; applicable integration and billing prerequisites from 2.b.

**Enablement steps**

1. Open **Purview > Data Loss Prevention > Policies** and review existing policies for the chosen workflow.
2. For supported labelled-content restrictions, select **Microsoft 365 Copilot and Copilot Chat** and prepare the relevant label conditions. Do not assume this location governs all Copilot Studio, Foundry or external-agent traffic.
3. For agent-generated email that traverses Exchange, prepare an **Exchange email** policy scoped to the approved accounts, recipients and sensitive-information conditions. An agent using a different mail service is outside this path.
4. For supported custom-agent interaction controls, use the integration and policy targeting agreed in 2.b; define how the application handles a policy response.
5. Keep new policies in a supported **simulation/test mode without blocking or user-impacting actions**. If the chosen control does not offer a suitable non-enforcing mode, leave it at design stage pending authorization.

**Expected outcome**  
Scribblestack has a DLP design and, where simulation is available and data is supplied, a route to understand potential matches. Simulated matches do not prove that content was blocked, and not every match creates an alert.

**Change boundary:** No new DLP blocking is introduced. Existing enforced policies remain unchanged. An agent may not explain a downstream DLP restriction to the user, so the policy owner must own operational follow-up.

**Microsoft references for 2.c-2.d:** [Agent 365 data protection and label requirements](https://learn.microsoft.com/en-us/purview/ai-agent-365) and [DLP for Copilot interactions](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about).

### 2.e. Review AI Interactions Through Communication Compliance

**Capability**  
Use Communication Compliance to detect selected policy conditions in supported AI prompts and responses and route matches for human review.

**Customer benefit**  
Scribblestack can bring potentially inappropriate communications or sensitive-information concerns into a controlled review process with named reviewers and escalation responsibilities.

**Prerequisites**

- Supported interaction collection, applicable licensing and **pay-as-you-go requirements for non-Microsoft 365 Copilot AI data**, including relevant Copilot Studio scenarios.
- Communication Compliance administration permissions; reviewers must have the appropriate investigation permissions and be assigned to the policy.
- Approved populations, classifiers/conditions, review settings, privacy arrangements and escalation process.

**Enablement steps**

1. Open **Purview > Solutions > Communication Compliance > Policies** and review existing AI-related policies.
2. Prepare an appropriate supported policy with the selected interaction sources, population and detection conditions. Reuse Scribblestack's communication standards rather than assuming every classifier is relevant.
3. Assign authorized reviewers and agree how matches will be triaged, documented and escalated. Separate policy administration from permission to inspect interaction content where required.
4. Obtain approval before activating the policy and making captured communications available to its reviewers.

**Expected outcome**  
A defined review process is available for supported, collected interactions. A match is a signal requiring human assessment, not an automatic finding of misconduct or regulatory breach.

**Change boundary:** Communication Compliance is a review/detection capability, not an inline agent kill switch or universal prompt blocker. Policy activation and reviewer access have privacy implications even when they do not block activity.

**Microsoft reference:** [Communication Compliance for generative AI interactions, including billing and reviewer requirements](https://learn.microsoft.com/en-us/purview/communication-compliance-copilot).

### 2.f. Investigate Agent Data Risk Through Insider Risk Management

**Capability**  
Use supported Insider Risk Management agent policies to identify and prioritize agent-related data-risk indicators. This is separate from user policies that assess how employees use AI tools and websites.

**Customer benefit**  
Scribblestack's authorized investigators can bring supported agent-related signals into an established triage and case-management process.

**Prerequisites**

- Insider Risk Management setup, relevant roles, supported agent signals and confirmation of the available agent-policy experience and preview status.
- Approved privacy controls, investigation ownership and escalation criteria.
- Review of current access-scoping and guest-content limitations. Microsoft documents that administrative units are not currently supported for agent alerts and that scoped analysts cannot see those alerts; do not assume this satisfies LBU separation requirements.

**Enablement steps**

1. Open **Purview > Insider Risk Management > Policies > Agent policies** and inspect the existing/default agent policy before proposing a new configuration.
2. Confirm which agent types, indicators and collection paths are supported in Scribblestack's tenant.
3. Agree the available policy settings and investigation access with the insider-risk owner. Where the required access separation is unsupported, retain the capability as a design decision.
4. Assign a review route for agent alerts and escalation into the approved investigation process. Keep any employee **Risky AI usage** policy separate from the agent-policy design.

**Expected outcome**  
Scribblestack has an agreed approach to reviewing supported agent data-risk signals. Product risk indicators do not automatically implement Scribblestack's business-risk tiers or establish a person's intent.

**Change boundary:** Enabling monitoring or investigation access is a substantive privacy decision. No new employee-monitoring policy, case escalation or automated access restriction is activated by this narrative.

**Microsoft reference:** [Monitoring agents with Insider Risk Management](https://learn.microsoft.com/en-us/purview/insider-risk-management-monitoring-agents).

### 2.g. Govern Retention and Legal Retrieval of Captured Interactions

**Capability**  
Use Data Lifecycle Management and eDiscovery to retain, search and manage supported captured AI interaction records according to approved legal and records-management requirements.

**Customer benefit**  
Scribblestack can define how relevant interaction records should be preserved and retrieved rather than relying on an agent's conversation history or a short-lived activity view.

**Prerequisites**

- Legal/records-owner decisions on retention duration, deletion, holds, custodians, locations and access.
- Appropriate retention-management and eDiscovery roles, with separate authority for case access and exports.
- A supported collection route that actually captures the required records. Foundry and enterprise AI scenarios may need explicit collection policies; selecting a retention location does not collect missing content.

**Enablement steps**

1. Map the selected interaction sources to the supported storage and retention locations, including **Enterprise AI apps** where applicable.
2. In **Purview > Data Lifecycle Management > Retention policies**, prepare the approved scope and retention behavior, taking existing policies and holds into account.
3. In **Purview > eDiscovery > Cases**, define the authorized case-access, search and export process for the supported interaction records.
4. Obtain legal and records-management approval before publishing retention/deletion settings, placing holds or exporting content.

**Expected outcome**  
Scribblestack has a records-management design and a supported retrieval route for captured interactions. Neither Audit visibility nor an empty search establishes that full conversation content is retained.

**Change boundary:** Retention, deletion and holds affect evidence and storage obligations. Do not shorten retention, introduce deletion, remove holds or perform evidence exports as part of configuration planning.

**Microsoft references:** [Retention for Copilot and AI apps](https://learn.microsoft.com/en-us/purview/retention-policies-copilot) and [Foundry collection requirements for retention and eDiscovery](https://learn.microsoft.com/en-us/purview/ai-azure-foundry).

### 2.h. Organize Compliance Evidence and Ongoing Policy Ownership

**Capability**  
Use Compliance Manager assessments and an agreed operating model to connect the selected controls with improvement actions, evidence owners and review responsibilities.

**Customer benefit**  
Scribblestack can see what has been designed, what remains dependent on implementation, and who will maintain the controls after initial enablement.

**Prerequisites**

- Applicable assessment availability/licensing, Compliance Manager access and compliance-owner agreement on the framework being assessed.
- A list of selected policies and integrations, their actual status, named owners and evidence-handling requirements.
- Agreed review frequency and escalation routes across data protection, compliance, security and agent owners.

**Enablement steps**

1. Open **Purview > Compliance Manager > Assessments** and review the relevant available AI assessments with the compliance team.
2. Map selected capabilities to applicable improvement actions. Keep planned configuration separate from implemented controls and observed results.
3. Assign policy owners, evidence owners and review dates, including responsibility for DLP matches, communication reviews and collection failures.
4. Record gaps requiring business-process controls or capabilities outside this PoC rather than marking them complete through a product setting.

**Expected outcome**  
Scribblestack has a clear ownership and evidence framework for the chosen controls. A compliance score or completed improvement action is not legal certification or proof of compliance with every applicable regulation.

**Change boundary:** This is assessment and operating-model preparation. No regulatory attestation or declaration of completed control effectiveness is made.

**Microsoft reference:** [Compliance Manager assessments](https://learn.microsoft.com/en-us/purview/compliance-manager-assessments).

### 2.i. Consider Endpoint and Browser Controls for Public AI Use

**This capability is included for completeness. Endpoint/browser deployment is not assumed or proposed as part of this Agent 365 PoC.**

**Capability**  
Use supported Purview endpoint/browser integrations for visibility and DLP around staff use of public AI websites, with a separate user-focused Insider Risk Management option where appropriate.

**Customer benefit**  
Scribblestack can understand how public AI website use could be addressed alongside managed-agent governance, without confusing a user's browser activity with an agent's cloud runtime.

**Prerequisites**

- Endpoint-owner assessment of existing Purview onboarding, supported operating systems/browsers, extension or Edge configuration requirements and coexistence with CrowdStrike.
- Applicable endpoint DLP/insider-risk entitlements, device-management permissions and approved user-monitoring arrangements.
- An explicit scope decision and separate endpoint change approval; CrowdStrike presence alone neither establishes nor rules out Purview Endpoint DLP readiness.

**Enablement steps**

1. Review the existing device/browser estate with the endpoint and data-protection owners without changing it.
2. Identify the onboarding, browser integration and policy prerequisites for the desired public-AI scenario.
3. Prepare the supported **DLP > Devices** policy design and, only if separately requested, a user **Risky AI usage** design with the required signals.
4. Leave device onboarding, extension deployment, new collection and policy activation outside the current enablement activity unless separately approved.

**Expected outcome**  
Scribblestack has a documented feasibility and scope decision for public-AI data controls. No endpoint visibility, warning or blocking outcome is claimed for the current PoC.

**Change boundary:** Do not onboard/offboard devices, replace CrowdStrike, deploy browser extensions or introduce Intune policies through this section.

**Microsoft reference:** [Endpoint data loss prevention](https://learn.microsoft.com/en-us/purview/endpoint-dlp-learn-about).

### Purview Planning Decisions for Scribblestack

| Customer input | Enables |
| --- | --- |
| Selected agents, platforms, channels and existing collection coverage | 2.a/2.b visibility and the correct integration route. |
| Approved content capture, viewer permissions, privacy and LBU separation requirements | Appropriate access across activity, compliance and investigation experiences. |
| Licensing and Azure consumption approval | Cost-aware enablement of the selected cloud/custom-agent capabilities. |
| Existing labels, sensitive information types, data owners and repositories | 2.c information protection and 2.d DLP design. |
| Communication standards, reviewers and escalation process | 2.e Communication Compliance. |
| Insider-risk ownership and supported investigation access model | 2.f agent-risk review without assuming employee-monitoring approval. |
| Retention, deletion, hold and evidence-export requirements | 2.g records management and eDiscovery planning. |
| Assessment framework, policy owners and review cadence | 2.h ongoing governance and evidence responsibility. |
| Endpoint/browser feasibility and an explicit scope decision | 2.i remains informational unless separately authorized. |

### Purview Takeaway

Map each control to its actual data source, collection route and policy location. Audit metadata, captured content, DLP enforcement and retained evidence are different outcomes. Establish data access, privacy, consumption costs and retention responsibilities before enabling the selected capabilities.

## 3. Microsoft Defender: Understand Agent Security Posture and Investigate Supported Threats

Defender adds a security perspective to the agent estate: which supported agents are visible, what security findings are available, and how supplied activity can support threat detection and investigation. For supported cloud-agent paths, runtime protection can also evaluate relevant interactions and tool activity.

**Agent 365 registry visibility, Defender inventory, security posture, runtime evaluation and incident generation are separate capabilities.** Each depends on the relevant connection and telemetry. None should be assumed to cover all approximately 10,000 registry entries merely because those entries are visible in Agent 365.

### What Scribblestack Gains

| Ref | Capability | Benefit to Scribblestack |
| --- | --- | --- |
| **3.a** | Security connections and cloud-agent inventory | Establish which selected agents and data sources are available to Defender. |
| **3.b** | Agent security posture | Prioritize supported findings and exposure relationships for owner-led remediation. |
| **3.c** | Cloud-agent runtime protection in Audit mode | Understand supported threat detections without activating new blocking. |
| **3.d** | Prompt evidence for investigation | Give authorized responders additional context where supported and approved. |
| **3.e** | Threat investigation and advanced hunting | Connect agent-related signals with the existing security-response process. |
| **3.f** | SaaS AI application discovery | Assess available cloud-discovery routes without assuming Defender endpoint deployment. |
| **3.g** | Local-agent discovery and endpoint runtime protection | Understand the endpoint-dependent capability and why it is unavailable in the current PoC posture. |

These are **capability options and expected benefits**, not completed outcomes or a recommendation to deploy every option. In this example, discovery would establish the supported cloud-agent paths, security objectives and required connections. A separate validation plan should follow the agreed design.

**Planning note:** CrowdStrike remains Scribblestack's endpoint-security platform, and Scribblestack does not use Entra Global Secure Access. This example does not introduce Defender for Endpoint or GSA. Cloud runtime evaluation uses the supported default audit behavior; creating custom blocking rules is outside this PoC's scope.

### Scribblestack Environment and Common Prerequisites

- Confirm Agent 365 and relevant Defender entitlements, **Security for AI** availability, supported platforms, regions and preview conditions. Availability must be confirmed for each selected capability rather than inferred from the overall product's release status.
- Identify the selected agents and Entra identities, existing platform/registry connections and the activity each source supplies. External-platform registry sync is not a substitute for runtime instrumentation.
- Nominate the security administrator, SOC investigation owner, agent developers and relevant Power Platform/cloud-platform administrators. Reader, configuration, hunting and response permissions are different authorities.
- Agree connector scope, data access, evidence collection, consumption implications and approvals before enabling new sources. Reuse existing connections and preserve their dependent controls.
- Separate cloud-agent security from endpoint prerequisites. Local discovery and local runtime protection require the supported Microsoft endpoint stack; those requirements must not be copied into a cloud-agent design or assumed satisfied by CrowdStrike.

### 3.a. Establish Security Connections and Cloud-Agent Inventory

**Capability**  
Connect supported Agent 365, Microsoft 365 and cloud-platform data sources to Defender and identify the agents available in its security inventory.

**Customer benefit**  
Scribblestack can establish a security-relevant view of the selected agents and identify missing data sources before relying on posture or detection capabilities.

**Prerequisites**

- Applicable entitlements, Security for AI availability and an authorized security administrator.
- Known existing Agent 365 connections, Entra identities, platform owners and approved access to the relevant Microsoft 365 activity sources.
- A supported platform integration route; credentials and permissions handled by the authorized owners rather than included in this document.

**Enablement steps**

1. Open **Defender > Settings > Security for AI > Get started** and review the Agent 365 connection status and existing data sources.
2. Review the **Microsoft 365** connector, including the required Entra management events and Microsoft 365 activities. Prepare only the missing, approved connection changes.
3. For supported external platforms, review existing **Microsoft 365 admin center > Agents > Connected platforms** configurations with the platform owner. Do not recreate or disconnect working integrations.
4. Open **Defender > Assets > AI agents > Agents** and map the selected records to their platform, identity and business owner. Record visibility gaps separately from an absence of security findings.

**Expected outcome**  
The selected supported agents have a defined Defender inventory and data-source mapping. An inventory record does not prove that prompts, tool calls or all runtime events are available.

**Change boundary:** Connector changes affect collection and dependent security features. No broad credential grant, platform disconnection or endpoint onboarding is included.

**Microsoft reference:** [Enable security for AI agents using Microsoft Defender](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/get-started-defender-security-for-ai).

### 3.b. Review Agent Security Posture and Exposure

**Capability**  
Review the security findings, recommendations and identity/resource relationships that Defender exposes for supported agents.

**Customer benefit**  
Scribblestack can prioritize the available findings and route them to the appropriate identity, data, platform or agent owner instead of treating every inventory entry as equally understood.

**Prerequisites**

- Supported inventory and security data from 3.a, with applicable posture capabilities and permissions.
- Known owners, intended agent permissions and business context for interpreting findings.
- Agreement on how product severity/risk indicators relate to Scribblestack's remediation process without replacing its business-risk classification.

**Enablement steps**

1. In **Defender > Assets > AI agents > Agents**, review the available platform, risk and security-indicator filters for the selected population.
2. Open agent details and inspect the available identity, tool, resource, alert and recommendation information. Record relationships not supplied by the source as unknown.
3. Assign each relevant finding to its owning team and define a proposed remediation action and priority.
4. Where supported, use the **AgentsInfo** hunting table to prepare an inventory/posture view for the security team.

**Expected outcome**  
Scribblestack has an owner-led view of available agent security findings and a prioritized remediation backlog. Missing findings are not proof of low risk, and product relationships are not a complete business-agent dependency map.

**Change boundary:** Reviewing posture does not remediate it. Permission removal, identity disablement, tool restrictions and platform changes require their own approval.

**Microsoft reference:** [Discover AI agents and assess security posture](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-inventory).

### 3.c. Prepare Cloud-Agent Runtime Protection in Audit Mode

**Capability**  
Evaluate supported cloud-agent runtime activity using Defender real-time protection. The documented **Default** cloud rule audits all agents; **custom rules block** matching actions. Audit visibility still requires a supported runtime integration, and the default rule's all-agent scope must not be mistaken for a per-agent pilot setting.

Coverage depends on the execution path: supported Agent 365 tool invocations use Work IQ MCP integration; Copilot Studio protection evaluates tool invocations; supported Foundry protection evaluates requests, responses and tool activity. This is not inspection of every arbitrary agent action.

**Customer benefit**  
Scribblestack can assess supported threat signals and operational impact before making any future decision about blocking.

**Prerequisites**

- Security for AI and required data connections, supported agent identities and confirmed runtime-protection availability.
- Security administrator plus the relevant cloud-platform owner. For Copilot Studio, configuration is per supported Power Platform environment and requires its administrator.
- Review of the default audit rule, any existing custom blocking rules, provider-error behavior and collection scope. Select agents for observation without assuming this narrows the default rule's scope. Confirm the integration route separately for Foundry or other supported platforms.

**Enablement steps**

1. Identify the supported runtime path for each selected cloud agent. Where no supported connection exists, leave that agent outside runtime-protection coverage rather than infer coverage from inventory.
2. For Copilot Studio, review **Defender > Settings > Security for AI > Get started > Connect Copilot Studio** and the corresponding **Power Platform > Security > Threat detection > Additional threat detection** configuration.
3. With the Power Platform owner, prepare the intended environment, provider application ID and endpoint from the supported setup flow. Keep the App ID consistent between Power Platform and the Defender connector configuration. Provider-error behavior is separate from a threat verdict or protection-rule action; an audit setting for errors does not neutralize blocking elsewhere.
4. Review **Defender > Settings > Security for AI > Policies & rules > Real-time protection**. Confirm the built-in **Default** audit rule and all applicable existing rules. Do not create a custom rule as an audit-only demonstration: the documented custom-rule action is blocking.
5. Enable a new connection only after approval and confirmation of its provider behavior, default audit coverage and applicable existing rules. If a non-blocking path cannot be established without weakening existing controls, retain the design without enabling it.

**Expected outcome**  
Once supported and authorized, the selected runtime path can supply evaluation signals and associated behavior records. **Audit mode does not stop the evaluated action.** A behavior record is not automatically an alert or incident. Microsoft documents that an agent covered by a blocking rule does not generate near-real-time alerts; audit and block behaviors remain available in **BehaviorInfo**.

**Change boundary:** No new Block rule, fail-closed provider setting, endpoint runtime control or tenant-wide rollout is introduced. Preserve existing production enforcement; do not weaken it merely to create an audit-only demonstration.

**Microsoft reference:** [Real-time protection, default audit behavior and custom blocking rules](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-real-time-protection).

### 3.d. Prepare Prompt Evidence for Authorized Investigations

**Capability**  
Review supported prompt evidence in Defender investigation experiences. Microsoft documents that prompt evidence collection is enabled by default and supplies relevant suspicious snippets, not complete conversations. Confirm the existing setting and approved data handling before changing it.

**Customer benefit**  
Authorized responders can gain context for an agent-related security signal, reducing reliance on an alert title alone.

**Prerequisites**

- A supported agent integration and available **Prompt evidence collection** setting.
- Security-administration authority and approved investigation access, privacy, data-location and retention arrangements.
- Agreement on handling sensitive content and secrets. Product redaction must not be treated as a guarantee that every sensitive value is removed.

**Enablement steps**

1. Review **Defender > Settings > Security for AI > Prompt evidence collection** and its current tenant setting.
2. Confirm which supported sources and investigation surfaces can provide evidence, and whether the setting has a broader scope than the selected PoC agents.
3. Obtain data-protection and security-owner approval before changing collection. Leave it unchanged if the available scope is not acceptable.
4. Define which responders may access the evidence and how it is handled during investigation and escalation.

**Expected outcome**  
Where enabled and supported, agent-related investigations can include additional prompt evidence. This is not a complete transcript archive and does not replace Purview retention or eDiscovery.

**Change boundary:** Evidence collection changes data handling even without blocking. Disabling future collection is not assumed to delete records already stored.

**Microsoft reference:** [Control prompt evidence in alerts](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-real-time-protection#control-prompt-evidence-in-alerts).

### 3.e. Investigate Threats and Prepare Advanced Hunting

**Capability**  
Use Defender alerts, incidents and hunting data to investigate supported agent threats, such as detected prompt-injection attempts, suspicious tool activity or sensitive-data exposure signals.

**Customer benefit**  
Scribblestack's SOC can place agent-related signals into its existing triage and response process, with clearer accountability across agent, identity and resource owners.

**Prerequisites**

- Actual supported telemetry reaching Defender; an approved instrumentation release where a custom platform requires it. For Foundry threat detection, Microsoft documents support for published agents, not agents used only in a playground.
- Appropriate investigation/hunting roles, available tables and access to the relevant identities and resources.
- Agreed triage ownership, escalation criteria and response authority. CrowdStrike telemetry or incidents are not assumed to be integrated into Defender.

**Enablement steps**

1. In **Defender > Incidents & alerts**, prepare the relevant views and ownership route for supported agent-related signals.
2. In **Advanced hunting**, inspect the available schemas before preparing queries. Relevant tables may include **AgentsInfo**, **BehaviorInfo**, **BehaviorEntities**, **AlertInfo**, **AlertEvidence** and **CloudAppEvents**, depending on the source and entitlement.
3. Define how responders will correlate available agent identities, timestamps, alerts and resource activity. Record source gaps and ingestion delays rather than treating an empty query as a clean security result.
4. Prepare custom detections only where a clear gap and supported data justify them. Keep scheduled detections, automated response and ticket integrations pending their respective approvals.

**Expected outcome**  
Scribblestack has a supported investigation and hunting approach for the selected agent activity. Not every interaction is retained as a hunting event; not every behavior generates an alert, incident or ITSM ticket.

**Change boundary:** Investigation preparation does not authorize identity disablement, device isolation, agent shutdown or automated remediation. No synthetic compromise or production attack activity is introduced here.

**Microsoft reference:** [Agent threat detection, investigation and hunting tables](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-detection-protection).

### 3.f. Assess SaaS AI Application Discovery Without Endpoint Replacement

**Capability**  
Use Defender for Cloud Apps Cloud Discovery with supported traffic-log or secure-web-gateway sources to identify SaaS AI application usage where those sources are available.

**Customer benefit**  
Scribblestack can assess whether existing network/security telemetry provides an additional view of AI application use without introducing Defender for Endpoint or Entra GSA.

**Prerequisites**

- Applicable Defender for Cloud Apps entitlement, administration access and an approved supported log/SWG source.
- Network/security-owner agreement on log content, upload method, privacy, coverage and processing costs.
- A clear distinction between discovery of an AI application/domain and discovery of an individual agent, its prompts or its local MCP configuration.

**Enablement steps**

1. Open **Defender > Cloud apps > Cloud discovery** and review any existing data sources and GenAI application views.
2. Ask the network/security owner to identify a supported existing log or SWG integration. Do not assume CrowdStrike supplies the required Cloud Discovery feed.
3. Prepare a narrowly scoped data-source configuration only if a supported route and approval exist. If no suitable source exists, retain this capability as informational.
4. Agree how discovered application use will be reviewed and how approved/unapproved use decisions reach the appropriate service owner.

**Expected outcome**  
Supported supplied traffic can provide AI application-usage visibility. It does not establish local-agent inventory, complete prompt capture or a record of every individual agent execution.

**Change boundary:** No endpoint deployment, new network blocking, application unsanctioning or traffic-routing change is included. Discovery is not itself an enforcement action.

**Microsoft reference:** [Set up Cloud Discovery](https://learn.microsoft.com/en-us/defender-cloud-apps/set-up-cloud-discovery).

### 3.g. Understand Local-Agent Discovery and Endpoint Runtime Protection

**This capability is included for completeness. Defender local-agent discovery and its associated endpoint actions are unavailable under Scribblestack's current endpoint posture.**

**Capability**  
On supported devices meeting Microsoft's prerequisites, Defender can discover supported local agents and MCP configurations and provide associated endpoint runtime-security capabilities. These are separate from the cloud-agent paths above.

**Customer benefit**  
If Scribblestack independently revisits its endpoint architecture in the future, this capability could provide visibility into supported locally running agents and their device/identity relationships.

**Prerequisites**

- Applicable Defender for Endpoint licensing, device onboarding and the supported operating-system, sensor and Microsoft Defender Antivirus configuration for the specific feature.
- Endpoint/security-owner approval and confirmation of current platform support and preview conditions. Microsoft's local-discovery prerequisites include active Defender Antivirus with real-time protection; discovery and posture also have different licensing requirements.
- Separate device-management prerequisites for any supported application/execution restriction. CrowdStrike telemetry is not a substitute for the required Microsoft endpoint components.

**Enablement steps**

1. Record this capability as **not enabled and outside the current PoC posture**.
2. Document the unavailable local-agent inventory, local MCP discovery and associated runtime/action paths so they are not included in claimed coverage.
3. Refer any future evaluation to the endpoint/security architecture owners as a separate decision. Do not perform device onboarding or activate endpoint enforcement in this PoC.

**Expected outcome**  
Scribblestack has an explicit coverage boundary: the selected cloud-agent capabilities may be considered, but local-agent discovery and endpoint enforcement are not delivered by this activity.

**Change boundary:** No Defender for Endpoint activation, antivirus-mode change, CrowdStrike replacement, Intune restriction, device offboarding or GSA deployment is proposed.

**Microsoft reference:** [Local AI agent discovery prerequisites and licensing](https://learn.microsoft.com/en-us/defender-endpoint/discover-local-ai-agents).

### Defender Planning Decisions for Scribblestack

| Customer input | Enables |
| --- | --- |
| Selected agents, platform/identity mappings and existing security connections | 3.a inventory and an accurate data-source boundary. |
| Security findings, business context and remediation owners | 3.b prioritized posture review. |
| Supported cloud runtime paths, environment owners and approved Audit behavior | 3.c non-blocking runtime-protection design. |
| Prompt-evidence privacy, scope and access approval | 3.d investigation context where acceptable and supported. |
| SOC ownership, hunting access, escalation and response authority | 3.e investigation planning without assumed automated response. |
| Available supported traffic logs/SWG integrations | 3.f feasibility without endpoint replacement or GSA. |
| Confirmation that the current CrowdStrike endpoint posture remains unchanged | 3.g explicit exclusion of unavailable local-agent capabilities. |

### Defender Takeaway

Establish the data sources and supported runtime paths before relying on security findings. Keep inventory, posture, audited behaviors, alerts and response actions distinct. In this example, cloud-agent evaluation remains non-blocking and endpoint-dependent capabilities remain excluded.