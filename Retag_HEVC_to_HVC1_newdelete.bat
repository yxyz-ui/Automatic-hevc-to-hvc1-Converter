@echo off
setlocal enabledelayedexpansion

for %%F in (*.mp4) do (
  rem get the base name (no extension)
  set "name=%%~nF"

  rem if the last 5 chars are "_hvc1", skip
  if /i "!name:~-5!"=="_hvc1" (
    echo Skipping already tagged: "%%F"
  ) else (
    set "out=%%~dpF%%~nF_hvc1%%~xF"

    rem only run ffmpeg if the output doesn't exist
    if not exist "!out!" (
      echo Retagging "%%F" → "!out!"
      ffmpeg -n -i "%%F" -c copy -tag:v hvc1 "!out!"

      rem if ffmpeg succeeded, delete the original
      if errorlevel 1 (
        echo Conversion failed, keeping original: "%%F"
      ) else (
        echo Conversion succeeded, deleting original: "%%F"
        del "%%F"
      )

    ) else (
      echo Output exists, skipping: "!out!"
    )
  )
)

endlocal
