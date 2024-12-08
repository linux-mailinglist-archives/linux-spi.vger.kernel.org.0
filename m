Return-Path: <linux-spi+bounces-5954-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CDE9E864F
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BE81883FDD
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069015B546;
	Sun,  8 Dec 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JPtfCPYD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521B15990C
	for <linux-spi@vger.kernel.org>; Sun,  8 Dec 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675121; cv=none; b=Av2cu+K17GSRaGSX4BJe/oTyLKxzkfUhFgRbwdWoUpTkwhjhT6g/sRyjNglWt96xrPlLtH808fcKj0uyg8u8lwZHQ7yHpcphqLh6C8N4Ci4z8DFlVfM1w6i/GEu/aZBd7/OuFtXO1EYRwG7QfIBuUYn23OYwoAVEYSP5tXv9pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675121; c=relaxed/simple;
	bh=XCzsuhWtTBgtikcHpQDU1X72W4M21kQHkNT9eU1FAm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0VIxUl8F45dAZI1i0ggbbDhQAWwMHRB3/rpLPe8zX8E7Ih7o5XDOhjfrOXyF+r7VUQtewAj81wW5GdxYv6CECQFARtLn6HDejVN8gPpD3ROllzBFzc1AZ3UDjKLuAgv8TKBYA+5/JcIQl/FgrZpkkMt3J2HMnGTOj7EcitlVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JPtfCPYD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so5195473a12.0
        for <linux-spi@vger.kernel.org>; Sun, 08 Dec 2024 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675118; x=1734279918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CL3RW1M+1jqdpfrkKxaJcNdqzAjdBj4zOd/4LxQYQ28=;
        b=JPtfCPYDuQDj06h8h+BLrPJzg/AXfRYTSlqafQby1FIHDPVYsp3WwvWVeqpJgyOtLV
         9lDr2Hc+9G6pcoQZFz4Ip8sk6giEqX1uWgDYzqUV+dnAVnKUkEgnaQG/8qWOMno4jBQK
         gpdoFjrJnXRpLdZmz8pNdEVWZl2FBju7+YEULByZJ+VuEL69iosjeokNCHr/fl9JcS3B
         BJmFqJhblfn4GJvsQZlzR8AuUVnArMm00PdjQQbpLekOZ18xxr4fCSjVP11SUBdHceec
         GAwzYCe3mnmtfdVNjBdRTxUWFNCQjsWGhegiCtRVkzdKAEVOMN04nEHKFeYTlzX6NvN/
         mcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675118; x=1734279918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL3RW1M+1jqdpfrkKxaJcNdqzAjdBj4zOd/4LxQYQ28=;
        b=o8DjnXJTFD8iIe4ppoi8zeDEegrKZ0rKEcTI3bKwI1yLPiR9D3zhKPPWPvI7XYcx/q
         ZiwmPXER5pAoVdaO89KNWEPBdmAdQuxNbU48XDsTaj28MGNqeJW7C7PM39d+xirKnZMG
         qyY5gQMerF/rGnUJVTmfjgj2GaTTrACQc/uvm8mzD2RyDIDuQdgletGIF4DxNjI7Aih3
         YmHe8bz3oWoEeZ0wUdUwD8sb3kDAR/zZJ23y/Ko6mg4KUiLmhjjMmaa8qOiWHlIhGtqS
         aHJUk9h2uSZxW3vQanUhwRjiEdd2HqEZtA131tRv6UnOJQ7J/zzS9xTv82NtIJQw5pWs
         39OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0t06MkCQSLZD+cPktCKlDHzoNBYCiw2mgTNtS74Nz0ZsiLXfxCv0O/pb8+IsgSxxCS64wFF9A8Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqc4suZULllgTZezpGQnrgHHzaCSmuQbpl6M9U9u8yFMTenYd6
	8VZ5+L1Gr7lJMO/4mVRGj2ZMtE9k3Lg5IZpofeB8E12k3eGax3DpsC4rmkyIrxQ=
X-Gm-Gg: ASbGncuPQ1eHavbPFPhg5FckDWDZFW85zrX4pGgljGJVs9kWZJzfChJeJu6/kOAFEOv
	iWJqlUi9Q3Z/EYfDoT/xK8qsNIxR+WDjYsuNtwu1JeRAoeslr2Qpw37tp2o7RaUFynpLiWv/B3U
	IRdfD4Z84QLCORqyJN7aCVWwWhRAF+IV3e9zeuPTTwRLr88chMWQyO5EfE5OJfWuyvs3Oaz/Lzr
	c9AbjlSwI//5sR6TmkAe8LEpoTdr8pSX+XOiOBWlAM9W3w7TKpowMh7Ypg=
X-Google-Smtp-Source: AGHT+IGJWEQkcn9gVXm4gaCzJ3nLfFkBCixjRRK2yzf+GnrblXYRmSu5ZvLGFdA9zVJtqFoG2CIf5A==
X-Received: by 2002:a05:6402:43c9:b0:5d0:cfad:f6c with SMTP id 4fb4d7f45d1cf-5d3be75abbemr10808689a12.21.1733675117744;
        Sun, 08 Dec 2024 08:25:17 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49e48sm4883698a12.30.2024.12.08.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:25:16 -0800 (PST)
Message-ID: <91b98edc-4313-45a8-9bfc-7df83b3d5640@tuxon.dev>
Date: Sun, 8 Dec 2024 18:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] dt-bindings: clocks: atmel,at91sam9x5-sckc: add
 sama7d65
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <b7a8a22a571f6fc2be56a25f26757f37fa8d2bb3.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b7a8a22a571f6fc2be56a25f26757f37fa8d2bb3.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add bindings for SAMA7D65's slow clock controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

