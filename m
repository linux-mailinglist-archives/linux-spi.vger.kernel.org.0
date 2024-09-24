Return-Path: <linux-spi+bounces-4939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141E983D1C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 08:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6D31F218F9
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799B6EB5C;
	Tue, 24 Sep 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQAjDCcS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA773451
	for <linux-spi@vger.kernel.org>; Tue, 24 Sep 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159189; cv=none; b=MJoxmy+oPHD2b1Oa++Mf38L4C/Q8QMXa90dk6REm/ihfFN8nS1wN4GWwlzPLJF43FPm2qZIj0t//HZZO8u4ASfPsGRnl3iSfjS6KZnMcy20eZ5XAt1q5Fe7koA45BTtFxqN8iAFN2dWnnqnJXbn1ktwxkEGzh/9q3W7zL2oj7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159189; c=relaxed/simple;
	bh=lYTd7hQ8FAoCkKxITL4zdXuYX8Yn/AHY0EdO4ffZYAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaT4YLcY54MmgIxTuJKSFTKaI8fgtDEDBUWhC647eP5vrcB6JEl8npF4D4CXFekf0A46zgF62wUjq++9MpNsV1yjSqR0uBDoVfUlb9X6KhvLh0wXEWpVyRoJNzYu/OTZz7pHJbq7zuK5DGtfTIjFZlZiqoJ9UNWkC7p9NlqFgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQAjDCcS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374d29ad870so2834046f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727159185; x=1727763985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdBSLWTjDz46WnUKd/zsdS9Z+CNhvUe7k25zO7xWOHY=;
        b=fQAjDCcSNUTRxIM1dmv0SUvdNpT3s2gDbNVTAeaeHoLy8xwJShFrP0jkZQ4tcBZRFo
         O7H5y8Ovw94mhm3nbbadfwYHQUTMiSqpvIlM7Xv3NYbb18DZzZm/1+U7IhuBJgVjrGDt
         N2cQ3Y3MZxtoNJvAZFHgj3O9s6nheIOnpDZBTpppEFiax0cmh+NF4qfGGLNCiYTAk0Pm
         OJiZZnWH52zm1U3mQNVH/L1cq336WqXJubl4F7hnwxsv/jb8DfK7js+3oonIO72VM+oV
         sngqYuDt8XIx4v2mSOk07I/GRMPkxXwetmI0dsH7rb++ptRZvUDNGG+XvYaWRj4TdpYQ
         djaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727159185; x=1727763985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdBSLWTjDz46WnUKd/zsdS9Z+CNhvUe7k25zO7xWOHY=;
        b=p6CBxwZYigpAM7upCnBqr15XyOGCci9zW8k2d8Ve+moVXrljMKkSAUtN1wb77K+5Ji
         v5WgUBjV/S4aeTSXxzBGYHyBRo81QS6sAYzbR0xZUlTlMpsKU7DmzuvnZfN5K8okiJL+
         E7TRINK/YN7IK/0YnggTODt+iZLSC1RdwggemQXgjH0rMo0jcBoGuhgIbfgsl3w5+EF6
         avxKefyCM2j3XccQMPX+pRGqV/jvzBsqqF2YLXzTjgFb1yK4sJ/M7Wd6ydO8L6KGfY0a
         gWSmB10DQptG/4aVk6IV8bcITFuBexxtapjOvSwwxS7iqCn3Xalp0SLNNqPoN+qJHZtP
         T1mg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/iQH6CZHG5VyXYRStQTiTL55eD7LlttTqKRQ0GUydbaKfKD9LikMp3MuX+TdMak14HzWo73z9Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUbaKPzIP4Ppk5mC6l3Td3gUv36nOPLBHa/EKx3Eh/c0ObM0i
	znMJLccl3DnfF93r03fxDhd+43T7sJhFy9givQ4z7bVu7TBYf6jdxH6H9vzHsxg=
X-Google-Smtp-Source: AGHT+IH7QCoWbsnczGD/UHfDyngk5Dnq6vWWlZdr2uSQqSKGcBjiebnb2RSWlwiXS9rCJr2xUVJQxw==
X-Received: by 2002:a5d:4a07:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-37a42252c42mr6407890f8f.7.1727159185161;
        Mon, 23 Sep 2024 23:26:25 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1acasm693353f8f.32.2024.09.23.23.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 23:26:24 -0700 (PDT)
Message-ID: <368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org>
Date: Tue, 24 Sep 2024 07:26:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
To: Alvin Zhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>,
 Bough Chen <haibo.chen@nxp.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-7-alvinzhou.tw@gmail.com>
 <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
 <CAPhrvRR3U9=0DuG_FQ81ZJq+RLe6Bn9YO831Mx2n3NkeV3MCdA@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPhrvRR3U9=0DuG_FQ81ZJq+RLe6Bn9YO831Mx2n3NkeV3MCdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/24 4:25 AM, Alvin Zhou wrote:
> Hi Tudor,
> 
> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2024年9月23日 週一 下午2:54寫道：
>>
>> Hi, Alvin,
>>
>> I quickly skimmed over the previous 5 patches and they are looking fine.
>>
>> I don't get this patch however.
>>
>> On 7/18/24 4:46 AM, AlvinZhou wrote:
>>> From: AlvinZhou <alvinzhou@mxic.com.tw>
>>>
>>> Adding Manufacture ID 0xC2 in last of ID table because of
>>> Octal Flash need manufacturer fixup for enabling/disabling
>>> Octal DTR mode.
>>>
>>> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
>>> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
>>> ---
>>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>>> index f039819a5252..1a8ccebdfe0e 100644
>>> --- a/drivers/mtd/spi-nor/macronix.c
>>> +++ b/drivers/mtd/spi-nor/macronix.c
>>> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>>>               .name = "mx25l3255e",
>>>               .size = SZ_4M,
>>>               .no_sfdp_flags = SECT_4K,
>>> -     }
>>> +     },
>>> +     /* Need the manufacturer fixups, Keep this last */
>>> +     { .id = SNOR_ID(0xc2) }
>>>  };
>>>
>>
>> Could you please elaborate why you need just the manufacturer id here? I
>> would have expected to see a specific flash entry instead.
> 
> Grateful to Michael for the valuable suggestion. This addition of the
> Macronix manufacturer ID enables the fixup functions such as
> macronix_nor_set_octal_dtr to be executed without the need to
> create separate ID entries for each Octal DTR NOR Flash in the
> flash_info.
> 

Ah, nice. Okay then. I'm going to review the rest of the patches. They
look promising ;).

