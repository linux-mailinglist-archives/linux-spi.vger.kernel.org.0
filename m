Return-Path: <linux-spi+bounces-12285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E0D0F2C8
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415EE3042826
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14D349AFE;
	Sun, 11 Jan 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ookWjjOm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD634887C
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142689; cv=none; b=awd4b92dEReKD5OGFaJZ63WvGKaMZHUXDntchljjfaPcCRrnc6fJQCoAyHnkwqKZmF8IOOAJ12WtGQUTjA34YGkKpEM1qot7XfErNAGsuxVzaUnhih05nCzsfKJWjcf635Aj7J7ARD8NrXhY2xzXiG02a1vt41c4Gd6CyX0VUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142689; c=relaxed/simple;
	bh=6nDyEm7V4aXX61sF6eUN6LhYpH2LhvalQYGjX/umKoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8HmbMRggV0IxuzWpjjOZTL86bdkZG+qW2ol8UnZfIYU7lFCuCmkl/zosBeJDZqEP2c+H2cqA1MC9vriSElR3LuVVqeh+olNQVgUu5+agzH6u351t68vBdJ7QuggssjFAL6wGx4WXT4FLOvtnNG2LY5VTJ8lN+KXsIGARwnjAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ookWjjOm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so8209942a12.0
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142685; x=1768747485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5bvCXfrw0wJAyvC451z7sPKX85y6guKkf78mDKwHw0=;
        b=ookWjjOmWIYoGV8NQWvwlqznn4j8X/9cIu1N+sDUGIRZyYgwPku/XDBbuWd6K70V+Z
         P7HY/w/F6flzBr5IXDYHVEB3ltopxlY2WHQAhLaOCeZR/Hrc1OWjU/V0asR/RmmmcEc3
         tbjCh+t/BspEkplUHtFz+y05jDP3wSvjg3CpDLl8Q1Bh5+kq3Y2fFlpvC/a4tjSPRZgV
         /s9DK4NFB7cEl6zQXNMcpwOkQ/LYani5uYAJvLM+ZJjDPhc1ZKQqnqz5mjqsBNhxaSmo
         d4j1Vc6VbI8lJrz1ATl82rXlA+iKCYIQCQ//J+lmO8a7bTRC9QTjtYFdAUSJ22DHDbQg
         LgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142685; x=1768747485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5bvCXfrw0wJAyvC451z7sPKX85y6guKkf78mDKwHw0=;
        b=SIUc5XhnZgK7mKILe4Vo7F2yRlMOH7xnKikZynERUdhXh/UC0ylbT6iys3qVeoyOjr
         cGBMRYyUz05a5kNa6UKyjqFkT9N0wGNJilSFUU01MDO8kWGglQoKm8RbVx2FoX0BVsRH
         i0qRJd0rP93ufat7pk5et5hXFP4iufVlEx3coMGOMFudgklDbUYcAxbhvzBTbe3SxCRS
         dFyHzsRWG8D4+hnIxyfGcANp2M3H1CDIOW6uZ76BWF5AQbQ5tUMVWYWCxyaLeu7oK6wa
         ZW4SSsgzn1JyoWV3L4634ndD4SfAtnsHsgqWleldxNFWHOKavAqyBzvyPMTh/wd8mAZ1
         RjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9+CVBBvd4dfCDV+jSFy/CqZYbYRDDT4RFtpzLL9NXnxI/HAwSzBXek85gKb+rIQpIExzbKfaffLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaf4/g4lXSRexKUvCJ96It243gOR/g4sHWTXLPWNpRqx5h/9ie
	YGh3cHJyAtiOTXjSVipC44EqRnoY5EK7FzdGYUk6oYAcfQ7ev/kzv5p0gpjiUlagU3Y=
X-Gm-Gg: AY/fxX4RcdWrbk6H9TjToi0LmD6GJuDnogDdU3CX2lHZhGN1aaoczglHzDyeort37QE
	1KKB0aJgFNOnY+Gsdh2zoHf9FCjpxiD3g8C7f7qy2li5XHT/TvasrsfhZ1FNlNkm8j1Io1pNBpQ
	O7ZVN0s61RclHDUDF7oTdBqgEieOZR31CsYtdaoHlXGh/ucjALzEl3jDAu2aJHlQvWausL0s9ms
	gqJpFeldZ8eKojDpa+F9TUvBz+yh0pSMpabXXkHL3bZ+4LCqF0SZ3i1pmKeLRxcbvZb2FOha9/r
	lSQJTWQAxWSIiIukBmDIoJaWdWqCvd0ldH/hJuafl2McfNhAx/28ekXzFafZb+2sg38ObPN84CP
	PCJDUVn0ncuzIbwMPoghnTLuA98R9OW+p/zj2NQX8ohhs8qQTDTqOZ+jx/KlrabhjwjZFBxKCid
	ogeieUpTUjNLwE+fWjKncGdIs=
X-Google-Smtp-Source: AGHT+IHGUu5OYQ17yt0Sks10puH6ECXvHmROUNTsHAGUEt843jNznhl0Fa7GBLD0pgo1znXFARhYGw==
X-Received: by 2002:a05:6402:146d:b0:64b:4540:6edb with SMTP id 4fb4d7f45d1cf-65097e4ce77mr13908239a12.22.1768142685334;
        Sun, 11 Jan 2026 06:44:45 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d44bfsm15272072a12.8.2026.01.11.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:44:44 -0800 (PST)
Message-ID: <ff941a66-cc09-4f57-a511-d253f48d7137@tuxon.dev>
Date: Sun, 11 Jan 2026 16:44:39 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add
 microchip,lan9691-aes
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-8-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x AES compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

