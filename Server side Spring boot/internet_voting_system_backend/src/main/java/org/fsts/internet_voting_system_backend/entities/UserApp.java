package org.fsts.internet_voting_system_backend.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@ToString
@Entity
public class UserApp implements UserDetails {
    @Id
    private String userId;
    private String username;
    private String email;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    private String nom;
    private String prenom;
    private String phoneNumber;
    private String CIN;
    private int age;
    private boolean isEnabled;
    @ManyToMany(mappedBy = "roomMembers")
    private List<Room> joiningRooms;

    @OneToMany(mappedBy = "roomCreator")
    private List<Room> createdRooms;

    @ManyToMany(fetch = FetchType.EAGER)
    private List<RoleApp> roles = new ArrayList<>();


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();

        for (RoleApp role : roles) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getRole().toString()));
        }
        return Collections.unmodifiableList(authorities);
    }


    @Override
    public boolean isAccountNonExpired() {
        return isEnabled;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isEnabled;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isEnabled;
    }

    @Override
    public boolean isEnabled() {
        return isEnabled;
    }


}
