Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3493F15D7FA
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBNNJy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 08:09:54 -0500
Received: from foss.arm.com ([217.140.110.172]:32886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNNJy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 14 Feb 2020 08:09:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31AA91FB;
        Fri, 14 Feb 2020 05:09:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84A23F68F;
        Fri, 14 Feb 2020 05:09:53 -0800 (PST)
Date:   Fri, 14 Feb 2020 13:09:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <20200214130952.GI4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline
In-Reply-To: <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 07:46:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> +static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
> +{
> +	struct cqspi_st *cqspi = dev;
> +	unsigned int irq_status;
> +
> +	/* Read interrupt status */
> +	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
> +
> +	/* Clear interrupt */
> +	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
> +
> +	irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
> +
> +	if (irq_status)
> +		complete(&cqspi->transfer_complete);
> +
> +	return IRQ_HANDLED;
> +}

This will unconditionally handle the interrupt regardless of if the
hardware was actually flagging an interrupt which will break shared
interrupts and the fault handling code in genirq.

> +	tmpbufsize = op->addr.nbytes + op->dummy.nbytes;
> +	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
> +	if (!tmpbuf)
> +		return -ENOMEM;

I'm not clear where tmpbuf gets freed or passed out of this function?

> +
> +	if (op->addr.nbytes) {
> +		for (i = 0; i < op->addr.nbytes; i++)
> +			tmpbuf[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
> +
> +		addr_buf = tmpbuf;

We assign tmpbuf to addr_buf here but addr_buf just gets read from so
it's not via that AFAICT.

> +	}
> +	/* Invalid address return zero. */

Missing blank line.

> +static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
> +{
> +	struct cqspi_st *cqspi = f_pdata->cqspi;
> +	void __iomem *reg_base = cqspi->iobase;
> +	unsigned int chip_select = f_pdata->cs;
> +	unsigned int reg;
> +
> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
> +	reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
> +
> +	/* Convert CS if without decoder.
> +	 * CS0 to 4b'1110
> +	 * CS1 to 4b'1101
> +	 * CS2 to 4b'1011
> +	 * CS3 to 4b'0111
> +	 */
> +	chip_select = 0xF & ~(1 << chip_select);

This says "if without decoder" but there's no conditionals here, what if
we do have a decoder?

> +	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
> +	ddata  = of_device_get_match_data(dev);
> +	if (ddata) {
> +		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
> +			cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
> +						cqspi->master_ref_clk_hz);
> +		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
> +			master->mode_bits |= SPI_RX_OCTAL;
> +		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
> +			cqspi->use_dac_mode = true;
> +		if (ddata->quirks & CQSPI_NEEDS_ADDR_SWAP) {
> +			master->bus_num = 0;
> +			master->num_chipselect = 2;
> +		}
> +	}

Given that the driver appears to unconditionally dereference match data
in other places I'd expect this to return an error if there's none,
otherwise we'll oops in those other code paths later on.

> +	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
> +			       pdev->name, cqspi);
> +	if (ret) {
> +		dev_err(dev, "Cannot request IRQ.\n");
> +		goto probe_reset_failed;
> +	}

Are you sure that it's safe to use devm_request_irq() - what happens if
the interrupt fires in the process of removing the device?

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GnB8ACgkQJNaLcl1U
h9C+fgf+Om+8sIQDPfShzyjlZsc5xBZOp8oDvh4pUB/LyqN2yM/zEyliKQW+lWOK
fR7W7t5WsTnJaHGyniMVPQs3duaCXpHKZYZgM9U7dhvrMnsX+6A6OZgsJDc3HwfZ
+Z1qQ5vEIOjv2A41gp26X6yp6rlG/7HyT2clyKL4fuoszBQQn231DLOYlh2rzIHN
hpgIOR2aNl0tz9HybLexivn6d5CmqYxrvvpRavkxpFTii9ReX9xNVhGz9BZRCrr0
xFqXz1MjYnTrB0HdEMjVn+RfT8TbdT5BcmNp4SRc9OigZuQrtraC0NNvrUxZfuIS
z8eVTgg4kHixNvaVrt5uWJ49071S5g==
=5DCl
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--
