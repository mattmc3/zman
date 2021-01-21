0=${(%):-%N}
@echo "=== ${0:t:r} ==="

source ${0:a:h:h}/zdocs.zsh

result=$(zdocs)
@test "zdocs succeeded" $? -eq 0
