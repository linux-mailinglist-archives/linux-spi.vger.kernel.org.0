Return-Path: <linux-spi+bounces-10807-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A8C03EE5
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 02:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEF1AA3017
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B7199237;
	Fri, 24 Oct 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="BEppYB+d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545718A6A7
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264262; cv=none; b=qdCmZvfwg6ggT4oChNN0giVXXGuiYZ3fPqeU3qG8qNWgLUrWvh8xWXVv0TFTcnogzpMZVeyrBYVmEVqkJErVo9IKF5O3s9rXK2F+Xhjsl7iYddDlwWjI1M6Q6icBAtizFdpritS5vMpPG3X1aTJdUIIKmQvExydvAV/SQWk9rIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264262; c=relaxed/simple;
	bh=dcbemmyeeMmTnjiRx8pMVuxWJgKXnilUcIcodBpT8G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSKelI/QsI7czql6D2yWyWdeoB5uNUHrpih28LQVbj3BoW3g0d7y1bc1cmin81igb5zU/KSBQCIUn9styWO7j7n+X3W8sMKdQoVcJmT8LT/t4ec8Qsny0Y9KYl18xC/vo5zzOJ4XAayf15NmA/sLxb2y0e4YXPFHYQWYUaYW1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=BEppYB+d; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so1409377a91.3
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264260; x=1761869060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+K9cJwbaPRk/hXgfMNgGGaWCdBEf3vNiXBdImnfxaI=;
        b=BEppYB+dZR/HQkBHf02ZH4zQzKbxMtB1UqBZrsoNFDa6n4UpcsNp2viYtufYTl1MxU
         FoKSUJTxDvCiMgyaV+yw90wnnI7sYU8a0mv7oFu+tBVZy/RQaFKoOEVBiIEOVbiUpUtQ
         HQ5UTFJWtvMv0ecWbMpZOicbK2fzVsbTIXNMhBYfknpORadqGMmQ+MO1vjg3UcFYyAFg
         TEfqw5QAhDCirUCm7i9PFsHpUVv0s7AdDyz/J5gXfg8NHi23bUwTAtKZWqDkn3tySzui
         DT/TfLSRHkA26kky+scX8WSZO/LrOuEtiCUUXiXGB66lTsbxMeF6DenwJ2mqKzKiyqsN
         /XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264260; x=1761869060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+K9cJwbaPRk/hXgfMNgGGaWCdBEf3vNiXBdImnfxaI=;
        b=quk1o8lhoYsiaySqu3Lj3SmzM5Nm0WwFWKFmNqr9AMDVdYyppVr7u5SBNGqEggwu9L
         oVcpM3gG/s2zh2vewLZygan9fpJvXTeEfKgNWxYqi5xW8LaG8OIshf+8zeTfuR/ft0ns
         jfjWHY9IKASBq1QiyyV3oZothTYGZbW4cELotSsK3JuNMB+6VmTYpjV0CF2352q2H03d
         SIBNfJNxN8pYNG5LMLCgAmjtAYvwAqGEfQCyq30nqYayZQAVFlsxkfMYOaEF/XvY8TE1
         deJfOFitXRxggtSHEtWjhhCezc8kiJzbKOasm+eFB+eqWRH1AXSZPNWNW33Hj4EFxma4
         UgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRRz2g6FyHFhE4af2S4tn4AB+UpQQtn9IxwczMgKLq+e8vvPAbvZPh5cMpIPtWNz6OBmgheKdp6BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcxnmkOZDCIvE5g6sCExUtKxll5YKCm7dBd4StPZKMdw4BIMk
	vzfi3NbFv+lhDjqdEjyZ7r8BYYYrAQCFpv7AlAScZq+yvKmJzL4hGP7IKV0tbt0YvEAduFHFBbZ
	dJ3Q3iEs=
X-Gm-Gg: ASbGnctrn6oM8vB2yu84JxjP8JT5zcUymwJgtD9F+VOfcewmMbgSDToTX6LNW129yph
	pyirutWEgw9sGSRfWN3jt/K7VrewJ79lJmCh2BlrFKmEtFoRvFCjbKkJmrVBEofw4Pt5OxEMTfd
	n54Yd5rQ3qdsQ6dkSwul732zv4OPT/D1wvNjQamhFn5bU+jnfQI5gshxjJrhyBzGzkCL9rMMgIL
	KmcGzupPyH88ZCDdEkLRxDDsg6y17zpntMWnphbVc3QL8Is5md6PqAEe2pGy6YsCHVRfWjgVR/H
	AWUQxND4q0W2pnSMLPYwcoZM2xxH//nVudpL4zyIr50OGT6odhPH/kS3GBbVgTgIKC3Yw02mWvz
	WmNS4Yr9jgksqgkjQAmAjdxmpYERXXXttvnukO+3UtivlTm09/7Q3XGZeRGH1TV0T3uuvKUWAey
	eEgVmtEYMsnacKAu3WX35CoVM2Nbs=
X-Google-Smtp-Source: AGHT+IE6HvbwvsCvQ5Cwmi6yqRRJUHyh9wrThsLz6Rz6ydecgfWWPWXRIw3RN/OVaQzDTAtqVvVBTg==
X-Received: by 2002:a17:90b:2247:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-33bcf8e5f10mr34441928a91.22.1761264259653;
        Thu, 23 Oct 2025 17:04:19 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:19 -0700 (PDT)
Message-ID: <f1a77da8-edf9-4e14-a7f9-01680f60fce6@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:18 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
To: "han.xu" <han.xu@nxp.com>
Cc: broonie@kernel.org, dlan@gentoo.org, Frank.li@nxp.com,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-8-elder@riscstar.com>
 <20251023195615.ke4rjhlgrxiavv6r@cozumel>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251023195615.ke4rjhlgrxiavv6r@cozumel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 2:56 PM, han.xu wrote:
> On 25/10/23 12:59PM, Alex Elder wrote:
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
> 
> Do you need to set the new sfa_size here for multiples of 1KB requirement?

Wow, yes.  I'm very sorry, I shouldn't have sent this series
out so soon.  I'm not at home and am not using my normal
development machine.  But importantly I admit to not testing
this on the target hardware before sending.

I won't do that again.

					-Alex

> 
>> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
>> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
>> +	.little_endian = true,
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


