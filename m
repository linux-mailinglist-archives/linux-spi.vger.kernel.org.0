Return-Path: <linux-spi+bounces-5961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291379E8681
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87510163CD1
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAE17277F;
	Sun,  8 Dec 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cPog8pRH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5516F265
	for <linux-spi@vger.kernel.org>; Sun,  8 Dec 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675621; cv=none; b=ojVPbf67THhoypH2Um1p6//bohAxf4Avkt9qE761J+sBAvDug20ePbJfOanm54PgbWWzqH64Jeea91QFjM3Rp5N+A6cg7R2GnQnJaSjDM5GtR4R1s43kJnivkZyJ4QsEuBrOB2hn6HJK2y3qkHMxg0kmoCWxLhwRoazVGvlF96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675621; c=relaxed/simple;
	bh=/35qo1NSaXfj274xmXlQdRGosPADR6c0eJgSNOG7OjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgeu+Qc+1MVo70EL4WQm3zFHbxZPRGXQKpgHKbq0dmvgvGG+wNhBv4iqxTWHB0iWZurN3+ygZaxz4jaojHFHUT7gQfWL2DvyatmEUP5nNEMFlfkGUnoMus1c8SOxXr4qULPYoHdoA3Wj1D1xNxe0ntL0YfWfcGKmz9WY5WDMPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cPog8pRH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa66ead88b3so142369566b.0
        for <linux-spi@vger.kernel.org>; Sun, 08 Dec 2024 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675617; x=1734280417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAZgKK7Ob7dVD/6GRHg29F0t0wRjMiOSNr01J0LKftk=;
        b=cPog8pRHKdk/okPkIRve2/Z9TqHy/oP114O8aBGG/kgUGYAE8asM9POL/3cEmVGaF0
         4vlINOjfpBaA1uuQPyfq9va3Yrx659D+R6aQvXT91LkfdtCU1c3kN3+VkCAyT4YAAq1n
         BITjI4hTOx+pLsPZaeGg5Szkc/ZuOwLnb5ZuKeP6fOZ0KheqI4w2EV6hJnOy6TXkdaz9
         sfPrh7ENqzhadDvR2i5Behk+dh6H0IEBqviSUMtSh0+RRjtJdhiP6JO1XDaFy1AhzA/S
         2KGvNsXXtzcyW8mjNiynTjWK7hlIxNdwMsQLHagGVTPDzocYYhVmVBHwuW60FaKncFr9
         NASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675617; x=1734280417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAZgKK7Ob7dVD/6GRHg29F0t0wRjMiOSNr01J0LKftk=;
        b=OPyzqwGiGMCNT+3FMRRZbcNDKldiWS6DqPrSeKyVkK2k6AlpXcvIUWkh+YCqR6CRKG
         3lgNSUeqQR4sxiUogvLQ4G30yoB6aXhuAzpreCRPrsnZWyKYf/dq3cQoC9Ll6M3UVJXQ
         Hfg4aKnjfo6H303suXWTUudvQmTazmBt+h0tvY0HbfQ/ob6e2k8Mm/821+rfAT9T/iKc
         GM96xkI+nKGpRt44yGepToMyAi4PmRKcLNDASuSKpxbuyATQsagtQJPNdkMFURxhJdFL
         qBpQdMSTdULqXAUg0l89ypOXtubtv38jflqc72aC4U+36Za93FKl3zho+VGZkl2ka2ln
         o7sg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6TpPkQEyY4TN58B/zhTUM2h12ugVy65e8uIh0DmS9A347nDj6g/nYkK1XjT0IrgmlD2xX/3Jdis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qBSdg8aNJ2rHr4GBqG+AG8KgGBfK0ICNii1ZvAyEtrb44Pyx
	kfpKihB1dADfv1eSSnhnczqPfmkG6YC14zRnchDpHo43p4WZmtzVkGA1NVoC0Zc=
X-Gm-Gg: ASbGnctowd/AMLpuMYgDwSqyIEXOA0TbWKjgI3tA3f287rnD7n83i7k5DMYKpW5sOW9
	6STLjI1f9bXSAHECmyrwnKIGpeOTG4yieCxv9HPOLd/Th4mbkmqN6vfdQdxwD5DZCI2zz3eM2SJ
	B8PyJLUoRxs3SuilWDOBRH0QgUq5zfJk8wfhqORGxS4n4m/+vLgaW5NuQaXS9w0rKiH0Ewbt6tm
	cPzK0g5fYHBIz6slnwt1R3wSqADoC2iZkogEfkjp0DTTd2XBdUgx6zl2qY=
X-Google-Smtp-Source: AGHT+IEG5BzdBKSU5T5ma5GlgSE9+K05duEqvgjt64DfRU1QPy3ISe7GWbOxCcAy7BgfRsflElX9gA==
X-Received: by 2002:a17:906:32d0:b0:aa6:7027:7b01 with SMTP id a640c23a62f3a-aa670277bf0mr300268066b.20.1733675616848;
        Sun, 08 Dec 2024 08:33:36 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67a4f8dc2sm113804466b.179.2024.12.08.08.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:33:36 -0800 (PST)
Message-ID: <6ea8fa5a-78e4-46d3-8e20-c2a723bb7e86@tuxon.dev>
Date: Sun, 8 Dec 2024 18:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ARM: configs: at91: sama7: add new SoC config
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
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add sama7d65 to the sama7_defconfig.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

