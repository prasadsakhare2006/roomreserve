package com.roomreserve.booking.mapper;

import com.roomreserve.booking.dto.BookingDto;
import com.roomreserve.booking.entity.Booking;
import org.springframework.stereotype.Component;

@Component
public class BookingMapper {

	public BookingDto toDto(Booking booking) {
		return new BookingDto(booking.getId());
	}

	public Booking toEntity(BookingDto bookingDto) {
		Booking booking = new Booking();
		booking.setId(bookingDto.id());
		return booking;
	}
}
