package nathan.mg.api.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import nathan.mg.api.store.Store;
import nathan.mg.api.store.StoreRepository;
import nathan.mg.api.user.Role;
import nathan.mg.api.user.User;
import nathan.mg.api.user.UserDto;
import nathan.mg.api.user.UserRepository;

@RestController
@RequestMapping("store")
public class AuthController {
	
	@Autowired
	private StoreRepository storeRepository;
	
	@Autowired
    private UserRepository userRepository; 
	
	@PostMapping
	@Transactional
	public void register(@RequestBody @Valid UserDto user) {
        Store store = new Store(user.store());
        
        User admin = new User(user);
        admin.setStore(store);
        admin.setRole(Role.ADMIN);
        
        storeRepository.save(store);
        userRepository.save(admin);
	}
	
}
