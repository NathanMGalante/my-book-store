package nathan.mg.api.store;

import jakarta.persistence.*;
import lombok.*;
import nathan.mg.api.user.User;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
public class Store {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String slogan;
    @Column(columnDefinition = "LONGTEXT", nullable = true)
    private String banner;
    
    @ManyToOne
    @JoinColumn(name = "admin_id", nullable = false)
    private User admin;

    public Store(StoreDto store) {
        this.name = store.name();
        this.slogan = store.slogan();
        this.banner = store.banner();
        this.admin = new User(store.admin());
    }
    
    public void setAdmin(User admin) {
        this.admin = admin;
    }
}
