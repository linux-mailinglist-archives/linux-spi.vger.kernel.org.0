Return-Path: <linux-spi+bounces-12287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0736D0F34F
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C628306C55F
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497DE34A78D;
	Sun, 11 Jan 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X9Wk2tta"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6403491C9
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142730; cv=none; b=XEpBIK0qtUw5X6FcaiU948ZtKAG+RUp71wPcjgWFqy/ycpZ04jILKZh9/IYXk97nqdo7XRCmuY6ZDhqkWvbqr+LTpcrvOqheZKS+KMSd/6UqX6IMIMXV6kZYOd0VO95JczCX/wgGYJfyZMyBGjYnLCw5D0OUIfEG1lCi9Srww+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142730; c=relaxed/simple;
	bh=YDHNGLJfluFKzT2RaL2uk9Ugi0ok4Sk7jIeMDkApg6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPrxx7CxX55DtYc8w1/3F9UGoggDk6oWqqymvK+4OPfl2zlox1A6Ti+buGioxZCM3saW6yocBos36IQvxVbI81TWJWhsUdrcNtzW7SQvIisRj3T9M7m7vE15uUXGTTMa7k3dDtkXVCnfdpKePmtcGR2dA9cy+TL2OVdo9caMCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X9Wk2tta; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1187459466b.2
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142726; x=1768747526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6rwalswAWwTHAknUrP94zFyJo4NhuP+T6GegkCWM/M=;
        b=X9Wk2ttak/FxxYeh5WLK137PvXT2Bo+6f4tTd7DoZEvDfH1xyhWoL4n6yF/gvnCw8z
         z+h9Pq1VYPIop7EYoYHEF/ZvxNpxMSSGAdL55uhaBcqSfbLSS6+O0g3gtUKbcER1Z7IK
         s2S2cmElL/gpcQWFvwhm/u+qSVXzl+qK0VjAc1Dk2jlacBc88hyZK8whHoOR0r+uNnl3
         9BPa6sdp3h6wLWdtn2N8cV2+HuBUCgov4KQjwoG6XwRdQ8sxApffjIH+TQL/Pc4vRPxm
         y7mX4RoTw9OGMaAtnsluf6omcNfoTTI99nG19wYn4YbH2bFtmLM64ISHwLjSgcuMJIRj
         qGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142726; x=1768747526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6rwalswAWwTHAknUrP94zFyJo4NhuP+T6GegkCWM/M=;
        b=rzOKexw3s77RjZLDEOz0MZG83lJekqnxSTcZvLEboSStieGEx+rYu9xiAOd1rCyulZ
         eDEZ9Ty8nx4CF7h7F2JLHTY1Mr8pwc6nNtbNwB5f+GBD6YYLA2P9O/TbBs5dcOasyzPc
         8Zupjb/5YZ2DjTrIA4/nFznm3qZoaBgfpkfC00XA8COmI4g6lGCx69UMEss64lGSUz8q
         oSk3OwGpwsP5sA8NnOPrlgcxUzK9fuPxlMe8x3T4O2o/W47YGiA5zmWYbU5ZlcwOfHqs
         BSriiWlYe5Gd+UXydiGRNVI+R/OxXvmmtoTczXCstrE9lVyNcpCeecD7MfwwzvGCUnNO
         GqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp3OCm7xmIrCs9kT/F1k1KU8kmGaRzvsYmcYZdrjwDpRbO5qcxNO0EyKhL0IylJeja1gN/k80YYIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwH5Ss+6Ny4wJuOopayd/NAKE2GU/2UkswYja5eODxds7FPzgU
	KuksbE/MAuOkINual9TGQjPV9x84C4I4wyhZOoK/i/NxEKwX9JKuFA4498b4Lh8nbxk=
X-Gm-Gg: AY/fxX7aswaqPq7K8zMj/B/eQrYsgwSFB24LF9ar7meBgyuB9/PybtM/urcHPNs6VqS
	veH4yV5kuHhGcXWLZsTYSK9++nSON3RxxGcuU8G3Dj4fjXjFAq1pZz77x5TMQKhgyUxsRV+SdIc
	Jt5TP5rw+VDUv9LKQ5fx+VPxZ/Z1JfyHbLR+VBtOHKYARpMSxKwsjY1aduwCf4sbsl7BSydF5XD
	RMYb+EVADNMxcrT7fvWMv6RKqdK+8BrMSEOPWoTDAFU28uFs0sjqJUm96WCsDfoZPqAurHQUydP
	e1b0Ipiqsk4Oy9n0PhR+sG4pAUrjZUIwowyQmPq6FyQAcj6zraVaY9Jp0EeLeNUSZSLDz+SGRYd
	dBHBaHyzFapnc002SgeZV9ZRuijfvItcvSiKZWEQouBCXP/vDjQSg1A79dxwmGW8HQ8Vp01m2iX
	iPPgIuv5EwFQO9McPieg6/WRg=
X-Google-Smtp-Source: AGHT+IGvS7IBApFn5Y6caZIpVWCcEKkW6+CPDWe6wxvm6P/BpWNKX4ZQoy1X15u9d+HjeZrWR8LDZA==
X-Received: by 2002:a17:907:6d10:b0:b84:40e1:c1c8 with SMTP id a640c23a62f3a-b8444f4afb5mr1764352266b.33.1768142726523;
        Sun, 11 Jan 2026 06:45:26 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm1699865166b.66.2026.01.11.06.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:25 -0800 (PST)
Message-ID: <7081b61b-599d-4a59-8a27-291c55a0e52a@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] dt-bindings: dma: atmel: add
 microchip,lan9691-dma
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
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-10-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-10-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x DMA compatible which is compatible to SAMA7G5.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

