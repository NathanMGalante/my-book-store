package nathan.mg.api.store;

import jakarta.validation.constraints.NotBlank;

public record StoreDto(
		@NotBlank
		String name,
		@NotBlank
		String slogan,
		String banner
) {
}
