Return-Path: <linux-spi+bounces-6105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEC9F62B8
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 11:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E09161F37
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4691922F1;
	Wed, 18 Dec 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWZgV8gM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010F199E88
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517320; cv=none; b=itOJyCKlmiQ+rEuKo9ogjN7cgK1U3Be9FdAXnCorXrvOup+Dj5ZiFBiqk3j0IdvyYT5KzlG+3WMxjEcEvXx/Y4GDeuSR+UYMsvwXceTwmhvx5iEr24b9+MB/5l5IQgURHyKyHiPoCPm22IWxhJsZhHnqs3vKFy5vBKltGe0Joag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517320; c=relaxed/simple;
	bh=lGFLRshJGhdDnc69AuJ2ctiIe3BuuxdvNoVFlglToAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICoXaiY8cpspUJP+5xGGi9UItcXVaRJdiQz+H1roE4KVjWv34/29HJRHcTm1ZfqoFe0SPlv/wBbfY2T6Wyl7ucMTcPuJxCGzhjwXSvnCPx37pYK16bAbJ9rJCLgdxkfjTiUKN8A2SzdVlCV8hNnBQOzvw3VHsQ0aa/In2EGxFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yWZgV8gM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d161947so3042280f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 02:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734517317; x=1735122117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJrFuVoxxR4UWWMuZ0HLQsYBjKF3RT/r1rHKTzI8EMk=;
        b=yWZgV8gMYdwgrygdA+oFPhZbXMJJ1W9V8QI+MGjctaPiWfrZro8XAJzP8YASUV7jbX
         coQO8ar8l/biWfLkzDXtNanpuqyL3xq9CnenPX3uafLHgoYfCGUeQbd6z4BNczWHK8i4
         YFKGGNaJ6NsAZpokFVonEVGXfWdJXGLdF6ckWYPEZdDukvcPw921cp+bJswK3D+j1o3b
         x+xJYU1O9cz2yIbldiWEx59LlZ1IrTbx/MeKfrHv0++Ii5yWGFyYDyVlWfAshn5S2Rot
         mf4IJZkQD6LuCxGeXQGV0TgmYpdRcYeMI3ZFahkiJUQVgkXAlL4RpTg0E6UaA16QLpaX
         AKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734517317; x=1735122117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJrFuVoxxR4UWWMuZ0HLQsYBjKF3RT/r1rHKTzI8EMk=;
        b=oCQP66YWSDChIhDYxc7VLroGPX5uZEEJla1xggeCqN1+rsUfTNly0goKu2JXsjfgot
         ExAR7JY0IGKavMJdF2K5HV7+9x5yC1FlAWg/BXy6al++ZGQ9G0zzD+DALNVV3UG+Xy5T
         K0KeBeTFeGBSjhZ7ZvJb9WDAjfNBe2TNkB2JrvSta5fO6jfXiEcmJmRpbGHQT+4cp0XL
         bjpv+d+Y7xv0wyyj6JrCbaCsp2lgkm7+37PV6lO2MBRfh1tu8lKzHIMcgHdNZc7djHAM
         tNSDkHhdwYTSW1NTeuFKkShnOvaI7oN6yR8zdNfiDpjIFwne2fVuUmIYhIdM4Zv0J+z+
         cR0A==
X-Forwarded-Encrypted: i=1; AJvYcCVfKckLEhdzuD3+jS/8pp6xirMI1vCd8T4PIl/OL2bYMQZ1Y9g7lcCr7g/yvHYIH8SFnJFEl5sHJmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzww7s3XxMiiCTkEHdi7oF1NoeQCCp9Ebmh1HWALnyz4FWJlE/0
	iK2lBciqKdp9JFIJkgZ6jCxEMa2/ZlyzFar8PkoeT9NKFrr2iZiTl5+Ry1EBfeE/9qfms6ZuOep
	0
X-Gm-Gg: ASbGnctd8mintaLK4+MoP8UL9M3WOlN/2Gdn3jJRlLLAFLDZFgsHLK3ltMLXYmgLtUr
	AZHmDNAmwOR2WkrAIYiIxoUXN645lhrMUk/OyI/K6mC/Cb9W7PDBSazf5mAx0ThKyfhiDgDGxZj
	4CdgqjefiVuGKWSv35cMyJogzkJ/XuMGegRnZCI2jr7lr8Gt8pRWZEaCKJPaxPvK0WcWOgwwUNW
	aqilzcJwyI2WbdCaZ189m7o3eYCHzG+9FdIS3wRwBq5WY099UvwEIUo+JIFLmE7
X-Google-Smtp-Source: AGHT+IEeObS6BkwBM7Lew+oHxilbmEwDIMCj+h4CLtgguQuuDz2PWjV1ULyU++iL1sum1joUkK/4rw==
X-Received: by 2002:a5d:6c6d:0:b0:385:e411:c894 with SMTP id ffacd0b85a97d-388e4da50eamr1721095f8f.43.1734517316820;
        Wed, 18 Dec 2024 02:21:56 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012034sm13479845f8f.22.2024.12.18.02.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:21:56 -0800 (PST)
Message-ID: <4ca13ef9-062f-4952-9588-c14f22867bf3@linaro.org>
Date: Wed, 18 Dec 2024 10:21:54 +0000
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
 <e2fcc787-8fb3-4023-af76-c0db3f4b40d6@linaro.org>
 <87pllpe3nl.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87pllpe3nl.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/24 9:33 AM, Miquel Raynal wrote:
> On 18/12/2024 at 08:14:36 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 12/13/24 12:25 PM, Miquel Raynal wrote:
>>> On 11/11/2024 at 14:38:53 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>
>>>> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>>>>> Make the link between the core macros and the datasheet.
>>>>>
>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>> ---
>>>>>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
>>>>> index 686e872fe0ff..9e2562805d23 100644
>>>>> --- a/drivers/mtd/nand/spi/winbond.c
>>>>> +++ b/drivers/mtd/nand/spi/winbond.c
>>>>> @@ -18,6 +18,11 @@
>>>>>  
>>>>>  #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
>>>>>  
>>>>> +/*
>>>>> + * "X2" in the core is equivalent to "dual output" in the datasheets,
>>>>> + * "X4" in the core is equivalent to "quad output" in the datasheets.
>>>>> + */
>>>>
>>>> doesn't help great for an outsider like me. Is quad referring to cmd,
>>>> addr or data? Or maybe of all? I need to read the code anyway.
>>>
>>> I also don't like these terms. IIRC "output" is referring to the data cycles,
>>> otherwise it means address (dummy) and data cycles.
>>>
>>> In single, dual or quad mode the naming is unclear but "okay". But octal
>>> DDR modes can require the opcode to be sent in octal mode as well, which
>>> is new. If we support that, I'll take care of using a more
>>> understandable naming for all macros like Xy-Xy-Xy, X being the
>>> buswidth, y being S (sdr) or D (ddr) and the three members being
>>
>> 8d-8d-8d is common and covered by few standards, yes.
>>
>>> Command-Address-Data. I might even be tempted to include dummy cycles as
>>> well, because it is important to be clear if eg. in octal mode "1" means
>>> "1 cycle" or "8 cycles".
>> I find the info about dummy cycles useful. I wonder if such terminology
>> is already specified in a standard. If not, maybe we can put the dummy
>> cycles after the mode, in parenthesis? I would refrain custom terminology.
> 
> I see you concern, but would you mind giving an example of what you have
> in mind?
> 

on a second thought, the number of dummy cycles can vary depending on
frequency, so better to stick just to the
	Xy-Xy-Xy, X = {1,2,4,8}, y = {S, D} terminology.

