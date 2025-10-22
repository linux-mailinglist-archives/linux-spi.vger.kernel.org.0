Return-Path: <linux-spi+bounces-10769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB5BF9F31
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 06:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4A914E2F2E
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF92D8375;
	Wed, 22 Oct 2025 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="RRDW9RU7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154842D7DE5
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107666; cv=none; b=IDF/Y0+HyOkWjSmIq+oPwTTb6PLtrCow21jodidcEJwpbU05OsgZ7fbgv9c//Y1z3AZpqKYeAFCWGITZ58wkcf2IiTDCuE+gnWCCVtHcKb+S8PqDRkI/4WtY57fEZp+trxbo8QggkJ0oLP8S4EwyKxdtm21WkIdInTN5kN0Yqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107666; c=relaxed/simple;
	bh=M0//wu4eodGM73UzE+/RSQN3dfA7ycS4x9S8XdOl3lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqhldhkalW/+xBIHGMwaftIl2BUFHAtrBEkwDt1IdikmhfHakRIf4woSRWiNkpFDCspZg6BChshYaGWjRm0HVsUYLAB8pF5CGaSa/BfpM3fFY3Mk/CnRrYoa0g64rQIjAZ7ppUHY0o+Fc2ER2ACTAjg2aJRhDmlKtCq9p/Xh8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=RRDW9RU7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290b48e09a7so76851635ad.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107664; x=1761712464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EssM+PiDmpcGAGhJSWtJ6fJ+4b18HXlZ45HuXkPg0+A=;
        b=RRDW9RU7laJZmotdYwqR2m9vMwxpOoZhDjjRrTxfpvoceparqP8yt9dy6aDGl4Q2Lo
         MgtMpUfcsfZHPpecLRfUL+Q2xr9tMVwBuC6wRRQ9LeIGO1/C60zWBO+DEBWfyX3WuwRI
         iTvi2q0p03ObVjo8iJgDJQMcEX0r2vK6PexfYRCn7Cu+ELm9v9ErffEqJyTOzf+6Kvlz
         8gMfbjdwWVfnvLGPcTUA8HbvxKj8WJOnToTGRv6CN+Pqnh3pur5Ks8fkdA9giLSdzyu7
         boo1MqqIcd+va3CFmsVIEXkBMAuso/NgRFC32llsNpO0Rpe8zD7FRv0u1cEcc4G6wjSK
         75IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107664; x=1761712464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EssM+PiDmpcGAGhJSWtJ6fJ+4b18HXlZ45HuXkPg0+A=;
        b=pmcq8jmgykTIgIMHxFSaBRnt/mdLeqHfk6QA0/eD0SN5Alq1n0akuvjFgLqL2ZrTHt
         66oSkB1LakptWeyNLx4T561YBAtV5CLf9JRE25UilBfzIUQDc5qfnYaR3UUgtyIFmKOR
         ztWD96ue3PFyqMQQCRACT9EU2QTWtiw8Fk9kOmaI71aSVcHxKcvs8ps1JwG61YplAZbx
         G7wKgEnsLHhtPRQJL2XU/ab4juckxcv0r8cUnBaaYKWiS3717JpYej6cuOuLi8Nurbxe
         +mOL97uaVNOdvqEtEcXvmYnTMLWmJ79wfZczDRi5jtwt+gmR3/rzp2kT/gyxq/M3o20L
         Qsvw==
X-Forwarded-Encrypted: i=1; AJvYcCUPeVUdnuqo5cNbbPAzgsjJZnQVvGA/4bqlEykTdnI8nIxoTLOJMn/ZFIViBTbge2IAiAJ7HHoqmsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBptHJ2UtZyByPXggm6BrRTL/I3QYbQhIUMfLOGPPpBl5ut5YO
	YVQkqXi89zYjV5lWi+Fw1MZ0pwGCzAU9ByK6zrKSR5GgyZmleWQEbZESlXXB0gjI0Ac=
X-Gm-Gg: ASbGnctgemVQyO8lWYNNUFO2kLSaujMwLErYy7qm4aIVPBZrVfDaEMZKtaQI1N8M22D
	x2G1Pn2TYX3MSBgp1yaF+QzW4J1+4kfVmYnoSd8WrVup/kYquDt0BoHXcItgSK1czAerBM9cdXK
	D3gtPq+9GaHmdem4jqrRfCE0VjUjM1xcLX58ct8wiK4qQ/tuCRrDlU3MalyCmzOwTV7nApi1r2M
	+7ypJP8eaDXiEZx2VciW9kOHMLFAIX91/aXcnpz5hCCxj9eLDsflYmV5WTB1F4t4HL8uP5z+8CC
	L0ATXYy+B4jjo0nD0D9rFEMGsuWEZWU9ylVZRdnJuObvwJm04e5QFYlpaFsk0cH1gyzZh/tQ5wG
	9hDrS04b/04finek0AKhI0H8Won5tAUJ0SGWNj1KkBdkm08hW/mucX3mc4l/cUD18EFQAusxD3m
	IU4nU5GhxYc6Se
X-Google-Smtp-Source: AGHT+IF+2IOi2vlkb7frAQI7xnO/+5ggSuzSXcXZ4DCJ3RIWA9BMWmGP9exglnUcXrvVgUWfIgCoyg==
X-Received: by 2002:a17:903:228f:b0:24c:ea17:e322 with SMTP id d9443c01a7336-290c9c89cbemr234187615ad.3.1761107664444;
        Tue, 21 Oct 2025 21:34:24 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:24 -0700 (PDT)
Message-ID: <d13590f1-937d-4ef6-8d2f-d0647557b695@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:23 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] spi: fsl-qspi: add a clock disable quirk
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-5-elder@riscstar.com>
 <aPaJ479zH/90fJ2d@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaJ479zH/90fJ2d@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:13 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:47AM -0500, Alex Elder wrote:
>> The SpacemiT K1 SoC QSPI implementation needs to avoid shutting
>> off the clock when changing its rate.  Add a new quirk to indicate
>> the clock should not be disabled/enabled when changing its rate
>> for operations.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 1e27647dd2a09..703a7df394c00 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -197,6 +197,11 @@
>>    */
>>   #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
>>
>> +/*
>> + * Do not disable the "qspi" clock when changing its rate.
>> + */
>> +#define QUADSPI_QUIRK_NO_CLK_DISABLE	BIT(6)
> 
> NO_CLK_DISALBE look likes not clk disable capability. Maybe
> 
> QUADSPI_QUIRK_SKIP_CLK_DISABLE

OK, that's better.

> 
>> +
>>   struct fsl_qspi_devtype_data {
>>   	unsigned int rxfifo;
>>   	unsigned int txfifo;
>> @@ -306,6 +311,11 @@ static inline int needs_tdh_setting(struct fsl_qspi *q)
>>   	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
>>   }
>>
>> +static inline int needs_clk_disable(struct fsl_qspi *q)
> 
> bool type?

Yes I agree with this suggestion.  However all of the other
needs_*() functions return int and are marked inline (neither
of which I would normally do).

You want me to add a patch to update the others too?  If I
do that it will look more like this:

static bool needs_swap_endian(struct fsl_qspi *q)
{
         return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
}


					-Alex

> 
> Frank
> 
>> +{
>> +	return !(q->devtype_data->quirks & QUADSPI_QUIRK_NO_CLK_DISABLE);
>> +}
>> +
>>   /*
>>    * An IC bug makes it necessary to rearrange the 32-bit data.
>>    * Later chips, such as IMX6SLX, have fixed this bug.
>> @@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>>   	if (needs_4x_clock(q))
>>   		rate *= 4;
>>
>> -	fsl_qspi_clk_disable_unprep(q);
>> +	if (needs_clk_disable(q))
>> +		fsl_qspi_clk_disable_unprep(q);
>>
>>   	ret = clk_set_rate(q->clk, rate);
>>   	if (ret)
>>   		return;
>>
>> -	ret = fsl_qspi_clk_prep_enable(q);
>> -	if (ret)
>> -		return;
>> +	if (needs_clk_disable(q)) {
>> +		ret = fsl_qspi_clk_prep_enable(q);
>> +		if (ret)
>> +			return;
>> +	}
>>
>>   	q->selected = spi_get_chipselect(spi, 0);
>>
>> --
>> 2.48.1
>>


