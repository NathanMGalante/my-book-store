package nathan.mg.api.user;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nathan.mg.api.shared.Role;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String email;
    private String password;
    @Column(columnDefinition = "LONGTEXT", nullable = true)
    private String photo;
    @Enumerated(EnumType.STRING)
    private Role role = Role.GUEST;

    public User(UserDto user) {
        this.name = user.name();
        this.email = user.email();
        this.password = user.password();
        this.photo = user.photo();
    }
    
    public void setRole(Role role) {
        this.role = role;
    }
}
