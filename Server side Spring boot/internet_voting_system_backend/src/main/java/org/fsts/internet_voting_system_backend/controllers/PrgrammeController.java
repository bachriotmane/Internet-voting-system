package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.ProgrammeDTO;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.mappers.ProgrammeMapper;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.repositories.ProgrammeRepository;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.springframework.format.annotation.DateTimeFormat;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.lang.model.element.NestingKind;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;
import java.util.List;

@RequestMapping("/programmes")
@RestController
@AllArgsConstructor
public class PrgrammeController {
    private final ProgrammeService programmeService;
    private  final ProgrammeRepository programmeRepository;
    private final VoteMapper voteMapper;
    private final RoomService roomService;
    private final ProgrammeMapper programmeMapper;

    @GetMapping("/votes/{id}")
    public List<VoteDTO> getVotesProgramme(@PathVariable String id){
        return programmeService.getProgrammeById(id).getVoteList().stream().map(voteMapper::fromEntity).collect(Collectors.toList());
    }

//<<<<<<< HEAD
        @GetMapping("/{roomId}")
        public ResponseEntity<?> getProgrammesByRoom(@PathVariable("roomId") String roomId)
        {
            Optional<List<Programme>> programmes = roomService.getProgrammesByRoom(roomId);
//=======
//    @GetMapping("/{roomId}")
//    public ResponseEntity<?> getProgrammesByRoom(@PathVariable("roomId") String roomId)
//    {
//        Optional<List<Programme>> programmes = roomService.getProgrammesByRoom(roomId);
//>>>>>>> 835fc5c290981c7854e0f0d492479b5efb35d210

            if(programmes.isPresent() && !programmes.get().isEmpty() )
            {
                List<ProgrammeDTO> programmeDTOS = programmes.get().stream().map(programmeMapper::fromEntity).toList();
                return new ResponseEntity<>(programmeDTOS, HttpStatus.OK);
            }
            else{
                return new ResponseEntity<>("there no programme in this room *_*",HttpStatus.NOT_FOUND);
            }
    }

    @GetMapping("/byDateAndRoom/{roomId}")
    public List<ProgrammeDTO> getProgrammeByDateAndRoom(
            @PathVariable String roomId,
            @RequestParam("date")
            @DateTimeFormat(pattern = "yyyy-MM-dd")
            LocalDate date
    )
    {
        Room room = roomService.getRoomById(roomId);
        List<Programme> programmes = programmeService.findProgrammeByDateAndRoom(date, room);
        List<ProgrammeDTO> programmeDTOs = new ArrayList<>();
        if (programmes != null) {
            programmeDTOs = programmes.stream().map(programmeMapper::fromEntity).toList();
        }
        return programmeDTOs;
    }

    @GetMapping("/byKeywordAndRoom/{roomId}")
    public ResponseEntity<?> getProgrammeByKeywordAndRoom(
            @PathVariable String roomId,
            @RequestParam("Keyword") String Keyword
    )
    {
        Room room = roomService.getRoomById(roomId);
        List<Programme> programmes = programmeRepository.findByProgrammeTitleContainingIgnoreCaseAndProgrammeRoom(Keyword,room);
        if(programmes!=null)
        {
            List<ProgrammeDTO> programmeDTOS = programmes.stream().map(programmeMapper::fromEntity).toList();
            return new ResponseEntity<>(programmeDTOS, HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("there no programme in this room with this specific keyword ",HttpStatus.NOT_FOUND);
        }
    }
}
