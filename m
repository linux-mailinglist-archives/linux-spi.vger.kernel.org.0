Return-Path: <linux-spi+bounces-10198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20556B8E3AB
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B843BCF45
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15B22332E;
	Sun, 21 Sep 2025 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="0DrFFI/y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C61FE471
	for <linux-spi@vger.kernel.org>; Sun, 21 Sep 2025 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481890; cv=none; b=Gwy91Z+2UC2X3cW0wWGn+FlzIov+FwIGAJUZZYps2BIibVvo98gjtBPk6SbkIQVcz7b5LgUmJq9EIuNrucbCY63qacDaUip9EKvVHhglQ7j1RBWPhm2zLyqyEWG9ulwia89829VUPfe4Bl0BImhVychrZgJfkyIJczGp2rOvJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481890; c=relaxed/simple;
	bh=srYtm3oBIvUj97TCmmHwjRWYDpoeZlRczyaWQJBFgdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCEcHxaBmtXUXtAQ61A+KFy1X9+mf50S7exo7BqYQbMTJ8Uu122dTJJnh4y0W5n7cBwC3rOQL77QIA96JzTZKKCHJGtTho8K+YeqEqrqxkHP5OTRC4k0vao0eY5GazwQDxDKDn1S41ZMZa0NbwM5pzuDew7u5nyaNxleSXZyHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=0DrFFI/y; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8ca2e53c0d3so10205739f.1
        for <linux-spi@vger.kernel.org>; Sun, 21 Sep 2025 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758481887; x=1759086687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMuX0JbtGkVS69zIsmL/4yyhk/kkfK+G5uLsvMrvjAc=;
        b=0DrFFI/yVgPu8zg9A96I9D2wbRjG4taQv5iURQSuwpWDoYVCm7KHSys7bfL7gk7sES
         IiwWoEFJp2sa+ConHzeZpaDhDfBFSj6NGIkPK9PbUWL0DhGHKt5CxLlTsh6SKqAtJMt0
         Lyi82QWgYT78aIRNkwfeeJVBw/XFsZbtjkcNGflJyqAsOgH0N5qwi9HE4rsotR6HIOuK
         JaTUzzZ1fZREKbARMUsy2gUY6JEvQvr/Z6fXxeHloZxppsRpC4LvY/JFmIY+YHuDhSbv
         7uOEHjIVgFLP4mACRNNHGAuhYQOrn3Rr4N4elC2lCd0Q6rhhmF/hXATv33J3JYkGuVCv
         BP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758481887; x=1759086687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMuX0JbtGkVS69zIsmL/4yyhk/kkfK+G5uLsvMrvjAc=;
        b=q8BSXslGBWvM5eAz1pvqzTO4DoMJMaJVzFwLkKksbd7f3iSbND0Jet7yfDINkoaQnN
         BMGOnkX378p6YM7zZS/0ESW/Prd0W6+4Mj2oqUS+Cgmrh/5HX7+Lh/rFxDEuEaUOxVum
         pnjfKQNJTAYJlY/5cDzrLBxgvloQjLgZYHdWXQvMifDMcisMxtuS4RH/PS2cyv1n0sdu
         iEcIPMEofisoxT4TbMQTN3u+WoyBKAjdM0zGVoOfAcCSQZotBey4Q6MVXiTSIW62fHpt
         e2nV3S1In1PbZDF5SfNuuf8ICe1sbZc29MgBn+dFYKDe3LIPj2GRIPxLsm/2IvyuTl/e
         ajJA==
X-Forwarded-Encrypted: i=1; AJvYcCUyr9TXBiRCVET7AjeJ1A3KmQwx4q1lVFqurGudOLxjJm8T5Dsd9WrAnmxknnrkXyrNA4KjU188kPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8i/BiPTW7ndQp06gq2CZF7INsRLp/OqP8ZbJkaMIC/EDTjWlR
	a1owPya1p/OvSJQfw4EBrwSp2WLxzUGHynAKhprKe5aYap4fpm76fWtX8HJ4BjhfpXo=
X-Gm-Gg: ASbGnctK3EfSjQN5TNeXFaIk5tmx/gkFGI5ueZ80qpFjFUSTd7sVVVx7OvwslYc6AkP
	CPpsFk4zxPXRtz2hayPGVi6TgsDaQCbauNA8zwwenh4KkgPeAOOmCk04A0kHMpLq53xEgzrGPWY
	W0W1XuKh/4dI8NPce1aJ7ygGGk7P0CIIF6gXIcFDcYtom5b/ab438dCdFK0yubucUUnAUmEy63z
	bBn6dW7IYBZA2n72+0voNWQhjZKCy7MnBByWztenOpQPxMukAB5aNtA++9tgEPMBWfz24pNhK3a
	ZI095s4pbdmy0T2SLXNDl+xD23COgyjocSpnM+CoJWSGkO3UZA5mIJpnrGqnl1OyAglKDdxLUPx
	GtbzosVmtba2zIF/SCo00wxqL8iEUIjSKSdF74Vh7eN04CvOYxg9lqNPIOounzmfFJ1Nzxd8=
X-Google-Smtp-Source: AGHT+IErLvmxbESoatXMb3XqN+8yw94Jw5Exiri+q1GvICGK0rTfRDmu/C2sh2YMSDRU5YG3uU2tzA==
X-Received: by 2002:a05:6e02:190a:b0:425:7526:7f56 with SMTP id e9e14a558f8ab-425752680c5mr30193615ab.5.1758481887085;
        Sun, 21 Sep 2025 12:11:27 -0700 (PDT)
Received: from [10.211.55.5] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-55ec34ec281sm107152173.0.2025.09.21.12.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 12:11:26 -0700 (PDT)
Message-ID: <ab64c617-f0a0-4dd8-95c9-cf85486d5612@riscstar.com>
Date: Sun, 21 Sep 2025 14:11:25 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Troy Mitchell <troy.mitchell@linux.dev>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-3-elder@riscstar.com>
 <aM9t7fO_DyIG92Rx@troy-wujie14pro-arch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aM9t7fO_DyIG92Rx@troy-wujie14pro-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/25 10:15 PM, Troy Mitchell wrote:
> On Fri, Sep 19, 2025 at 10:59:12AM -0500, Alex Elder wrote:
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - The SPI_SPACEMIT_K1 config option is added in sorted order
>>      - The spi-spacemit-k1.o make target is now added in sorted order
>>      - Read/modify/writes of registers no longer use an additional
>>        "virt" variable to hold the address accessed
>>      - The k1_spi_driver_data->ioaddr field has been renamed base
>>      - The DMA address for the base address is maintained, rather than
>>        saving the DMA address of the data register
>>      - CONFIG_MMP_PDMA is checked at runtime, and if it is not enabled,
>>        DMA will not be used
>>      - The spi-max-frequency property value is now bounds checked
>>      - A local variable is now initialized to 0 in k1_spi_write_word()
>>      - The driver name is now "k1-spi"
>>
>>   drivers/spi/Kconfig           |   8 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-spacemit-k1.c | 968 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 977 insertions(+)
>>   create mode 100644 drivers/spi/spi-spacemit-k1.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 82fa5eb3b8684..4f6c446c6bc16 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -1071,6 +1071,14 @@ config SPI_SG2044_NOR
>>   	  also supporting 3Byte address devices and 4Byte address
>>   	  devices.
>>   
>> +config SPI_SPACEMIT_K1
>> +	tristate "K1 SPI Controller"
>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on OF
>> +	default ARCH_SPACEMIT
>> +	help
>> +	  Enable support for the SpacemiT K1 SPI controller.
>> +
>>   config SPI_SPRD
>>   	tristate "Spreadtrum SPI controller"
>>   	depends on ARCH_SPRD || COMPILE_TEST
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index eefaeca097456..637d750ead996 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -140,6 +140,7 @@ obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
>>   obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
>>   obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
>>   obj-$(CONFIG_SPI_SG2044_NOR)	+= spi-sg2044-nor.o
>> +obj-$(CONFIG_SPI_SPACEMIT_K1)		+= spi-spacemit-k1.o
>>   obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
>>   obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
>>   obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
>> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
>> new file mode 100644
>> index 0000000000000..8d564fe6c4303
>> --- /dev/null
>> +++ b/drivers/spi/spi-spacemit-k1.c
>> @@ -0,0 +1,968 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Support for SpacemiT K1 SPI controller
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
> SpacemiT?

Already addressed this suggestion, which Yixun also made.
  
https://lore.kernel.org/lkml/034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com/


> 
>> + */
>> +
> [...]
>> +static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct k1_spi_io *rx = &drv_data->rx;
>> +	u32 bytes = drv_data->bytes;
>> +	u32 val;
>> +
>> +	val = readl(drv_data->base + SSP_DATAR);
>> +	rx->resid -= bytes;
>> +
>> +	if (!rx->buf)
>> +		return;	/* Null reader: discard the data */
>> +
>> +	if (bytes == 1)
>> +		*(u8 *)rx->buf = val;
>> +	else if (bytes == 1)
> typo?

Yes, Vivian noticed this too.  It's a bug, and it will be
fixed in the next version.
  
https://lore.kernel.org/lkml/a7070f3f-8857-4834-9e9e-02068637075c@iscas.ac.cn/

> 
>> +		*(u16 *)rx->buf = val;
>> +	else
>> +		*(u32 *)rx->buf = val;
>> +
>> +	rx->buf += bytes;
>> +}
>> +
> [...]
>> +static bool k1_spi_write(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct k1_spi_io *tx = &drv_data->tx;
>> +	unsigned int count;
>> +	u32 val;
>> +
>> +	if (!tx->resid)
>> +		return true;	/* Nothing more to send */
>> +
>> +	/* See how many slots in the TX FIFO are available */
>> +	val = readl(drv_data->base + SSP_STATUS);
>> +	count = FIELD_GET(SSP_STATUS_TFL, val);
>> +
>> +	/* A zero count means the FIFO is either full or empty */
>> +	if (!count) {
>> +		if (val & SSP_STATUS_TNF)
>> +			count = K1_SPI_FIFO_SIZE;
>> +		else
>> +			return false;	/* No room in the FIFO */
> please early return:

OK.

> 
> if (!(val & SSP_STATUS_TNF))
>    return false;
> count = K1_SPI_FIFO_SIZE;
>> +	}
>> +
>> +	/*
>> +	 * Limit how much we try to send at a time, to reduce the
>> +	 * chance the other side can overrun our RX FIFO.
>> +	 */
>> +	count = min3(count, K1_SPI_THRESH, tx->resid);
>> +	while (count--)
>> +		k1_spi_write_word(drv_data);
>> +
>> +	return !tx->resid;
>> +}
>> +
> [...]
>> +
>> +static int k1_spi_transfer_one_message(struct spi_controller *host,
>> +					   struct spi_message *message)
>> +{
>> +	struct k1_spi_driver_data *drv_data = spi_controller_get_devdata(host);
>> +	struct completion *completion = &drv_data->completion;
>> +	struct spi_transfer *transfer;
>> +	u32 val;
>> +
>> +	drv_data->message = message;
>> +
>> +	/* Message status starts out successful; set to -EIO on error */
>> +	message->status = 0;
>> +
>> +	/* Hold frame low to avoid losing transferred data */
>> +	val = readl(drv_data->base + SSP_TOP_CTRL);
>> +	val |= TOP_HOLD_FRAME_LOW;
>> +	writel(val, drv_data->base + SSP_TOP_CTRL);
>> +
>> +	list_for_each_entry(transfer, &message->transfers, transfer_list) {
>> +		reinit_completion(completion);
>> +
>> +		/* Issue the next transfer */
>> +		if (!k1_spi_transfer_start(drv_data, transfer)) {
>> +			message->status = -EIO;
>> +			break;
> we don't need return a error code?

You're right.  This always returns 0.  I think I'll
just return message->status.

Thank you for catching this.  I'll fix it in the next version.

					-Alex


> 
>> +		}
>> +
>> +		k1_spi_transfer_wait(drv_data);
>> +
>> +		k1_spi_transfer_end(drv_data, transfer);
>> +
>> +		/* If an error has occurred, we're done */
>> +		if (message->status)
>> +			break;
> ditto.
> 
> [...]
>> +}
>> +
>> +static void k1_spi_dma_cleanup(struct device *dev, void *res)
>> +{
>> +	struct k1_spi_driver_data *drv_data = res;
>> +
>> +	if (k1_spi_dma_enabled(drv_data)) {
> if (!k1_spi_dma_enabled(drv_data))
>    return;
> 
>                    - Troy
> 
>> +		k1_spi_dma_cleanup_io(drv_data, false);
>> +		k1_spi_dma_cleanup_io(drv_data, true);
>> +	}
>> +}
>> +
>> +
>> +static const struct of_device_id k1_spi_dt_ids[] = {
>> +	{ .compatible = "spacemit,k1-spi", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, k1_spi_dt_ids);
>> +
>> +static void k1_spi_host_init(struct k1_spi_driver_data *drv_data)
>> +{
>> +	struct device_node *np = dev_of_node(drv_data->dev);
>> +	struct spi_controller *host = drv_data->controller;
>> +	struct device *dev = drv_data->dev;
>> +	u32 max_speed_hz;
>> +	int ret;
>> +
>> +	host->dev.of_node = np;
>> +	host->dev.parent = drv_data->dev;
>> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
>> +	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>> +	host->num_chipselect = 1;
>> +
>> +	if (k1_spi_dma_enabled(drv_data))
>> +		host->dma_alignment = K1_SPI_DMA_ALIGNMENT;
>> +	host->cleanup = k1_spi_cleanup;
>> +	host->setup = k1_spi_setup;
>> +	host->transfer_one_message = k1_spi_transfer_one_message;
>> +
>> +	ret = of_property_read_u32(np, "spi-max-frequency", &max_speed_hz);
>> +	if (!ret) {
>> +		host->max_speed_hz = clamp(max_speed_hz, K1_SPI_MIN_SPEED_HZ,
>> +					   K1_SPI_MAX_SPEED_HZ);
>> +		if (host->max_speed_hz != max_speed_hz)
>> +			dev_warn(dev, "spi-max-frequency %u out of range, using %u\n",
>> +				max_speed_hz, host->max_speed_hz);
>> +	} else {
>> +		if (ret != -EINVAL)
>> +			dev_warn(dev, "bad spi-max-frequency, using %u\n",
>> +				 K1_SPI_DEFAULT_MAX_SPEED_HZ);
>> +		host->max_speed_hz = K1_SPI_DEFAULT_MAX_SPEED_HZ;
>> +	}
>> +}
>> +
>> +/* Set our registers to a known initial state */
>> +static void
>> +k1_spi_register_reset(struct k1_spi_driver_data *drv_data, bool initial)
>> +{
>> +	u32 val = 0;
>> +
>> +	writel(0, drv_data->base + SSP_TOP_CTRL);
>> +
>> +	if (initial) {
>> +		/*
>> +		 * The TX and RX FIFO thresholds are the same no matter
>> +		 * what the speed or bits per word, so we can just set
>> +		 * them once.  The thresholds are one more than the values
>> +		 * in the register.
>> +		 */
>> +		val = FIELD_PREP(FIFO_RFT_MASK, K1_SPI_THRESH - 1);
>> +		val |= FIELD_PREP(FIFO_TFT_MASK, K1_SPI_THRESH - 1);
>> +	}
>> +	writel(val, drv_data->base + SSP_FIFO_CTRL);
>> +
>> +	writel(0, drv_data->base + SSP_INT_EN);
>> +	writel(0, drv_data->base + SSP_TIMEOUT);
>> +
>> +	/* Clear any pending interrupt conditions */
>> +	val = readl(drv_data->base + SSP_STATUS);
>> +	writel(val, drv_data->base + SSP_STATUS);
>> +}
>> +
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
>> +	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
>> +		/* Disable all interrupts on error */
>> +		writel(0, drv_data->base + SSP_INT_EN);
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
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


