package nathan.mg.api.user;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nathan.mg.api.store.Store;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String email;

    private String password;

    @Column(columnDefinition = "LONGTEXT", nullable = true)
    private String photo;

    @ManyToOne
    @JoinColumn(name = "store_id", nullable = false)
    private Store store;

    @Enumerated(EnumType.STRING)
    private Role role = Role.GUEST;

    public User(UserDto user, Store store) {
    	this(user, store, Role.GUEST);
    }

    public User(UserDto user, Store store, Role role) {
        this.name = user.name();
        this.email = user.email();
        this.password = user.password();
        this.photo = user.photo();
        this.store = store;
        this.role = role;
    }
}
