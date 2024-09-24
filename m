Return-Path: <linux-spi+bounces-4941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08098983DB7
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A77FB233B0
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1312C544;
	Tue, 24 Sep 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GisfYX3B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370C1448DC
	for <linux-spi@vger.kernel.org>; Tue, 24 Sep 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162252; cv=none; b=UxHU6n6CY+06vNSE1h5HU7I5a/P4Tx3+Gv1ptCEZhtFt9YtaMN1XIIEUwYHVh0IqztUIAEHbhZkWF1eMDNU+UKGTKXCmCKlEmE3zCFcNjBSN8by2bskw8EGvkW8ZpRkxT2iawe5FHDOaaxciOppk8Yi/ZeDvce8VK169ixHj/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162252; c=relaxed/simple;
	bh=bRAvfOb88mqhRhXnBxTTbylscfuGQFLmSZLP8MqeiaE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I3Cqo6G3GvmW4/NYLncxCL7IIhEMYlqaq18yqdXlocFyOzTlXg9wt+3W45xzq+eMSXmaJ3LdZ7uE072XEm7pTWB2A/7GP3qDnO76GxWz07IE4Axczms4K8XUuijP7u+XXLOQm75xTbwnzt+UPBijibpw9FrYqWGN6WlITt/Dhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GisfYX3B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so51701515e9.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Sep 2024 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727162249; x=1727767049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=je3cqWSYer77yEubCNKAdoGpIIKvbkuX5RJOi++fMR0=;
        b=GisfYX3BAEnfQwJQ+ZiwwPiGs5Koscx1RhlwSRwFjC6cKWNgXJ909WHiyCG+1I/wPH
         AKe0A65/nJSniKEoA+tpMjlCetTb1+aLPK5UDmh6MfHZO2FDSWt2snYHW8EM7YHpjySc
         wq5nztGFSOBO2pxIf3+Cbl2pp721oVJpd2owkhN48qKjltvJwps1Ds+96phqRwrPiDtH
         jHecqp3XbjapzzyiFr7UigCF7UESlxHIiEkh8m2JhnTDN7NLs4ZxSaa3lZKpqYtRQS1o
         pyje2/iLL4kt/nTyQOIpOB73iKp737Y++0hXsnyTdJ1jay1H/ifEIAvfSEHX45TGywc1
         I22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727162249; x=1727767049;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je3cqWSYer77yEubCNKAdoGpIIKvbkuX5RJOi++fMR0=;
        b=jqhMRBDuXcQq0ATupSD0bp22+aANISkWmo7H7csVXQZHIkqd9Cp/KmZXkT6mDHWFpZ
         9pcvkraNSmawh8xUKmH8IryBwZbNLU+HPpyZkIQW8K6K5c2LavHMK/hVqJcmCHlVJstX
         +vxGiRsvMo7uOlg0cZzJwQMYAoQJ66u/XtxQvgiWLY4qgxAMmofmqlfN2KGZVtAZIav8
         GHMgOtHyjx1qqz6WLBt2AFZIR3Sy9wuj0O/2pyeeZBfytLOH7qEI/v5KnUFNJw5Hc13h
         5LFk8k2fMxbt/9I+iqvEej7qA5pechnZv7VwzOPTteSYMssXTn0DaUpC4vYKi8CKWMEB
         w6HA==
X-Forwarded-Encrypted: i=1; AJvYcCUTBHCrpvdS0LB9P5LHbCTZA2WMJMclkOz6js5PCFqHhJtsagPMppfhGZiH7V8O9nuse895ovwmAEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxairRdBEcaxnNxtrFDvC26ZDt6IHds2syCkUs1mhEJffxji0Au
	u0PKK0ygdn/TLEGWHJwNw26E1fsmZQ8+aTFQPz50cFhiN4zj/Gc0rTfYf+gW4eE=
X-Google-Smtp-Source: AGHT+IFn3k7mkPSmRC3eeu9UzsnDrRRDgq+BPkVZJpkFWFDCdEc479FolGZTOf6O5SCCYMyFII7RsA==
X-Received: by 2002:a05:600c:1913:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42e7c19bba1mr106144965e9.25.1727162249062;
        Tue, 24 Sep 2024 00:17:29 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e90298f14sm12365895e9.19.2024.09.24.00.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:17:28 -0700 (PDT)
Message-ID: <79406f2b-8411-4059-b959-9e543944fb9c@linaro.org>
Date: Tue, 24 Sep 2024 08:17:26 +0100
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
 <618e4514-791b-4a73-a1ba-45170a21e453@linaro.org>
Content-Language: en-US
In-Reply-To: <618e4514-791b-4a73-a1ba-45170a21e453@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/24 7:36 AM, Tudor Ambarus wrote:
> 
> 
> On 9/24/24 7:26 AM, Tudor Ambarus wrote:
>>
>>
>> On 9/24/24 4:25 AM, Alvin Zhou wrote:
>>> Hi Tudor,
>>>
>>> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2024年9月23日 週一 下午2:54寫道：
>>>>
>>>> Hi, Alvin,
>>>>
>>>> I quickly skimmed over the previous 5 patches and they are looking fine.
>>>>
>>>> I don't get this patch however.
>>>>
>>>> On 7/18/24 4:46 AM, AlvinZhou wrote:
>>>>> From: AlvinZhou <alvinzhou@mxic.com.tw>
>>>>>
>>>>> Adding Manufacture ID 0xC2 in last of ID table because of
>>>>> Octal Flash need manufacturer fixup for enabling/disabling
>>>>> Octal DTR mode.
>>>>>
>>>>> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
>>>>> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
>>>>> ---
>>>>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>>>>> index f039819a5252..1a8ccebdfe0e 100644
>>>>> --- a/drivers/mtd/spi-nor/macronix.c
>>>>> +++ b/drivers/mtd/spi-nor/macronix.c
>>>>> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>>>>>               .name = "mx25l3255e",
>>>>>               .size = SZ_4M,
>>>>>               .no_sfdp_flags = SECT_4K,
>>>>> -     }
>>>>> +     },
>>>>> +     /* Need the manufacturer fixups, Keep this last */
>>>>> +     { .id = SNOR_ID(0xc2) }
>>>>>  };
>>>>>
>>>>
>>>> Could you please elaborate why you need just the manufacturer id here? I
>>>> would have expected to see a specific flash entry instead.
>>>
>>> Grateful to Michael for the valuable suggestion. This addition of the
>>> Macronix manufacturer ID enables the fixup functions such as
>>> macronix_nor_set_octal_dtr to be executed without the need to
>>> create separate ID entries for each Octal DTR NOR Flash in the
>>> flash_info.
>>>
>>
>> Ah, nice. Okay then. I'm going to review the rest of the patches. They
>> look promising ;).
> 
> ah, but then you'll always have a matched ID, so you break the generic
> flash probing for macronix. Is that correct?

Answering myself: it's fine. Generic flash probe just fills a name,
which we don't really care about.

