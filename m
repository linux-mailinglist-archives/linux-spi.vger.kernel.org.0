Return-Path: <linux-spi+bounces-8303-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6496AC445E
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 22:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D7B7AAF38
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 20:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F0202C3E;
	Mon, 26 May 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzAd6JFm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7931A254C;
	Mon, 26 May 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290881; cv=none; b=uXUz+Wi3/9d4t5oc8kZtT0dR1tjJeUwbUZD3jxg2tXZK2ot68/GXa/PUGYOWHtedcu5N8RFU44k9kVNfRMtCigPp+50q+B+1NJYibOFQH8PujiMxEmg0IvH1b5Udsw6S5LbPAftCQ9xtLroQXOrkYi5C2sv/qrkhaKQKZq22PPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290881; c=relaxed/simple;
	bh=DiOBEVzKNYx/PQXlHnGjwbjjkHwfjQ25vTPBhozmAJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b67EVXqWo5OUuMbO241VQzkzeIXMQNSQC0xVZdH6ZN+oCPZCqHpyURqvEX9Vd5U+H4+kYns5/zRNW1K9tweDCjYoWR2+KMS10FeyGWfjgcLlARnb9ExBZNM36qZa1ZNlJbfpnHklWnOpB5RJQqEALrHaI0cl+PhLqycbT8J2VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzAd6JFm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604e2a2f200so1411960a12.1;
        Mon, 26 May 2025 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748290878; x=1748895678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwGwL1R5+A9nxd4dy8PEerX4QLjdTorOtvO+bIuw+fc=;
        b=OzAd6JFmY5fMnhZfnHuTQcpOMIYBUSTq3JNejdLdAAu+USx0Up7QXXq7NxS8g1lNJ4
         GuNR5k43N3Va32CUMhc8r6rlvQq2snZOLPyWTCMfym/Q8DC1laZnI6Jt4eOh8tde/akb
         DUucm2kZUKM9/m1ywPFT0UfLF3L2kqdBBQGJvKa9YnZN6aKB9hfIw1k5LPgSP1SBJjpP
         kSORaR7myGO51lMMGV3gAcrhjNfSV64Ts4nt6HOrFmSWoC+cxJJ/LzGZ+dzO6u5nxoVb
         fCpjddHL0uZaPUuzmW2iKqXorere+c4JonbDUSRlLxdi/xptrcsJ6PVMP24vv7k6DOgl
         FPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748290878; x=1748895678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwGwL1R5+A9nxd4dy8PEerX4QLjdTorOtvO+bIuw+fc=;
        b=l35zQhJpCXC/FLDgG2/YNZKpJzVvLZcZmJOJGvDT3F6SNY/eDAHmV552+0IqUGDLIx
         pparQpDn6FTPZQWyFjmmi1S+CMDMYiYgNEaYo4WHr3LzcryAmf7H9/hB0N/VS6JmsrgU
         9apn5nwe2ExT+MUPaVRDJK3tA1bg3mXujQaQdygcgbJX3NVtVMAG3gJ8qBY4lCF61xAQ
         y+GvHWe6rqU/TLFHHGpQAolzWwrr+ZrybPvCmWxb4cJGxEJVJjUOsWMWgIk/kgOEqSdE
         9j6SnlpI33FAbYQFGoqfsAPmOyClSLlgwhtZviXnHbccd1pmha8YBCvEnq9rJYZvJNCI
         cf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUhysCSyxxMaU6BTqJ+UG8CTO/dXpn1xRv7aN5nl8BpRL5f5j6XhdhEG//lNiVNedeA702js2+L82L6@vger.kernel.org, AJvYcCVg4SfCsjRySVSqDZt1H//LMtpXnIRhcgRHEj4FFhkzkEoyvob0Il1iO2DzzcURO3t5aS2R5zFdF0meIVhO@vger.kernel.org, AJvYcCWntxR5r0fGwlJmWwFWaFYeUW2QKwRfzqypPidRJ8PWoF47KpJILt5y+gnymyumpV2voD2pyQ14p/L9obqt@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVyk5zy5G3+PljYonQANsQ+TdbLnv14hUrhkRvwW2RORIEYgt
	yAcHkC31bSk9D6VzU+e6Bh6Y155j6c12Bc5ThiqpXW8gdPth1fk4PAyW
X-Gm-Gg: ASbGncsO4C3rIKuw75mC+gR0DTF5qxgTVUd65vRwvZrT5/VCFzUp76kBF/9758YyYDv
	9GrHQtAsfXqhqrsHKxLO1/DydHyqw2v+hooeBqJk7n6MwCA0EOjlw7pV3y8Q2hzgUGwyMUiLqGR
	49A1HX8koKK9Vjradr1ffTqrdrGDDMbfgHBWOpSvEcKRO66/GoFoWn66vrtvxyY1lqc3+J4r2Tk
	SoIVjdJBzANPwMnY1T23cC8VscUNzK8d5aBkaKmXhw/KTQm9zdbb7DVqCXHUKjgdeo6RhvjeHxr
	bgDG5tb69G9k8VoBHoAq9vjoEcVPhalvZqqBbD5V/iWzMIOQSfldssX1fjkQvOTeRnZK73zFLN8
	/ry0f+iiqgQHridLY
X-Google-Smtp-Source: AGHT+IGe6juV60a5hMqsQdI23XueeHzJAlXhlZuR9Lhudg3mhmRAjYN4WPw3YGPkaSEDDtLe84BGSw==
X-Received: by 2002:a17:907:3da8:b0:ad2:53fc:a876 with SMTP id a640c23a62f3a-ad85b1c3ae0mr983862366b.31.1748290878121;
        Mon, 26 May 2025 13:21:18 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6045e3917d3sm3160590a12.71.2025.05.26.13.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 13:21:17 -0700 (PDT)
Message-ID: <c73a0d7d-5618-4e57-af70-1d25ab38a7ad@gmail.com>
Date: Mon, 26 May 2025 22:21:17 +0200
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
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
 <87cybv2032.fsf@bootlin.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87cybv2032.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miquel,

[...]
>> ---
>> Preferably, this should go in via the SPI tree along with the previous
>> patch. It is not a strict requirement though, in the case it gets
>> included separately through the mtd tree it reveals the bug fixed in
>> the first patch.
> 
> Sorry, didn't see that in the first place. Fine by me.

Sorry for the inconvenience. Should I add these kind of notes into the cover
letter next time?

> 
>> ---
>>  drivers/mtd/nand/qpic_common.c       | 28 ++++++++++++++++++++++++----
>>  include/linux/mtd/nand-qpic-common.h |  8 ++++++++
>>  2 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> index e0ed25b5afea9b289b767cd3d9c2d7572ed52008..fb1f81e4bdacaa3e81660a20e164926c64633513 100644
>> --- a/drivers/mtd/nand/qpic_common.c
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -15,6 +15,13 @@
>>  #include <linux/slab.h>
>>  #include <linux/mtd/nand-qpic-common.h>
>>  
>> +static inline int qcom_err_bam_array_full(struct qcom_nand_controller *nandc,
>> +					  const char *name)
>> +{
>> +	dev_err(nandc->dev, "BAM %s array is full\n", name);
>> +	return -EINVAL;
>> +}
> 
> This is rather uncommon, I don't know if it's very relevant to do
> that. Please drop this static inline function.

The purpose of the inline function is a bit similar to dev_err_probe().
It helps to standardize the error message, and it allows to print the message
and return with a value in one go.

So this kind of statement ...

	if (bam_txn->bam_ce_pos + size > bam_txn->bam_ce_nitems) {
		dev_err(nandc->dev, "BAM %s array is full\n", "CE");
		return -EINVAL;
	}

... can be simplied like this:

	if (bam_txn->bam_ce_pos + size > bam_txn->bam_ce_nitems)
		return qcom_err_bam_array_full(nandc, "CE");

The latter is cleaner for me, but no problem, I will remove that.

Regards,
Gabor

