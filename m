Return-Path: <linux-spi+bounces-6097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEDE9F5FF9
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F647A28F4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 08:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57836158A09;
	Wed, 18 Dec 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FiO17yND"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC13156225
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509683; cv=none; b=QDOa7EIJhKwfeThob+G8J6yMbHXOSNa23oz+0rcehL2s3vE1AR4qB/KFCqotR53Zr0EfuA0J3pfmcIYGCPhHchTQOkZBvhnfWVGfSn/8v6cntUaPcy3dL5j2r/FX1PZL04fcTzXmC7FdUvuqBuAlbUH8KFyb6h0xTxO9X4Ky+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509683; c=relaxed/simple;
	bh=yzFtCKnTQ601A3f16AYTs8uZ5JScAxJvGB1+vxjME4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPKYSyaQ/du61MndWroLsPZR39F9KGreRT52dVD8tUCSBxW39YOs6hgZE5HYzuuajOehXMF3X0539rB0JbyQgTmrFgkzV59G4WZnzF4RRe3x2qMmBmh08LavjK6vHnim9k/zcdHyYw8N0/XTHDJjK/jLjm0sCHl7aQuJ2C+hUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FiO17yND; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso7628302a12.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 00:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734509680; x=1735114480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLshIda1SzJ3vEMtXnstyNooyVa33Af0YFLEb1I/GJY=;
        b=FiO17yNDNzD/+NDrtK5dj29S+ucPZlfD/rwYItM+CrXJBs/DZxQY+XwGvtukUPSgMH
         LZR/2cmPpeV1oeLSI191YTfjpxfS0CiG5vL0LSk38weeTPz4j+serSv+dGY5yLEmsQCD
         Y37c6VDysQjr6+Xxqut4kEuM3Gfza45GMuX72axyhZThYwoMR3oC6qElsOHCv6dqrRT6
         t4GOK5oN5ALqSkV1VB8G3TBu1d5Q7pvhud8O8r62fdlyZsrrJvpehjEOekhTjct0rnG4
         q3VL4JgxmJDppbTWgs9t95/K4c/+F1RUUpQGaJoRNqJnkMqXVKCmnT4gg62P8C5UpK3l
         9Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734509680; x=1735114480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLshIda1SzJ3vEMtXnstyNooyVa33Af0YFLEb1I/GJY=;
        b=lZ38qQ9hsZIcTwx6qfXjMe8+6tYMOcWuTq0kZyaavFTjMR0dhpyv4NSW3A+dd+/hXt
         /oVO3C3ejEiIINjb9ug7gf6UquJHsw0bBufl8gn1Q11UPpiYuZm1XLxAFL4cCMm1Hh6L
         CB1lGvlshB1uhwdtN7q8wmnMOwg0i22ecD1Fu6Z6kdpSbtmI3pXX3FwxI67LgDiL/cKn
         ptZpqrnrdW+JgZU38IcK+1xErrnVhwfCgXSxk/5/770asoODwa+986Epw5GAgyVX1NoE
         08WpOfZ4cNjRfmDJNyVhIfvqWTiylRhn7xxXiSyl/pPXzSjGRbvlU9/MQo1oCL9jtlcU
         nvSg==
X-Forwarded-Encrypted: i=1; AJvYcCW1IW/1TWz3sCiSF0byUxW76O5IhC5QBHtfufNgf98OC3KLgENNkme2PmEHOyT//Djthhd+Mu0a56o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZMuOdL6IngzcIfkRxpYJuL1SiVF4j/bThljiaGr8jpZnIHDQ
	KQYrCbVZoS0ChUHcz9DkZWkGpjPU7G3XyaaYBvtZiNXUSjjZU7/ei7JFJSpdI0w=
X-Gm-Gg: ASbGncsKIpOxndDLXRBoBmIZYtx3n8nL80co7aOjmDd7ClHSAj8OuXJadNkelj6X+4V
	0XwBVbPM5yDd2JwtQy+o9n4IL2tkSx9jVQ4bJxXd0Yfu1XPa4Rh2oeCtA/jTHks8yCtEWS7PCQy
	LGzLx6k4h+/xrvvH+tt4xw/U/Y1+LrltvD4r7TPZOaJtnxkJDIV1O7vxOoMvyHYEDOXSl18kRKJ
	hbVKxBVdin8UBcYSzih58rZb5/iCXuQC0XQoBiIakXs1LfqC0RPYFPy/mYDQNtD
X-Google-Smtp-Source: AGHT+IHhxI1Zr2mYA29SpEH95vNXNub6qcj7eCX6FH7pRb6bOEwBLTqGGOoN5lOsuLYigCMF4VpDpQ==
X-Received: by 2002:a05:6402:3814:b0:5d3:ff93:f5f9 with SMTP id 4fb4d7f45d1cf-5d7ee3b6194mr4832155a12.20.1734509679654;
        Wed, 18 Dec 2024 00:14:39 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960071edsm535623766b.27.2024.12.18.00.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 00:14:39 -0800 (PST)
Message-ID: <e2fcc787-8fb3-4023-af76-c0db3f4b40d6@linaro.org>
Date: Wed, 18 Dec 2024 08:14:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] mtd: spinand: winbond: Add comment about naming
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-24-miquel.raynal@bootlin.com>
 <71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org>
 <87wmg3kbxa.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87wmg3kbxa.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 12:25 PM, Miquel Raynal wrote:
> On 11/11/2024 at 14:38:53 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>>> Make the link between the core macros and the datasheet.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
>>> index 686e872fe0ff..9e2562805d23 100644
>>> --- a/drivers/mtd/nand/spi/winbond.c
>>> +++ b/drivers/mtd/nand/spi/winbond.c
>>> @@ -18,6 +18,11 @@
>>>  
>>>  #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
>>>  
>>> +/*
>>> + * "X2" in the core is equivalent to "dual output" in the datasheets,
>>> + * "X4" in the core is equivalent to "quad output" in the datasheets.
>>> + */
>>
>> doesn't help great for an outsider like me. Is quad referring to cmd,
>> addr or data? Or maybe of all? I need to read the code anyway.
> 
> I also don't like these terms. IIRC "output" is referring to the data cycles,
> otherwise it means address (dummy) and data cycles.
> 
> In single, dual or quad mode the naming is unclear but "okay". But octal
> DDR modes can require the opcode to be sent in octal mode as well, which
> is new. If we support that, I'll take care of using a more
> understandable naming for all macros like Xy-Xy-Xy, X being the
> buswidth, y being S (sdr) or D (ddr) and the three members being

8d-8d-8d is common and covered by few standards, yes.

> Command-Address-Data. I might even be tempted to include dummy cycles as
> well, because it is important to be clear if eg. in octal mode "1" means
> "1 cycle" or "8 cycles".
I find the info about dummy cycles useful. I wonder if such terminology
is already specified in a standard. If not, maybe we can put the dummy
cycles after the mode, in parenthesis? I would refrain custom terminology.

