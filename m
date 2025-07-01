Return-Path: <linux-spi+bounces-8947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EFEAEFDB6
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364A31884B0D
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE46277C81;
	Tue,  1 Jul 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+vYhc5o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150972749ED
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382541; cv=none; b=K3pdyB6y0xwWcAzZ7KYMAoBiImoz/Efbldod/W9hbBUveRcwPvmP1SRTOI2fBy6Tyf6zs1rIYG1tlY8JQ20sJxkm4F8+bv7BEYkunYqa6JRjSAvFrCvrYWjA6W1F0E5KmOAE7+c+8GC59CP9CpIhkbXPPp1am/xRNkQsk2APiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382541; c=relaxed/simple;
	bh=LygfmcVRSaPOsa8+C2yvEY4RHbClFgk/DP5RCPz6doI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n25eiAzECgsskvkwQ/mhGtjCyDGqJ8ihPyn9BFEU8p0qObDd9ZY5o83GVMgIAeO0RITDndb5POmJ0Pyh7V4chn7dQl0jajRN+1F5gD/9Sfr5r2kTs7uNZmXpIooy3AYBk75VF++lrbA9XP/JXTVNQqhcVOmZmIGYgVwtCu/toj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+vYhc5o; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54690d369so3259976f8f.3
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751382537; x=1751987337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4YWJf36Jd5Za5bEQzBkDardDPxHz8Phk46tA5vnrP8=;
        b=W+vYhc5osgB1C+JsA78GrYBitNA6wsPzWZ1MhQdFSbxx3qWlE4+Uz++VRGa3YZUV2E
         pbKB1Col7IkY8/DxlpSBihFe18/Fz9p+tk5B+x3eOzR1m1jkCMtPkopCaIAoMbOdcl2H
         uq6HcJ9VyjwhB9mv4zOObYXvEEj1PLcPUHCAqn2KWgE5LqtX1SLVBUa2w3FpOkHOIpBt
         YBLBNaVUUd50rw2KR8QujGlE2ngY9ZP9yY07ALPdZa5pErakq2S3FVGa86eZgma571U0
         MqlVIt8oDiDDVGzb9xEBJ2tp+cRSy5hTQ3jpZrZ6wu+UEhRClRW2YKqr7xWj7VZe0GG6
         aSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382537; x=1751987337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4YWJf36Jd5Za5bEQzBkDardDPxHz8Phk46tA5vnrP8=;
        b=DiNduLth/LvQPocHwK7kYqXtpdfJyIx070Pv9RnGYd1PyYSgWVhhKlSQWSe0SZckQr
         DvNCU+A+2oWrL+AM6yAfcfdf5ZVq5dKRzHODjMo2YpvSG9JLfmtlO6u2zuTCSjPHBGRm
         2DBjwGnOTEdYqWX5nIE/AfrE908SC3kbPf4BdUD9xktvHBcTeVmqGA2DKegDtyfCH5wL
         5KTv/G8BEAWniuA1UnRxsWHbQnSbnFMV12QiuXAExPoO8pjynhWX+zBhvVJ/piNvW7ju
         csePLLCsyDyfFMsmQHmgQmdtt6yeCs6ALE/E0j9AR/bQq9TAE6SSzcFJsqIu80SMktrK
         51UA==
X-Forwarded-Encrypted: i=1; AJvYcCXuYTAa5U5iyCX8X75xAq2FPf1IVPTaOpkgA9HiaaxdZaFx5NvvavS94HrTm3iITSfhmlIdW35w75Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspJ9qQ1bGFIbHFwWtLUZCWsRFEicCScm4eS5FZZvstnKYjD8s
	cKlC3XLvpYJl4E0N3KKaIVQY+IleU3I4R4IbRJKsBBQ2JkbVXwri2UF9LhtW8aDqkUc=
X-Gm-Gg: ASbGncsDWopAcP8jcdHPY/YZijKpMSMcjZebNL1FkQwsVCSOmE79WVD9/QAwEVIYqoI
	QaRSRaq+30bJIGQl9i8R2V1cBmqWr8XxrtmQUpI4ssiibkMCfhyzFB8BO/E23FOymzGEqL9lHX9
	ksm59U6uB18+PrNGZBKDAQUSvo1xzq46O0QhKtmJb6w52cMxqX8eupQYkj77rQXto+9ZG41Zm+i
	zdlNNV5yJ7KDdG6Iacu9pMdP2SlTzwczINLwGbnWo+QkYwdjlIDgiWUthgsIs8+NLlRUo6j90ho
	HblgAUvvZ8S1PCzC6LLkXv7l7oOmQqWoZKaJo+LPUpzuBR71weE4GxfZNdCURPfXRpE=
X-Google-Smtp-Source: AGHT+IEbIjn4wdPBC/r5LoH/ZIV7Nx4cdgbX0q9FVgHuQEdOsmJoG9kbU5u7jAyd+uqc2CbplXsd9Q==
X-Received: by 2002:a05:6000:440f:b0:3a3:6595:9209 with SMTP id ffacd0b85a97d-3a8fdeffb3emr9901767f8f.36.1751382536969;
        Tue, 01 Jul 2025 08:08:56 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a87e947431sm13537193f8f.0.2025.07.01.08.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:08:56 -0700 (PDT)
Message-ID: <019e182b-2830-4325-8c85-19041afd40f4@linaro.org>
Date: Tue, 1 Jul 2025 16:08:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] spi: spi-fsl-dspi: Increase DMA buffer size
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
 <20250701144711.hfcgk7hhk5w4jmvf@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250701144711.hfcgk7hhk5w4jmvf@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2025 3:47 pm, Vladimir Oltean wrote:
> On Fri, Jun 27, 2025 at 11:21:41AM +0100, James Clark wrote:
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index e7856f9c9440..46d3cae9efed 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -493,6 +493,39 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
>>   	return cmd << 16 | data;
>>   }
>>   
>> +static int dspi_dma_bufsize(struct fsl_dspi *dspi)
>> +{
>> +	if (spi_controller_is_target(dspi->ctlr)) {
>> +		/*
>> +		 * In target mode we have to be ready to receive the maximum
>> +		 * that can possibly be transferred at once by EDMA without any
>> +		 * FIFO underflows. This is CITER * SSIZE, where SSIZE is a max
>> +		 * of 4 when transferring to a peripheral.
>> +		 */
>> +		return GENMASK(14, 0) * DMA_SLAVE_BUSWIDTH_4_BYTES;
> 
> Is this really a constant that can be hardcoded? Should this be queried
> from the EDMA driver somehow?
> 
> I'm not well versed in the dmaengine/dma-mapping API at all, but I see
> fsl_edma_probe() makes a call to dma_set_max_seg_size(), which consumer
> drivers such as DSPI can query using dma_get_max_seg_size(). To the
> untrained eye, and from a great distance, it looks like the value you're
> interested in. Apologies if that isn't the case.
> 

You're probably right, and there's no particular reason to hard code it 
if it can be queried. I'll have a look at this.

>> +	}
>> +
>> +	return PAGE_SIZE;
>> +}
> 
> The other question is: what's fundamentally different between the host
> and target operating modes, such that we return different values? Why
> not the same?

This is missing from the commit message, but the reason is because it's 
a large allocation (256K with both tx and rx buffers) that should be 
avoided unless absolutely necessary so we wanted to limit it to only 
target devices.

The other reason to not allocate it dynamically based on the size of the 
message is because we assumed that it was better to do large contiguous 
allocations at boot time. If it's delayed until the device is used then 
the allocation might fail due to memory fragmentation.


