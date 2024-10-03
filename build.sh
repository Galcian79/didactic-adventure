###   Ryujinx - Nintendo Switch Emulator - Building Script

# Project - https://github.com/ryujinx-mirror/ryujinx


# Makedepends for Archlinux (other distros may vary):  'desktop-file-utils' 'dotnet-sdk-bin' 'jq'


  export DOTNET_CLI_TELEMETRY_OPTOUT=1

  dotnet clean
  dotnet nuget locals all -c

  _args=(
    -c Release
    -r linux-x64
    --nologo
    --self-contained true
    -p:DebugType=none
    -p:ExtraDefineConstants=DISABLE_UPDATER
    -p:Version=1.1-master
  )

  echo "Building AVA Interface..."
  dotnet publish "${_args[@]}" -o publish_ava src/Ryujinx

  echo "Building GTK3 Interface..."
  dotnet publish "${_args[@]}" -o publish_gtk src/Ryujinx.Gtk3

  echo "Building SDL2 Headless..."
  dotnet publish "${_args[@]}" -o publish_sdl src/Ryujinx.Headless.SDL2

  echo "Shutting down dotnet build server in background."
  (timeout -k 45 30 dotnet build-server shutdown) > /dev/null 2>&1 &



### extra credits to Galcian79 - https://github.com/Galcian79/didactic-adventure
