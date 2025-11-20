Return-Path: <linux-spi+bounces-11372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D7C72F6D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06491347C1A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458430ACE5;
	Thu, 20 Nov 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKw7SDMq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AB6BB5B
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628582; cv=none; b=emB/GNV8ZyFs73exBXBO3BxkjlGIS8ZHeMeLMHMYjKDYz4x+SJ9gGJl92h8mBuaksIYP3XKWOQylSOlIbIMIkj4fsUdY/hhau7a8G/AUaHOudHyrgKR/3p/6Zs+1aOFoRe6R5ORwU1oNW8avuheWS+WjipU/u9yLEi73WFPBQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628582; c=relaxed/simple;
	bh=fBIQ1iUSom1JW1iZWyOAUX3M/GlqXi6cGe3IKPBNWcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC8eT6TmnVDGCqx3y1+M0J+xvqupndiWi15+riRIquTfqVCeXsPWPttQZP9SNwCSFJ+455FBolW/PwSIMMpS/a7XHS2bDYIrfrU0odX4AhAlT7MkNmQf4s98Z18PQRIE/x9nO6F/27GWcHs1TrNf6hfPqidxc4UPJqWM2p+YIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKw7SDMq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so3999015e9.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763628579; x=1764233379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tr4vxP+sQBMMwJGPDae6MZt25g996ad6jUynMcaybIQ=;
        b=tKw7SDMq+dHmfHUbw1sgwocHfVeqw2w4qGqwzAFEsJhOApl7ZrJcfNNkMMJHUYD5rw
         jSFHLLLaEGj1rgcvbDiBkEN9T/twcGkqWANhTIHvZV0S0tZXdTRqvbwci4qIVXyHLj8U
         jKDiNXJzG7uMlg/DeiYPnTCl9E+bJwxQvTz/aeLtJ0Gsn0ryKzFmA6GzrCMQV3BYEtwK
         Pb8cx8BQZt+A0sTCe86mG5X1jDdqy26aEXfxlPbJKflV7Cy7CnNd3LbLw8AoX8gJ4eGk
         +dUD1dWFCQQPub0dHZhC9bT39iNpyaqurZc0zDlvhWWF45lW9XK7c580INSNJXde0Uin
         hSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763628579; x=1764233379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr4vxP+sQBMMwJGPDae6MZt25g996ad6jUynMcaybIQ=;
        b=O7bSNEqxQ6+q0OCOaYT8x02SooPTUGnWzl8QRLBVSPFfP5A6ptdE1SHcSK5mKJzU/l
         0W6mrCTjkYI91UN8V33v7RnGQMkJCF6DVUf0ufTc7T8ZWsoAezrv4+noppEe4G/yFake
         RilfNgE2FS/Y+JGWa8FwiTrBq4olyjwkv6y67E9+kzbjGHUnaJKPbGb4NC9ou6ByL3hr
         P+vKlrqGI7ZZpLiOCmw010WR0QOn6POHk2GVhXQBaYporfOs7AsCCQVcfp+/qlEZNgvb
         zsBs+3YnPQGcZrqcFuHWFBTq9k2BFmq/8xbCxN/JdbUDBYgtiOk7mxJEuUmnkGXDXjPL
         tBnA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZNhWo1urQ/fKFNTUR9RzFrGkuWXvJDbOwJoZijzYClMilhu7YHIcFvgilI1T59Z/dCo6Npnd1pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrPHjmon/467OKG4A6W8a/Ye5O9JbNaUvqY8iPBOFM7c8yC4v
	6gq7fTBYiWxYaCiH8gztHZR61PJWZfGH2aVVDnx7b25XRnGbiBrcpE+YD7mRq6e2AiI=
X-Gm-Gg: ASbGncvMVQtTccx4lUkAgfD/SPGe+HuQmvcXFyK2yDTCXPB5XMHvEXyYltw502AFO3M
	0c53WRZWwB9hXGKg1La2xNe7MOPZzX/qkhI97ev6ichn9R4Ppzv3bOE+s5n6hT7zDbq5zfyrJGT
	hQSjT52yjVVL3pXLLt1tfg5r9a26VFQyNu3EvGy7dKofYKdHibUwm1AtwzkyinmKdiEe9YYx+e6
	8Cn69f0y6B1s1pTijm8sZwbCKJlubxgydK1MWR6UmbCu3Lg/pwmcvVcz7V9hk9pQRZcNJlv6xgI
	v88PDEHyC26r+Hj3NsTId+uhsjqOyHuqCGahMar1VoDH7+X8EPfmnpDpbh2n+cgrzPur/YgTmz5
	GzwF3jvtkCst9EINDQaVEgZ/al7aORBksmFlnrVSpOhECkXh/ZOrKmGek+/7OtkIew7jLaMlrJP
	QjeRJF5Vs4JSqwtRLi
X-Google-Smtp-Source: AGHT+IG08wEeQkKE04km+1877mSVK+vsQ96TT4GEyEbDJFmXtwyb5oX4SsollpOGVesQpgnEz/YLjA==
X-Received: by 2002:a05:600c:458c:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-477b9ea56eemr17323825e9.4.1763628578701;
        Thu, 20 Nov 2025 00:49:38 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b83200f1sm36785945e9.15.2025.11.20.00.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:49:37 -0800 (PST)
Message-ID: <a9161234-de04-4090-afb4-7b619cae3c35@linaro.org>
Date: Thu, 20 Nov 2025 10:49:36 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/28] spi: spi-mem: Create a repeated address operation
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
 <0be97b27-4f8b-4d22-a653-154e87ecbc78@linaro.org>
 <871pluc5id.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <871pluc5id.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 7:10 PM, Miquel Raynal wrote:
> Hi Tudor,
> 

Hi, Miquel!

> First, thank you very much for all this precious feedback! I am happy to
> get feedback not only on the spi-mem side, but also on the NAND changes!

yeah, I had a spare window and reviewed as much as I could. The set won't go
in this cycle anyway, I plan to review the rest as well. But not just now :)

> 
> On 05/11/2025 at 16:43:58 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>>> In octal DTR mode, while the command opcode is *always* repeated,
>>
>> this info is wrong: opcode can be repeated, inverted or a dedicated 16bit,
>> so please fix this to not mislead readers
> 
> I didn't know :) But yeah I had SPI NAND mind which was obviously
> wrong. I'll correct.
> 
>>> addresses may either be long enough to cover at least two bytes (in
>>> which case the existing macro works), or otherwise for single byte
>>> addresses, the byte must also be duplicated and sent twice: on each
>>> front of the clock. Create a macro for this common case.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>  include/linux/spi/spi-mem.h | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>>> index 81c9c7e793b6ab894675e0198d412d84b8525c2e..e4db0924898ce5b17d2b6d4269495bb968db2871 100644
>>> --- a/include/linux/spi/spi-mem.h
>>> +++ b/include/linux/spi/spi-mem.h
>>> @@ -43,6 +43,14 @@
>>>  		.dtr = true,					\
>>>  	}
>>>  
>>> +#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\
>>
>> I find the name too generic. This is an macro for 1 byte addresses,
>> right?
> 
> Yes it is. The name mimics the "dtr command repeat" macro name. Maybe
> you want to include the info that it is  carrying a single byte? maybe
> "*RPT_SINGLE_BYTE_ADDR"? but that's a big too long IMO. Any other idea?
Let's keep it as you proposed, I see how they are used in patch 27/28 and
it looks alright.

Cheers,
ta

