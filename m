Return-Path: <linux-spi+bounces-8762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E42AE7E2A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00FE1890B55
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F22285C80;
	Wed, 25 Jun 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+N3SKJF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D127C863
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845148; cv=none; b=OPKlB0wbZ9+HPjandUL6GqcXfelGugSVKaNVdhL8WLyl3fWSmlPV8cAwrtrbAwFvVhyKZQue/N+AggZmO3RVxCykSyrzSA/sHlT+DVijxu1IKtqyew3K5HRLYwIOkG+XsCJRTrlyKkNo7uHszK4RAFXfdo4LEkzxTCuGxPF2u4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845148; c=relaxed/simple;
	bh=MrRga72y9s3IG9s+3PWdhvyFhlYCAnz1dBzKqnRtsvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtATED/xLbbDDLaAp5IwJVPKUiCT5aaUmPEc3Igy3Cp5hSNAPHL5HyrQ2PKSb4aSnEXCm3iZzLPUBAKGFcEReMwCeJrMO7zVSLCF8FOdvT8bXQspSpwCthFqIuXPDNlJevOYGgLKnImubwreWQHYcBVpp5Bu8Fwhm8OSHTDMOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+N3SKJF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442fda876a6so57147265e9.0
        for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750845145; x=1751449945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvynr5GPXAD7xF14LG7ABlRKJ5SF08nktafK/D9Sp4o=;
        b=Z+N3SKJFuiPHaejrVN9ql6f/eYo9opFv/34l4t2kNyVuZJoBMnnz2r80ZfEdoA7aGF
         DIptkYPQkY6kZN0bdSZ7qmNxmL39a/iO4moJUt+f+vTQYU74Au060W+0sd3pYH12oA7L
         WqbiDn2SACu1YYwbIkJ/tvlju7kWkm/bqnXrTfhXD3HoRUD23mW/PXhZREFK5dSg1yxp
         10oajCPwXJBUR45kT2ut/FjQYbCCrx68A4utXijV2vWube1lMdXXwCxknADrZiYoQZMh
         LVBjhtH0FMZsY1nDewk2b0yoV+jpgSM5C/Meek/+ZTe52ohRptW+qk0xEAg+cZpzVFra
         lt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845145; x=1751449945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvynr5GPXAD7xF14LG7ABlRKJ5SF08nktafK/D9Sp4o=;
        b=fatqCxcUKnQgPveMERxzmCWH7qBw+pHfAKNaQ/rm1BGzYeC0VIYsZ6rPj14UkI7we9
         VlK50ls3z+E8H9YZ6wFC79wTPst3UFbos9PYAE0sGvbht4QBPkrhus40B64Z6nm74qZb
         V1FavQBYtAjfktsJHXKscg/v7lgq8Gf44xchC/Xu4NqSnCW35AeKTeUaROGo8SJ167M9
         SJe4aiuglOecjAMyT1VXygTFnsr80lzvuCSIL9zAe62wXKbelAp7RJr84axdcnCnLGTd
         fBx5AoqDD9aWcfVoNOBpvv13FX2U73KKck9yv5/0fYrvrGKJt5xMctTAwDLbO757L0k6
         J0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGegQatvuCK2sLj2hS38FpMo3yIwIc25fatfoW5UmFZxUr7AWLgQnA/JaPYMGTsCc/fC4Q6M/dJiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+bCVkU/OwsaQytL3nV/rSuENZGoQfvmTI5kN8DycGYePcubQ
	fI/zixW9FsYCzkxKnc6ca8QgmA29ddW6S7NBgwi00s0H9A6IaSW7ZSlfMdYl805LaSQ=
X-Gm-Gg: ASbGncsg3IicAU9Mwn/jOIhCJDueU3f6DxRluU2ZG23WR5+OwbhH7yl9OB+zMHvhu2C
	wQjd5MYmvf3P9Zeg4PajZME7VCXFRxnhB6V370sp1iSKtdlTEkV6YO4KVBuwZ9fc5UYXvY4ZNtO
	CMasLZmn1yeEK/CrlxqDpUiqrZ3CAmXy8vmcjDrg1vlkN/kSvFppgERKo9fej6c1V29Qi9LpRlT
	owMI802fbfQAq+eXosdRDyf6oLupe1KjSprdLWaLCILF5/IOujArvL0oT8LUC1BKg9Mb/t5/X0V
	xqV2kAjzzsammYdW3NUvhZ2UItHjbhQ40aswO3exytAtXevkWVDH0/hYGRyi2Dx5QK0=
X-Google-Smtp-Source: AGHT+IGWhnH2ozWlkqt9r0oHgwgVkhzmM8aFffesqO/fLKJ2oKRNU+kDEm/CqDK4ln1Y/aAeqeYL2g==
X-Received: by 2002:a05:600c:8b70:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-45381ab1724mr20000025e9.11.1750845144979;
        Wed, 25 Jun 2025 02:52:24 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453822c3084sm15607705e9.0.2025.06.25.02.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 02:52:24 -0700 (PDT)
Message-ID: <3eddec49-f41a-4b59-972f-92693677bb7c@linaro.org>
Date: Wed, 25 Jun 2025 10:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
To: Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-1-e7d574f5f62c@linaro.org>
 <aFrLMCq6hRJj5FjI@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFrLMCq6hRJj5FjI@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2025 4:58 pm, Frank Li wrote:
> On Tue, Jun 24, 2025 at 11:35:31AM +0100, James Clark wrote:
>> In target mode, extra interrupts can be received between the end of a
>> transfer and halting the module if the host continues sending more data.
>> If the interrupt from this occurs after the reinit_completion() then the
>> completion counter is left at a non-zero value. The next unrelated
>> transfer initiated by userspace will then complete immediately without
>> waiting for the interrupt or writing to the RX buffer.
>>
>> Fix it by resetting the counter before the transfer so that lingering
>> values are cleared. This is done after clearing the FIFOs and the
>> status register but before the transfer is initiated, so no interrupts
>> should be received at this point resulting in other race conditions.
>>
>> Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-dspi.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index 04c88d090c4d..744dfc561db2 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -1122,11 +1122,19 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>   		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>>   			status = dspi_dma_xfer(dspi);
>>   		} else {
>> +			/*
>> +			 * Reset completion counter to clear any extra
>> +			 * complete()s from spurious interrupts that may have
>> +			 * happened after the last message's completion but
>> +			 * before the module was fully in stop mode.
>> +			 */
> 
> I think you change is correct. reinit_completion() should be called before
> dspi_fifo_write().
> 
> comments is quite confused. how about below comments?
> 
> /*
>   * Reinitialize the completion before transferring data to avoid the case where
>   * it might remain in the done state due to a spurious interrupt from a previous
>   * transfer. This could falsely signal that the current transfer has completed.
>   */
> 
> Frank

Will do

>> +			if (dspi->irq)
>> +				reinit_completion(&dspi->xfer_done);
>> +
>>   			dspi_fifo_write(dspi);
>>
>>   			if (dspi->irq) {
>>   				wait_for_completion(&dspi->xfer_done);
>> -				reinit_completion(&dspi->xfer_done);
>>   			} else {
>>   				do {
>>   					status = dspi_poll(dspi);
>>
>> --
>> 2.34.1
>>


