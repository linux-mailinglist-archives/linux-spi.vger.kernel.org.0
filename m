Return-Path: <linux-spi+bounces-10239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93521B95DE9
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789601894F81
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BD322DC1;
	Tue, 23 Sep 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dAjaEmgk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5125A63D
	for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631769; cv=none; b=RYu7bjHo9dVG1eiNH7U3BeKw+F8XGR1UDUJEa49akur7uURl+Jm7funlkAKRCAz//GTn/lpes6cMQumhWtk9wX+hPDxcKfcPjSpWFnV0vZgHTpBbdES1eNZWS8/jfkI996oExkxz00FXO97FwhtpzV/ocK9notTSRfI3EvlEsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631769; c=relaxed/simple;
	bh=viMHlMgc2DeVPr1JzbzU5Lkyrq+sYbfd7FhWBYhy4fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhhY9Z70fmHYMrkdymkWOJ4/2djeFje/2uMw6FKSRuKqmE7BWABgtQT4ORT2SUgZWanozYb/5LcfOiDGueQvL5naZ6rsVD6fyY11VnFHgIg/51FNFz3UhiHXZJ+9FTNfugerFjYjfvf6WQLbIm25sm/Wmf2wnYxTYkRv6nKSxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dAjaEmgk; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3fe48646d40so29481035ab.0
        for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758631765; x=1759236565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU9aQ8bM7T2Ftc+EDUk8mZlFRUJvemFzpUBxk0Wb8I=;
        b=dAjaEmgk2y/UZ1dYIOFTm5C8p92Lk/An3f8xyNUz1ElBUboF4ZQ3WbirrpFT/PHKYG
         J0w40nIjk1dhlYeUlDKnpVQMutNAY3NshcSKxroTQbjfsiUH9AcNj7VPfvB3zxlqHV5N
         Kk7T4AWMzRkxZudAb9Id0E9tCVIY/sWehnpA2jXPUN3j+//FUTNjngibEfYZOlnQHqdF
         SRFsY9Utl3ymLON3YwCwK4+ZX4Q4cEIevm4QUEz1fxhGW5P2f0NEKjgiCLhm0ksQBGH+
         AFp6+68lQC5AZETSNd989ygpNJjNALRtXAnClUwJluJUQ2zXziz4VF23tuMR9s7PDCKO
         iSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631765; x=1759236565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU9aQ8bM7T2Ftc+EDUk8mZlFRUJvemFzpUBxk0Wb8I=;
        b=I7VXd62mZEvw2TM+JVgCJ9VGexPWfVFm1AbUgFnNaX0vXR9eUfBx4VUVbSut5hTE8Y
         OOZwY+Qf7si/l/RF9w34b6FoKQJq6zrBS/t8kSgCy5boj2CX0NvVzDDJNySThjROgk45
         9Ef82wdcla8xHWMIlq+fGHk8dC/hfnc0bpF3961baHzZ8lGV83Wsoc/NCj5MRMnHPeIN
         NQ1XuOIZ9YneJP6IQ+G9jnU/oC6JJ1OL6sTnU5nVL5Ui7FOyC8pPtEI9+BVuiKBOsjTM
         k5fmnTunB1J2w9hCVQQTsxY64VlsPV2RFjdo9hwahVolSsagtvHS7tltZR6dDeGvii2m
         e+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT1rmRnLm7fSAiNWs4IMd8Tm68TkJmb4JaVq44G4Fwm/AR5BrvgHLG7BJsbVF84nLJrXOdaXMBfTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAkQYODORLLC3Zk7Vf6yi4DqVrnMer4EqOVl/cmalBorcU3ge
	eIzNO0fBsHoWT4Wt9qKNx8rqVLiZouzETIQ8Fv6p6a6RzI7fyOr4n+/sNqsmsKVUmV8=
X-Gm-Gg: ASbGncvAFROlYd3FgZNISrWeGduApIspxePgxJIZaWICOgaTXC9hYnELfezYfSSpfVz
	CKL0t3zP4LVFIq5jdzsBccWaGjoUfQzQ8ACP5/2OI+X5JyN3vgwsTBTVVEkK/9wwta2Au4TgG94
	YxlSot64FWsBwOHvIDGCZKXuA0NT+a2+fTtfPXHNzBmnm5yiyXpvFWIHCK5W5qI7KCgLk4VWFFB
	BRneFI7B23gCj5x3hN6SlXO2kbLjjRIhn+Tl5VJ31SeDyQIjcbjFqprJvrsE6qHzaQhNiMOYAz3
	BSnpUBQPDY5erQAnI1oJBx3p+1bUfxI9FhbwcyPFxPQXT3rqT2b7h9hhS0zo+X+AYkob3etlC3Q
	aukszvjRfD46pjve7V3cpBVR31R3/6zTO+F4a0bWU5j85Jkq7EWPsn47tgrm9ng==
X-Google-Smtp-Source: AGHT+IFj1XQAMzFpu45XELaWdmBGc77d+Kzj8EzJZoLjGXq7RU8vmmffnX+IA/9d84nt85uqzgtH9A==
X-Received: by 2002:a92:c24b:0:b0:424:2c9:26b5 with SMTP id e9e14a558f8ab-425823254efmr34685275ab.9.1758631764817;
        Tue, 23 Sep 2025 05:49:24 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556f74174cfsm3556602173.57.2025.09.23.05.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:49:24 -0700 (PDT)
Message-ID: <786f4a5e-f62e-4cd0-a017-7b61408f34aa@riscstar.com>
Date: Tue, 23 Sep 2025 07:49:22 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-3-elder@riscstar.com>
 <20250922230639-GYA1303776@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250922230639-GYA1303776@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 6:06 PM, Yixun Lan wrote:
> Hi Alex,
> 
> On 11:17 Mon 22 Sep     , Alex Elder wrote:
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v3: - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
>>      - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
>>      - Added a comment stating we use 1, 2, or 4 bytes per word
>>      - Cleaned up DMA channels properly in case of failure setting up
>>      - No longer use devm_*() for allocating DMA channels or buffer
>>
>>   drivers/spi/Kconfig           |   9 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-spacemit-k1.c | 965 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 975 insertions(+)
>>   create mode 100644 drivers/spi/spi-spacemit-k1.c

. . .

>> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
>> new file mode 100644
>> index 0000000000000..2b932d80cc510
>> --- /dev/null
>> +++ b/drivers/spi/spi-spacemit-k1.c
>> @@ -0,0 +1,965 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Support for SpacemiT K1 SPI controller
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
>> + */

. . .

>> +static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
>> +{
>> +	struct k1_spi_driver_data *drv_data = dev_id;
>> +	bool rx_done;
>> +	bool tx_done;
>> +	u32 val;
>> +
>> +	/* Get status and clear pending interrupts */
>> +	val = readl(drv_data->base + SSP_STATUS);
>> +	writel(val, drv_data->base + SSP_STATUS);
>> +
>> +	if (!drv_data->message)
>> +		return IRQ_NONE;
>> +
>> +	/* Check for a TX underrun or RX underrun first */
> s/RX underrun/RX overrun/

OK.

>> +	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
>> +		/* Disable all interrupts on error */
>> +		writel(0, drv_data->base + SSP_INT_EN);
> should clear status of SSP_STATUS instead of disabling ISR, see commet below

The status is cleared immediately after reading, above.  We hold
the status value so we can act on the current state of the FIFOs.

>> +
>> +		drv_data->message->status = -EIO;
>> +		complete(&drv_data->completion);
>> +
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	/* Drain the RX FIFO first, then transmit what we can */
>> +	rx_done = k1_spi_read(drv_data);
>> +	tx_done = k1_spi_write(drv_data);
>> +
>> +	/* Disable interrupts if we're done transferring either direction */
>> +	if (rx_done || tx_done) {
>> +		/* If both are done, disable all interrupts */
>> +		if (rx_done && tx_done) {
>> +			val = 0;
>> +		} else {
>> +			val = readl(drv_data->base + SSP_INT_EN);
>> +			if (rx_done)
>> +				val &= ~(SSP_INT_EN_TINTE | SSP_INT_EN_RIE);
>> +			if (tx_done)
>> +				val &= ~SSP_INT_EN_TIE;
>> +		}
>> +		writel(val, drv_data->base + SSP_INT_EN);
>> +	}
> It occur to me, enabling/disabling interrupt in trasfer_start()/ISR is
> unnecessary, which bring extra overhead, why not enable them once
> and only handle status clear bit? I mean bits has "R/W1C" in SSP_STATUS

Disabling the TX interrupt when we are done sending means we
won't get a pointless "more room in the FIFO" interrupt.

Disabling the RX interrupt when we have received what we want
means we won't get interrupted again, even if (for some reason)
there is more in the FIFO to consume.

I think this is OK.

					-Alex

>> +
>> +	if (rx_done && tx_done)
>> +		complete(&drv_data->completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int k1_spi_probe(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct reset_control *reset;
>> +	struct spi_controller *host;
>> +	struct resource *iores;
>> +	struct clk *clk_bus;
>> +	int ret;
>> +
>> +	host = devm_spi_alloc_host(dev, sizeof(*drv_data));
>> +	if (!host)
>> +		return -ENOMEM;
>> +	drv_data = spi_controller_get_devdata(host);
>> +	drv_data->controller = host;
>> +	platform_set_drvdata(pdev, drv_data);
>> +	drv_data->dev = dev;
>> +	init_completion(&drv_data->completion);
>> +
>> +	drv_data->base = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +								&iores);
>> +	if (IS_ERR(drv_data->base))
>> +		return dev_err_probe(dev, PTR_ERR(drv_data->base),
>> +				     "error mapping memory\n");
>> +	drv_data->base_addr = iores->start;
>> +
>> +	ret = devm_k1_spi_dma_setup(drv_data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "error setting up DMA\n");
>> +
>> +	k1_spi_host_init(drv_data);
>> +
>> +	clk_bus = devm_clk_get_enabled(dev, "bus");
>> +	if (IS_ERR(clk_bus))
>> +		return dev_err_probe(dev, PTR_ERR(clk_bus),
>> +				     "error getting/enabling bus clock\n");
>> +	drv_data->bus_rate = clk_get_rate(clk_bus);
>> +
>> +	drv_data->clk = devm_clk_get_enabled(dev, "core");
>> +	if (IS_ERR(drv_data->clk))
>> +		return dev_err_probe(dev, PTR_ERR(drv_data->clk),
>> +				     "error getting/enabling core clock\n");
>> +
>> +	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>> +	if (IS_ERR(reset))
>> +		return dev_err_probe(dev, PTR_ERR(reset),
>> +				     "error getting/deasserting reset\n");
>> +
>> +	k1_spi_register_reset(drv_data, true);
>> +
>> +	drv_data->irq = platform_get_irq(pdev, 0);
>> +	if (drv_data->irq < 0)
>> +		return dev_err_probe(dev, drv_data->irq, "error getting IRQ\n");
>> +
>> +	ret = devm_request_irq(dev, drv_data->irq, k1_spi_ssp_isr,
>> +			       IRQF_SHARED, dev_name(dev), drv_data);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "error requesting IRQ\n");
>> +
>> +	ret = devm_spi_register_controller(dev, host);
>> +	if (ret)
>> +		dev_err(dev, "error registering controller\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void k1_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data = platform_get_drvdata(pdev);
>> +
>> +	k1_spi_register_reset(drv_data, false);
>> +}
>> +
>> +static struct platform_driver k1_spi_driver = {
>> +	.driver = {
>> +		.name		= "k1-spi",
>> +		.of_match_table	= k1_spi_dt_ids,
>> +	},
>> +	.probe			= k1_spi_probe,
>> +	.remove			= k1_spi_remove,
>> +};
>> +
>> +module_platform_driver(k1_spi_driver);
>> +
>> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.48.1
>>
> 


