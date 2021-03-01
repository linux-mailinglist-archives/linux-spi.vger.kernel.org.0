Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0071F328018
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhCAN4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 08:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhCAN4N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 08:56:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6258164E5C;
        Mon,  1 Mar 2021 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614606911;
        bh=zGC7/StaWRwdFP7Cp+9bLiNGjGmp0Q6jjYBd9yZBWQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJ3m5YurlpzMPUiEec48086xsShwdSNKc9bqsHs1Zqoyy+Qvu6cKXN9XPryawt+OT
         jaA1x5DVkNGtnO6Zh2J1MgsFYRAaNeY9Bzu+7kfDUrq9mi4dJyYWQ0x/lmsgcv5tDQ
         BOD4KyYYFK6NYO8gSMdfGqwk0kTknImEP2Fp6vLHyl4xOwqEVIOQiXBMSQC82zHdpv
         /PG4bxNoWI589BU0rVdCb4BK6y/wYZ/mMVY7jiUS3BBUeZsET5mGSq8K5/WQ/+ASpd
         oWhwY5x9l42Iemj77yOeyDALNSt8tW93oDEqbrKzc8V7/q1SoylvZ4IFVl4eYW5eOO
         VmyOPJ8lMwVhw==
Date:   Mon, 1 Mar 2021 13:54:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210301135405.GC4628@sirena.org.uk>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:

> This driver supports SPI Controller for HiSilicon Kunpeng SOCs. This
> driver supports SPI operations using FIFO mode of transfer.

> +HISILICON SPI Controller Driver
> +M:	Jay Fang <f.fangjian@huawei.com>
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +W:	http://www.hisilicon.com
> +F:	drivers/spi/spi-hisi.c

Please give this a more specific name, the commit message already says
this is for the Kunpeng SoCs but HiSilicon has other products, or may
choose to use a different IP in some future Kunpeng part for that
matter.

>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
>  obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
> +obj-$(CONFIG_SPI_HISI)			+= spi-hisi.o

Please keep the Kconfig and Makefile sorted.

> +++ b/drivers/spi/spi-hisi.c
> @@ -0,0 +1,573 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*

Please make the entire comment a C++ one so things look more
intentional.

> + * HiSilicon SPI Controller Driver (refer spi-dw-core.c)

This comment suggests that this is a variation of the DesignWare
controller if that is the case please extend that driver rather than
adding a totally new one.

> +/* Disable IRQ bits */
> +static void hisi_spi_mask_intr(struct hisi_spi *hs, u32 mask)
> +{
> +	u32 new_mask;
> +
> +	new_mask = readl(hs->regs + HISI_SPI_IMR) | mask;
> +	writel(new_mask, hs->regs + HISI_SPI_IMR);
> +}

This is a read/modify/write cycle and appears to be called from at least
process and interrupt context but I'm not seeing anything that stops two
different callers of it or the matching unmask function from running at
the same time.

> +	while (hisi_spi_rx_not_empty(hs) && max--) {
> +		rxw = readl(hs->regs + HISI_SPI_DOUT);
> +		/* Check the transfer's original "rx" is not null */
> +		if (hs->rx) {
> +			switch (hs->n_bytes) {
> +			case HISI_SPI_N_BYTES_U8:
> +				*(u8 *)(hs->rx) = rxw;
> +				break;
> +			case HISI_SPI_N_BYTES_U16:
> +				*(u16 *)(hs->rx) = rxw;
> +				break;
> +			case HISI_SPI_N_BYTES_U32:
> +				*(u32 *)(hs->rx) = rxw;
> +				break;
> +			}
> +			hs->rx += hs->n_bytes;
> +		}
> +		--hs->rx_len;

You can probably get better performance by running some of the transfers
in 32 bit or 16 bit mode, no need to do that to merge the driver though.
Also are you sure that the length is tracked properly for things that
aren't bytes?

> +static irqreturn_t hisi_spi_handle_transfer(struct hisi_spi *hs,
> +			u32 irq_status)
> +{
> +	struct spi_controller *master = hs->master;
> +
> +	/* Error handling */
> +	if (irq_status & ISR_RXOF) {
> +		dev_err(&master->dev, "%s\n",
> +			"interrupt_transfer: fifo overflow");

There is no need to use the %s here, it just makes the display more
confusing.

> +static irqreturn_t hisi_spi_irq(int irq, void *dev_id)
> +{
> +	struct spi_controller *master = dev_id;
> +	struct hisi_spi *hs = spi_controller_get_devdata(master);
> +	u32 irq_status = readl(hs->regs + HISI_SPI_ISR) & ISR_MASK;
> +
> +	if (!irq_status)
> +		return IRQ_NONE;
> +
> +	if (!master->cur_msg) {
> +		hisi_spi_mask_intr(hs, IMR_MASK);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return hisi_spi_handle_transfer(hs, irq_status);

It's probably clearer to just merge the two bits of this interrupt
handler here, it's a bit confusing that they're separate functions and
there's only the one caller of _handle_transfer().

> +static int hisi_spi_transfer_one(struct spi_controller *master,
> +		struct spi_device *spi, struct spi_transfer *transfer)
> +{
> +	struct hisi_spi *hs = spi_controller_get_devdata(master);
> +
> +	hs->n_bytes = hisi_spi_n_bytes(transfer);
> +	hs->tx = (void *)transfer->tx_buf;

If there's a need to cast to void * something is very wrong here.

> +	hs->tx_len = transfer->len / hs->n_bytes;
> +	hs->rx = transfer->rx_buf;
> +	hs->rx_len = hs->tx_len;
> +
> +	/* Ensure the data above is visible for all CPUs */
> +	smp_mb();

This memory barrier seems worrying...  are you *sure* this is the best
way to sync, and that the sync is best done here if it is needed rather
than after everything else is set up?

> +
> +	/* Disable is needed to deal with transfer timeout */
> +	hisi_spi_disable(hs);
> +
> +	hisi_spi_flush_fifo(hs);
> +	hisi_spi_update_cr(hs, spi, transfer);

Especially given this, if there may be some left over operations going
on elsewhere might there be races due to that?  I'm also wondering if
it's faster to just reset the controller as is done in some error
handling paths.

> +	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, IRQF_SHARED,
> +				dev_name(dev), master);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
> +		return ret;
> +	}

This will free the IRQ *after* the controller is unregistered, it's
better to manually free the interrupt

> +	ret = hisi_spi_add_host(&pdev->dev, hs);
> +	if (ret)
> +		return ret;

I don't see much value in splitting this out from the main probe
function, again it's just making the code a bit more complex.

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA88fwACgkQJNaLcl1U
h9AzKwf/ZzJB2G2zSgUaqLzVfCRk5YAIo2F4zthX51d3Yo7uGVaEUPXJrHItsX73
hj24aHDj7jvPtIKytxtl9M10ingHS1Sb2znq+c4r5QhZzMPRdC7Adnr5ynmOLvbI
j2UuDwjuHJoD5xpFQv5tHZGHqWajEhnEh3os6Vw3+rtXeMDfP8TbkZ4zT+uCyWdF
y6xrEjQqS6Zp3tmWkHveKlKMGZhJ4kuvMg3lFbK5l3L+seZelSpMvsH7RzVxCsyR
XhBaCVz5kOdYfR54WnmLeLcdiJMnwZAyyaK+0/Hpr0+stmkBbj8Pk1rkMCFUk6mZ
Uucu9sFc9X00o9BF0vTZopNAHdmfQA==
=PYes
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
