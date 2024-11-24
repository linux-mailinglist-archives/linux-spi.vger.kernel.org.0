Return-Path: <linux-spi+bounces-5809-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5F9D702B
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43742162DE3
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DD188907;
	Sun, 24 Nov 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HOCOk5UP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A5191499
	for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453568; cv=none; b=HOQJqs1bgVJS5HlPQxNVOqiJQPFrkxGZ8+dcjfcp4xJAa0+o6XUAVFFZUo9eHIpuudtCYJOblo4tA7T3B6cK9ck0EHbjo60cYttr9ZSE9nTZXlo1OofXfQRZtjxzTFHvB7Q8Bm6lJ9gsg4D1Rwp6+XyiieeBO12SQeCitrNQcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453568; c=relaxed/simple;
	bh=579OTAxxCTsdzuh+nLXM4qxYrJpkNNqj06Nk7dWiucg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agPEnEYav/TzeMPiTpeg6/bpttab+9UrNBf1jZAbqJ0709ZWvudhoTBLZVnC4E8q5eRbX1Yt2O09wtRbNe4X9vt7rZONLcuGR9A2HFOPaxgO1UTxQjFcz19IXU7lg6TM1uK3MNuWmy7BUkxyLp75j5aHY/YpPvea4bC/C2nnnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HOCOk5UP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349f160d62so847315e9.2
        for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732453565; x=1733058365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDgXaUWWMXn90x1MGvmiPRPBz637uFXJlZfJg+bhsYo=;
        b=HOCOk5UPZKkjXEZ3v14KiQMmAAGJcntS3/JT4Fq3QD4zOnvudYybDR2ooMkWesSgIa
         bNKg7jpn9eNP9/J2CXlRT891DqkzTATJFL10cELoo5QaF0hKpyIzcQOLyc+gtY5zqTs6
         yTCGtSoOIfg/HyXUqJ8jRKCdR9UiYRkQkJnzkHiiEhyy9G/GfPNhfOTgT8FGqmuEUuaR
         US2ve565Xs9ri1J03HdcvO+Oh+gDGDhyM4DcMGAiiEA0RXIxYM8waaLpKoZlghLltFgr
         o8j6dxvw4MHCuOOtO+bMuoFpoSz1GI0mYZ+btL4CWDOMZrHDK6jN4Jf2ekfOeTWV8pX+
         5PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732453565; x=1733058365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDgXaUWWMXn90x1MGvmiPRPBz637uFXJlZfJg+bhsYo=;
        b=GvstdEi/E8pVg8WoZStXgrlcZ1wXf1tj7S+O02rDcz0iwJCyK2lhPZq3xBoAt17bNV
         /6f1T+lUJGGiWkID125xv1oKdAxDf+yjTKtWMJHKbeurGn4wYbKouexFAdEhYviFKtXh
         Y0Z7IVJoRCzQdnVdmxCeElQfLhrZgYK4XB2gjCW4z5tSLP5RwcpVTbBqdkFB3ZfdkAHy
         /4p070Ryxit/I5RfQkzmM33yUFUDdt7vNoS3vnCWMFGN/0MCT10w7EWAfdHQ/aM/CDcK
         roA41t4JhNsptUfkZw7Cv5WX1H1wfvdS9chIjDu7WQf+J2TR2JA/9B25hT9/GEKBsJxP
         fZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUDhLKYwK5I7ZBiUwmqdoI6mqCYEuCsQFLbiaH6UVsnqmcOzY9aHVowEcAuHHkAikcdRwWuANFTsZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nT9v6dYt8XrsJTDOwNwogYEKvB8FUKUEvzfF8ItmJFVMqJev
	YdVfw6kC0geklGUtgPk6c7R8GMLUV/nPvEc3GzU9bTU8T4OB6E/xCQxwx4TziIc=
X-Gm-Gg: ASbGnctNBeeJ/hEOdyCSbtyxA9qMExeRrZcJMm2AJWEgKPt3kDknJ/acjiBq246DV9N
	Cp/bnxXfJiHxyZLlcXeA+d5UeZCF/Tc4dQI12q9MoEybUlHpWAfdEVZbqUCaah1886DG2zEyIN9
	Tu0v4JJHSAJvo8IgVW+8coyN+ILNCUlCYUkoCU/pYd/3I9oPU2lT4ibeH7qzZEI8sEq3KOk/qK0
	nQdlLKiQ8eXdqL6B5CIsyqDirk2zSh8yVUZfQfjADeUGQCsB1mpo6ePmw==
X-Google-Smtp-Source: AGHT+IE/ekA4n5NRsUPfRrSQ4WEQs+2aEfMt8e8Vr2hUc52ItH2CCdtUMuUey9X354G87nt1GQ6+6g==
X-Received: by 2002:a5d:64cc:0:b0:382:4503:728a with SMTP id ffacd0b85a97d-38260be41c0mr7533295f8f.53.1732453564522;
        Sun, 24 Nov 2024 05:06:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5f59sm7682760f8f.10.2024.11.24.05.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 05:06:03 -0800 (PST)
Message-ID: <55685905-7a28-4796-b386-1212bc1abed1@tuxon.dev>
Date: Sun, 24 Nov 2024 15:06:00 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] ARM: configs: at91: sama7: add new SoC config
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <4c7750b6f29b4ac0e2858ac279af7548e19934bc.1732030972.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <4c7750b6f29b4ac0e2858ac279af7548e19934bc.1732030972.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 19.11.2024 18:40, Ryan.Wanner@microchip.com wrote:
> +config SOC_SAMA7D65
> +	bool "SAMA7D65 family"
> +	depends on ARCH_MULTI_V7
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL

These starting here:

> +	select HAVE_AT91_USB_CLK
> +	select HAVE_AT91_UTMI
> +	select PM_OPP

ending here are not needed for this phase, AFAICT.

> +	select SOC_SAMA7
> +	help
> +	 Select this if you are using one of Microchip's SAMA7D65 family SoC.
> +

The Kconfig changes should be a separate patch.

