Return-Path: <linux-spi+bounces-8586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB87CADB11D
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923ED169A24
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92663292B39;
	Mon, 16 Jun 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGvaPTJb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63552292B48
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079223; cv=none; b=GO5VNtKwetFIVuTCPR64CITzvEmBWcB5LQ1wWrAhJu1+fqnomDYB85Uh4D1Pwb+BXnu26wi4RWMkTHpvPg2JMKwezlV4Qpac3G4bCGjiorb+99K2XfmXMNqgHj1kLRUWFamAoVBGXXNakxX4xvJnXT+09vrtIjVZLXqvWNvG6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079223; c=relaxed/simple;
	bh=ee/RwBi8FKq9VtJWA9MlNDaZc7H3g32sL1jjfJsCjaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmTidbKTBD01JDXMqfOyaFgN2FnUp4E8TejNzrJMTB0mAcyUTyLPQb5I1qPNbNVdK8GPhL1yDhSGL34VYpenVagi6rmjhp6zIB4maerrbhvQ/zkS0IR6fsNeAoS3KW66F4yuubdbD50cW7H4K/8VSSmOlF9NPRDixCqlzSd7Klc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IGvaPTJb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so22594785e9.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750079220; x=1750684020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvG8EvOBERndyafhh0R3gUvPVZ3AkVSl0zI3A6MAIiE=;
        b=IGvaPTJbwpudoSi+/srk0DY/kALkjaRG+1gfCnA9Z9NiHpoD+kY6qy2cU0fV5ASl5H
         QlfSyQpWFlZZakYAGQ9bM4pWEsBGii7trWwJ/gKl8Z/JudYguLkG0j5Rr3wydEUOiY4i
         YCWLZrbF5soTVvn5bkPKBlFWKWnTMDcm1SCksLhZVHXXN4G2YkhM+UjcwvXZOYlH+znJ
         8Lu5HHmQ6Ws0AI04o27R6a4x1HGTr1yfczNGaDa05GfHtav3DV3f2rIrQxJ8Zuh/nBhr
         nRzYuYN5hx/WyKHUh9r0S1jaiXeCH3TJZ3bqSm6lTNiYIbRq1jDe+5892bv43dYednCf
         ncSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079220; x=1750684020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvG8EvOBERndyafhh0R3gUvPVZ3AkVSl0zI3A6MAIiE=;
        b=FGoqYv9P7nwpKaz7EbxlG3UN2Yp8wfVUvMo/gzesvOJWIjA+KB7AkmytbfsmC9KTUc
         ucX/R03J7w3nc04hn0SLU9usMiIzfLyZPrehVllv3kkgFYDIutHVk6POsMQOogVLHC4F
         8/2W65O5NTaZQm0N41zqCjfgmIcQzkIJ+OkD8Pg2Y/pbhbSHRHG6EAxIbtHwS2Jf5lHM
         WHskprvrJ7YhB/A+7fGbA2TuQbui6+3+ek3IqLDlUAWhMAlIWxeTooaZxRRnGI1bEM4U
         waTYqHqJlnDX+bdiDER+3+2e7gaIfixmiPjXj/xYGMg586P5Za/fAtZsj6PG2ewmn2Gr
         uB7g==
X-Forwarded-Encrypted: i=1; AJvYcCVSz4Zu1KuQgEbL8UxrZ+CqHVEIxCX3ljXBWAcfmJRnMaubCe/VevcDuugMwXRhYYb1PAsKq1l8hlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4TsIkBCV3FGE1OI0cP9mMk+9yOWDRnmWwo4Xd9dPUfJ8c7eR
	UazJ+Y4MNnOO4MFy/z2xWei+1gMvvJKRsh7aS2wZLtNEZAw0EnwrlSIPk0GONLCWn4U=
X-Gm-Gg: ASbGnctFhQdTgRCghjKylB6QUZiZP3h1N2skGEhUZnKg4LvUvEr79miNaRI9poCF2bo
	mBa+JdPQwqHFZCMbqD6qJUfezcvl3MovMQBmWrXFlcxlo9bLrdldP34KoZlzrcWm/bUT9JKTQLp
	Ocqr7llS370mOuZ6aXC3OLU1HulVhcKVNsiOXqguRUq5FH0+WgNpnX2oHFyGxA5YDijNAShgb+S
	JHEKSwPuudQf8IhKuy+pScnEaik+wqchFFvUDuUYB3Dio5mXvJcPhD4Npfd+AHZXoTfcWfXT2AN
	7ZvUkTlM5bglk4d1P6zLh3EKWx+MkYkolDOOwEuSXZCQyoG4k4hhtqcUzWfGdY8pShc=
X-Google-Smtp-Source: AGHT+IG90jrm0/YmUPPNZ3DkrXfamsqfYyknv5iOIGHsAtWVD7TaDVkBdpDcbQNvCeQ9SbB64y/LyQ==
X-Received: by 2002:a05:600c:1ca1:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-4533cacf2d1mr70512635e9.1.1750079219441;
        Mon, 16 Jun 2025 06:06:59 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2384cesm142172555e9.16.2025.06.16.06.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:06:59 -0700 (PDT)
Message-ID: <a0291b82-5441-421b-9338-eef26d72544e@linaro.org>
Date: Mon, 16 Jun 2025 14:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Robin Murphy <robin.murphy@arm.com>, Vladimir Oltean <olteanv@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
 <20250613-james-nxp-spi-dma-v2-2-017eecf24aab@linaro.org>
 <adbbfc9c-5d21-4c8f-ba71-ae1103569037@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <adbbfc9c-5d21-4c8f-ba71-ae1103569037@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/06/2025 12:56 pm, Robin Murphy wrote:
> On 2025-06-13 10:28 am, James Clark wrote:
>> Using coherent memory here isn't functionally necessary. Because the
>> change to use non-coherent memory isn't overly complex and only a few
>> synchronization points are required, we might as well do it while fixing
>> up some other DMA issues.
> 
> If it doesn't need coherent memory then does the driver really need to 
> do its own bounce-buffering at all? Could you not simplify the whole lot 
> even more by getting rid of {tx,rx}_dma_buf altogether and relying on 
> the SPI core helpers to DMA-map the messages in-place?
> 
> Thanks,
> Robin.
> 

In this case the device needs a control word to be written into the 
buffer for every SPI word to be sent, so it didn't fit into what was in 
the core layer. But we did look into doing it that way.

James

>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-dspi.c | 55 ++++++++++++++++++++++++++++ 
>> +-----------------
>>   1 file changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index 744dfc561db2..f19404e10c92 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -379,6 +379,11 @@ static bool is_s32g_dspi(struct fsl_dspi *data)
>>              data->devtype_data == &devtype_data[S32G_TARGET];
>>   }
>> +static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
>> +{
>> +    return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +}
>> +
>>   static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
>>   {
>>       switch (dspi->oper_word_size) {
>> @@ -493,7 +498,10 @@ static void dspi_tx_dma_callback(void *arg)
>>   {
>>       struct fsl_dspi *dspi = arg;
>>       struct fsl_dspi_dma *dma = dspi->dma;
>> +    struct device *dev = &dspi->pdev->dev;
>> +    dma_sync_single_for_cpu(dev, dma->tx_dma_phys,
>> +                dspi_dma_transfer_size(dspi), DMA_TO_DEVICE);
>>       complete(&dma->cmd_tx_complete);
>>   }
>> @@ -501,9 +509,13 @@ static void dspi_rx_dma_callback(void *arg)
>>   {
>>       struct fsl_dspi *dspi = arg;
>>       struct fsl_dspi_dma *dma = dspi->dma;
>> +    struct device *dev = &dspi->pdev->dev;
>>       int i;
>>       if (dspi->rx) {
>> +        dma_sync_single_for_cpu(dev, dma->rx_dma_phys,
>> +                    dspi_dma_transfer_size(dspi),
>> +                    DMA_FROM_DEVICE);
>>           for (i = 0; i < dspi->words_in_flight; i++)
>>               dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
>>       }
>> @@ -513,6 +525,7 @@ static void dspi_rx_dma_callback(void *arg)
>>   static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>   {
>> +    size_t size = dspi_dma_transfer_size(dspi);
>>       struct device *dev = &dspi->pdev->dev;
>>       struct fsl_dspi_dma *dma = dspi->dma;
>>       int time_left;
>> @@ -521,10 +534,9 @@ static int dspi_next_xfer_dma_submit(struct 
>> fsl_dspi *dspi)
>>       for (i = 0; i < dspi->words_in_flight; i++)
>>           dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
>> +    dma_sync_single_for_device(dev, dma->tx_dma_phys, size, 
>> DMA_TO_DEVICE);
>>       dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
>> -                    dma->tx_dma_phys,
>> -                    dspi->words_in_flight *
>> -                    DMA_SLAVE_BUSWIDTH_4_BYTES,
>> +                    dma->tx_dma_phys, size,
>>                       DMA_MEM_TO_DEV,
>>                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>       if (!dma->tx_desc) {
>> @@ -539,10 +551,10 @@ static int dspi_next_xfer_dma_submit(struct 
>> fsl_dspi *dspi)
>>           return -EINVAL;
>>       }
>> +    dma_sync_single_for_device(dev, dma->rx_dma_phys, size,
>> +                   DMA_FROM_DEVICE);
>>       dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
>> -                    dma->rx_dma_phys,
>> -                    dspi->words_in_flight *
>> -                    DMA_SLAVE_BUSWIDTH_4_BYTES,
>> +                    dma->rx_dma_phys, size,
>>                       DMA_DEV_TO_MEM,
>>                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>       if (!dma->rx_desc) {
>> @@ -644,17 +656,17 @@ static int dspi_request_dma(struct fsl_dspi 
>> *dspi, phys_addr_t phy_addr)
>>           goto err_tx_channel;
>>       }
>> -    dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
>> -                         dma_bufsize, &dma->tx_dma_phys,
>> -                         GFP_KERNEL);
>> +    dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
>> +                        dma_bufsize, &dma->tx_dma_phys,
>> +                        DMA_TO_DEVICE, GFP_KERNEL);
>>       if (!dma->tx_dma_buf) {
>>           ret = -ENOMEM;
>>           goto err_tx_dma_buf;
>>       }
>> -    dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
>> -                         dma_bufsize, &dma->rx_dma_phys,
>> -                         GFP_KERNEL);
>> +    dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
>> +                        dma_bufsize, &dma->rx_dma_phys,
>> +                        DMA_FROM_DEVICE, GFP_KERNEL);
>>       if (!dma->rx_dma_buf) {
>>           ret = -ENOMEM;
>>           goto err_rx_dma_buf;
>> @@ -689,11 +701,12 @@ static int dspi_request_dma(struct fsl_dspi 
>> *dspi, phys_addr_t phy_addr)
>>       return 0;
>>   err_slave_config:
>> -    dma_free_coherent(dma->chan_rx->device->dev,
>> -              dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
>> +    dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
>> +                 dma->rx_dma_buf, dma->rx_dma_phys,
>> +                 DMA_FROM_DEVICE);
>>   err_rx_dma_buf:
>> -    dma_free_coherent(dma->chan_tx->device->dev,
>> -              dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
>> +    dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
>> +                 dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
>>   err_tx_dma_buf:
>>       dma_release_channel(dma->chan_tx);
>>   err_tx_channel:
>> @@ -714,14 +727,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
>>           return;
>>       if (dma->chan_tx) {
>> -        dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
>> -                  dma->tx_dma_buf, dma->tx_dma_phys);
>> +        dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
>> +                     dma->tx_dma_buf, dma->tx_dma_phys,
>> +                     DMA_TO_DEVICE);
>>           dma_release_channel(dma->chan_tx);
>>       }
>>       if (dma->chan_rx) {
>> -        dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
>> -                  dma->rx_dma_buf, dma->rx_dma_phys);
>> +        dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
>> +                     dma->rx_dma_buf, dma->rx_dma_phys,
>> +                     DMA_FROM_DEVICE);
>>           dma_release_channel(dma->chan_rx);
>>       }
>>   }
>>
> 


