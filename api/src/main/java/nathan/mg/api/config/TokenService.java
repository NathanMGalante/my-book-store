package nathan.mg.api.config;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;

import nathan.mg.api.user.User;

@Service
public class TokenService {
	
	@Value("${api.security.token.secret}")
	private String secret;
	
	public String generateToken(User user) {
		try {
		    Algorithm algorithm = Algorithm.HMAC256(secret);
		    return JWT.create().withIssuer("auth0")
		    		.withSubject(user.getUsername())
		    		.withClaim("authorities", user.getAuthoritiesAsStringList())
		    		.withExpiresAt(expirationDate())
		    		.sign(algorithm);
		} catch (JWTCreationException exception){
		    throw new RuntimeException("Erro ao gerar token jwt", exception);
		}
	}

	private Instant expirationDate() {
		return LocalDateTime.now().plusMinutes(15).toInstant(ZoneOffset.of("-03:00"));
	}
	
}
