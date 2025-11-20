Return-Path: <linux-spi+bounces-11420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B2C75351
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812984F9F91
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F7A346FC0;
	Thu, 20 Nov 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="0YhPki+M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D70376BEB
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653866; cv=none; b=tcTHabt2hnJlNh7vAbhTgW1tjY9WGxhfwDRK6bX4pwEpAq87nSyBK92bKdysV5h1mmUY5UiRyijtc87PtyZO+Z6WHIxiVWD8NDQZiMjwuxH0SArjYQ7dAAGmfHAXeRh3OSVAfQc5dTRXawYUKz5ojl381K1mn4C14zjxJzBcoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653866; c=relaxed/simple;
	bh=kbGuukyo5NVuqdwX2FCzLSAFMv2gkrlyNzPgdYI6GCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icmNGIhoxG+ZaOOPmUpq/vmfdltIWSW7aUSYWGJle+Mu63E2mZ0weaYpB93kG1ZJtS8o6ZKEjWXW4I6eO6CyAbKhdFI4ID6Mm1gCUbROTjgjGkG2A3VLzVmhJrCI0Ls2RDnHB2dFYjZWhtk/zQySQhS11QZa31z7ThN3/IeR0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=0YhPki+M; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43346da8817so5654895ab.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763653862; x=1764258662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jVULdmnGJZUzqfCeuMvq76ewKlBDnLfe0I6V5R7xpM=;
        b=0YhPki+Mh1f38eY9cTpsFxkzRUKaZP2D1Q0ZdaERWlM8Z02t1GgxkTDfVXf+8C8doc
         9P/tWTEcqK8YgONy0FJfIjGl1qTjTxRbXd+jjoISX3E54m3mwJo5Jk4owxYWpvvuXT+s
         +F1vlqksATjaD9ewZuZ3+2z4qwAKd5TjEnsd298LJsodyMFtKvBrYvO5vSdBu/cStu+W
         qvqYkf+x9MY6tmZ179+haa/v69EIYk15FSiTVeag0CVpPo5JfHnpVXnwp0MfrqVoQ5ob
         AjMWr5zx6ZB4LkKI8pX7NOcWo8Hn9t8ZOr9Rz6JRt9upIfSe+P76FJALVyV5NDhGV/FS
         6gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653862; x=1764258662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jVULdmnGJZUzqfCeuMvq76ewKlBDnLfe0I6V5R7xpM=;
        b=ZMvaLI3y0rpvIFOHx3Xdp736Yfw7/zrF3wmaTtK8Ad4hSjIjh6aZzEyQ+lX1UXA69/
         0XHJ5j++4bnUe3pX00po5kjjBSRvIPxOZMdY4n1sR8jNqDebo8lD338SI8b1CImrap4Z
         eNE58oUNQ0nYBGqGLptowWuQ94axMQ2n9wZRRCV5xdnbl+t6Fw9yodx3bItk3g+gSiQ3
         B2EDcpP/FUkt26HvAzVDXlEDJMa4Fds9t4yJDVrUWphBfiowBnyxtDfGyCxG9O64TnVm
         zptWUGTHoHJUk5PuFHZQ6HZapKzASNZaocw6+rFJEgo+1jGknKVN277Zd7fsynAqw1d9
         zWpg==
X-Forwarded-Encrypted: i=1; AJvYcCUAXLlq6Rn9EZll3jBeFh8UldR1vq53/xUE/10b/xBnIqg73G07bKArjnXZLMaPvvgpze+Wq/PFHOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UO0QstsDM+UE9jlC3YNf/+0BBcVdrjgDLFia9M7oEHqs7peY
	R7HouK9A+xgGWzq6DisaXl/XqTmn0s5BhXPAfjV/ioSYtn6X30XgQPg1VXOkEg55E58=
X-Gm-Gg: ASbGncuO9TOYRpblXxGhJwLoYOFqBvVgqbE5F9V31/rAhilbfe3Fu+V9E3gpaejv3BC
	POhxYBw7IQfNrQfx3BoqEAMhaHCLwy+x8fOVpORTaFlIwwsRcrMHnPILNr7c5bAxNoqsvKKpfXf
	nhMs5J0dCX466n6NLy5jCUCZwpLjmKtjXheF9j+cHN5TAKQ7M2E9rzHXOqoePL8xBXoMmBEh+ha
	oyKlhRX1qdgp3MIVrUUjmk1k5JSNlSyDFzZrX9vJIw9Fy1qcqBdr/ne/CmKvZD/4fqZb4VxVv6d
	FCXnApQGnkrlQz6TuTMzi3gtfe01+AcI9gvz/Kb1lbSYl1trxHb1PWDZf9ZUrSUaAU8epye/oLM
	xig7CiMSl3pjJ3aR+OgRxgAZR8hLGQa4+kDFTzEGVnuG7G0ZCpIk4D7RKT0SMUA88wBK2wh91sF
	0LSDdcc3Zm9aVBiap9FTV8xjGLK0B1f3/ZHCjv94JhR3+Tt9YwrQ==
X-Google-Smtp-Source: AGHT+IHY73/hmK2ihdGHJpO3Mip0NgdP4MWhJ3aese0GPaKfQ3SvazcDhmEwhbgkWjtEbqE30jfr9w==
X-Received: by 2002:a05:6e02:b46:b0:434:96ea:ff45 with SMTP id e9e14a558f8ab-435aa8ee764mr24969925ab.19.1763653862415;
        Thu, 20 Nov 2025 07:51:02 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949386c3666sm99186439f.17.2025.11.20.07.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:51:02 -0800 (PST)
Message-ID: <963990a3-d39c-4e72-8add-02d98f59770a@riscstar.com>
Date: Thu, 20 Nov 2025 09:51:00 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Mark Brown <broonie@kernel.org>
Cc: dlan@gentoo.org, p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251114185745.2838358-1-elder@riscstar.com>
 <20251114185745.2838358-3-elder@riscstar.com> <aRoVqVtYLJJAPCia@sirena.co.uk>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aRoVqVtYLJJAPCia@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/25 12:19 PM, Mark Brown wrote:
> On Fri, Nov 14, 2025 at 12:57:43PM -0600, Alex Elder wrote:
> 
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.

Sorry for the delay responding to this.  You provided some really
great feedback and I appreciate it.

> This looks mostly good but there's a bit of open coding that looks like
> the driver could make more use of the core.
> 
>> @@ -0,0 +1,966 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SpacemiT K1 SPI controller driver
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
>> + */
> 
> Please make the entire comment a C++ one so things look more
> intentional.

I do see in drivers/spi/ files that start just like above,
and others that start with all "//" comments (more of the
former than the latter).  I really don't prefer using "//"
for anything but the SPDX ID, but... since you requested
it I will make that change.

>> +static bool k1_spi_map_dma_buffer(struct k1_spi_io *io, size_t len, void *dummy)
>> +{
>> +	struct device *dmadev = io->chan->device->dev;
>> +	unsigned int nents = DIV_ROUND_UP(len, SZ_2K);
>> +	struct sg_table *sgt = &io->sgt;
>> +	void *bufp = io->buf ? : dummy;
>> +	struct scatterlist *sg;
>> +	unsigned int i;
> 
> The SPI core can do DMA mapping for you, the only thing this is doing
> that's unusual is that it's imposing a fixed 2K limit on block sizes.

OK.  I will use the DMA support provided by the core.

> If this limit comes from the DMA controller (which looks to be the case
> since we feed the entire table into the DMA controller at once?) the
> core will already DTRT here, assuming the DMA controller correctly
> advertises this restriction.

I will verify this.

>> +static bool k1_spi_map_dma_buffers(struct k1_spi_driver_data *drv_data)
>> +{
> 
> ...
> 
>> +	/* Don't bother with DMA if we can't do even a single burst */
>> +	if (drv_data->len < dma_burst_size)
>> +		return false;
>> +
>> +	/* We won't use DMA if the transfer is too big, either */
>> +	if (drv_data->len > K1_SPI_MAX_DMA_LEN)
>> +		return false;
> 
> The core has a can_dma() callback for this.
> 
>> +static int k1_spi_transfer_one_message(struct spi_controller *host,
>> +					   struct spi_message *message)
>> +{
> 
> ...
> 
>> +	/* Hold frame low to avoid losing transferred data */
>> +	val = readl(drv_data->base + SSP_TOP_CTRL);
>> +	val |= TOP_HOLD_FRAME_LOW;
>> +	writel(val, drv_data->base + SSP_TOP_CTRL);
> 
> This looks like it should be a set_cs() operation?

I'll implement that, along with using spi_transfer_one_message().

>> +	list_for_each_entry(transfer, &message->transfers, transfer_list) {
>> +		reinit_completion(completion);
>> +
>> +		/* Issue the next transfer */
>> +		if (!k1_spi_transfer_start(drv_data, transfer)) {
>> +			message->status = -EIO;
>> +			break;
>> +		}
>> +
>> +		k1_spi_transfer_wait(drv_data);
>> +
>> +		k1_spi_transfer_end(drv_data, transfer);
> 
> Why not just implement the transfer_one() callback?  This just looks
> like it's duplicating code.

I'm working on this now, and it's the reason for the delay.
Methodically switching things over to the generic interface
has been taking some time, but I think I'm close now.

>> +static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
>> +{
> 
>> +	/* Get status and clear pending interrupts */
>> +	val = readl(drv_data->base + SSP_STATUS);
>> +	writel(val, drv_data->base + SSP_STATUS);
> 
> This unconditionally acknowledges all interrupts even if we didn't
> handle anything...This is a good observation.

There are only 6 interrupt conditions that get cleared.  Three
are errors, and the other three are read/write FIFO "ready"
interrupts.  The code that follows handles all of those, so
doing this right away was a sort of shorthand.

That said, there was a chance for an early return (if the
message pointer was null), and that should be checked before
we clear the status register.

In any case, my work the last day or so has included a lot
of tweaks to the handler.  I'll try to make it clear what's
done makes sense.

Thank you very much for the review.  I wish I had looked
harder at just using spi_transfer_one_message() before.
But I *love* suggestions that will make the code become
smaller and simpler.

					-Alex


