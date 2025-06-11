Return-Path: <linux-spi+bounces-8452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4092DAD5917
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D5C7A3CAA
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2F2BE7D1;
	Wed, 11 Jun 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gh0ipziO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9C2BDC2F
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652845; cv=none; b=agPO6eXG9DjZIioaqedRj7uW6J6kKEwsBlCCQwktHN4zhlt3w1WgLYMrsaEiaVHVMEJqidm3SqQ11jhZg7ROxj6JMyzYF4ZeiBBLGiaFFTHBvc26xhz5D/MK0T7/7ex+0DTquJR+Tqoub9K7mQnw6dA/RzIpm9SI6OpzDZsNVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652845; c=relaxed/simple;
	bh=LPFa+9psyfZ/kUWmfuHembHpxCJT9UYctI5V70BrYhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t98k5dmTLfLjHtc0FPbmScXG+OG7raUz3o5TLx9/ELO/uT+HzaWFwbtqwbQUUf8o/82TeooW8QuR/BwXwzzopflJWPRLlhMZMjwjadfAg6rEqBKXMd8lbLN3fql2BFsy2pUQIa6NfT773a5xzL7TatL1VhmVxLGuoQWV/a7rKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gh0ipziO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so5127489f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749652842; x=1750257642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3oNjI0+fE5a1sp5ezyw/B8kijMIdxGNtB5JPW69Z4Q=;
        b=Gh0ipziOZi20t6YJzZhqhRMRlex2RYvTJLMeR+YVsY2VkP8cnBD+nY6lzhvpz4+Yft
         sl/S+s8OkdqEY85cd+68V0PWkqT4SHGgTj5uarcOhvAnxAITjK01VbqpFx2qP7ne0YXF
         QI8affQyLeid/nMPLwwTsjTMGT+qj66bXaBcDhRKzEn5rpObsYpH7eGQmKxtEiwXfQcL
         v3LSlSX/YFRtUqT93Rms0Dnc+nHGLOT076SBB5+meoKprlk6Bwir0HgUbEthuL558uIi
         Q6UxlfexPRNobLuwZUEH2dBI8ZUuP5J989n7Mz1R3o2AHfKOvI5FtlTUN+7RcFB6uysk
         6BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652842; x=1750257642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3oNjI0+fE5a1sp5ezyw/B8kijMIdxGNtB5JPW69Z4Q=;
        b=rJQSbQpZg2dyhJA9qIRK/z4bcvX6WxLt/sqpAjaInJrjrbu56KGpZWep7+J6yIeBPf
         9aBSvq+SSISCcn2CHvF6pU7wbS2IZ/IM+WC2SmaTJ3LypmPoSTYLxf45KrkriLZKGoNe
         K8vHNFYbMLqrgP4fXdI+qnWJjny3O8T9FbHXl+1P/HXAIYe1iQVvvPN6mnIVrORg99FI
         Izs3dDLIMsbKkmpiiqLSdDA7R63ZpnL6lrNmscUV53K5PP/pw5uBvAdEOPYDuj+Bfrxd
         u//h4uAfAN1HXsP8PgKQBzbqG6x/+qoNctMtXuAXtnoa8UQObv+VspPCZm1r2Jp9pMt8
         fkaA==
X-Forwarded-Encrypted: i=1; AJvYcCWxLjnCjBa2cxQxyPGPe5qFWmy/ZNTNuULTwav0pxTk0QdN5D/cONtP4yisEjZpUG+28167GKXMvew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7NZi5R5SIy2Edph/v7wQxo/Q3fukk++X7a1gX9ckgTs+gabg
	kdQzdlVB9DFnzAPoTWvrLK1d/L18iw81ODXTap3nDX2j5xx63iVOmTto8ViZi+4Mf3U=
X-Gm-Gg: ASbGncvKzWzo/K46n8DmhSeLl/VA9lM5gtWt/bIJFc6zN+bd70LUYteLHVDBRRCI0sN
	AyxbVXZmQj2ILQDVLNuTA50VmlUP468n1ZRSogAQXWu+GHPkn/8pJHdik6KHV6uvYwd6dtviLzg
	zfOVK6UWymGoU6+3ksq+r0CbWFuD5vcjc9KMuepusHyKYENzOmGCTgU4MXaUdoNpovP3kPmMIIx
	+Zkr1phMWG8p/kdDphvUJVk+hOl+8+4vGkDK8WXW1yHVvPCF6Kbc77KG2zjFqgdEzxIyWD+ND56
	FF73A22IlnOyMFfiYrDaL72EWiyChcNa7MoXJ0ZUPkxMXxMVL4JG0iIlxam7FM/samQ=
X-Google-Smtp-Source: AGHT+IHHQOnypMfj2r2sUTTE3yi43SalVUjfXgPbPaXOLleRnpOnnpVeqGUKny8eXtf60DNIIRrgmg==
X-Received: by 2002:a05:6000:430a:b0:3a4:e665:ca5 with SMTP id ffacd0b85a97d-3a558aa5739mr2648236f8f.23.1749652841923;
        Wed, 11 Jun 2025 07:40:41 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244e0e3sm15790400f8f.68.2025.06.11.07.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:40:41 -0700 (PDT)
Message-ID: <d95fbd83-995e-48ca-bf23-147caa80b9e1@linaro.org>
Date: Wed, 11 Jun 2025 15:40:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-4-2b831e714be2@linaro.org>
 <20250610215233.35ikv4sslkyukgwr@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250610215233.35ikv4sslkyukgwr@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2025 10:52 pm, Vladimir Oltean wrote:
> On Mon, Jun 09, 2025 at 04:32:41PM +0100, James Clark wrote:
>> In target mode, the host sending more data than can be consumed would be
>> a common problem for any message exceeding the FIFO or DMA buffer size.
>> Cancel the whole message as soon as this condition is hit as the message
>> will be corrupted.
>>
>> Only do this for target mode in a DMA transfer because we need to add a
>> register read. In IRQ and polling modes always do it because SPI_SR was
>> already read and it might catch some host mode programming/buffer
>> management errors too.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-dspi.c | 31 ++++++++++++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index e211e44e977f..75767d756496 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -228,6 +228,7 @@ struct fsl_dspi {
>>   	const struct fsl_dspi_devtype_data	*devtype_data;
>>   
>>   	struct completion			xfer_done;
>> +	int                                     xfer_status;
> 
> This is certainly simple, and simple is not bad.
> 
> But based on the fact that you care about the xfer_status only when
> there's an associated dspi->cur_msg, have you considered to update
> dspi->cur_msg->status directly?
> 
> You'd need to reset dspi->cur_msg to NULL at the end of
> dspi_transfer_one_message(), and then check for NULL when you update
> the transfer status.
> 

That will work. I can use it for polling and DMA modes too and I think 
it looks a bit better after a refactor.

>>   
>>   	struct fsl_dspi_dma			*dma;
>>   
>> @@ -504,12 +505,22 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>   
>>   static void dspi_setup_accel(struct fsl_dspi *dspi);
>>   
>> +static bool dspi_is_fifo_overflow(struct fsl_dspi *dspi, u32 spi_sr)
> 
> Can you name this some way else, like dspi_fifo_error()? It's strange
> for a reader for this to return true on an underflow.
> 

Will do

>> +{
>> +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
>> +		dev_err(&dspi->pdev->dev, "FIFO under/overflow");
> 
> Missing \n.
> 
> And you should use dev_err_ratelimited(), as you don't want an external
> entity, when in target mode, to DoS you.
>

Ack

> Also, could there be individual error messages for TFUF and for RFOF?
> If you are concerned about the penalty for the error-free case, make the
> check two-level. First for all errors, then for individual errors.
> 

If I was going to split them I would probably let the compiler optimize 
it whichever way was best. The real reason for combining them is because 
usually you get them both together. As long as the message and fifos are 
configured correctly you'd always get TFUF and RFOF at the same time and 
I wanted to avoid printing twice for one event.

We could have 3 different warnings, TFUF/RFOF, TFUF and RFOF but I don't 
think that's useful to an end user. At that level of debugging you'd 
probably have a load of other debug printfs added anyway.

>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   static int dspi_dma_xfer(struct fsl_dspi *dspi)
>>   {
>>   	struct spi_message *message = dspi->cur_msg;
>>   	int max_words = dspi_dma_max_datawords(dspi);
>>   	struct device *dev = &dspi->pdev->dev;
>>   	int ret = 0;
>> +	u32 spi_sr;
>>   
>>   	/*
>>   	 * dspi->len gets decremented by dspi_pop_tx_pushr in
>> @@ -531,6 +542,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
>>   			dev_err(dev, "DMA transfer failed\n");
>>   			break;
>>   		}
>> +
>> +		if (spi_controller_is_target(dspi->ctlr)) {
>> +			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>> +			if (dspi_is_fifo_overflow(dspi, spi_sr))
>> +				return -EIO;
>> +		}
>>   	}
> 
> Can this go within this block from dspi_next_xfer_dma_submit() instead?
> 
> 	if (spi_controller_is_target(dspi->ctlr)) {
> 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
> 		// here
> 		return 0;
> 	}
> 

Makes sense yeah

>>   
>>   	return ret;
>> @@ -918,6 +935,8 @@ static int dspi_poll(struct fsl_dspi *dspi)
>>   		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>>   		regmap_write(dspi->regmap, SPI_SR, spi_sr);
>>   
>> +		if (dspi_is_fifo_overflow(dspi, spi_sr))
>> +			return -EIO;
>>   		if (spi_sr & SPI_SR_CMDTCF)
>>   			break;
>>   	} while (--tries);
>> @@ -939,8 +958,12 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>   	if (!(spi_sr & SPI_SR_CMDTCF))
>>   		return IRQ_NONE;
>>   
>> -	if (dspi_rxtx(dspi) == 0)
>> +	if (dspi_is_fifo_overflow(dspi, spi_sr)) {
>> +		WRITE_ONCE(dspi->xfer_status, -EIO);
>> +		complete(&dspi->xfer_done);
>> +	} else if (dspi_rxtx(dspi) == 0) {
>>   		complete(&dspi->xfer_done);
>> +	}
>>   
>>   	return IRQ_HANDLED;
>>   }
>> @@ -1032,13 +1055,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>>   		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>>   			status = dspi_dma_xfer(dspi);
>>   		} else {
>> -			if (dspi->irq)
>> +			if (dspi->irq) {
>> +				WRITE_ONCE(dspi->xfer_status, 0);
>>   				reinit_completion(&dspi->xfer_done);
>> -
> 
> Nitpick: The blank line was doing fine here.
> 

Ack

>> +			}
>>   			dspi_fifo_write(dspi);
>>   
>>   			if (dspi->irq) {
>>   				wait_for_completion(&dspi->xfer_done);
>> +				status = READ_ONCE(dspi->xfer_status);
>>   			} else {
>>   				do {
>>   					status = dspi_poll(dspi);
>>
>> -- 
>> 2.34.1
>>


