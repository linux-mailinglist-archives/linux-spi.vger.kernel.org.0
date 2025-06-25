Return-Path: <linux-spi+bounces-8765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C068BAE7EBC
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496C5188F4E4
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1EE29B768;
	Wed, 25 Jun 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gse//QQH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47461DED70
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846202; cv=none; b=EJl6wNt79oaN9kJyIhZcUpMdc4bVFO159GGJVIK5knbEtNeoHtIK7EDH0zjQ0MvzqI1DSaR3HtWMwM8MppxfRXzrsAalLxo7V+b4MWGxj4Io1zzqDBb2hDTS6yyKq2h3qWBzDjZuNQd953lQxJv/akkLCnXDIbauc86mPVNmVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846202; c=relaxed/simple;
	bh=OylUmlOteTQZOUB8k3gp2U6i5Fi2b03eFfECFDhsR6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANosPYEu4a8m2wFdEntthpa1zBKOTDp4iC++zAS4t+cR6OpbUNsnHOMRFyFR+hbvchopanv+kxJlQlvasvF+3butayuRTLpPHee/nWbbMLOdN36F2+IJL/r8YSYwPRnCHSgOrlecGVsbDgafjVtOZqgQrxSCb0KJZKgaRMb0mog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gse//QQH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1628695f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846199; x=1751450999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4I1PJPpHezpA836vKI44sV4N989fSWCkW53dGjnJDg=;
        b=gse//QQHqbzpDXiZ1MDZ70rHRU1GYKRGnMsHCV4iUlZ6lLmIjfoQqXGixWt2i5HhjB
         ka6+S3fwAzatSM6GkRh3Wf5HVXEo5TyMfiYGXwOvayjD6IW0F2mxOycCT8oRMujxhilK
         FCH1krRbZ70bnQFTs0Ok6duecKFQwUMTcESzhc6fak+dAJvPC1IkHRRHfdn3CvYGkYeb
         dCCwLhM6vhXGIv552XlqdTRE1tAvznFxGMR3mRmxYHur0R4U5mqAC0MDELoWXUpx+cki
         btkOzFrKrDtXGJwLfXhoihxC9ueBLtqg6NrREz4ajP7gFJHrArTpSbi4u330yAZlqSoo
         jERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846199; x=1751450999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4I1PJPpHezpA836vKI44sV4N989fSWCkW53dGjnJDg=;
        b=B0xM19E05nI89hIVrGNujXpD3Kl8xfp7uIYhrExy2UNEMwHlgmK6W0SgMgOMcXlBzt
         7nvIYgqI+5+Z9YsWYgPZx5rV9p/lmYGHWXMzWHiDdO5s6CLcIDxvYZeWdDSmeA/rfFlx
         Aem0LSg+u/mybpmfVkLJ5xjSVVZEL0+pTihK28UCNz979DN9t+TcyWUwpMuKsjHyb3G8
         cWMXyOnwiqurUGqqEs2jnH70/6Jk6YeCQXAJ539MT+qlWRHnvI3MMSHOijic7K+tEDw3
         VyJOpWAaiE3donq7fzZSGLN75D1rpw/ofuych3iNywYe5672VAKFLA6ig/fHM1v5vtV+
         lv8A==
X-Forwarded-Encrypted: i=1; AJvYcCXRI2iFX2IkHoBTXqFiiWSIY2/BiV/E16Pcq2bQU/SObH4Ack3BtV3c0IOxtmA2k4pviGxkySTOxw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVB5riL5KftQxoJxmhT5W4fte+YlmM9j21tG2f4iXraVvcoPut
	yz7q/wEGp9j75z9AG3vs22u2TAqGeTcBreZeJ6O55jObIACFmmCdjg9tMiH9SyBzdF4=
X-Gm-Gg: ASbGnctYrn8j9N81ISNSgHtFn11ajdCO9RysUOZNqV7p2iXJX5fSHzUonr8BaC98ijU
	dhzIuU+0l8So09jGZJ4MDDOwj+UuCDxHwmX9CC8Xcc/+ywG3s1tXRyMX3Sob6NHPB4dDyFrczdp
	2QLN0qBoyS/wlxt16tiYJiHy0t9h/+YT0tF8gfz3EGwQg4+YuJZu4dI5vrSr6Srmd9uNqLZhUp5
	0t4OaPF63mf761tdO52MMV6rbsKezZfecFQdn9bVTLMz5sMFGpwON6zr22/CSXuepmVxe3Hijcv
	AYNuSVuopnyPwtpeIYdhk4haoS/9S7dgN9JBmite824IgcRIAcES+TY3jn9zv5ogCV551p7DNNL
	ejg==
X-Google-Smtp-Source: AGHT+IEUMHqgZbLFHpHfwdSLV9qr4L6CCkcPkB2BptUFawy9i4DhryIcnKtQz1y2O+KERfW+BoO8YQ==
X-Received: by 2002:a05:6000:2207:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3a6ed5b880amr1909565f8f.5.1750846199010;
        Wed, 25 Jun 2025 03:09:59 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233a895sm15457165e9.3.2025.06.25.03.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:09:58 -0700 (PDT)
Message-ID: <0e26494d-7b85-4874-a2e4-a498ce1864c8@linaro.org>
Date: Wed, 25 Jun 2025 11:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
To: Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>
 <aFrXRDJmMgt0qTlL@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFrXRDJmMgt0qTlL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2025 5:50 pm, Frank Li wrote:
> On Tue, Jun 24, 2025 at 11:35:36AM +0100, James Clark wrote:
>> In target mode, the host sending more data than can be consumed would be
>> a common problem for any message exceeding the FIFO or DMA buffer size.
>> Cancel the whole message as soon as this condition is hit as the message
>> will be corrupted.
>>
>> Only do this for target mode in a DMA transfer because we need to add a
>> register read.
> 
> "We need to add a register read" is not reason.
> 

Maybe: "It's not likely to catch any errors in host mode so optimize by 
avoiding an extra register read"?

> Add checking FIFO error status at target mode in a DMA transfer since PIO
> mode already do it. It help catch some host mode ...
> 

Are you suggesting that we check for FIFO errors in host mode too? It 
requires an extra read and check in dspi_tx_dma_callback(), but I'm not 
sure what it could catch. Realistically as long as everything is setup 
correctly then neither of those flags will be set. It will either always 
work or never work.

It might be better to add it later if a use becomes apparent otherwise 
it's extra noise in the code.

>> In IRQ and polling modes always do it because SPI_SR was
>> already read and it might catch some host mode programming/buffer
>> management errors too.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> index 58881911e74a..16a9769f518d 100644
>> --- a/drivers/spi/spi-fsl-dspi.c
>> +++ b/drivers/spi/spi-fsl-dspi.c
>> @@ -560,12 +560,24 @@ static void dspi_rx_dma_callback(void *arg)
>>   	complete(&dma->cmd_rx_complete);
>>   }
>>
>> +static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
>> +{
>> +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
>> +		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
>> +				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
>> +				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
>> +		return -EIO;
>> +	}
>> +	return 0;
>> +}
>> +
>>   static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>   {
>>   	size_t size = dspi_dma_transfer_size(dspi);
>>   	struct device *dev = &dspi->pdev->dev;
>>   	struct fsl_dspi_dma *dma = dspi->dma;
>>   	int time_left;
>> +	u32 spi_sr;
>>   	int i;
>>
>>   	for (i = 0; i < dspi->words_in_flight; i++)
>> @@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>
>>   	if (spi_controller_is_target(dspi->ctlr)) {
>>   		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
>> -		return 0;
>> +		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>> +		return dspi_fifo_error(dspi, spi_sr);
>>   	}
>>
>>   	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
>> @@ -1069,6 +1082,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
>>
>>   			if (spi_sr & SPI_SR_CMDTCF)
>>   				break;
>> +
>> +			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
>> +			if (dspi->cur_msg->status)
>> +				return;
> 
> 
> Although fifo error may happen after you check, it may reduce some possilbity
> and catch some problems.
> 
> Frak
> 

Not sure what you mean by this one. But I've seen a few small errors now 
that I look again. The error check should be before the transfer 
complete break. And tries should be reset for each part of the message.

>>   		} while (--tries);
>>
>>   		if (!tries) {
>> @@ -1085,6 +1102,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
>>   static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>   {
>>   	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
>> +	int status;
>>   	u32 spi_sr;
>>
>>   	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>> @@ -1093,6 +1111,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>   	if (!(spi_sr & SPI_SR_CMDTCF))
>>   		return IRQ_NONE;
>>
>> +	status = dspi_fifo_error(dspi, spi_sr);
>> +	if (status) {
>> +		if (dspi->cur_msg)
>> +			WRITE_ONCE(dspi->cur_msg->status, status);
>> +		complete(&dspi->xfer_done);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>>   	dspi_rxtx(dspi);
>>
>>   	if (!dspi->len) {
>>
>> --
>> 2.34.1
>>


