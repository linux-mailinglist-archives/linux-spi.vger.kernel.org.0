Return-Path: <linux-spi+bounces-12427-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9DD2D202
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 08:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E59A330AD34B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 07:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D730EF69;
	Fri, 16 Jan 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DOz03dJJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551B2F12BF
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548145; cv=none; b=CmyGqxBbZ6a64z6+ug5SNEVr0xLr2PzSyLdYoo+CusTqTO8WoznMScN3gqrMbriDpgfz+NtIvyByNW+rcbP54C9aFSrf/sywJ16A8rtlojfXnRNrOJOQk1upFiQyr9HLzSyGy1s9pCzFARZAv0Pi2vooF7ffFbwPfFA9rzfwE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548145; c=relaxed/simple;
	bh=ZoZCxIZIxuNG7iiq7ouEpN8AOaGaswIYZVOM5BEKY0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGQ5b8rp9pYLxxiEE1+dYjIlbIk3qB1Gp+qt/0gQxomob2RCNxENep8WgwxuJgOCXW0duhbAIhpW00HRL+dpfaHBix3GpshseLVj0KVx38XZnr/Wl03PC6PYlRmL0z3NLxoYwQsvMG4cXOETj7H9VkWrbhLS+REAYYW769zcCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DOz03dJJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305882so832274f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 23:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768548141; x=1769152941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W95GN1V+oZI3tCyhJrWoqvfYp2X9bfUg8CvoDb5FSAs=;
        b=DOz03dJJJrHhANTzRWfRIwG4CLx0lVlmsIjqaVXIAMhwfUkQMzxluDIvnt6G5tZvZr
         4c0dlJQT35H7vKeQ2kACS7kFyjHOCBRMDhEqHMGjvAHO3J/KXmEMGQKVzcuA8Tkh5u4v
         iSdLnjY0HoFbhIx7+jU9y4jcsGD5y9+L4A9Rbbfwe9Oajkr9Uy/QAO6wftMa4FTKMWiv
         Xr2onvXDgcKQNOVRRMi3T/uSAL+HyazSQJuk5cqWgDP+C85At8mPoVxlZUnJY2INJNn6
         NZOLFZwP31nUoRTSEM/hLvbT2rEi9re57qBnGAEmHczkC9DApHPsTcrZS0p+KjQiDy4r
         ffNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548141; x=1769152941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W95GN1V+oZI3tCyhJrWoqvfYp2X9bfUg8CvoDb5FSAs=;
        b=gbUUxCXT5aI32nydIGvP10IBYrW0iOoa9r4wonhKYWhw1qJ5aOgoGiOQNj+B/J3PbD
         Q/Tl/bxLCY8dWY/vQni/TqgqpETebr1peGfie5n/s7FNxSVm3iWLfcOQjLfQx1TwlwOQ
         JrVkLbg1OCIBkykm/Bwb3VKvzQoAQmOW+QBVl1X4basRFCfeJZxX1n/66KtlHy5gZWXW
         pLPt0DD1TA1I9CO2rKKJhh5Es9voh3ACo8EVfuQoKxb6C3cPeyeC2cP2nOO/ugnwtLmQ
         HNGQYg2TNEUxuLXfRPpNUBRI0AgdZdAKzB8dYd+QFa2BqgNAMcbisblZXPsnEWz+uix6
         ORlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEkuVCaXRFUta4kyUR1FcSjg+nVbwtuB4Dz5fp55vYXL2x5rADQf38YSOhZ4GhAqH5AAw0cvGHOZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYl93d6+441RRi1P5bU5X7Hqmlsn/LfkTGlY1IGYTMPrqHYKug
	a1MvzoGFNWuD2aDrQbPiFWfeWxOMgplVZ7GljYV/FSHl5TE9N8TBgNgbo9jEzG5ZURs=
X-Gm-Gg: AY/fxX7tyLvHiCS0qLasx7mNA3EsuT2EphauaiykQlle530MauctsL8jyOSVoTS5k6l
	Xy0Tf6523pREg2AQn6O+3iV32xZFfhwveOGc18YbmxAooUMicEnEnw9tQ8PrAw7cWL95O2+6EFz
	RQw94EzJcSknwLobf2avd1UPhpotTSWgak8oJpvnUR237jJgbEuijUHi3ph7NhHuoEs3IwiyXVC
	dd/As5I7i+tzAWDltumcDAaiIIheSMByNtU+zQ8p6+47FLy1sFfy46xU8zJTMRPykgxYm1UWLf4
	ETjzELbe4EZ+idEc57CbxGBtuQS0n6XTfBKjLqbfGHkKu0nAEke/L0xdTlZV+Skg4fwW9FmRB9F
	XAi/IlrjAWlDkYiqPblSzt/CntNgRDDiIBJh8CU6TQ854T7TfPGaLR44Ler0kiL1URHZ32nyTQR
	2GwFt8BlptflWrSlQSSg==
X-Received: by 2002:a5d:5d81:0:b0:431:752:672b with SMTP id ffacd0b85a97d-4356998a823mr1864994f8f.14.1768548140696;
        Thu, 15 Jan 2026 23:22:20 -0800 (PST)
Received: from [10.31.13.216] ([82.77.28.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm3496749f8f.42.2026.01.15.23.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 23:22:20 -0800 (PST)
Message-ID: <40b636b3-b1d3-4c67-bbfd-6f41a5b0b290@tuxon.dev>
Date: Fri, 16 Jan 2026 09:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] arm64: dts: microchip: add LAN969x clock header
 file
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, lee@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linusw@kernel.org, olivia@selenic.com,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, Ryan.Wanner@microchip.com,
 tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-8-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260115114021.111324-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/26 13:37, Robert Marko wrote:
> LAN969x uses hardware clock indexes, so document theses in a header to make
> them humanly readable.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


