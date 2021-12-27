0=${(%):-%N}
@echo "=== ${0:t:r} ==="

source ${0:a:h:h}/zman.zsh

result=$(zman)
@test "zman succeeded" $? -eq 0
