Return-Path: <linux-spi+bounces-10355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FDBAA2B7
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 19:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E56161823
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4103002BD;
	Mon, 29 Sep 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZT3ER36"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16802580E2;
	Mon, 29 Sep 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166926; cv=none; b=DWiTz2qnLfUYrUvoSkg0WrMtM+KfExW0bb38HGeSqQGothNp9laAAgzeLYK7sw6LTzr3ZGrMVBrCPerEIryAsVk4SJNhGnNrkTL589Uqaq2rZ+IHfc4Gx4158PiRO296YnR8WRNczDAjSBRhzj7RKdv1A96HAjFRKhPnGZMS3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166926; c=relaxed/simple;
	bh=xKSdXyclKtURS/6958s8l+F1kXgju1+RQlV/tYc2Sck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtrQlQw2N+lyylYibWRUJJqUambtntXEYDQYQXWrbyYb6DCP+fHE/wtpofijEkL3LhkUZFmFuzv+6oQx+yivZEdP+QeNgJEwsM+no/ZpOl/uySMwHurotgM+rOYIUOr0EgSjWt3FE5OVGMhoFu6W+EDFc680oCYp+8r8XPY31T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZT3ER36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D85C4CEF4;
	Mon, 29 Sep 2025 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759166926;
	bh=xKSdXyclKtURS/6958s8l+F1kXgju1+RQlV/tYc2Sck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZT3ER36gaOdwjVxchhpXqYhDp1qyDLzaMkoICEu1xsXmAL24HH1Q8zjhw0biljAB
	 wTqKksQ1DAigHYHb2kOrmne5R/bqqEovtrV/3OcNCvMtKyH9Ry1SbRe4lH03mdCw7t
	 MCmgMDyAB1H7jstxrjCtfKlyEtM3UWzJmVWK/WKLU5NQlUym2EYQLM0Eg7zxH3QetX
	 FXkuamFKphRhIxBDRGE361UrsiL6cYCJyt0jwdlM8sBBTnArX4uN/3b6ybxCiODmDh
	 uvj9OkjMLk6R4t4k8ntF+TSqmBzwET21pNiFNFh32gQk8AsoZG9bC3nUM1Y3fHCLuc
	 10rt/RKRFDdsQ==
Date: Mon, 29 Sep 2025 18:28:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Axiado Reviewers <linux-maintainer@axiado.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Prasad Bolisetty <pbolisetty@axiado.com>
Subject: Re: [PATCH v2 2/3] spi: axiado: Add driver for Axiado SPI DB
 controller
Message-ID: <aNrBx4KTgGT5OE72@finisterre.sirena.org.uk>
References: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
 <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-2-b0c089c3ba81@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cZ9/Y9e1KhVhzbDv"
Content-Disposition: inline
In-Reply-To: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-2-b0c089c3ba81@axiado.com>
X-Cookie: The star of riches is shining upon you.


--cZ9/Y9e1KhVhzbDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2025 at 01:58:02AM -0700, Vladimir Moravcevic wrote:
> The Axiado SPI controller is present in AX3000 SoC and Evaluation Board.
> This controller is operating in Host only mode.

This looks mostly good, but the formatting is a bit odd, one small bug
and there are licensing problems.

> Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
> Signed-off-by: Prasad Bolisetty <pbolisetty@axiado.com>

The signoff of the person sending the mail should be last.

> +++ b/drivers/spi/spi-axiado.c
> @@ -0,0 +1,1029 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Axiado SPI controller driver (Host mode only)
> + *
> + * Copyright (C) 2022-2025 Axiado Corporation (or its affiliates). All rights reserved.
> + *
> + */

All rights reserved or GPL?

Please make the entire comment a C++ one so things look more
intentional.

> +	/* xspi->clk_rate - AMBA Slave clock frequency
> +	 * transfer->speed_hz - Slave clock required frequency
> +	 * As per data sheet - SCD = (AMBA Slave clock/SCK) - 2
> +	 */

Please use terms like "device" rather than outdated ones like slave.

> +}
> +/**

Blank line between functions please.

> +	/* Process any remaining bytes in the RX FIFO */
> +	u32 avail_bytes = ax_spi_read(xspi, AX_SPI_RX_FBCAR);
> +
> +	// This loop handles bytes that are already staged from a previous word read
> +	while (xspi->bytes_left_in_current_rx_word_for_irq &&

The mix of /* and // seems a bit random, does it mean something?

> +	 * Handle "Message Transfer Complete" interrupt.
> +	 * This means all bytes have been shifted out of the TX FIFO.
> +	 * It's time to harvest the final incoming bytes from the RX FIFO.
> +	 */
> +	if (intr_status & AX_SPI_IVR_MTCV) {

> +		ax_spi_process_rx_and_finalize(ctlr);
> +		return IRQ_HANDLED;
> +	}

> +	if (intr_status & AX_SPI_IVR_RFFV) {

We can't get incoming and outgoing data interrupts simultaneously
asserted?

> +	drain_limit = AX_SPI_RX_FIFO_DRAIN_LIMIT; // Sane limit to prevent infinite loop on HW error
> +	while (ax_spi_read(xspi, AX_SPI_RX_FBCAR) > 0 && drain_limit-- > 0)
> +		(void)ax_spi_read(xspi, AX_SPI_RXFIFO); // Read and discard
> +

If you need the cast to void there something is going wrong.

> +	ax_spi_setup_transfer(spi, transfer);
> +	ax_spi_fill_tx_fifo(xspi);
> +	ax_spi_write(xspi, AX_SPI_CR2, (AX_SPI_CR2_HTE | AX_SPI_CR2_SRD | AX_SPI_CR2_SWD));
> +
> +	spi_transfer_delay_exec(transfer);

The core will implement any per transfer delays, this will double them.

> +	fifo_total_bytes = xspi->tx_fifo_depth;
> +	/* Calculate protocol overhead bytes according to the real operation each time. */
> +	protocol_overhead_bytes = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;

/*
 *
 */


> +	/*Calculate the maximum data payload that can fit into the FIFO. */

/* Calculate

--cZ9/Y9e1KhVhzbDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjawcMACgkQJNaLcl1U
h9D7uAf/ezOiFJAnnp9OphHFZ36w2sWLfl3KC6kZn/2aKFTkXioJE01EmJO8HPPJ
RJDxyTI2cAGVkS2LoZiXTWf0YL16mI17L4M3lhHT7ce/s5DRdGVz6l49oXvNsod3
M/K4RdzPhQ0f8cJPbFGkiAhEoeh6vCcBY1V2du2DUQgci2QnhNpEaUaoL/+WRbv5
teS3pnjbOq/JgkNtI72x41qLK1930i33S79IMulm03r95rEtCA0ucaB/QaI+81px
YZrlk9W8s7pD8gFqmwVM2bN2GS6AzIsi3TfetTA7I0vVlKTg83PytJpzRNQFzgNr
3rzwhnjnTo6jZxQag5ZFxNVstjMwsA==
=WP3J
-----END PGP SIGNATURE-----

--cZ9/Y9e1KhVhzbDv--

