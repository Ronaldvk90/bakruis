group "default" {
  targets = ["amd64", "armv7", "arm64"]
}

target "amd64" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64"]
  tags = ["docker.io/ronaldvk90/spotify:latest"]
  push = true
}

target "arm64" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/arm64"]
  tags = ["docker.io/ronaldvk90/spotify:latest"]
  push = true
}

target "armv7" {
  context = "."
  dockerfile = "Dockerfile.armv7.anus"
  platforms = ["linux/arm/v7"]
  tags = ["docker.io/ronaldvk90/spotify:latest"]
  push = true
}
