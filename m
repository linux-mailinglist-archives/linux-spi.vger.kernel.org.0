Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0E92AC071
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgKIQEr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 11:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIQEr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 11:04:47 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850AE206CB;
        Mon,  9 Nov 2020 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604937886;
        bh=qpWupAqFktlAEJCGUxawGfsjvPHqwItam4PilNDZDXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odJWZEdORfx4XYNW+XSLTcqpyLh0L6/TizWw7/tBSYB0os70KfIybjw1fYuz2377d
         TZLCkYm3yI1wN/YILWmIFVM5fwhRHo/ij6rbj2SLFFg5g4uH+Qu/q/wfw+ZaTeA1R7
         D0UWuhrjTm+M+XZAwx4UXPGqnh/LqjXpXQbLeXHY=
Date:   Mon, 9 Nov 2020 16:04:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Message-ID: <20201109160432.GF6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-5-damien.lemoal@wdc.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 07, 2020 at 05:13:52PM +0900, Damien Le Moal wrote:

> With boards that have slow interrupts context switch, and a fast device
> connected to a spi master, e.g. an SD card through mmc-spi, using
> dw_spi_poll_transfer() intead of the regular interrupt based
> dw_spi_transfer_handler() function is more efficient and can avoid a lot
> of RX FIFO overflow errors while keeping the device SPI frequency
> reasonnably high (for speed). Introduce the "polling" device tree
> property to allow requesting polled processing of transfer depending on
> the connected device while keeping the spi master interrupts property
> unschanged. E.g. device trees such as:

This isn't something that looks like it should be configured via DT as a
separate property, this is more of a tuning property as far as I can see
- even on the same hardware there might be cases where people prefer to
keep using interrupts but for example allow transfers to stall while
waiting for the interrupt controller giving lower throughput but more
CPU cycles available for other things.

Unfortunately we don't have any information about how much interrupt
latency we should expect which makes this a bit annoying.  I do see that
there's already some existing attempt in the DMA code to tune burst
sizes to avoid FIFO overflows - it looks like the hardware is doing
something unusual and possibly unfortunate here though I've never
looked at it so I'm not sure exactly what is going on there but perhaps
ther's some tuning that can be done in there?  TBH I'm not clear what
the failure mode is where we need software to service interrupts
promptly in the middle of a DMA transfer in the first place, that seems
really strange.

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+paI8ACgkQJNaLcl1U
h9D74gf+M46xb04/TMs2lLQseMfMEPw7Fh0jhSYWXuEmx5c0TM/8PPV56XCoV6CF
RuIPkAKLK0Gz0FwLWQ7hNLwz9TczwxzKygGLVcODVuQqhQf7rRlTb4wABZirWIkp
GnOJ3npCwKyvsCc61l3sdyasnwbnmi1X3X3qgmLWEGrK1RAyVLF/bx8swuL29L9n
LUdhKqqzFHS0czgcTQXMgkrGE7GpM2CFZP7bYA/meuOjLB6/8u9siqAdD/e/Fvub
ccmw/vmi5UIUGSP0xTc5p27QmjqOG/8GiZIGq4IPqKdawxgErIrYoLblm4N/BGrT
EmfK2cMi+qlFLQLy76Fixh/wnOZhSg==
=mHA6
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
