if [[ "$OSTYPE" == darwin* ]]; then
  delete-old-ios-simulator-runtimes() {
    local runtime_output runtime_row identifier runtime_label
    local -a runtime_rows

    runtime_output="$(
      command xcrun simctl runtime list --json | /usr/bin/osascript -l JavaScript -e '
        ObjC.import("Foundation");

        const input = $.NSString.alloc.initWithDataEncoding(
          $.NSFileHandle.fileHandleWithStandardInput.readDataToEndOfFile,
          $.NSUTF8StringEncoding
        ).js;

        const compareVersions = (left, right) => {
          const leftParts = String(left).split(".");
          const rightParts = String(right).split(".");
          const length = Math.max(leftParts.length, rightParts.length);

          for (let index = 0; index < length; index += 1) {
            const leftPart = Number.parseInt(leftParts[index] || "0", 10);
            const rightPart = Number.parseInt(rightParts[index] || "0", 10);

            if (leftPart > rightPart) return 1;
            if (leftPart < rightPart) return -1;
          }

          return 0;
        };

        const runtimeRows = Object.values(JSON.parse(input))
          .filter(runtime => runtime.platformIdentifier === "com.apple.platform.iphonesimulator")
          .sort((left, right) => compareVersions(right.version, left.version))
          .map(runtime => {
            const label = `iOS ${runtime.version} (${runtime.build})`;
            return `${runtime.identifier}\t${label}`;
          });

        runtimeRows.join("\n");
      '
    )" || return $?

    [[ -n "$runtime_output" ]] || { echo "No iOS simulator runtimes found"; return 0; }
    runtime_rows=("${(@f)runtime_output}")

    runtime_label="${runtime_rows[1]#*$'\t'}"
    echo "✅ $runtime_label (keep)"

    if (( ${#runtime_rows} == 1 )); then
      echo "Nothing to delete (only one iOS simulator runtime found)"
      return 0
    fi

    for runtime_row in "${runtime_rows[@]:1}"; do
      runtime_label="${runtime_row#*$'\t'}"
      echo "❌ $runtime_label (delete)"
    done

    for runtime_row in "${runtime_rows[@]:1}"; do
      identifier="${runtime_row%%$'\t'*}"
      command xcrun simctl runtime delete "$identifier" || return $?
    done
  }
fi
