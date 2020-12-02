Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF762CC3C3
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbgLBR2e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 12:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389133AbgLBR2d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 12:28:33 -0500
Date:   Wed, 2 Dec 2020 17:27:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606930071;
        bh=MPAQ9HG1EWyVVFVnD2aFee4ZP8j1of0y7BE+v8pRSww=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=zadRVGZ+FIY02EBv2pomvtVB4qp3w+t5WEwbFkSCr5zGB6gIREMSaIP46MhT+OMc5
         blNaczpDPT2QWWX21MhFcfK/HSRsRwDPO0bUkAhpvkcwvw4a1Lo2QmOKX2tSaEd2GM
         lmWa35nYcvhMuTTPNfyUFzpdAaNsbgLPWE9zhKEk=
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <20201202172721.GL5560@sirena.org.uk>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
> Tegra SoC has a Quad SPI controller starting from Tegra210.
>=20
> This patch adds support for Tegra210 QSPI controller.

This looks pretty clean but I've got a few questions below about how
this integrates with the frameworks as well as some more minor issues.

> +config QSPI_TEGRA
> +	tristate "Nvidia Tegra QSPI Controller"

Everything else in this file is SPI_, even the qspi controllers.

> +++ b/drivers/spi/qspi-tegra.c
> @@ -0,0 +1,1418 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 NVIDIA CORPORATION.  All rights reserved.
> + */

Please make the entire comment a C++ one.  It also appears that the "All
rights reserved" here conflicts with the GPL-2.0-only SPDX statement...

> +static void
> +tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi_data *tqspi,
> +					   struct spi_transfer *t)
> +{
> +	/* Make the dma buffer to read by cpu */
> +	dma_sync_single_for_cpu(tqspi->dev, tqspi->tx_dma_phys,
> +				tqspi->dma_buf_size, DMA_TO_DEVICE);
> +
> +	if (tqspi->is_packed) {
> +		unsigned int len =3D tqspi->curr_dma_words *
> +				   tqspi->bytes_per_word;
> +
> +		memcpy(tqspi->tx_dma_buf, t->tx_buf + tqspi->cur_pos, len);
> +		tqspi->cur_tx_pos +=3D tqspi->curr_dma_words *
> +				     tqspi->bytes_per_word;

It seems weird that this device needs us to do a memcpy() to do DMA,
most devices are able to DMA directly from the buffers provided by the
SPI API (and let the SPI core sync things).  What is going on here?

> +	tegra_qspi_writel(tqspi, status, QSPI_FIFO_STATUS);
> +	while ((status & QSPI_FIFO_EMPTY) !=3D QSPI_FIFO_EMPTY) {
> +		status =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(tqspi->dev,
> +				"timeout waiting for fifo flush\n");
> +			return -EIO;
> +		}
> +
> +		udelay(1);
> +	}

It'd be good to put a cpu_relax() in the busy loop.

> +static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi,
> +					 struct spi_transfer *t,
> +					 bool is_first_of_msg)
> +{

> +		/* toggle cs to active state */
> +		if (spi->mode & SPI_CS_HIGH)
> +			command1 |=3D QSPI_CS_SW_VAL;
> +		else
> +			command1 &=3D ~QSPI_CS_SW_VAL;
> +		tegra_qspi_writel(tqspi, command1, QSPI_COMMAND1);

This is worrying, the client device might be confused if /CS is doing
things outside of the standard handling.

> +	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
> +			     &cdata->tx_clk_tap_delay);
> +	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
> +			     &cdata->rx_clk_tap_delay);

These properties are not mentioned in the binding document.

> +static int tegra_qspi_setup(struct spi_device *spi)
> +{

> +	if (cdata && cdata->tx_clk_tap_delay)
> +		tx_tap =3D cdata->tx_clk_tap_delay;
> +	if (cdata && cdata->rx_clk_tap_delay)
> +		rx_tap =3D cdata->rx_clk_tap_delay;
> +	tqspi->def_command2_reg =3D QSPI_TX_TAP_DELAY(tx_tap) |
> +				  QSPI_RX_TAP_DELAY(rx_tap);
> +	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);

The setup for one device shouldn't be able to affect the operation of
another, already running, device so either these need to be configured
as part of the controller probe or these configurations need to be
deferred until we're actually doing a transfer.

> +	/*
> +	 * Tegra QSPI hardware support dummy bytes transfer based on the
> +	 * programmed dummy clock cyles in QSPI register.
> +	 * So, get the total dummy bytes from the dummy bytes transfer in
> +	 * spi_messages and convert to dummy clock cyles.
> +	 */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (ntransfers =3D=3D DUMMY_BYTES_XFER &&
> +		    !(list_is_last(&xfer->transfer_list, &msg->transfers)))
> +			dummy_cycles =3D xfer->len * 8 / xfer->tx_nbits;
> +		ntransfers++;
> +	}

This seems weird, there's some hard coded assumption about particular
patterns that the client device is going to send.  What's going on here?
I don't really understand what this is trying to do.

> +static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
> +{
> +	struct tegra_qspi_data *tqspi =3D context_data;
> +
> +	tqspi->status_reg =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
> +	if (tqspi->cur_direction & DATA_DIR_TX)
> +		tqspi->tx_status =3D tqspi->status_reg &
> +				   (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
> +
> +	if (tqspi->cur_direction & DATA_DIR_RX)
> +		tqspi->rx_status =3D tqspi->status_reg &
> +				   (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
> +	tegra_qspi_mask_clear_irq(tqspi);
> +
> +	return IRQ_WAKE_THREAD;
> +}

It's a bit unclear to me the value we gain from having this handler - if
we don't specify a handler genirq will already mask the interrupt until
we get to the thread anyway and we could just read the status in the
threaded handler.  OTOH it doesn't do any harm, just struck me as a bit
odd.

> +	master =3D spi_alloc_master(&pdev->dev, sizeof(*tqspi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "master allocation failed\n");
> +		return -ENOMEM;
> +	}

Please switch to using the devm_ version of the API to allocate
controller, it makes things much more robust.

> +	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
> +				 &master->max_speed_hz))
> +		master->max_speed_hz =3D QSPI_MAX_SPEED;

The core will do this for you.

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HznkACgkQJNaLcl1U
h9Dvegf/QlZMImpAudDFLOG4Cd2V2E42AyofUM3XUWuTJ7PtboxO1kHvHZg215Mo
nov8Yr6mt3e3McRYfLDgTmk3FDx0QM2FxQG/IcXu3dKlpnF8Zb7d68WJ6KIbsNUD
hlMwo9xzNHeC4QJFAHnvDqyq+MWTn68B/PVkINmCF/ZhENNcAVCHlg8kbnpaHjVl
01wpKQTXntMB6ALMv1fdhDPFf3ag/dgeAGAkVIUJLaCJBmgnxfkUZRyODzdqpyGj
UAk1/fdn0iLWKrlqqiEzVZzKibh4j/xQ0gFLt/jtLVxf7ubdLVU0Tate/IEcd8b3
5Hp7ZEhWqtQHin4HfmAY3+lkxXpH6w==
=ush/
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
