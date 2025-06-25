Return-Path: <linux-spi+bounces-8763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5209AE7E3E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7571882FAA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33B30749E;
	Wed, 25 Jun 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+OJek/I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D2284671
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845391; cv=none; b=lhcZ1ueDsNXa9opM2bZ/IgSZ6ju5ebMgpSRckqS2d+wBzClp1cNSmWZaDC33EVQ0sXAho6OeN/fSMuTKpu8pPB2yWqkg8N8mmbNS0PjTYrNS3NUPE3r2DrymK11H1iMFx4CiVIMfsprW08gD8vx1TJ7jpAxk0MmEZ2FDjynuT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845391; c=relaxed/simple;
	bh=8FU/7tPeSpa7lK21KpiF9ik38Y+Bs84pnJnck2VkIBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7dOBlBsvLTiEK4c4HczxP+A4LsBez6vZhIldaOm7ymO9AQ39sLVdWg+hgTc1Hm2GjTXv3bzgTqkxIiEgvicJGhprh55j+SrR8oOMnMW9n4d39GVAmcAyvVzduCC2q/cDMiFhLSgR3tPvMnDirQ26v3yZqFbKi8JRE9CZxjflZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+OJek/I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so4692455e9.0
        for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750845387; x=1751450187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnv6+0ikBWTu5GUwzfXL+31J9Qfk+uEDhfcL5PdN9P4=;
        b=W+OJek/IgJud9HkcVZp/KJttq4ju8cJrgxCOjwNTpVvfKC8BeOdzSoMx/kI6kggBJQ
         Tax8Oxqfkt2pB6GKMre4RAf5svXwqLlYj0tmrj03HAAwtELto8D/qzZpeM8sGvpWYeZi
         X/XeJIHfMhy1/tuUndOGHamdHekqojCymHZygxXZErJkXnDYrTYlQ28kWQn5+NssCUan
         LijnHdFBjm9NdiBZkqUdey/ABHX1sSzIXEi72TFNrbeqsKJ2PAs915yBVpaqGds5jj2U
         +8U+/7sfevi1SqngZiLIYTEicsJy7houR3gUBm8gyXNZudxvwl3o+TfGPM0+UZnn0MO2
         uREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845387; x=1751450187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnv6+0ikBWTu5GUwzfXL+31J9Qfk+uEDhfcL5PdN9P4=;
        b=BvBl+cJZufumSlzyoQWlS4yGBm2A8nZU59vmd4j+VjTXbS1NmfCXaPyxgtwxJWJPYz
         cggBlkDT7jwuNvFtcE5aBQ2inaoryYWRi3hUGRo1T3LiEyrnXiyhkHsbzrsrf/PwRtn8
         8cuJ9NmFs+MkOqLx3lN5ubfzHP1f93OmTWshYzsuWTv/ltH2xfhp1eJ/e4+VKI16Oc2n
         dHmlo4FafTY4EM/t5b5Op6KXAPsisXYEm7EjnRcduWhzM5RIlkV1KofGNEq9a3qcSQMA
         Rns7rphLxfx2/F3p7OxesqqHWB5OIHmg0JbVZmN0IRGPbS9/9W7bK4RXi8/FDpxiQ/cs
         oAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzq9thvo3kWTS7/XR9ySsqxVi0Rv+HoEGkHt4XIKqYYns1jU4wquJsCUhhLWgQiYh+12sF2ORDj8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn18zDn4qQZ/Fn3fqRFuQur8sKxAklSkDQ5Nw0QrkgI587P2el
	AnNYrs7JqrflRs3Ow2hPSltqni6xAHTTbOmjuvj8mKHZ/p6DULLrEDJXd/UEm40LBo8=
X-Gm-Gg: ASbGncss+pGdDtNobtP37WPCCYuQn+dkGRG+aHlj0gp8tx7eUzTUWcuw6MtP36EPJt3
	D0NqVAejfvDV1GbN4UYoZ6BCQGYYX2A3AFhUEJSwHomr6/nkk6bAFJAoW68a0N+nRFYVEiC/XJF
	CKP1fQTsSdFE93Z+nV6cMtE6u126GQsbPSE/ZHraGoKsl8+zOAfxTVRlMo4eFYxTzfuQI/eTxpm
	Vlu0QpNOrY19PLCeiFnpYxv/FLan3SIoCCG77DSgpQrEpozWohnux6c2TNFt2NgCcxaR76uiaYI
	Q/mdm6SkD+OhgLkDEZzWR0ufxlE/c8sn8e+gr8WNAIONlALQLucjzdb3REttBbwkI1I=
X-Google-Smtp-Source: AGHT+IHUT2mOdBDTYilOC0pGw2ewz3RMDzSyuUrAJ3h5EYqrxtwLBoi5uS6ecJ7xvkaUQCE+iExiWw==
X-Received: by 2002:a5d:64e6:0:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a6e71ff6aamr6132185f8f.15.1750845387416;
        Wed, 25 Jun 2025 02:56:27 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c749sm15055145e9.4.2025.06.25.02.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 02:56:26 -0700 (PDT)
Message-ID: <a27378b4-45f7-4f5f-b01f-72eb9b7d2d8f@linaro.org>
Date: Wed, 25 Jun 2025 10:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
To: Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-2-e7d574f5f62c@linaro.org>
 <aFrP1ZNvjHCPmbWG@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFrP1ZNvjHCPmbWG@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2025 5:18 pm, Frank Li wrote:
> On Tue, Jun 24, 2025 at 11:35:32AM +0100, James Clark wrote:
>> This will allow us to return a status from the interrupt handler in a
>> later commit and avoids copying it at the end of
>> dspi_transfer_one_message(). For consistency make polling and DMA modes
>> use the same mechanism.
>>
>> Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
>> this isn't actually a status that was ever returned to the core layer
>> but some internal state. Wherever that was used we can look at dspi->len
>> instead.
>>
>> No functional changes intended.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-dspi.c | 68 ++++++++++++++++++++++++----------------------
>>   1 file changed, 35 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index 744dfc561db2..feb29bb92a77 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -591,11 +591,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>
>>   static void dspi_setup_accel(struct fsl_dspi *dspi);
>>
>> -static int dspi_dma_xfer(struct fsl_dspi *dspi)
>> +static void dspi_dma_xfer(struct fsl_dspi *dspi)
>>   {
>>   	struct spi_message *message = dspi->cur_msg;
>>   	struct device *dev = &dspi->pdev->dev;
>> -	int ret = 0;
>>
>>   	/*
>>   	 * dspi->len gets decremented by dspi_pop_tx_pushr in
>> @@ -612,14 +611,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
>>   		message->actual_length += dspi->words_in_flight *
>>   					  dspi->oper_word_size;
>>
>> -		ret = dspi_next_xfer_dma_submit(dspi);
>> -		if (ret) {
>> +		message->status = dspi_next_xfer_dma_submit(dspi);
>> +		if (message->status) {
>>   			dev_err(dev, "DMA transfer failed\n");
>>   			break;
>>   		}
>>   	}
>> -
>> -	return ret;
>>   }
>>
>>   static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>> @@ -986,36 +983,40 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
>>   				dspi->progress, !dspi->irq);
>>   }
>>
>> -static int dspi_rxtx(struct fsl_dspi *dspi)
>> +static void dspi_rxtx(struct fsl_dspi *dspi)
>>   {
>>   	dspi_fifo_read(dspi);
>>
>>   	if (!dspi->len)
>>   		/* Success! */
>> -		return 0;
>> +		return;
>>
>>   	dspi_fifo_write(dspi);
>> -
>> -	return -EINPROGRESS;
>>   }
>>
>> -static int dspi_poll(struct fsl_dspi *dspi)
>> +static void dspi_poll(struct fsl_dspi *dspi)
>>   {
>>   	int tries = 1000;
>>   	u32 spi_sr;
>>
>> -	do {
>> -		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>> -		regmap_write(dspi->regmap, SPI_SR, spi_sr);
>> +	while (dspi->len) {
> 
> Preivous have not checked dspi->len.
> 
> Not sure if it is logical equivalence
> 

It used to be this:

    status = dspi_poll(dspi);
  } while (status == -EINPROGRESS);

Where checking status for -EINPROGRESS is equivalent to checking dspi->len.

>> +		do {
>> +			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>> +			regmap_write(dspi->regmap, SPI_SR, spi_sr);
>>
>> -		if (spi_sr & SPI_SR_CMDTCF)
>> -			break;
>> -	} while (--tries);
>> +			if (spi_sr & SPI_SR_CMDTCF)
>> +				break;
>> +		} while (--tries);
>>
>> -	if (!tries)
>> -		return -ETIMEDOUT;
>> +		if (!tries) {
>> +			dspi->cur_msg->status = -ETIMEDOUT;
>> +			return;
>> +		}
>>
>> -	return dspi_rxtx(dspi);
>> +		dspi_rxtx(dspi);
>> +	}
>> +
>> +	dspi->cur_msg->status = 0;
>>   }
>>
>>   static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>> @@ -1029,8 +1030,13 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>   	if (!(spi_sr & SPI_SR_CMDTCF))
>>   		return IRQ_NONE;
>>
>> -	if (dspi_rxtx(dspi) == 0)
>> +	dspi_rxtx(dspi);
>> +
>> +	if (!dspi->len) {
>> +		if (dspi->cur_msg)
>> +			WRITE_ONCE(dspi->cur_msg->status, 0);
>>   		complete(&dspi->xfer_done);
>> +	}
>>
>>   	return IRQ_HANDLED;
>>   }
>> @@ -1060,7 +1066,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>   	struct spi_device *spi = message->spi;
>>   	struct spi_transfer *transfer;
>>   	bool cs = false;
>> -	int status = 0;
>>   	u32 val = 0;
>>   	bool cs_change = false;
>>
>> @@ -1120,7 +1125,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>   				       dspi->progress, !dspi->irq);
>>
>>   		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>> -			status = dspi_dma_xfer(dspi);
>> +			dspi_dma_xfer(dspi);
>>   		} else {
>>   			/*
>>   			 * Reset completion counter to clear any extra
>> @@ -1133,15 +1138,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>
>>   			dspi_fifo_write(dspi);
>>
>> -			if (dspi->irq) {
>> +			if (dspi->irq)
>>   				wait_for_completion(&dspi->xfer_done);
>> -			} else {
>> -				do {
>> -					status = dspi_poll(dspi);
>> -				} while (status == -EINPROGRESS);
>> -			}
>> +			else
>> +				dspi_poll(dspi);
>>   		}
>> -		if (status)
>> +		if (READ_ONCE(message->status))
> 
> Why need READ_ONCE()? Does any hardware (DMA) set status?
> 
> where update message->status at pio mode.
> 
> Frank

Because message->status is set from dspi_interrupt(), so the compiler 
wouldn't be aware that this variable can be changed from elsewhere. 
Otherwise it could assume that it's never written to in 
dspi_transfer_one_message() and not bother to read it again.

>>   			break;
>>
>>   		spi_transfer_delay_exec(transfer);
>> @@ -1150,7 +1152,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>   			dspi_deassert_cs(spi, &cs);
>>   	}
>>
>> -	if (status || !cs_change) {
>> +	dspi->cur_msg = NULL;
>> +	if (message->status || !cs_change) {
>>   		/* Put DSPI in stop mode */
>>   		regmap_update_bits(dspi->regmap, SPI_MCR,
>>   				   SPI_MCR_HALT, SPI_MCR_HALT);
>> @@ -1159,10 +1162,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>   			;
>>   	}
>>
>> -	message->status = status;
>>   	spi_finalize_current_message(ctlr);
>>
>> -	return status;
>> +	return message->status;
>>   }
>>
>>   static int dspi_set_mtf(struct fsl_dspi *dspi)
>>
>> --
>> 2.34.1
>>


