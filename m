Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07422C0CEB
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgKWOGl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 09:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbgKWOGk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 09:06:40 -0500
Received: from coco.lan (ip5f5ad5b5.dynamic.kabel-deutschland.de [95.90.213.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679D820782;
        Mon, 23 Nov 2020 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606140399;
        bh=wpNsUNVwsLY5jMAZPy42TCcbZQ0xV6gAyFD1qFGZyNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ovtMWwiapcbY+4qTXgHHVT40s/mdFxg8VNDvUXot3T3ItmCtb+pvAkbT9XwnG9LqU
         ezyuZtgVXZ6OpMK0WbVoBfYQTo11tt0bYjlDZHrBiEu0Obn63uWySZxBDeDjZwWf7X
         vGn9SQdaDNvz7bP+3HDAKdXqab53C2PU6PneDgdw=
Date:   Mon, 23 Nov 2020 15:06:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Kozlov Sergey <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH for-5.10] media: netup_unidvb: Don't leak SPI master in
 probe error path
Message-ID: <20201123150634.2bd62db7@coco.lan>
In-Reply-To: <48e6a396526bcd0a26e970036dbe3207cce57ea6.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
        <48e6a396526bcd0a26e970036dbe3207cce57ea6.1605512876.git.lukas@wunner.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Em Mon, 16 Nov 2020 09:23:13 +0100
Lukas Wunner <lukas@wunner.de> escreveu:

> If the call to spi_register_master() fails on probe of the NetUP
> Universal DVB driver, the spi_master struct is erroneously not freed.
> 
> Likewise, if spi_new_device() fails, the spi_controller struct is
> not unregistered.  Plug the leaks.
> 
> While at it, fix an ordering issue in netup_spi_release() wherein
> spi_unregister_master() is called after fiddling with the IRQ control
> register.  The correct order is to call spi_unregister_master() *before*
> this teardown step because bus accesses may still be ongoing until that
> function returns.
> 
> Fixes: 52b1eaf4c59a ("[media] netup_unidvb: NetUP Universal DVB-S/S2/T/T2/C PCI-E card driver")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org> # v4.3+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
> Cc: <stable@vger.kernel.org> # v4.3+
> Cc: Kozlov Sergey <serjk@netup.ru>
> ---
> @Mauro Carvalho Chehab:
> This patch needs to go in through the spi tree because it depends on
> commit 5e844cc37a5c, which is on the spi/for-5.10 branch.
> Please ack (barring any objections).  Thanks!

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I'm OK on having this merged via SPI mailing list.

> 
>  drivers/media/pci/netup_unidvb/netup_unidvb_spi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
> index d4f12c250f91..526042d8afae 100644
> --- a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
> +++ b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
> @@ -175,7 +175,7 @@ int netup_spi_init(struct netup_unidvb_dev *ndev)
>  	struct spi_master *master;
>  	struct netup_spi *nspi;
>  
> -	master = spi_alloc_master(&ndev->pci_dev->dev,
> +	master = devm_spi_alloc_master(&ndev->pci_dev->dev,
>  		sizeof(struct netup_spi));
>  	if (!master) {
>  		dev_err(&ndev->pci_dev->dev,
> @@ -208,6 +208,7 @@ int netup_spi_init(struct netup_unidvb_dev *ndev)
>  		ndev->pci_slot,
>  		ndev->pci_func);
>  	if (!spi_new_device(master, &netup_spi_board)) {
> +		spi_unregister_master(master);
>  		ndev->spi = NULL;
>  		dev_err(&ndev->pci_dev->dev,
>  			"%s(): unable to create SPI device\n", __func__);
> @@ -226,13 +227,13 @@ void netup_spi_release(struct netup_unidvb_dev *ndev)
>  	if (!spi)
>  		return;
>  
> +	spi_unregister_master(spi->master);
>  	spin_lock_irqsave(&spi->lock, flags);
>  	reg = readw(&spi->regs->control_stat);
>  	writew(reg | NETUP_SPI_CTRL_IRQ, &spi->regs->control_stat);
>  	reg = readw(&spi->regs->control_stat);
>  	writew(reg & ~NETUP_SPI_CTRL_IMASK, &spi->regs->control_stat);
>  	spin_unlock_irqrestore(&spi->lock, flags);
> -	spi_unregister_master(spi->master);
>  	ndev->spi = NULL;
>  }
>  



Thanks,
Mauro
