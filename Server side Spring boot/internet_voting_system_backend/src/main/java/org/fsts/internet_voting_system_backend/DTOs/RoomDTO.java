package org.fsts.internet_voting_system_backend.DTOs;

import lombok.Builder;

import java.util.Date;
import java.util.List;

@Builder
public record RoomDTO(

        String roomId,
                 String title,
                 String roomDescription,
                 Date createAt,
                 Date startAt,
                 Date expireAt,
                 String code,
                 List<String> roomMembersId,
                 String roomCreatorId,
                 List<String> programmeListId
) {
}
