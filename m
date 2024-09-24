Return-Path: <linux-spi+bounces-4940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC27983D35
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 08:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76505283364
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7C17BBF;
	Tue, 24 Sep 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wekq3CxY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006B13FEE
	for <linux-spi@vger.kernel.org>; Tue, 24 Sep 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159778; cv=none; b=n3uT/K+wL4YM9YDSu5iVEu37zNxAtLOJpxBdNxDXOkCaXnL5dHt4CRAsJnlnzr5jXf35VkInnhgao9IsAf+oEhQeqJtQGdE+J7/9o2fkztyfL3p5+H6rIbHsQ5+ZlUfuxnWsIc4XLXkGGijSsvVFrXaD+TwRwXA1eBo4a4KBDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159778; c=relaxed/simple;
	bh=0yaVP4jAEOdfCuKEmNDzhPvKU2bMPvbasd5+pyVnSSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EH9knczgJn+MugKTx9aeVnWT3cPwEhfMj5iESpeUoTchBNjv8v5xvX7H9QRer0URd7OyqPv6t3xcqkmPauMAW6euic9Hx8j5CK9cmyyJaNV40PklwsGCiQ8yAYWPfB2vxD/pcP1newsIV7lBoysamkeOIwim/I0uawLLSxCpXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wekq3CxY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so49410655e9.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727159774; x=1727764574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5O9hi7/yXg+YxoIrnEDuOK7KeUqbocdowl5jauyzj8=;
        b=Wekq3CxYB6jHm/0ZPMGfPlRP1xPqVBG4/+MzPcMyFD7R/Kb3qeJkIdzOqcbmlVOWrL
         BH7V7Nogg0MQUZOARS2av6m4r6YRjFpg/pxnwUKMvv1UXoEz4SIOVqtwWBmlEt5nX30s
         nU/dxmtSu2gM4wtARazBb0LDZ6hwixmLtWv/vZpwmsswnyAH2FvT20NifCUam7KWMgXL
         iJY9fd5WHprWhF80IxnSXJ++W64aIMprfNAkCXRnAc/3Cssa8+tKXqociqIKrN4RhRGD
         endSot6ZT7ncjAHO76+HNrJ4Z9xQBlSsYfLk6SSya10MAC0v7F8mbWpS7Auo76muD9di
         qE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727159774; x=1727764574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5O9hi7/yXg+YxoIrnEDuOK7KeUqbocdowl5jauyzj8=;
        b=r1v8W+lqvwMB1TuqKTHLXtKaWCF5P/mxX2BchMmbaZUo4w54lTiW9FeN+aqp2LPhnB
         b9gTfVlff2qeZS1ylwvK0RE6+jjYBp0g3gJ0+m1e51YkF9VFHpPzepon5NUZxTumol6H
         W3Hnoxx4Hfb2ryKA/XQfZqqd1zAFm8KO7+jWZI9Zq3XaXB/Q3k3TnGPfO7Z8gyGDUByS
         odD9ScMa6PWIdPuV5bk3+zoGO+gYAkGgWKiGrnyLKV15VQ1WQgx8Hw6+/NF0S/y4wfqO
         pf5wGOjhoKDi3N/bedmXU1RxEotapIqC3F4+8WI1AWFLxq4fkaptQ1UIYt4Wjnz32e39
         eySw==
X-Forwarded-Encrypted: i=1; AJvYcCXWH3yG+wDJooU3NoXWWsTx2Kl12u9WtcrjWl7+5nv9O5LNkaWHVDSAg25VX8uxFSYh3YGQjjnTOeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05sEDwGT5glaI4CGMa9SMsQX3tlVcW4NDXlD9GGWDu9A/UaRj
	l8AwqoM2WQohI0/ZPGbPirx5vYE7Rs7THFGIHxLvwS6yWebu5S1bLReRNUNgmwA=
X-Google-Smtp-Source: AGHT+IH5FhoHbJ9IDBbAUP30tScNk63Y9tGAEtEwCMUDmUad60Ilu2dLIg4b9hx0dvztT+6CqWGaog==
X-Received: by 2002:a05:600c:1ca2:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-42e7abf43c3mr102426065e9.10.1727159774479;
        Mon, 23 Sep 2024 23:36:14 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9811sm710709f8f.86.2024.09.23.23.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 23:36:13 -0700 (PDT)
Message-ID: <618e4514-791b-4a73-a1ba-45170a21e453@linaro.org>
Date: Tue, 24 Sep 2024 07:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
From: Tudor Ambarus <tudor.ambarus@linaro.org>
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
 <368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org>
Content-Language: en-US
In-Reply-To: <368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/24 7:26 AM, Tudor Ambarus wrote:
> 
> 
> On 9/24/24 4:25 AM, Alvin Zhou wrote:
>> Hi Tudor,
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2024年9月23日 週一 下午2:54寫道：
>>>
>>> Hi, Alvin,
>>>
>>> I quickly skimmed over the previous 5 patches and they are looking fine.
>>>
>>> I don't get this patch however.
>>>
>>> On 7/18/24 4:46 AM, AlvinZhou wrote:
>>>> From: AlvinZhou <alvinzhou@mxic.com.tw>
>>>>
>>>> Adding Manufacture ID 0xC2 in last of ID table because of
>>>> Octal Flash need manufacturer fixup for enabling/disabling
>>>> Octal DTR mode.
>>>>
>>>> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
>>>> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
>>>> ---
>>>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>>>> index f039819a5252..1a8ccebdfe0e 100644
>>>> --- a/drivers/mtd/spi-nor/macronix.c
>>>> +++ b/drivers/mtd/spi-nor/macronix.c
>>>> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>>>>               .name = "mx25l3255e",
>>>>               .size = SZ_4M,
>>>>               .no_sfdp_flags = SECT_4K,
>>>> -     }
>>>> +     },
>>>> +     /* Need the manufacturer fixups, Keep this last */
>>>> +     { .id = SNOR_ID(0xc2) }
>>>>  };
>>>>
>>>
>>> Could you please elaborate why you need just the manufacturer id here? I
>>> would have expected to see a specific flash entry instead.
>>
>> Grateful to Michael for the valuable suggestion. This addition of the
>> Macronix manufacturer ID enables the fixup functions such as
>> macronix_nor_set_octal_dtr to be executed without the need to
>> create separate ID entries for each Octal DTR NOR Flash in the
>> flash_info.
>>
> 
> Ah, nice. Okay then. I'm going to review the rest of the patches. They
> look promising ;).

ah, but then you'll always have a matched ID, so you break the generic
flash probing for macronix. Is that correct?

