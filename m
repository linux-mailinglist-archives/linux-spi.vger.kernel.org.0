Return-Path: <linux-spi+bounces-10771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E64BF9F3D
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 06:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3477919C2AA4
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7D2D978B;
	Wed, 22 Oct 2025 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gnBDGDz9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921842D9499
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107672; cv=none; b=m2hsK3pCZn5D36ZMu9rOfzyh1kfWPIVe2NiBqLAd05eItvOWWLSIL4iqiVAGr1LdGa9eDW/3nFduPF4cTokQ0/7GPH4qJMB/vIIEm1HEGi1rK6FKnirSdw1ZwAWORof7BN/0eZtwmuV6YUQJutOgHaUGmDDcQdNzrf9SRiIOUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107672; c=relaxed/simple;
	bh=Goyx1DuFl/fOnbQXpijC04VlfkeSYrobSs3FUEza79w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJonQq+e2FffK+5CuETD4EGzJLKNWTt3qsW280jkmiDKoEM1ewciGU9kNDC4t/XWmL1XvE5kscmzlrajl5947si3V2MVfcKytQ3T0zCCoO1f6yZjf4Vf38jLIp82HwA2EqidYU8aaoEECV9aRxgwkGZOCZH5C7bt1+ZcWzyCW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gnBDGDz9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so5698959a12.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 21:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107670; x=1761712470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDiGuotIxX46vya9PSPOnNWB7duItx5Jd361PWPn4+w=;
        b=gnBDGDz92BzY9Xf8L9luYAk431jG9f8kAbslyXTVcqrK3jXeN3GBulVMam0QacRV4g
         epN05+WR7Aqdtkz8ydyZi6rF6vUEsgzD1fICPQOkJJYCK9dW70rNpJTjM7GUcGHGFcH/
         r4hr2Cv88L8Ak27Okvh3rkeX81e8Su4OqyBQmmeCkQjhdJzLEevN4YYiHoSNt4r65Gm+
         09NSRXIS7MwcOESvskN86Yn3OFMvg3RaxNR3jbMl07InJ1rKkOlbTwVt+Ugg6iVYEuv7
         20QysUeaMGlKFfDpjCguoEowxThQsBuULM6B5vhmQrlWwg0QjY1nWTweJTfDXxKc7iad
         6m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107670; x=1761712470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDiGuotIxX46vya9PSPOnNWB7duItx5Jd361PWPn4+w=;
        b=ereBeSft+qshb8EAKetbj7gu05Y+X5ofnTFjW/n/z5GgevWMk7CE62lV3nxJ8G2laE
         8ScpY0g/dzsghJ5PY6jKfOdtykpu04DOjFULa8W/DgLTXM1ev/imPWKMEZZHAxjUvP18
         D54Mtp/Ed+kwGaOVoiwhM3G92LlAtGwodyGfiO6nOw2sI/njZCLaH0kt8BHoEX+KT+Bk
         mDiyaVRe0708QWGlR1epxMsRDmaELFRs4dkuBRf5k4072YXXH1+FvyzE9SzVhjLq/f2D
         Wuqfo4RIzPXQYHPakPZf9VlswmMgMiqeRl99j6QNfoS0rlx+9ziVGi+Xp7ZLMovzHFTG
         u1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCRDyTYj+q8ww+hemHZv6CiBP62xsNZy1ZwdIjATShebIkJiDRRQ5CqpXNLqCMDDISOy+tf/gqbfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzlczNy6igq8Jzod4yOrsAqczcuCSMF+aTJSk1ey58K5tTteX
	JvWBcMlQac+Tc+8QYsklkQ7+gQ71oEKtRb4vGEKP/FNhcOPa+P4SIRZ9dfYTA8sITFA=
X-Gm-Gg: ASbGncu4bBwmt5BA8m14H450BHyg/atfPuwBRvGKfd75s7T5xsUQYYAMZNkPK45NF/m
	zFvEeXkdfWzHHCOhREVa4aL0P2vTt+RCb7h83agP6ICaFGBHqvA0pAbKEM941ccJaUjhWxo+idZ
	DdIf+DauQ537d4Hnn6udp++vxihejnVFjfXUuSSS5EPFWqhieuSMaAvRqdfxt5w9YtX1gA/ryGo
	8SdyMCCl26SGPG21beFlD/UyXqXxGbX43EX/d300iHVVCwhwUgfTffOUtFm8tJEbj5i3tPPFhfF
	n7opmfDNY4lZ2shHtNrodIT3Qw9O8z13iKMXDxyPpRhBrsR+LAEO6Vanr2wWaYWQ/tCs+Yl6fIW
	/Ze9sjh4LuBvBB0d6tC9KWeFa7jtKaz6Yhudwda+eZg9k16gaqN60OElvuCGwJcAj3hjrdayLWs
	QwRF1GbxiY/eV27+w3UlToQKKMH7wf0GF4qw==
X-Google-Smtp-Source: AGHT+IFAmBZDikILCClmp+7vVKcnj+i3LKl9ZiDVNdmnt9krXWJ4kKo97aK6dBcsuheQDKRB7IIDbw==
X-Received: by 2002:a17:902:e784:b0:292:39b4:e785 with SMTP id d9443c01a7336-29239b4e9cemr216223575ad.26.1761107669783;
        Tue, 21 Oct 2025 21:34:29 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:29 -0700 (PDT)
Message-ID: <91bd83c0-c721-41aa-9716-a750b73c7e41@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:28 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] spi: fsl-qspi: support the SpacemiT K1 SoC
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-7-elder@riscstar.com>
 <aPaML32I0Ao1xhpX@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaML32I0Ao1xhpX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:23 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:49AM -0500, Alex Elder wrote:
>> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if
>> ARCH_SPACEMIT enabled.
>>
>> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver
>> by defining the device type data for its QSPI implementation.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/Kconfig        |  3 ++-
>>   drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 4d8f00c850c14..2e3d8bd06ceb2 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>>
>>   config SPI_FSL_QUADSPI
>>   	tristate "Freescale QSPI controller"
>> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
>> +			ARCH_SPACEMIT || COMPILE_TEST
> 		   ^
> 		   align to here

OK.  I was mimicking what I saw on the only other instances of
a continued line in the file, SPI_BCM_QSPI.

					-Alex

> 
> Frank
> 
>>   	depends on HAS_IOMEM
>>   	help
>>   	  This enables support for the Quad SPI controller in master mode.
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 9ecb756b33dba..f4f9cf127d3fe 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -267,6 +267,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>>   	.little_endian = true,
>>   };
>>
>> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
>> +	.rxfifo = SZ_128,
>> +	.txfifo = SZ_256,
>> +	.ahb_buf_size = SZ_512,
>> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
>> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_NO_CLK_DISABLE,
>> +	.little_endian = true,
>> +};
>> +
>>   struct fsl_qspi {
>>   	void __iomem *iobase;
>>   	void __iomem *ahb_addr;
>> @@ -998,6 +1007,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>>   	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>>   	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>>   	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
>> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
>> --
>> 2.48.1
>>


