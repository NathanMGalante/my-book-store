package nathan.mg.api.store;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import nathan.mg.api.user.UserDto;

public record StoreDto(
		@NotBlank
		String name,
		@NotBlank
		String slogan,
		String banner,
		@NotNull
		@Valid
		UserDto admin
) {}
