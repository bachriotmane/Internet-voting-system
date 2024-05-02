package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RequestMapping("/programmes")
@RestController
@AllArgsConstructor
public class PrgrammeController {
    private final ProgrammeService programmeService;
    private final VoteMapper voteMapper;

    @GetMapping("/votes/{id}")
    public List<VoteDTO> getVotesProgramme(@PathVariable String id){
        return programmeService.getProgrammeById(id).getVoteList().stream().map(voteMapper::fromEntity).collect(Collectors.toList());

    }
}
