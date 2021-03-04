Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF532CD31
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 07:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhCDGz2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 01:55:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4644 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbhCDGzA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 01:55:00 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DrhQ255hlzYDmQ;
        Thu,  4 Mar 2021 14:52:42 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 4 Mar
 2021 14:54:15 +0800
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>,
        <linuxarm@huawei.com>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
From:   "Fangjian (Jay)" <f.fangjian@huawei.com>
Message-ID: <7693d3a5-733f-36e3-4af7-12aac5c13bde@huawei.com>
Date:   Thu, 4 Mar 2021 14:54:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210301135405.GC4628@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CC:linux-spi

Dear Mark,

Sorry, there are some format problems in the earlier reply email,
please ignore it. Please reply based on this email.

Thanks
Jay

On 2021/3/1 21:54, Mark Brown wrote:
> On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
> 
>> This driver supports SPI Controller for HiSilicon Kunpeng SOCs. This
>> driver supports SPI operations using FIFO mode of transfer.
> 
>> +HISILICON SPI Controller Driver
>> +M:	Jay Fang <f.fangjian@huawei.com>
>> +L:	linux-spi@vger.kernel.org
>> +S:	Maintained
>> +W:	http://www.hisilicon.com
>> +F:	drivers/spi/spi-hisi.c
> 
> Please give this a more specific name, the commit message already says
> this is for the Kunpeng SoCs but HiSilicon has other products, or may
> choose to use a different IP in some future Kunpeng part for that
> matter.
Will fix.
> 
>>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
>>  obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
>> +obj-$(CONFIG_SPI_HISI)			+= spi-hisi.o
> 
> Please keep the Kconfig and Makefile sorted.
> 
Will fix.

>> +++ b/drivers/spi/spi-hisi.c
>> @@ -0,0 +1,573 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
> 
> Please make the entire comment a C++ one so things look more
> intentional.
> 
Will fix.
>> + * HiSilicon SPI Controller Driver (refer spi-dw-core.c)
> 
> This comment suggests that this is a variation of the DesignWare
> controller if that is the case please extend that driver rather than
> adding a totally new one.
> 
The hardware processing flow code is very different, so it would be
unrealistic to extend one driver to achieve compatibility with two
different IPs.

>> +/* Disable IRQ bits */
>> +static void hisi_spi_mask_intr(struct hisi_spi *hs, u32 mask)
>> +{
>> +	u32 new_mask;
>> +
>> +	new_mask = readl(hs->regs + HISI_SPI_IMR) | mask;
>> +	writel(new_mask, hs->regs + HISI_SPI_IMR);
>> +}
> 
> This is a read/modify/write cycle and appears to be called from at least
> process and interrupt context but I'm not seeing anything that stops two
> different callers of it or the matching unmask function from running at
> the same time.
> 
Those mask/unmask will not be called at the same time from process and
interrupt context. In process context, unmask will be called after SPI
controller be Disable and Flush (interrupt handing has ended).

>> +	while (hisi_spi_rx_not_empty(hs) && max--) {
>> +		rxw = readl(hs->regs + HISI_SPI_DOUT);
>> +		/* Check the transfer's original "rx" is not null */
>> +		if (hs->rx) {
>> +			switch (hs->n_bytes) {
>> +			case HISI_SPI_N_BYTES_U8:
>> +				*(u8 *)(hs->rx) = rxw;
>> +				break;
>> +			case HISI_SPI_N_BYTES_U16:
>> +				*(u16 *)(hs->rx) = rxw;
>> +				break;
>> +			case HISI_SPI_N_BYTES_U32:
>> +				*(u32 *)(hs->rx) = rxw;
>> +				break;
>> +			}
>> +			hs->rx += hs->n_bytes;
>> +		}
>> +		--hs->rx_len;
> 
> You can probably get better performance by running some of the transfers
> in 32 bit or 16 bit mode, no need to do that to merge the driver though.
> Also are you sure that the length is tracked properly for things that
> aren't bytes?
> 
hs->tx_len = transfer->len / hs->n_bytes;
As the code above, the length is not in bytes.

>> +static irqreturn_t hisi_spi_handle_transfer(struct hisi_spi *hs,
>> +			u32 irq_status)
>> +{
>> +	struct spi_controller *master = hs->master;
>> +
>> +	/* Error handling */
>> +	if (irq_status & ISR_RXOF) {
>> +		dev_err(&master->dev, "%s\n",
>> +			"interrupt_transfer: fifo overflow");
> 
> There is no need to use the %s here, it just makes the display more
> confusing.
> 
Will change.
>> +static irqreturn_t hisi_spi_irq(int irq, void *dev_id)
>> +{
>> +	struct spi_controller *master = dev_id;
>> +	struct hisi_spi *hs = spi_controller_get_devdata(master);
>> +	u32 irq_status = readl(hs->regs + HISI_SPI_ISR) & ISR_MASK;
>> +
>> +	if (!irq_status)
>> +		return IRQ_NONE;
>> +
>> +	if (!master->cur_msg) {
>> +		hisi_spi_mask_intr(hs, IMR_MASK);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	return hisi_spi_handle_transfer(hs, irq_status);
> 
> It's probably clearer to just merge the two bits of this interrupt
> handler here, it's a bit confusing that they're separate functions and
> there's only the one caller of _handle_transfer().
> 
Will change.
>> +static int hisi_spi_transfer_one(struct spi_controller *master,
>> +		struct spi_device *spi, struct spi_transfer *transfer)
>> +{
>> +	struct hisi_spi *hs = spi_controller_get_devdata(master);
>> +
>> +	hs->n_bytes = hisi_spi_n_bytes(transfer);
>> +	hs->tx = (void *)transfer->tx_buf;
> 
> If there's a need to cast to void * something is very wrong here.
> 
Yes, fix compile warning.
>> +	hs->tx_len = transfer->len / hs->n_bytes;
>> +	hs->rx = transfer->rx_buf;
>> +	hs->rx_len = hs->tx_len;
>> +
>> +	/* Ensure the data above is visible for all CPUs */
>> +	smp_mb();
> 
> This memory barrier seems worrying...  are you *sure* this is the best
> way to sync, and that the sync is best done here if it is needed rather
> than after everything else is set up?
> 
The commit 0b6bfad ("spi: spi-dw: Remove extraneous locking") explains
why memory barrier is needed here. And put it here to make it easier to
understand.
>> +
>> +	/* Disable is needed to deal with transfer timeout */
>> +	hisi_spi_disable(hs);
>> +
>> +	hisi_spi_flush_fifo(hs);
>> +	hisi_spi_update_cr(hs, spi, transfer);
> 
> Especially given this, if there may be some left over operations going
> on elsewhere might there be races due to that?  I'm also wondering if
> it's faster to just reset the controller as is done in some error
> handling paths.
Will fix this. Disable and Flush will be done before fill hisi_spi's
transfer info.
> 
>> +	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, IRQF_SHARED,
>> +				dev_name(dev), master);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
>> +		return ret;
>> +	}
> 
> This will free the IRQ *after* the controller is unregistered, it's
> better to manually free the interrupt
> 
Ok
>> +	ret = hisi_spi_add_host(&pdev->dev, hs);
>> +	if (ret)
>> +		return ret;
> 
> I don't see much value in splitting this out from the main probe
> function, again it's just making the code a bit more complex.
Ok
> 





