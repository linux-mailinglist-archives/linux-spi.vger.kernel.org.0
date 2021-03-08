Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5269330C44
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHLYe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 06:24:34 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:3350 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCHLYS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 06:24:18 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DvGBy3mmqz5Yq9;
        Mon,  8 Mar 2021 19:22:02 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 8 Mar
 2021 19:24:15 +0800
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>,
        <linuxarm@huawei.com>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
 <79a0bb79-654b-8afc-f34a-c3a08bae275c@huawei.com>
 <20210304123425.GA4731@sirena.org.uk>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <88de0bfa-c0a5-f2b9-ab10-bc163e36d92a@huawei.com>
Date:   Mon, 8 Mar 2021 19:24:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210304123425.GA4731@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dear Mark,

On 2021/3/4 20:34, Mark Brown wrote:
> On Thu, Mar 04, 2021 at 10:54:40AM +0800, Fangjian (Jay) wrote:
>> On 2021/3/1 21:54, Mark Brown wrote:
>>> On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
> 
>>>> +/* Disable IRQ bits */
>>>> +static void hisi_spi_mask_intr(struct hisi_spi *hs, u32 mask)
>>>> +{
>>>> +	u32 new_mask;
>>>> +
>>>> +	new_mask = readl(hs->regs + HISI_SPI_IMR) | mask;
>>>> +	writel(new_mask, hs->regs + HISI_SPI_IMR);
>>>> +}
> 
>>> This is a read/modify/write cycle and appears to be called from at least
>>> process and interrupt context but I'm not seeing anything that stops two
>>> different callers of it or the matching unmask function from running at
>>> the same time.
> 
>> Those mask/unmask will not be called at the same time from process and
>> interrupt context. In process context, unmask will be called after SPI
>> controller be Disable and Flush (interrupt handing has ended).
> 
> Given that this is disabling the interrupt that doesn't sound like it's
> going to be entirely robust - if we need to disable the interrupt
> presumably there's some chance it might fire.

> +
> +	/* Disable is needed to deal with transfer timeout */
> +	hisi_spi_disable(hs);
> +
> +	hisi_spi_flush_fifo(hs);
> +	hisi_spi_update_cr(hs, spi, transfer);
Especially given this, if there may be some left over operations going
on elsewhere might there be races due to that?  I'm also wondering if
it's faster to just reset the controller as is done in some error
handling paths. (Mark)

As the previous review said, would it be better to reset controller
and waiting for interrupt to complete in error handling paths?
As shown in the code below.

	static void hisi_spi_handle_err(struct spi_controller *master,
		struct spi_message *msg)
	{
		struct hisi_spi *hs = spi_controller_get_devdata(master);

		hisi_spi_reset(hs);
		hisi_spi_flush_fifo(hs);

		/*
		 * Wait for interrupt handler that is
		 * already in timeout to complete.
		 */
		synchronize_irq(hs->irq);
	}

This ensures that the new transfer will not start until the previous
transfer is completed. And we don't need to disable the controller
every time before data transfer.


Thanks
Jay

> 
>>>> +	struct hisi_spi *hs = spi_controller_get_devdata(master);
>>>> +
>>>> +	hs->n_bytes = hisi_spi_n_bytes(transfer);
>>>> +	hs->tx = (void *)transfer->tx_buf;
>>> If there's a need to cast to void * something is very wrong here.
> 
>> Yes, fix compile warning.
> 
> This cast just masks whatever the problem is, if the compiler is
> complaining about using a void pointer it's spotted an issue.
Will fix.
> 
>>>> +	/* Ensure the data above is visible for all CPUs */
>>>> +	smp_mb();
> 
>>> This memory barrier seems worrying...  are you *sure* this is the best
>>> way to sync, and that the sync is best done here if it is needed rather
>>> than after everything else is set up?
> 
>> The commit 0b6bfad ("spi: spi-dw: Remove extraneous locking") explains
>> why memory barrier is needed here. And put it here to make it easier to
>> understand.
> 
> The reader of this code won't have any kind of pointer to that commit,
> this needs to be clearer.
Will fix.
> 


