Return-Path: <linux-spi+bounces-10804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D912C03ED3
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 02:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E1134EBB42
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951B2AE8E;
	Fri, 24 Oct 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Ra456RKt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C242F5B
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264250; cv=none; b=hOkUoRz/a9LqYnytyzjxitSCL4ZPnZbbDCmeqgdmW0UUW5+NZ2vCgOqazJ6Ljy6L0P+g/g+EOK9bPAk9ffVhl3X/qxnxw+tj9WQszizmL6IL+ViJBrq3lORDK9VBoghq0LB8JpCf4lUkarqvuHyEiI+S1Q5FDA8/lI9Q2L/MATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264250; c=relaxed/simple;
	bh=PQewqef8yzvtBnGMpEYxHFkLVWv3yesJZz1LSiXZ7bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnM4e3argzNC7X4ZUE2BXdq4gf6w91hdaAeF+vLIar70tyJFbj0+ZZsiGm4kTJBGcSUPiGTOrstgG5j9rnBcXWQmmTZHwtNl4oy8JFWFzwLy99+JjSsSOickjfjsRq5u1ru9iiV2YrtaaChUxcuPaQbhUWO4Wk1g90IjcIUgbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Ra456RKt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2697899a202so19858235ad.0
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264248; x=1761869048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iB+cZBHLCpSws7+7BlwrY++97OnOWh6DYfkP9FhnwvQ=;
        b=Ra456RKt+p87Z+5ies0CTv89TWrQCPK7lbWxIH0eBhWlxEnqI4yBsK1BqumB6uL2I5
         VYsgSukp1FYWJQ8A344agSKJbQeP1SJjZRthEALNXkloajZ6BcW1a9EMPPGYxMcMMFSY
         2lqHI1byB2VO8Dk7gnrw5yzkAKTaE3tCltY7in3UTsx4vnIXHKVhC368bdmBZoLgQamh
         T///7SWmLfFO6nx4pG9SQq2ypMQ6urUiKZroSmdCkF5hteRz1vzBv6R0mmY1BnA8thiO
         AYVY2KD1jDKqWJVyqV2UzG4kRqBTVfwoh+v1TeZZMNvi2bPDX1lStqQmLyzEYTpk8AjO
         La1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264248; x=1761869048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB+cZBHLCpSws7+7BlwrY++97OnOWh6DYfkP9FhnwvQ=;
        b=KR/w6Zwdaea3HJFzegYYV8NIxESn8e9C6bWMLn+uZ3OM9PP2KnSRzoU49FUeHfug6G
         u9V7ZR4cxS/LQf7ub9zPRw43T/5MvxzOgpA37c2DD+Y3OzUTBG49SQ/M6EzyauWV7LeK
         PrIbzNxxSTfcHVI/r6pMjQjuin8/dv5T63sUvY7PTqlFL1OcsRYWB6XVsj6SUnG161yG
         eTWRZpQkpCSK5aa2WyHszyAFWw4EXCjiLV4mBfRdTlUI8FWfShcXwcwHdtMGB7lpo8a2
         rQfwxFKQwU2X2VQoiL8pC4JYyVZMbL3KOBCarfR93h/1ZToBL0bnWFLdMO79BmpyR1Xm
         RCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcmWzMCjyDzSZPrBn5hngdYmwGfwWxMQQsfyWL+VbyLXmXRAFuCz8brzDisp1wvOFaZgbJNT7SrME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9/okMadJWRJSJitlxXH776c0Xrf7RVEhqQydrwDZGO7XirvS
	3NkdE+qT0ajfkJ0G1aPyWPjlRxD+xYgQgkwGslmTERSilskyude2pSALhEgAzypXMaY=
X-Gm-Gg: ASbGnctkWkwcXYMSLQDW/+NonkM3Zc7Z5tsUOJhHDS6mZdC+A6oR4pzCEP3EZs6ifyU
	yQ38I7kNJSdoc6FalQbh8T2kVSsGTVIX+gJ1zUs4v/NXiAYhx1leb2O3vs92bGkHtW/qU17RJXL
	4XDD/OfCfy6i2qrMuzvI76FCBz1dOM3WC1fRDTZvo/RwC8dqV/p8+pdO1jOzJAVYGphBs9oJVWu
	XxGOMm/Zr5jR8piZvCjmn4yFHb2U0cdev9Gw0d9SuKhx3gEs/ZG1gfkAmd1RdDlxycwcmBN4AZJ
	kMxlRrMqut+U/G39TvkwRRyGgeBI4dO6/ItgWjDsd+dBH7s1iEkqoStSszDUEjz5cbiOBo2s2iA
	/x2eOWgd/LqJCQHoAeu96eAsSg1AvzbPGpYXf3QU4oX1qCny/tUWcoedWgeIzHdbpotv/remjN/
	w8T08/Sf/IXuWxpXZS
X-Google-Smtp-Source: AGHT+IG1GOEsittfwiwfypAgRO1bXivhphlMMbLL2fhQ3i2Er7Mu9kpHhxTrXPCZNYaEGYBC76LFsA==
X-Received: by 2002:a17:902:ef4e:b0:290:d8f0:60be with SMTP id d9443c01a7336-29489e70291mr8426785ad.30.1761264248064;
        Thu, 23 Oct 2025 17:04:08 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:07 -0700 (PDT)
Message-ID: <aea95912-9f06-4a3c-897b-d985c18e89e8@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:06 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] spi: fsl-qspi: switch predicates to bool
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-5-elder@riscstar.com>
 <aPq7ZnKrxbokwHxP@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq7ZnKrxbokwHxP@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:33 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:16PM -0500, Alex Elder wrote:
>> Change all the needs_*() functions so they are no longer inline, and return
>> bool rather than int.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - New patch: predicates now return bool type and drop inline
>>
>>    patch (patch 4).
>>   drivers/spi/spi-fsl-qspi.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 1e27647dd2a09..1944e63169d36 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -276,34 +276,34 @@ struct fsl_qspi {
>>   	u32 memmap_phy;
>>   };
>>
>> -static inline int needs_swap_endian(struct fsl_qspi *q)
>> +static bool needs_swap_endian(struct fsl_qspi *q)
> 
> why drop inline, and next patch needs_disable_clk() have inline.

That was a mistake.  I intend to drop inline on all of them.
Will fix.

					-Alex

> 
> Frank
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
>>   }
>>
>> -static inline int needs_4x_clock(struct fsl_qspi *q)
>> +static bool needs_4x_clock(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK);
>>   }
>>
>> -static inline int needs_fill_txfifo(struct fsl_qspi *q)
>> +static bool needs_fill_txfifo(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890);
>>   }
>>
>> -static inline int needs_wakeup_wait_mode(struct fsl_qspi *q)
>> +static bool needs_wakeup_wait_mode(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618);
>>   }
>>
>> -static inline int needs_amba_base_offset(struct fsl_qspi *q)
>> +static bool needs_amba_base_offset(struct fsl_qspi *q)
>>   {
>>   	return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL);
>>   }
>>
>> -static inline int needs_tdh_setting(struct fsl_qspi *q)
>> +static bool needs_tdh_setting(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>>   }
>>
>>   /*
>> --
>> 2.43.0
>>


