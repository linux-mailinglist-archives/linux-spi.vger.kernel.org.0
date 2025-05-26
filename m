Return-Path: <linux-spi+bounces-8302-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD2AC443B
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389FE189BAE0
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C72AD31;
	Mon, 26 May 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0NXfKpH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BA3FE7;
	Mon, 26 May 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289693; cv=none; b=IWuE11thGtWWPvbNM2vDhNlndrf1AdECewTts2OV59Rp46BPhMtNwrvwpxnFTVYNHbIPPJbSfB97sdjrZRA+BMDd/5RKpZ2iQmo5DltanJM1RgW11xvHZvPM6d22sL1eT16BxsfKh64zncY9pCuIVqrc+n35CqFA/ObN4/CNH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289693; c=relaxed/simple;
	bh=ZLJgam4FvhrtKoLyXGYOdu9eZXdCTgwzaZdbzfRj6+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgJ1IfXzCsFVqnLaZZh/5zdDYZ68aiT2hghtzAVICWgH24pme3oj1Cew8XWsKPg5vfTUertg99Bv0WjrTm/2S9e59ac2wK1MhbdkupFgGYimTYdJc80dkFsR9kWVC4AN9FOYnTmCtuYOyQ6IJDs/GijCGTlYGpXNzr5haBwgHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0NXfKpH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-602039559d8so5244824a12.1;
        Mon, 26 May 2025 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748289690; x=1748894490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5UZXlK7jyoyEbPjk1xDvrCMNiZh+VKlzRkBAGqXQcY=;
        b=A0NXfKpHBYuLum04lw10aor0FgzaCVv2p5+MCS5d3uhZUTm6Vrd/2oDtxX/7Fk5qGy
         H9vMg1/PTYGASi379LQa571bxVsdi0o6KYpXzVWngRqqsutsRkHYsvMyCBahObSs4XhM
         PUyHL+wj/g5Ky0Pm+F0KTquEHRS2vPwRII+d5NGuJ9qmJzwbYozyFpPCzFY8Q75RvoZU
         XT/OSKN44QxeKsaTSixj41u4C/HPJkNk8oB/b9fVWWc4IxfjjNrin8PAaxVKNkuQk9YL
         u+/sVgEAdNcUd/kPT4/TisPi4dYgfFzmFXFD7bKkk7kkgT1qICcZ6ZvEwd9PGiK03ma1
         6gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748289690; x=1748894490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5UZXlK7jyoyEbPjk1xDvrCMNiZh+VKlzRkBAGqXQcY=;
        b=OU2bTqNG7+2A4nkB0h3+mZ9cRA9hD8RjAvc4zJYU/TCkBC5EZvTHw6BKsIlrolMEZd
         9UqtBmiFPjy/VbS4uXeEM8jg7WdV1JchYJsD6+mXKo3ktJ8IcOrJNTh8M8eNGv/tZSBx
         J/j3jD6PObFPw9MtpYmVPEx3i6Z5cHK5f5PPDoPudonPifx6gPw89itHKPeopkzY32Lb
         pFvQv+upThjX/7iBFEOLxyHtWj8A/w47T53RfMuN5QoopqG4rDzYl2PzbrQRCDXkv0lg
         9PQVQTTd2a86UsbT7ha5n9ppUbjbhAkM+mmrOWi4m1UpUjAEuKCQ1L54c32B4hfPr8zR
         bXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeXnjwtp9YBofFpUZ73K7VX2nJB0mba6cTbdBBp+p9tCiA9Xv7LM3ZePgtg8t/sVSiy0Akm6nS3GuwHoj8@vger.kernel.org, AJvYcCWnFXpjGpM5YJe5gZPF7fAwP6QfYr4lHXPk05sffH40a3r/tg6sTq2kgAXX3w7SEQHDkx4337CNYwXjXT86@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PCdNJ/XThlpBONd1X4gHj/fL3l+fAZ5/vB62hWttOijT9A8Y
	3AqKh8Dc2y1+3L5aKedSVHRH4+VjmTW3i4Ibq44PaQ88/rRxXBBi7VRt
X-Gm-Gg: ASbGncthhRsZmrY3ByaHraPjCZRhcJW0/R9wrMtGoUrdN//fyjRUhAyUnPzYbTIf3of
	VImjs7zw8bR9oSfBkyhovbwh/m7YHcJ4kUMCVxfxxz8iKGterCy3FCouq4fECjvPNmM0JsdbSG6
	R3POSEt8w2ZRjdtpgMdKW3M6EvC2E1RbnrKxgS2U9GyhXzmfzu+JoMcJqCsajr1gWOTYbID+udb
	frfrKo9rdLZCZgAxYKp5SQJT8BPvRNbCHc/WZbeYqRp0dBYk9VFz5vCDFdQF3PfDgdX52Up9LzY
	RX8dAVEYeLo5cXxWZVDK+cYarZrx6N4Pi09rMPlUiuijoJzG61KuW0ckgmxlBTL12jfFO/xzP+m
	W1D2EnTQX7VXDbMV0
X-Google-Smtp-Source: AGHT+IG11zehgCzBXjbnF2eT+TAQneLA6ATYCudw9kas/3Q4I6BaiJNJpShUkGjOy5/EEURb6r1AaA==
X-Received: by 2002:a17:907:6d0c:b0:acf:c:22ca with SMTP id a640c23a62f3a-ad85b00b7d1mr884949166b.1.1748289689706;
        Mon, 26 May 2025 13:01:29 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04e821sm1743988166b.17.2025.05.26.13.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 13:01:29 -0700 (PDT)
Message-ID: <b9134a1d-3dbc-4cd9-b22a-90b1c8934ce9@gmail.com>
Date: Mon, 26 May 2025 22:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds access
 of BAM arrays
Content-Language: hu
To: Md Sadre Alam <quic_mdalam@quicinc.com>, Mark Brown <broonie@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
 <8ab1e48a-f698-9859-3992-6a26f63d62f1@quicinc.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <8ab1e48a-f698-9859-3992-6a26f63d62f1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 05. 26. 8:53 keltezéssel, Md Sadre Alam írta:
> Hi,
> 
> On 5/25/2025 10:35 PM, Gabor Juhos wrote:
>> The common QPIC code does not do any boundary checking when it handles
>> the command elements and scatter gater list arrays of a BAM transaction,
>> thus it allows to access out of bounds elements in those.
>>
>> Although it is the responsibility of the given driver to allocate enough
>> space for all possible BAM transaction variations, however there can be
>> mistakes in the driver code which can lead to hidden memory corruption
>> issues which are hard to debug.
>>
>> This kind of problem has been observed during testing the 'spi-qpic-snand'
>> driver. Although the driver has been fixed with a preceding patch, but it
>> still makes sense to reduce the chance of having such errors again later.
>>
>> In order to prevent such errors, change the qcom_alloc_bam_transaction()
>> function to store the number of elements of the arrays in the
>> 'bam_transaction' strucutre during allocation. Also, add sanity checks to
>> the qcom_prep_bam_dma_desc_{cmd,data}() functions to avoid using out of
>> bounds indices for the arrays.
>>
>> Tested with the 'spi-qpic-snand' driver only.
> I recommend testing this patch on both the IPQ and SDX platforms,
> as the QPIC raw NAND driver are utilized across both.
> 
> If you have access to IPQ and SDX devices with raw NAND, please proceed
> with testing on both.

Sorry, I have no SDX devices at all, and unfortunately I can't access my older
IPQ boards before next week.

> 
> Otherwise, I can handle testing on the IPQ raw NAND device and coordinate with
> Lakshmi Sowjanya D (quic_laksd@quicinc.com)
> for testing on the SDX platform.

If you could do some testing in the meantime, that would be superb.
Thanks for that in advance!

Regards,
Gabor

