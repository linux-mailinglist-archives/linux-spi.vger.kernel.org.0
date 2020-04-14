Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942A31A793C
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbgDNLQx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 07:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390864AbgDNLQv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 07:16:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6853620732;
        Tue, 14 Apr 2020 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586863009;
        bh=pdiAfPJFb7n9nJZw2BCIedfddr3UhffyVNfvLYt2UO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPUVkMFAz81FIftM+Vmg+bvhCKgrsM8OhIbsvcyWG6CKF4kAdUO+zV5x52fKy9n/n
         swFdI6d/PMyr/R3DdXPlvGx/9NAlFV1nMWR8ECFSnh5m7fOy97mAMg52FQzGL/TxVs
         AhgBPI/diFy5pJcD6+OMtqQrEx9Kb1q5KVmAKWVg=
Date:   Tue, 14 Apr 2020 12:16:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-amd: Add AMD SPI controller driver support
Message-ID: <20200414111646.GC5412@sirena.org.uk>
References: <1586719711-46010-1-git-send-email-sanju.mehta@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <1586719711-46010-1-git-send-email-sanju.mehta@amd.com>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 12, 2020 at 02:28:31PM -0500, Sanjay R Mehta wrote:

> +++ b/drivers/spi/spi-amd.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD SPI controller driver
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +#define DRIVER_NAME		"amd_spi"

This is unused.

> +/* M_CMD OP codes for SPI */
> +#define SPI_XFER_TX		1
> +#define SPI_XFER_RX		2

These constants should be namespaced, they're likely to collide with
generic additions.

> +static void amd_spi_execute_opcode(struct spi_master *master)
> +{
> +	struct amd_spi *amd_spi = spi_master_get_devdata(master);
> +	bool spi_busy;
> +
> +	/* Set ExecuteOpCode bit in the CTRL0 register */
> +	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
> +			       AMD_SPI_EXEC_CMD);
> +
> +	/* poll for SPI bus to become idle */
> +	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
> +		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
> +	while (spi_busy) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule();
> +		set_current_state(TASK_RUNNING);
> +		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
> +			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
> +	}

This is a weird way to busy wait - usually you'd use a cpu_relax()
rather than a schedule().  There's also no timeout here so we could busy
wait for ever if something goes wrong.

> +static int amd_spi_master_setup(struct spi_device *spi)
> +{
> +	struct spi_master *master = spi->master;
> +	struct amd_spi *amd_spi = spi_master_get_devdata(master);
> +
> +	amd_spi->chip_select = spi->chip_select;
> +	amd_spi_select_chip(master);

This looks like it will potentially affect devices other than the
current one.  setup() may be called while other devices are active it
shouldn't do that.

> +		} else if (m_cmd & SPI_XFER_RX) {
> +			/* Store no. of bytes to be received from
> +			 * FIFO
> +			 */
> +			rx_len = xfer->len;
> +			buffer = (u8 *)xfer->rx_buf;

> +		/* Read data from FIFO to receive buffer  */
> +		for (i = 0; i < rx_len; i++)
> +			buffer[i] = ioread8((u8 __iomem *)amd_spi->io_remap_addr
> +					    + AMD_SPI_FIFO_BASE
> +					    + tx_len + i);

This will only work for messages with a single receive transfer, if
there are multiple transfers then you'll need to store multiple buffers
and their lengths.

> +static int amd_spi_master_transfer(struct spi_master *master,
> +				   struct spi_message *msg)
> +{
> +	struct amd_spi *amd_spi = spi_master_get_devdata(master);
> +
> +	/*
> +	 * Extract spi_transfers from the spi message and
> +	 * program the controller.
> +	 */
> +	amd_spi_fifo_xfer(amd_spi, msg);
> +
> +	return 0;
> +}

This function is completely redundant, just inline amd_spi_fifo_xfer().
It also ignores all errors which isn't great.

> +	/* Initialize the spi_master fields */
> +	master->bus_num = 0;
> +	master->num_chipselect = 4;
> +	master->mode_bits = 0;
> +	master->flags = 0;

This device is single duplex so should flag that.

> +	err = spi_register_master(master);
> +	if (err) {
> +		dev_err(dev, "error registering SPI controller\n");
> +		goto err_iounmap;

It's best to print the error code to help people debug things.

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6Vm50ACgkQJNaLcl1U
h9DTLgf/a2X2W0MkhtYzKVnCDzBWqLhL2bdhBrNhEv9f6ypQVOKElUqCEOaz1Kij
tyynR5W+cil5lFwn5nem0JUJspA9NUTXKcVHr+mNtXOrhsnIRs4ivn4Cb3ONGYOo
sXOg58hjkdtY6hBu67aJZWc14GeA6ude9mIiSUqSeKg9BGtlT3NTKDJOegaRYwWB
KA2hjah9K1gHSiJz52UHi+zMetu/U+ZZ/dMTwnCcgRjSnRDrSJ2ymKvc7QfxXNTa
icA53PPUXqP0DpEB6koGdvG+1e3h84M9TUC6MlWXvT71HFZwric6twH/neCATnpL
sMIdkpafh0yVPgd/YxbklAJtdB/E9w==
=0Rfk
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
