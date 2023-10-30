let ArtifactPipelines = ../../Command/MinaArtifact.dhall
let Pipeline = ../../Pipeline/Dsl.dhall
let PipelineMode = ../../Pipeline/Mode.dhall
let DebianVersions = ../../Constants/DebianVersions.dhall
let Profiles = ../../Constants/Profiles.dhall

in

Pipeline.build 
    (ArtifactPipelines.pipeline 
        DebianVersions.DebVersion.Bullseye
        Profiles.Type.Standard 
        PipelineMode.Type.PullRequest
        ["DUNE_INSTRUMENT_WITH=bisect_ppx"]
        False
    )