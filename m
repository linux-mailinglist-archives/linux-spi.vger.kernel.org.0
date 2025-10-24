Return-Path: <linux-spi+bounces-10808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D93C03EEB
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 02:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26324EED2E
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 00:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20AE1A23A5;
	Fri, 24 Oct 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="spUunLUU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CF4A3C
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264265; cv=none; b=RTmFEvKZY6T97/75pfNXyxd6DrKlFzVhmPMCDCztfisTK9Bgks9yihUqIZA7sIHIVQCabu7gKTAHMPHVK3EXOvYXJmrj2/ThjBx5dgjwlgYATocTQm5nXLiY/gwJiLye06awufKK8UDlQFsVS9W/ZBRfDx3VVdbVG65uJUyrqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264265; c=relaxed/simple;
	bh=ceWD1KwcWrkZhyx2DZAU3kYVDAav9FmdCMppa5vbOco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUT9F5VRdVRCXZ8XgrVKyIJSATH71fppM4EU4Wgz60IG9jbERmeUFWtNRQXqR712OkRediwSDzlMA5VC39dIkOxKAyzEKB/03JUayYHIThNDgwj4huasfQutJPQr6yMMk/QmWm+t4DTXP8SDpCdW8U6Hcjui55ckDZGFbpzBAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=spUunLUU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b62e7221351so1227135a12.1
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264263; x=1761869063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qjw6GkWiRFtO3Gl0DgzCouuS1/pA0eKo+XSbrrk/AhI=;
        b=spUunLUUUp7D/IVJd23jbdde85ncZByujDolU8ssb2lbpNnysiE52W8ynnMLcPdGlW
         RDwkC67D71LFeLLUnqPwQPaB/P8ujiBB1CyMSBgGQ4rHEzqkAJQ4AuT6YfSmzYttZfQF
         jkhdqooT40v/QbqIs5ZgrrjG4wDPEEi/zfOU691tKZFBdCCf3zs+wsDy5yvWoQUMJ/YL
         Aj9doqjuN3nrfasW1SfKNg7RDanyjOtnx4PJj+wIvaYg1OL5Y7TcDQewNH9/hPSKjoHD
         p3kn1/RY+f4BFH+z9uCwPZ+RuSmtE9c9eydaxdFOWzZJABka0BDPRe0lRqtM8+ICeUgp
         5i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264263; x=1761869063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjw6GkWiRFtO3Gl0DgzCouuS1/pA0eKo+XSbrrk/AhI=;
        b=lZBSF+dQMJWHNQ2Sl9dDovljGv8g1/rtalCxzxPq0pX05Vat3fBATHiJ8WbOoxw7dm
         oM3VBEH2+WhyRA9tVu3O9Fflcl4RYDm1g7PyWqXPr4TcBtABNKVwz2cj3JGSPM5qcEvE
         hRWSfQ1fUbIjMpi0PTExx6Yt3G9zxNZoSkGN37EZeKUTjgycqCxTGRYq8FolXpB0+caG
         hspcT7w9XHOiNVMdCn0RA5+ZXSbDBJpEo/wcb7oT6CJP4TNOfUL+/p0AlgZy000g1QJI
         ob6MTh5ZLZkseAGkWDqQIXVQje41PQyJt2rAjBk2FXOfO3mBsvStZ/zo+sVLm74elYKD
         jfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdeiqn2jxyKmPmmV0iIDqVP0GKpx5KmeTNDwuE+bWKUInMSuZ0jQ8koOPXKdnM0bQSDlfyaHE3mco=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZj6xtt0ji9v0V04q3/ezCh1zE5ue/DfWrA/sNg13dmepNo3T
	n+gIk+TvJWG2GQiEQsrMPMcw+aQQaMCoPT1EVTeSGcvRE2do9m6T4cgZZ5Nh2xbmJco=
X-Gm-Gg: ASbGncs4BRWgVa4hqgTlnkjm6lz1lUMrOSaivLIYSH8eASRfqDIsTVQlzXccMNtMimg
	392p3DiUF4wssTpcxDyXFf5GHw8bBjtPLEmJEmtJBk4rGYAK8Y23e8cU0arzEce7Eq6E0licBv7
	FxlfF1fJRGHT8AQndrQ3idBafR5MNDvZMcGWAja3psPXTf/EdLB9gLUkFNE+wG50n2vKGDhkS5M
	5TRQHrH4PKQS0q1IrF+FSEsWupHZ3pZZ1U4Qh1aAVwEmUjfSghyP3eZGjhhleNJSIM7FlP7wbA2
	N8QGQKaDzr+LVI/b3QS5gtfGoClviXEiqJAmkzrYFAPCMd4+igGXS5uhBXu8/xb15mzQuDT8Hfu
	C2ZoLGdAGglu9Qmmox5W30XsJUSyIPmAJHBtSkpc3896uVNRQ6w1SQXf3ga1bgcbAPFZ8dWLTO8
	6y9tpMoTksWR+STwoT
X-Google-Smtp-Source: AGHT+IEVlzxGRMXWgrP8LOTMF8F9hRbegGiF7+NmjpjW9vsaNPPeuDl5n70FEErCCNUHIH/8Cpl0Uw==
X-Received: by 2002:a05:6a20:e212:b0:334:a4dd:cd09 with SMTP id adf61e73a8af0-334a85341bbmr37585340637.10.1761264262970;
        Thu, 23 Oct 2025 17:04:22 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:22 -0700 (PDT)
Message-ID: <f1da325a-af36-4759-b3e6-6b0a4e9eb13c@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:22 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
To: Frank Li <Frank.li@nxp.com>
Cc: broonie@kernel.org, han.xu@nxp.com, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-8-elder@riscstar.com>
 <aPq9LHwtALpsOIwz@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq9LHwtALpsOIwz@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:41 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:19PM -0500, Alex Elder wrote:
>> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if ARCH_SPACEMIT
>> enabled.
>>
>> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver by
>> defining the device type data for its QSPI implementation.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - A continued line the Kconfig file is now aligned
>>
>>   drivers/spi/Kconfig        |  3 ++-
>>   drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 4d8f00c850c14..592d46c9998bb 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>>
>>   config SPI_FSL_QUADSPI
>>   	tristate "Freescale QSPI controller"
>> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
>> +		   ARCH_SPACEMIT || COMPILE_TEST
>>   	depends on HAS_IOMEM
>>   	help
>>   	  This enables support for the Quad SPI controller in master mode.
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index a474d1b341b6a..d4b007e8172b2 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -268,6 +268,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>>   	.little_endian = true,
>>   };
>>
>> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
>> +	.rxfifo = SZ_128,
>> +	.txfifo = SZ_256,
>> +	.ahb_buf_size = SZ_512,
>> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
>> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
>> +	.little_endian = true,
> 
> did you test your code? miss set sfa_size here.

I confessed earlier I did not, and I'm very sorry about that.
No future version will be sent until it's all tested.

					-Alex
> 
> Frank
> 
>> +};
>> +
>>   struct fsl_qspi {
>>   	void __iomem *iobase;
>>   	void __iomem *ahb_addr;
>> @@ -1003,6 +1012,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>>   	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>>   	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>>   	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
>> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
>> --
>> 2.43.0
>>


