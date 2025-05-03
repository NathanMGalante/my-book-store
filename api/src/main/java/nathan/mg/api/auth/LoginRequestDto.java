package nathan.mg.api.auth;

import jakarta.validation.constraints.NotBlank;

public record LoginRequestDto(@NotBlank String username, @NotBlank String password) {

}
