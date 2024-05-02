package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.springframework.security.access.prepost.PreAuthorize;
import jakarta.servlet.http.HttpServlet;
import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.repositories.RoomRepository;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.List;
import java.util.Optional;

@RequestMapping("/programmes")
@RestController
@AllArgsConstructor
public class PrgrammeController {
    private final ProgrammeService programmeService;
    private final VoteMapper voteMapper;
    private final RoomService roomService;
    @GetMapping("/votes/{id}")
    public List<VoteDTO> getVotesProgramme(@PathVariable String id){
        return programmeService.getProgrammeById(id).getVoteList().stream().map(voteMapper::fromEntity).collect(Collectors.toList());
    }

    @GetMapping("/{roomId}")
    public ResponseEntity<?> getProgrammesByRoom(@PathVariable("roomId") String roomId)
    {
        Optional<List<Programme>> programmes = roomService.getProgrammesByRoom(roomId);

        if(programmes.isPresent())
        {
            return new ResponseEntity<>(programmes.get(), HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("there no programme in this room *_*",HttpStatus.NOT_FOUND);
        }
    }
}
