Return-Path: <linux-spi+bounces-12283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1ED0F284
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E20D630215E8
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DE342169;
	Sun, 11 Jan 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoTM+k2S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8B348466
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142636; cv=none; b=Vog38/Mj9HFABLmC5IGkTF6pcUGers/RzZJWNOV0R6M9F+QA5LkkTH7h93qLnKjqQFG/nuHogoAqcMyAtjfMAeLxT355mlOv/ErvK7GwDPK/kcpuv5xP4+7a08FvuquNND72HyPPpNI1chAWVtRbbwPx3HA4gFLVzis+HBAPmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142636; c=relaxed/simple;
	bh=PnoQRnuiOPkoaR4OWKdkvM54htM4YQiVOhdkWK0qg5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbPa9/IGBaM0h3I50EqETvRmq2T1panpWJVdZzRu3FfuKKKah/48ET1rs2dh1U6YwbYuwVsb5fSm/WnA8rE2/AkpScEZXR3w9G3x5IV3LxSl77KUcbFYHw/U21RqMJN8HBpydG3iJ/yd+ZlNvrTj3H4E+xFw4CDRsp6uEnxaZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoTM+k2S; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so922355666b.2
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142633; x=1768747433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8ivZWfcmepYc5T+3Up0ol6uJ6XFnUAYmd34ka9AIUo=;
        b=NoTM+k2SO5HylCVHcHNqCec7b7gBIoX2QQd6dHlIYohJij5ffigE1XqVlvs93gRqWu
         zSIkpxTis8OI66sDUEw9DNOr0vv38lEu0MABsxGfO4mb7PU0O/BAenxo8CfbBvrIUjvJ
         LRD7tBDt5dQcbYHF3oqbQYYGIp7uzpqccEsipOONv2jXTM+d2xEwUlLYcgjMnPd3UHaG
         v1LNXlJiyOp211uIT/EXTZAXo6ZwY2pa/ypM6jMTRJzxVWBG9VG0jzGXdKX5J6OsbGrT
         +1rzoSd6z1syRrs42BwDqXaqn95JEU2D+Qx2+rM7+dRq6TJYCADcu6Rbo1rrtVkRqMN4
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142633; x=1768747433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8ivZWfcmepYc5T+3Up0ol6uJ6XFnUAYmd34ka9AIUo=;
        b=CG5aP5SoWLMPirU1ld5Kbnksdk7SjbtsD8ArWuqVMgSyI1LLCbhBg+jJiHxBJv+iQu
         hDSYb/pzToa3YELXbltvG2t+RXPFIX+zMW62gnX65tw3CqWxU/jiuMC0a9M53FrUKRdd
         Dsn01ba/O5FHkb//nPvNIXVIh9TSUnChwHBxU5kHb4vlF4IF+MnfrWSyVJuv9GfB94Bb
         /XuEHMCgLrSFjxWjnBCqdfQCtREWVxGSPRosfh1c/uqOmSBpc7qPJ287PKatE44rKhvM
         1RkEuJ8m6fskVYd/MViq5HahzUBmZrgblmFwb28muq80bH2S5lWucBC9LRzhfrAUNbFY
         WHCA==
X-Forwarded-Encrypted: i=1; AJvYcCUUbVgzuQbTixc73Jpqgd04+9Und+AVujctgHn2QqzepjfIYwxic2KnU+ImWbkut2uF6851Q19/6JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiP0gD8y7Y/2MR+ZJrC55RtXZ3upWKZbdyOAzRXojoHUJ55MVZ
	2Yij1i52nwyDnyywsIwdmwe1MP93FeP2EfqOucXQEZDIDjuQQOEd2NTMCpyZENF75zk=
X-Gm-Gg: AY/fxX5eFmFI4wtFiHB/dGwiPZ8ABJeOpJ2OJQiR7v+IOjWZauC5J9wNxu7d4aP7gLq
	+u94sFaUe6zaMsrEk/rq0+fuiQ+kAiAsDvttZ8B5QEk+fBOH/JiY1x7i65cnUts3fjg/XXVR4YJ
	LAAXeT+wNGMhoyZFFADZRCSMCl3T+zT7/3Bxuahph25Gvbg6zTK8LrkQq9cFCDJcOq++nkfPKlE
	/hEaljQh9u4tcDwKjFG/UbDYqOnOHcD++VOxAq1nkMd6X7Qu5yXyb/zji4gPqaDLgf6Fi/MNU8b
	jwHJBW01c8baeRUDk2Y2NeVcE7oTuFgw+xgCTcCfsUmTED+ejhjs+efre66ie5a99v3N0FWtcIT
	9YTbvVfdCzSr8BOkDU5of658OmH9Qc/VufZbsKa9m0BBOuD8Q6a0AeYfc/Hd2wDPRhHA4tDeMVN
	bsxqWH2T34NZuT2e7S3v97068=
X-Google-Smtp-Source: AGHT+IEIDu7YG5XG/nu65TCe1ZGy2PfVFAGljLAgOLVEydIa/k97PZQn/n1VHfMaw/abNX/NIg40nQ==
X-Received: by 2002:a17:907:980e:b0:b72:5d9c:b47b with SMTP id a640c23a62f3a-b8444f6f7dcmr1568524366b.36.1768142632630;
        Sun, 11 Jan 2026 06:43:52 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm491365166b.31.2026.01.11.06.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:43:52 -0800 (PST)
Message-ID: <d97c48eb-ebbe-4742-a4f6-220d4515a65f@tuxon.dev>
Date: Sun, 11 Jan 2026 16:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add
 microchip,lan9691-flexcom
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
 <20251229184004.571837-3-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add binding documentation for Microchip LAN969x.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

