Return-Path: <linux-spi+bounces-2830-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BA08C3D27
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10B5282423
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064F147C91;
	Mon, 13 May 2024 08:29:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369E147C72
	for <linux-spi@vger.kernel.org>; Mon, 13 May 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588942; cv=none; b=rbWzigc/XbUbJ23J6Tc+BdWZSFqLHHYxG3bhdPXy7ZUax4Cqi6t3xzto8LSkMwhVI4jXHYf3meP/asHXKKwH8e/ZE4rW2SP8bUQWC5lHrzotg+O5kxUP0lEztsJjwtSql8U/bVTjv7bOkXM/ITn8FFRJ4Iz8m6fTwloPlSg/DeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588942; c=relaxed/simple;
	bh=lHwMqh3/sQG+UrkqlERYWXvDvlxAsNbGETkH6rl1ZcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChX9nBdvTcXMjxI3ZbTSuvjNc3E0EUK+Mq06Fsv/pihtsJd3CuWvugKmecdQOcOOFY/FaQjJbKvxLfHxAwcEJmGRBEIuVAOVU1n/QsPY22jp3wJXDasz3Yc548Zbznqv6tyealTjvG+ZIG45Y9lsOE8rcgqUKU0yhOMmPd0bChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.goehrs@pengutronix.de>)
	id 1s6R3G-0005f7-2I; Mon, 13 May 2024 10:28:54 +0200
Message-ID: <39033ed7-3e57-4339-80b4-fc8919e26aa7@pengutronix.de>
Date: Mon, 13 May 2024 10:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: stm32: enable controller before asserting CS
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Brown
 <broonie@kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
References: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
Content-Language: en-US
From: =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.goehrs@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Hi,

I am in the process of updating an STM32MP157 based device from 6.8 to 6.9
and have noticed SPI related issues that may be caused by this change.

I am testing on an LXA TAC Generation 2 (arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dts)
and the issues I see are SPI transfer timeouts:

   [   13.565081] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
   [   13.565131] spi_master spi2: failed to transfer one message from queue
   [   13.565134] spi_stm32 44005000.spi: spurious IT (sr=0x00010002, ier=0x00000000)
   [   13.565145] spi_master spi2: noqueue transfer failed
   [   13.565183] panel-mipi-dbi-spi spi2.0: error -110 when sending command 0x2a
   [   13.769113] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
   [   13.769163] spi_master spi2: failed to transfer one message from queue
   [   13.769164] spi_stm32 44005000.spi: spurious IT (sr=0x00010002, ier=0x00000000)
   [   13.769177] spi_master spi2: noqueue transfer failed
   [   13.769210] panel-mipi-dbi-spi spi2.0: error -110 when sending command 0x2b
   [   13.977028] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
   [   13.977082] spi_master spi2: failed to transfer one message from queue
   [   13.977095] spi_master spi2: noqueue transfer failed
   [   14.460924] panel-mipi-dbi-spi spi2.0: SPI transfer timed out

Followed by workqueue lockups and the device becoming unresponsive later
in the boot, preventing me from logging in and investigating further that way:

   [   17.026263] spi_master spi2: noqueue transfer failed

   TAC OS - The LXA TAC operating system 24.04+dev lxatac-00011 ttySTM0

   lxatac-00011 login: root
   [   62.434326] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 44s!
   [   62.441321] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=-20 stuck for 44s!
   …

Reverting this commit fixes the issue for me. It may be some time before
I get around to investigating the issue in detail, so I thought I should
ask if anyone else has already noticed this as well.

We are currently in the process of adding the device in question to
KernelCI [1], which may help in catching such problems earlier.

[1]: https://github.com/kernelci/kernelci-core/pull/2542


On 24.04.24 15:52, Ben Wolsieffer wrote:
> On the STM32F4/7, the MOSI and CLK pins float while the controller is
> disabled. CS is a regular GPIO, and therefore always driven. Currently,
> the controller is enabled in the transfer_one() callback, which runs
> after CS is asserted.  Therefore, there is a period where the SPI pins
> are floating while CS is asserted, making it possible for stray signals
> to disrupt communications. An analogous problem occurs at the end of the
> transfer when the controller is disabled before CS is released.
> 
> This problem can be reliably observed by enabling the pull-up (if
> CPOL=0) or pull-down (if CPOL=1) on the clock pin. This will cause two
> extra unintended clock edges per transfer, when the controller is
> enabled and disabled.
> 
> Note that this bug is likely not present on the STM32H7, because this
> driver sets the AFCNTR bit (not supported on F4/F7), which keeps the SPI
> pins driven even while the controller is disabled.
> 
> Enabling/disabling the controller as part of runtime PM was suggested as
> an alternative approach, but this breaks the driver on the STM32MP1 (see
> [1]). The following quote from the manual may explain this:
> 
>> To restart the internal state machine properly, SPI is strongly
>> suggested to be disabled and re-enabled before next transaction starts
>> despite its setting is not changed.
> 
> This patch has been tested on an STM32F746 with a MAX14830 UART
> expander.
> 
> [1] https://lore.kernel.org/lkml/ZXzRi_h2AMqEhMVw@dell-precision-5540/T/
> 
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
> v2:
>   * Improve explanation of problem
>   * Discuss why not to use runtime PM instead
> 
>   drivers/spi/spi-stm32.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index e4e7ddb7524a..4a68abcdcc35 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1016,10 +1016,8 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
>   static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
>   {
>   	struct spi_controller *ctrl = dev_id;
> -	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
>   
>   	spi_finalize_current_transfer(ctrl);
> -	stm32fx_spi_disable(spi);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -1187,6 +1185,8 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
>   			 ~clrb) | setb,
>   			spi->base + spi->cfg->regs->cpol.reg);
>   
> +	stm32_spi_enable(spi);
> +
>   	spin_unlock_irqrestore(&spi->lock, flags);
>   
>   	return 0;
> @@ -1204,7 +1204,6 @@ static void stm32fx_spi_dma_tx_cb(void *data)
>   
>   	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
>   		spi_finalize_current_transfer(spi->ctrl);
> -		stm32fx_spi_disable(spi);
>   	}
>   }
>   
> @@ -1219,7 +1218,6 @@ static void stm32_spi_dma_rx_cb(void *data)
>   	struct stm32_spi *spi = data;
>   
>   	spi_finalize_current_transfer(spi->ctrl);
> -	spi->cfg->disable(spi);
>   }
>   
>   /**
> @@ -1307,8 +1305,6 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
>   
>   	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
>   
> -	stm32_spi_enable(spi);
> -
>   	/* starting data transfer when buffer is loaded */
>   	if (spi->tx_buf)
>   		spi->cfg->write_tx(spi);
> @@ -1345,8 +1341,6 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
>   
>   	spin_lock_irqsave(&spi->lock, flags);
>   
> -	stm32_spi_enable(spi);
> -
>   	/* Be sure to have data in fifo before starting data transfer */
>   	if (spi->tx_buf)
>   		stm32h7_spi_write_txfifo(spi);
> @@ -1378,8 +1372,6 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
>   		 */
>   		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
>   	}
> -
> -	stm32_spi_enable(spi);
>   }
>   
>   /**
> @@ -1413,8 +1405,6 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
>   
>   	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
>   
> -	stm32_spi_enable(spi);
> -
>   	if (STM32_SPI_HOST_MODE(spi))
>   		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
>   }

