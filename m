Return-Path: <linux-spi+bounces-12288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E33D0F2F7
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D45CB303BC17
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537CE34AAED;
	Sun, 11 Jan 2026 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g58+wShN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEF3491C7
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142746; cv=none; b=qaAPq/vw/axIWR+DDh+SRuYTN0xFOId2V7vfCbnG3vkc9I87uvZJKDjjuUloA+dRwCk7sBNI60qdIHYDYNbxzVaxq3b6xH6dGMPMKXbx3fqg7nnfX0uorVrfuOiJcD0tSKqaGXqGGxLdDxfyNtXyXqn8a8TKHFOR7rEWPIsVm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142746; c=relaxed/simple;
	bh=8+o9CrQDP9rR7vhYrkmBD4TEK1Ah1Um118V33OBjIn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFLF+aHUxh6rLhISbRa1rcmHyNxn5xne0Qg5gH/+en//evD83tMpe3xTX7QWN8Wh1BuDBePszD1NSvePu5Xhq5PPhx+TVAhj8a2FQjtkedbSucVL1tOw5TAIV3Dt3oMAZulSZT4CItCCvf4dxzEcOFEo3rnj9eugCqawkmBUMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=g58+wShN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so7925395a12.2
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142741; x=1768747541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=g58+wShNUGm4cSq/cIFs5BcjtBtziWlVwOnRIYJ0JBVThU79/8vxkDEUyOzt7AzJBB
         cTZ9e0Q9nDikPkEBLmzCCkAYBMC9A64/OO6AU4Ed+EOGygTBTQEKuknv7Bvpc0Hq4pfW
         tWuCEazhna5tzsEGgmV/QS1mDV7AI8F7irWQCIvLFAdd6UBceXKAjkUon+m8Sp9IuWPs
         p2XYZJYaezhBjl4awlNqxLX5lYDftU2jHR0SSz7JmKdP4CM//mkBYchNBUXZFooCPe+6
         dp21GWl3JMqXh5qWiJlPzG2nBfXylKpA9kssFDHJxDnXDPKiHgK0Z6Kpaw+F7SivT7OY
         h9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142741; x=1768747541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=BBZ192IXISpB2fhJB68dWcHEbH/7R/H6LQY9bjK51qdSP5/h4gOLrOY/5EmzrZIztW
         89H80lCjnPJeqzGCO3c+/hfOFX+ayXK7egN312BY22LUOWHs2kAOPCt1hcedGErfTIMK
         CJYP9Imd/eb/Nfsnw/fjGOqpuqEw4BF+cTbrcsGsZPhmJGLgh/9Yx5dnYvl0OmCRwnfs
         IoIQqKcsfqxHfA1dgPSfAAGhaTc7EgnGa8uNSgZAMT+qPWeKhAeGENw3fS3o82VNW0v/
         IDh0uxk33lHhTfsJI4ousrGjdS/j9A5ilKqsgO5H3NFzTBpaVnewfgbMy2EnXApyNocG
         NNog==
X-Forwarded-Encrypted: i=1; AJvYcCXk3COKP4CcU2BcOVYd0CU160VSN5SKJJ1S2Zd0/QkLU0wAEupZW2+rfrAMF4NUvS0JvDwhSkD+TsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvvRYm3+f7kVpwGocPtt8aYv+G0S64Be8UPrP/65fgVryLMpG
	WWAN5eRbxrMlAgXJ5usufZj13rl38KO63Cin8kHjpoWdDAQx/+eawlax/WiZYH8Tg1c=
X-Gm-Gg: AY/fxX4jj3GmZJYMWh2AsjUiyAsOQ9+UbG0wB0o9N/1/Bj/Vi1sHnyE4lHj8sCS2k3+
	xcuKJzojy6kP60OGR3um1gi9YEpPHFqZKeWgahkjH9qJuydih1+FGQqQDG3noglRQRQTEr/ywzh
	hjax93+MTO6N/saaOpOHDEAZwpORg00/vEeIE4OIVqAvDS6kV9JCsLGee6wMr6i8EZrwm5tDzbB
	XQ+unHxMRjq8KfhFB5WeynNaiNPp/Kn2h3PQ+BCcX93I07+f38oY6DE6wyQWEUUjundSe6N8JMf
	XC7VS5PiEmuM3LuKwLIHfTooMIP6qTaoTe/ImdkNApJXO60yTxhxntVQRXvlG/iwbT19B9oj0c8
	HTJcOl1j3w1BcbhYsRIjPDbucg/iDlKHSvLVttxLA3XdicZaka41KDwe6owmWLAJURA45H5Q7za
	RxAefSmpNTCULcK3/NrRDLeKc=
X-Google-Smtp-Source: AGHT+IGzzRSG9JPiSsYLBto386guzGNBLdjrzZm8+JQDEKUQ0tWs5J3FidjE880cd/bBYxLZJrvW2A==
X-Received: by 2002:a17:907:9455:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b8445169517mr1585237766b.8.1768142741298;
        Sun, 11 Jan 2026 06:45:41 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm260020066b.16.2026.01.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:40 -0800 (PST)
Message-ID: <555883af-66da-43a0-a4d6-bd3bc52581b6@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] dt-bindings: net: mscc-miim: add
 microchip,lan9691-miim
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
 <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x MIIM compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

