Return-Path: <linux-spi+bounces-8796-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2FAEB1A8
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880931BC6444
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBF279DD9;
	Fri, 27 Jun 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSfFUhJo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78E272E71
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014340; cv=none; b=LhsM0embB5kdvumDTt+Pqdv5RZeEJz1kIKpzYmc7m7LbW6jvOODZcsVSOu1tmz5SMotFOXvmXQHiokbhe7PhRzvuvz1TwsfNODivEQ4OyfI+YJTXdNlkMySV958HskplcyIawef+97VmkW/WFKaTyptG+JN9JvLP89msT7M/tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014340; c=relaxed/simple;
	bh=Trp2tEL9MBTHjgrxShlRCBnJKQ3r7660UkyS6y6g+ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEc+pipSaQ+CBeudguuTMS1HFz7HD9TZ8Am3DAFbVMhSTNdOJZYfbxn5rdnowkIEP/k8rWBIzSwjkLts5m0BLJg0GjXleMecLYWBjdYD1k5JqF8TpCW/qVQhIz93ECITKZ806etkvfgMNA9v07ueTEckf0AVFNMZnzHBf+g+490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JSfFUhJo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1745790f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751014337; x=1751619137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UoFUdFqAipKbBMVUce6Z7qQLfXF9kagacYpEqN92/d8=;
        b=JSfFUhJo2F8EXBGUNpMbkIKbjKcklAhHtf115HQiMSX3NE48lYGsc5bfzVRZgZjS95
         lkebQKemNmbRq9JIlk+nbwbbOGeTVaZAyNfZkcVclvRhBgPNeQ2hT+1Nk6MFcGiBzIMZ
         XIofhi8v3KXaJLTpIgtX7f5I9OnPSoVpMLDroy9zCJEQBl+KzILcg7+R7VnTgDx3vOZQ
         qeGyO4rDXMrSoW3kK5xPjO4b/+sl/jhJy7q3HZa8RMEN8PcxHQm01QRTOQ6U8WK/9Kfc
         nJ/UpC3xDw2RsdUamxKiYfB7MzwmeuNS0i7KZkwPUfAF+nZVZadCQFExY9qVxf2hwIAT
         bhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751014337; x=1751619137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoFUdFqAipKbBMVUce6Z7qQLfXF9kagacYpEqN92/d8=;
        b=X1cLg9ViT8LwOSgnmlSjC/QiBFUEWPm0TqlMmnrzj91bkVjWGAfWu8IufnOdUQmSMP
         MHBqSvSMnFwA9XuWDcffA3O5EYn7yD+IpPuRhsHEYEygh+tX/0do+j20Xl5hCijBLuOa
         MeAlmf/7UFvwxeNjbi+3newr8uaXBhZ93mggF38DdGqmk+69/MZbS5oZF9tM5/7bMFdB
         JPPR9lhK8yFtJ6tzY8aAgsX1UEuaFw8abfpadC2blmhQU8gnMjHDcU3rv3T2mPLH28mi
         e2Wqja1/nqqAEM0sbCC8Ty4zR3nZul9mm6/wJs1bQrfm/c5+BAIS4a8IRy9unH/DW9z1
         Wz9w==
X-Forwarded-Encrypted: i=1; AJvYcCVBa4UnR0p8MtAVyo4w+GzdpL8G1sLf6nmaneLitGIqbg+fQ4nbjdg6AEXDoMUebSklrcbRcdt4dXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lhEhNhXKivXy1i00Eq0Fn+VFC5yf2tpdQ1WXKEhQZzHp1TZx
	ZT/xAZAxAH/yr3h/psMmPunX37j0iJ8EH2soAcHwnPk9LIB6tPIUE/IPxHdGAPz4TZo=
X-Gm-Gg: ASbGncuBDRfKhm17mJ7Y6Aupf+1bfqt1dWLjerI3GkAQ3ZkOxz8Trd+uDuOTVFARJ4d
	txpCBzIUwL6c8VG5JF5Y3d59olbY6vdVdWQPEBMdk86ULOoJ3FgFE8+1BRw7NR1w7Ogw9OCforr
	0MDsqZqbUIpi66wK6gLJZj+jI7YrbzH/abge6KkEky/2Xb02CPhF6sOYuvJJo5KBXqSTqkPWUbW
	ELslP5g/cEm3h45qoOX5j9I5bPgd/EUi3aHCYaOj34bHLwSIFMx7LtnPw1v8OoxBlwcWPMEDRBG
	3oEJS5MyXgpoHfaOIOOBCb+vvp/3s1uaVvMABpvkd/vcjZEg0L6n8r3tcPqpkmZITf9DsxEkNQa
	A4g==
X-Google-Smtp-Source: AGHT+IECZfBrc+AzA+5LfKHuhgle/QkdG0KHezJE31byGodBUKLEFLFk2mmygHC6OYjmlmscdlmdXg==
X-Received: by 2002:a5d:4a01:0:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3a90d5a7e61mr1890018f8f.16.1751014337246;
        Fri, 27 Jun 2025 01:52:17 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e597a8sm2071994f8f.70.2025.06.27.01.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:52:16 -0700 (PDT)
Message-ID: <19302e67-7df1-4100-912d-c9b426a4b943@linaro.org>
Date: Fri, 27 Jun 2025 09:52:16 +0100
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
 <0e26494d-7b85-4874-a2e4-a498ce1864c8@linaro.org>
 <aFwN/LlXEmv82PcF@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFwN/LlXEmv82PcF@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/06/2025 3:55 pm, Frank Li wrote:
> On Wed, Jun 25, 2025 at 11:09:57AM +0100, James Clark wrote:
>>
>>
>> On 24/06/2025 5:50 pm, Frank Li wrote:
>>> On Tue, Jun 24, 2025 at 11:35:36AM +0100, James Clark wrote:
>>>> In target mode, the host sending more data than can be consumed would be
>>>> a common problem for any message exceeding the FIFO or DMA buffer size.
>>>> Cancel the whole message as soon as this condition is hit as the message
>>>> will be corrupted.
>>>>
>>>> Only do this for target mode in a DMA transfer because we need to add a
>>>> register read.
>>>
>>> "We need to add a register read" is not reason.
>>>
>>
>> Maybe: "It's not likely to catch any errors in host mode so optimize by
>> avoiding an extra register read"?
>>
>>> Add checking FIFO error status at target mode in a DMA transfer since PIO
>>> mode already do it. It help catch some host mode ...
>>>
>>
>> Are you suggesting that we check for FIFO errors in host mode too? It
>> requires an extra read and check in dspi_tx_dma_callback(), but I'm not sure
>> what it could catch. Realistically as long as everything is setup correctly
>> then neither of those flags will be set. It will either always work or never
>> work.
>>
>> It might be better to add it later if a use becomes apparent otherwise it's
>> extra noise in the code.
> 
> I think your origial last phrase is not good enough. You may rephrase it
> to make it clear.
> 
> for example: according to your patch
> 
> "Only do this for target mode in a DMA transfer because we need to add a register read."
> 
> "add a register read" is result, not a reason. the reason should be "you want
> host side capture such error."
> 
> Frank
> 
> 

Got it, thanks

>>
>>>> In IRQ and polling modes always do it because SPI_SR was
>>>> already read and it might catch some host mode programming/buffer
>>>> management errors too.
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
>>>>    1 file changed, 27 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>>>> index 58881911e74a..16a9769f518d 100644
>>>> --- a/drivers/spi/spi-fsl-dspi.c
>>>> +++ b/drivers/spi/spi-fsl-dspi.c
>>>> @@ -560,12 +560,24 @@ static void dspi_rx_dma_callback(void *arg)
>>>>    	complete(&dma->cmd_rx_complete);
>>>>    }
>>>>
>>>> +static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
>>>> +{
>>>> +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
>>>> +		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
>>>> +				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
>>>> +				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
>>>> +		return -EIO;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>>>    {
>>>>    	size_t size = dspi_dma_transfer_size(dspi);
>>>>    	struct device *dev = &dspi->pdev->dev;
>>>>    	struct fsl_dspi_dma *dma = dspi->dma;
>>>>    	int time_left;
>>>> +	u32 spi_sr;
>>>>    	int i;
>>>>
>>>>    	for (i = 0; i < dspi->words_in_flight; i++)
>>>> @@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>>>>
>>>>    	if (spi_controller_is_target(dspi->ctlr)) {
>>>>    		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
>>>> -		return 0;
>>>> +		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>>>> +		return dspi_fifo_error(dspi, spi_sr);
>>>>    	}
>>>>
>>>>    	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
>>>> @@ -1069,6 +1082,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
>>>>
>>>>    			if (spi_sr & SPI_SR_CMDTCF)
>>>>    				break;
>>>> +
>>>> +			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
>>>> +			if (dspi->cur_msg->status)
>>>> +				return;
>>>
>>>
>>> Although fifo error may happen after you check, it may reduce some possilbity
>>> and catch some problems.
>>>
>>> Frak
>>>
>>
>> Not sure what you mean by this one. But I've seen a few small errors now
>> that I look again. The error check should be before the transfer complete
>> break. And tries should be reset for each part of the message.
>>
>>>>    		} while (--tries);
>>>>
>>>>    		if (!tries) {
>>>> @@ -1085,6 +1102,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
>>>>    static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>>>    {
>>>>    	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
>>>> +	int status;
>>>>    	u32 spi_sr;
>>>>
>>>>    	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>>>> @@ -1093,6 +1111,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>>>    	if (!(spi_sr & SPI_SR_CMDTCF))
>>>>    		return IRQ_NONE;
>>>>
>>>> +	status = dspi_fifo_error(dspi, spi_sr);
>>>> +	if (status) {
>>>> +		if (dspi->cur_msg)
>>>> +			WRITE_ONCE(dspi->cur_msg->status, status);
>>>> +		complete(&dspi->xfer_done);
>>>> +		return IRQ_HANDLED;
>>>> +	}
>>>> +
>>>>    	dspi_rxtx(dspi);
>>>>
>>>>    	if (!dspi->len) {
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>


