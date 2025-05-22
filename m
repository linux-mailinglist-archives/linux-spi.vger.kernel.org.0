Return-Path: <linux-spi+bounces-8264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9018AC12A3
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2DDA40948
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6118C91F;
	Thu, 22 May 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZL9UKNX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970BDDAD;
	Thu, 22 May 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936169; cv=none; b=oLUHSzmqfu3H94nAJ6L3qEg+F2bKebAbyjjx0Gmz/EqVOrKjHy0Y3jiCPY43c5+FTSZ3aazm4qbrh6rCq1NKBWI7bIKkov1uECNuGECiHrl/vlZEpUMT8+2cDIVXb4+TbjgX0dmEfU8ir6b43oYn3THh9zchJTY50x6qjBRTViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936169; c=relaxed/simple;
	bh=v7g1Ex2cXiw8By3eneFXol0Fe6RHlOeOIGko9KQUZ4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cc0Z88RgjgOe/d1EQ0zE7QzRegcsWfYgPpv+evcQDvgMfvGXI5NRQwYydtAmRR/M1N3FBJamybtHi8ErCR/lCGMCHeQ1YVlcQ/2hcXzrpoWxrH5fLpaIU8FEdGRdkoJOsWr/9dEKygr3kimNRz5I3C8935jV3/4PwvXsgCngb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZL9UKNX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601f1914993so7890723a12.0;
        Thu, 22 May 2025 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747936166; x=1748540966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXlb98Jq8xguu+7ZKl/TCFGce1LzzWdMVuvQ7hjHTWY=;
        b=jZL9UKNXfwsiKbbUcoFHOnEihhpGRJ9ZteH7Fzz1wA1OSmPEIeEK+iFnC1YKjWp9yd
         gW/jdHi9DD9lSRnhECqnrCZHH2NFs0p48hfBUV16lOh2sGuZuHP5j+eXqcNiIlNvGlOa
         qNRHfs/cgRPNunMxsSaitA2kvH/hLiMVcqsyivaHePck2k8+ux9xFSLYO0LqNJN1K21f
         1I83vEfmuaaJVcRVNCgooUgc3LjcN58poaXn15ktg5d7Le+geLbiL51UYg5xoeBT3mhh
         z+wX874NUM9FLkIbowF+Cax1KbB95poAp6tM7xMjgBJAXKUfw+TGqVkPdZ5F1Ap2R/6p
         Iylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747936166; x=1748540966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXlb98Jq8xguu+7ZKl/TCFGce1LzzWdMVuvQ7hjHTWY=;
        b=u2c+8ZCe29alzGKszyWKKAM/VNzS5TjLtwrm3Nj68wtMK5WfRBprdz3a9aG0qUSjQg
         p9XnleURsYesFgqAvIbJU4nw5pNJay0SQ4gqIZQdbZ/CSP9YHMp3GEapOuXCvSt+fu0c
         0/c62vTiVDQFpUJynREV+bujuN3h1Hc63Xu4lzHurpLqnc6GAzTQjh9yIyAaUzmJGamP
         ydqHm4ZoAE3tyUNJM9IvWBnpkvnS1WglS15US3TtPiKk7rX110OLF2g/v01IcmpKJoHf
         w0mzfQMDI/GXR8SLUh98fMZFmNyvSTpAKCFCJG4f8m4BBBVdU/ylLZsiE4LLr/lbKaly
         0Hrg==
X-Forwarded-Encrypted: i=1; AJvYcCUqENUIqVhHz7AwDZOADaAHYq+sbpj+T2AXMfqx02pEdMDQXWZRAMs8CHCf6Oj84P1TaoIa3Xkvlh52@vger.kernel.org, AJvYcCVabkzOQuCL3AWMEQMbkfwlPnJpG+00a2hjXBWMearOQqM/YHOvSrGqDP1TGHTYee5vZrN9Qr3drT2RJC7t@vger.kernel.org, AJvYcCWF7dkdpKMcVy6rOc2Hfm0nrKV9n/8S1bZB2kDtjhFV+GBel9QVHVPpEBA54B0QDzHA/1zAcnkBoD1cDZYC@vger.kernel.org
X-Gm-Message-State: AOJu0YzklhJALih4pTVGTUSAnllQsM5FAHGEqMP/NpjDnjau8bewZSYP
	PQOVkyvhSi/GsUInR59ugdvhT1luwHIX5q3j5PNGxUlF98ZKXZCFP5Gg
X-Gm-Gg: ASbGncufOFEQhJlgiVe3fZyNEPx7Fy2SSt8QdB4Piuv9jcpCad8yb5eV1oEQ2VfrxcZ
	Zkr4X+3U9ShYYX6KAFJLfk7uy3aXh9fgYNwxewUHrkej1PR5OLnRT23wd6oZaGcpXo5+HGr0jeR
	XGd/KnsHZdA2zfD4TY3K6piiMaZ8jkYuv9v0Hyq/XNeENyA7v/72KbQhqvSr5ZcHY+0IQyKAfN6
	aeqwj3DOqDQpUhSxWChehf1K/UYxjtQXso+Iq8Ze4l/RbToCapV8aT9t7lVllTUM+4FhF6O+ZTe
	B9dD7wpAr10rgAlOWXiFR6DpscTUwjLgo5PG8XC584CJ6PVZOWVHVENBd6Rrj4zQcF7F8SIJnON
	HM9ZU6C4j6novt1SL
X-Google-Smtp-Source: AGHT+IEacT+OnQkIksGL3phaucP09y9PwnZSl4uyglfhmqkNpX/VieVElIyjZVOywJVl3/l2zAuGmw==
X-Received: by 2002:a17:907:3ea4:b0:ad2:49b5:8e0d with SMTP id a640c23a62f3a-ad536b7f1c3mr2350148266b.15.1747936165504;
        Thu, 22 May 2025 10:49:25 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047c30sm1101122166b.6.2025.05.22.10.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:49:24 -0700 (PDT)
Message-ID: <dec260e9-8874-4727-9211-de939991a344@gmail.com>
Date: Thu, 22 May 2025 19:49:24 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits ECC
 strength
Content-Language: hu
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
 <20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
 <8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
 <c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com> <878qn2nsa0.fsf@bootlin.com>
 <16195524-1f31-4968-a3fd-f3d24f1c4223@gmail.com> <87msbhezjf.fsf@bootlin.com>
 <007881c9-e03c-1473-d8eb-53fbad8c6a8e@quicinc.com>
 <87frh4ej87.fsf@bootlin.com>
 <e9f460c3-a575-1014-cca7-27f1d79024e2@quicinc.com>
 <87h61e8kow.fsf@bootlin.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87h61e8kow.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 05. 21. 9:52 keltezéssel, Miquel Raynal írta:
> On 21/05/2025 at 11:08:02 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
> 
>> Hi,
>>
>> On 5/16/2025 7:44 PM, Miquel Raynal wrote:
>>>
>>>>>> Interestingly enough, it reports the correct number of bit errors now.
>>>>>> For me it seems, that the hardware reports the number of the corrected
>>>>>> *bytes* instead of the corrected *bits*.
>>>>> I doubt that, nobody counts bytes of errors.
>>>>> You results are surprising. I initially though in favour of a software
>>>>> bug, but then it looks even weirder than that. Alam?
>>>> I have checked with HW team , the QPIC ECC HW engine reports the bit
>>>> error byte wise not bit wise.
>>>>
>>>> e.g
>>>>      Byte0 --> 2-bitflips --> QPIC ECC counts 1 only
>>>>      Byte1 --> 3-bitflips --> QPIC ECC counts 1 only
>>>>      Byte2 --> 1-bitflips --> QPIC ECC counts 1 only
>>>>      Byte3 --> 4-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>>>>      Byte4 --> 6-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>>>>
>>>> Hope this can clearify the things now.
>>> o_O ????
>>> How is that even useful? This basically means UBI will never refresh
>>> the
>>> data because we will constantly underestimate the number of bitflips! We
>>> need to know the actual number, this averaging does not make any sense
>>> for Linux. Is there another way to get the raw number of bitflips?
>> I have re-checked with HW team, unfortunately currently there is no
>> register fields available to get the raw number of bit flips. But
>> for newer chipset they have fixed this issue. But currently the QPIC
>> QPIC_NANDC_BUFFER_STATUS | 0x79B0018 register bit-8 will get set if
>> there is uncorrectable bitflips happened.
>>
>> For 4-bit ECC if 5-bit raw bit flips happened then bit-8 will get set in
>> QPIC_NANDC_BUFFER_STATUS.
>>
>> similar for 8-bit ECC if 9-bit raw bit flips happened then bit-8 will
>> get set in QPIC_NANDC_BUFFER_STATUS.
> 
> I believe the unrecoverable situation is handled correctly. What is not
> is the fact that we care about the number of bitflips before having a
> failure because if it reaches a certain threshold (typically 2/3 of the
> strength) the upper layer is responsible of moving the data around to
> avoid loosing it.
> 
> You need to identify the hardware revision that fixed it and provide a
> warning otherwise, or at least a comment in the code...

In itself, neither a comment, nor a warning will help as far as the upper layer
is concerned. However the driver can be changed to overestimate the number of
corrected bitflips.

I just sent a patch [1] which tries to addresses this. I admit that it is not
ideal, but in my opinion it is a reasonable tradeoff which can be used as a
temporary solution.

For a long term fix, probably it would be possible to change the driver to do
the ECC correction in software.  Although I have no idea how that would impact
the performance.

[1]
https://lore.kernel.org/r/20250522-qpic-snand-overestimate-bitflips-v1-1-35c65c05068e@gmail.com

Regards,
Gabor

