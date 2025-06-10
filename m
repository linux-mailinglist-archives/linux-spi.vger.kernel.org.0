Return-Path: <linux-spi+bounces-8430-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC7AD3DD4
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 17:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36D51887C3D
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213F2376EC;
	Tue, 10 Jun 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfPE8xXl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67441204680
	for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570403; cv=none; b=u1hICKUM4ZurNiiQYPzzwzobeVY5KDWhfe1jCFGwlhn7h+4O3NP3ySfUp9VCFgZB0X0odqtW/MBulvVyUQKOr/Tqu6eKQaBo1mjYGmF7Y7Zse0O1VXOSIIeTpqxrAhuk2z+CQZx+CZhhQZOVCVPmMTckTZgKngQ+sqsMzfFCjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570403; c=relaxed/simple;
	bh=vxuw3LvYAToyp49ZgYIxDv2CDjhyjusdO5Uv/G4/WzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8kP+bPG15d+zTHX4UYxx4Xs8J3eDZl39/i7lg/+pDzzGLE73Y3YnNVdnKbTNSYrFCmznlkRX03AGYonWCpXJzRcuhadPAbWy1Z+ChMBGd0ZLxjSML6WU0fGxJVEPd3F/gJZquqe4GY05S3jV1sf4SbbBhiYRSXSNKYgVSGqW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfPE8xXl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so64717545e9.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749570399; x=1750175199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32CoWJgbTlYUzAxIBjwb0Zjs1I5TbtzzAl+WJpqHnjE=;
        b=zfPE8xXlg68vFnsgeNl6CPGLzpFrlGHPxRaNC6uJrIR4O+aC1ULvACHfxch7ubU3TJ
         yCZL5JGLw5FLhFXtKOYoFh5axT4lY+wBoNqqnaINN9T7MgyBJZ0T+e2+6NaZv5qcWuNr
         +qT5qq/0UHev7P/dsLlxMQC/7V+GFR2GM2AzXDqkAVp5BHVhaW0M/ymytvChIdrorSzP
         HOeWr0bkgy/vv3BMGoHZ+aqfLcR+9aT7RqWLmYoQj1/J6hzHrd3pLnoksv5Vc6WMvzl0
         ZYjjcf1K5DJCayAn9CFUGX6zHXjnmdGxjCeLYdfCg2QYOWrH/gf/75LjG3zCJ+/hgRw6
         5lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749570399; x=1750175199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32CoWJgbTlYUzAxIBjwb0Zjs1I5TbtzzAl+WJpqHnjE=;
        b=svyA+tboj38Bi9PCYWU/dr1jbariIqN/t8WzxLy2mQkSgBGEOnf2jKHjnOz1z0zz8M
         DjOcoR2rhV4d8iaWf3xmUNvcXDHfjQos4iE6P0zL3SnIRLTXjOIFJrH8SNes1jHXAQ9o
         dTmWGkmshKowhKbMHURtQUcalbK92eGQBLKuTwzijN4Xm5JeHSKseW/Zi1B9MOm36+T6
         vO/QTDYUB/HeukgNKOfAMoxkmm4eNifBhguU5bdA8MQTDaYD3N0wNnJjJdZFSW6M8uft
         CTNVNAnUp4CGQO54n8hUkeNvYWH0HgsZnmh6x0hyBfbSLiRYaXzQaCWqYamKYAhakZ+v
         nHFg==
X-Forwarded-Encrypted: i=1; AJvYcCUOMEfAxwYwPL/fv1JKxUmB3jGTDTlIMQrJ/Hb1uyyF9NZ6T53+I830Ku4+NIYOvM8vdbE/eNvUBOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8IFFPqMlBUliisbPLV/DhMLp7zELealQZCSLtluAJpHDRupy
	/4IIe+c5FPtbUE/JxE4T4Gqn25CLki/EWnWBLfB76S3Xa5e7RhYjxbfgW7pSqvxZ4L0=
X-Gm-Gg: ASbGncvJ0VA36eA69thxhUmQgeiG4fn3MVhU37Xiwp3TljZY0lod65wBbG2y5VjHNmx
	K2y7P5B7BWZGFoUoXqz9Y1XmdG1M0yZ+RopfkcajdDrzyRJSiWh5cBKfczqbmQPhQ3aGmU7jUKK
	To2qJgciv94erOl3LTB1HD7rx8VLrSnAR22kzSjZgy+CMxkv2vO+v23VakQr2WgkhbLYQbNT3vi
	7BJs8GqR4AzuOeoWUwXDsCDyg/WySq2EMW/6Hiy9u8MT/xyPo1gkTva7aZ2WU29RoC/iJrLKSug
	WCGVgrcvhB3zzGEkIKGWZFdOqlSHuuxTIQyT1AI7IbFiHwcp9OiE9zGeT284c3L7u+Bc7HQcbXH
	OUw==
X-Google-Smtp-Source: AGHT+IHd43zcj5bc6he9pS95vdOv9J2OpBXBfAtfcsa4Xb6ZIBuGjAUEVSk6r3PPapBN44C27mrqDA==
X-Received: by 2002:a05:600c:8b57:b0:442:ccfa:fa with SMTP id 5b1f17b1804b1-4520141af75mr154049975e9.27.1749570398686;
        Tue, 10 Jun 2025 08:46:38 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e155500sm141292965e9.9.2025.06.10.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:46:38 -0700 (PDT)
Message-ID: <d364667f-e0b1-4f1b-9034-2fadfd5d457b@linaro.org>
Date: Tue, 10 Jun 2025 16:46:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2025 4:15 pm, Frank Li wrote:
> On Mon, Jun 09, 2025 at 04:32:39PM +0100, James Clark wrote:
>> Using coherent memory here isn't functionally necessary.
>> Because the
>> change to use non-coherent memory isn't overly complex and only a few
>> synchronization points are required, we might as well do it while fixing
>> up some other DMA issues.
> 
> Any beanfit by use on-coherent memory here?
> 
> Frank
> 

Presumably less cache maintenance traffic?

Thanks
James

>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-dspi.c | 55 +++++++++++++++++++++++++++++-----------------
>>   1 file changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index 386a17871e79..567632042f8f 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -247,6 +247,11 @@ struct fsl_dspi {
>>   	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
>>   };
>>
>> +static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
>> +{
>> +	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +}
>> +
>>   static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
>>   {
>>   	switch (dspi->oper_word_size) {
>> @@ -361,7 +366,10 @@ static void dspi_tx_dma_callback(void *arg)
>>   {
>>   	struct fsl_dspi *dspi = arg;
>>   	struct fsl_dspi_dma *dma = dspi->dma;
>> +	struct device *dev = &dspi->pdev->dev;
>>
>> +	dma_sync_single_for_cpu(dev, dma->tx_dma_phys,
>> +				dspi_dma_transfer_size(dspi), DMA_TO_DEVICE);
>>   	complete(&dma->cmd_tx_complete);
>>   }
>>
>> @@ -369,9 +377,13 @@ static void dspi_rx_dma_callback(void *arg)
>>   {
>>   	struct fsl_dspi *dspi = arg;
>>   	struct fsl_dspi_dma *dma = dspi->dma;
>> +	struct device *dev = &dspi->pdev->dev;
>>   	int i;
>>
>>   	if (dspi->rx) {
>> +		dma_sync_single_for_cpu(dev, dma->rx_dma_phys,
>> +					dspi_dma_transfer_size(dspi),
>> +					DMA_FROM_DEVICE);
>>   		for (i = 0; i < dspi->words_in_flight; i++)
>>   			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
>>   	}
>> @@ -381,6 +393,7 @@ static void dspi_rx_dma_callback(void *arg)
>>
>>   static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>   {
>> +	size_t size = dspi_dma_transfer_size(dspi);
>>   	struct device *dev = &dspi->pdev->dev;
>>   	struct fsl_dspi_dma *dma = dspi->dma;
>>   	int time_left;
>> @@ -389,10 +402,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>   	for (i = 0; i < dspi->words_in_flight; i++)
>>   		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
>>
>> +	dma_sync_single_for_device(dev, dma->tx_dma_phys, size, DMA_TO_DEVICE);
>>   	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
>> -					dma->tx_dma_phys,
>> -					dspi->words_in_flight *
>> -					DMA_SLAVE_BUSWIDTH_4_BYTES,
>> +					dma->tx_dma_phys, size,
>>   					DMA_MEM_TO_DEV,
>>   					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>   	if (!dma->tx_desc) {
>> @@ -407,10 +419,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>   		return -EINVAL;
>>   	}
>>
>> +	dma_sync_single_for_device(dev, dma->rx_dma_phys, size,
>> +				   DMA_FROM_DEVICE);
>>   	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
>> -					dma->rx_dma_phys,
>> -					dspi->words_in_flight *
>> -					DMA_SLAVE_BUSWIDTH_4_BYTES,
>> +					dma->rx_dma_phys, size,
>>   					DMA_DEV_TO_MEM,
>>   					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>   	if (!dma->rx_desc) {
>> @@ -512,17 +524,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>>   		goto err_tx_channel;
>>   	}
>>
>> -	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
>> -					     dma_bufsize, &dma->tx_dma_phys,
>> -					     GFP_KERNEL);
>> +	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
>> +						dma_bufsize, &dma->tx_dma_phys,
>> +						DMA_TO_DEVICE, GFP_KERNEL);
>>   	if (!dma->tx_dma_buf) {
>>   		ret = -ENOMEM;
>>   		goto err_tx_dma_buf;
>>   	}
>>
>> -	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
>> -					     dma_bufsize, &dma->rx_dma_phys,
>> -					     GFP_KERNEL);
>> +	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
>> +						dma_bufsize, &dma->rx_dma_phys,
>> +						DMA_FROM_DEVICE, GFP_KERNEL);
>>   	if (!dma->rx_dma_buf) {
>>   		ret = -ENOMEM;
>>   		goto err_rx_dma_buf;
>> @@ -557,11 +569,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>>   	return 0;
>>
>>   err_slave_config:
>> -	dma_free_coherent(dma->chan_rx->device->dev,
>> -			  dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
>> +	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
>> +			     dma->rx_dma_buf, dma->rx_dma_phys,
>> +			     DMA_FROM_DEVICE);
>>   err_rx_dma_buf:
>> -	dma_free_coherent(dma->chan_tx->device->dev,
>> -			  dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
>> +	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
>> +			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
>>   err_tx_dma_buf:
>>   	dma_release_channel(dma->chan_tx);
>>   err_tx_channel:
>> @@ -582,14 +595,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
>>   		return;
>>
>>   	if (dma->chan_tx) {
>> -		dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
>> -				  dma->tx_dma_buf, dma->tx_dma_phys);
>> +		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
>> +				     dma->tx_dma_buf, dma->tx_dma_phys,
>> +				     DMA_TO_DEVICE);
>>   		dma_release_channel(dma->chan_tx);
>>   	}
>>
>>   	if (dma->chan_rx) {
>> -		dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
>> -				  dma->rx_dma_buf, dma->rx_dma_phys);
>> +		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
>> +				     dma->rx_dma_buf, dma->rx_dma_phys,
>> +				     DMA_FROM_DEVICE);
>>   		dma_release_channel(dma->chan_rx);
>>   	}
>>   }
>>
>> --
>> 2.34.1
>>


