Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87CB3FEF94
	for <lists+linux-spi@lfdr.de>; Thu,  2 Sep 2021 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbhIBOlS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Sep 2021 10:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345405AbhIBOlR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Sep 2021 10:41:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3D6860BD3;
        Thu,  2 Sep 2021 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630593619;
        bh=ecmU1nlRZYPspOA+dcNklCLT1a4QmdQBNB1z1TKgWEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkqYaudVpge5kJGtjRZNK2il+wSV0t9N1blFY0XtjhMXlb6c5CQPhbvPcjvR3dxXp
         zVnys4zJPCJtKV/MKyNNcMw9NWedpzV9nHvQ0vdJ5bSF1qJC7sqWvV8lUTIo+dh4Td
         EqvrNoJjRfuWrqSEBFXZ1kMDTMd6iAE2i164pil59RqerwGWGfWnvJAaDWSZodSKj5
         XHKgQrCVedRG0Bz0v890uiw23IB507Z2pSEd0I1S4TdPlhplzVZot2CwnW1tfbjwXl
         jPujoEKIVLgbXONgUwuzBudM8cRxpE8zLKAokTOBOLVufmRqt1/df7rp4fh1aepzFG
         vxafYeG2CyV+g==
Date:   Thu, 2 Sep 2021 15:39:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     lukas@wunner.de, p.yadav@ti.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        mparab@cadence.com, Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210902143947.GC11164@sirena.org.uk>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <1630499858-20456-1-git-send-email-pthombar@cadence.com>
X-Cookie: Famous last words:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 01, 2021 at 02:37:38PM +0200, Parshuram Thombare wrote:

> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -0,0 +1,837 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Cadence XSPI flash controller driver

Please make the entire comment a C++ so things look more intentional.

> +static int cdns_xspi_setup(struct spi_device *spi_dev)
> +{
> +	if (spi_dev->chip_select > spi_dev->master->num_chipselect) {
> +		dev_err(&spi_dev->dev,
> +			"%d chip-select is out of range\n",
> +			spi_dev->chip_select);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

The core already validates this, are you seeing it happen?  If so we
should fix the core and either way just remove setup() entirely.

> +	if (irq_status) {
> +		writel(irq_status,
> +		       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
> +
> +		if (irq_status & CDNS_XSPI_SDMA_ERROR) {
> +			dev_err(cdns_xspi->dev,
> +				"Slave DMA transaction error\n");
> +			cdns_xspi->sdma_error = true;
> +			complete(&cdns_xspi->sdma_complete);
> +		}
> +
> +		if (irq_status & CDNS_XSPI_SDMA_TRIGGER)
> +			complete(&cdns_xspi->sdma_complete);
> +
> +		if (irq_status & CDNS_XSPI_STIG_DONE)
> +			complete(&cdns_xspi->cmd_complete);
> +
> +		result = IRQ_HANDLED;
> +	}

We will just silently ignore any unknown interrupts here.  It would be
better to either only ack known interrupts (so genirq can notice if
there's a problem with other interrupts) or at least log that we're
seeing unexpected interrupts.  The current code will cause trouble if
this is deployed in a system with the interrupt line shared (which the
driver claims to support), or if something goes wrong and the IP starts
asserting some interrupt that isn't expected.

> +	master->mode_bits = SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
> +		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
> +		SPI_MODE_0  | SPI_MODE_3;

I don't see any handling of these in the code?

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEw4jIACgkQJNaLcl1U
h9AeUQf6AvUcJyMqWKj/l9liaSVcRZB8sz8grFHG9p3vohD8YWJt4amXrdROzZnh
teF3YX3NNdwkwiETqbzGyrC3qtcRr+AfC9xMIT2FmBVqlJ+o+g12tR1PFbGh8EBC
NqlakHDEordBCGefUf+aZ9PQcXviyH2fU1xxzlrUNKh9OTMY1GeOB5sFebTg+hRi
De59eLn6ArWy9NmQvPvl4R99/AlwvoWiQ92AM2ymCt6PFCTxc8ujNKUU/xfx9XmK
ov6Fmt8FAUN/baGLqn27rpByXUZDC6I5knFc433K+aiilr0jFka6g05iEvcs2/H3
2AfVv0MV7appwxAgIRJCQ+tN+BiugQ==
=ypa/
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
