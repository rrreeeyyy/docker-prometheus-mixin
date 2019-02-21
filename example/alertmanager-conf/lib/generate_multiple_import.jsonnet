local generate_multiple_import(files) = std.join(' +\n', [std.format("(import '%s')", file) for file in std.split(files, ' ')]);

generate_multiple_import(std.extVar('importFiles'))
