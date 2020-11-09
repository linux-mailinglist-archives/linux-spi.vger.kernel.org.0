Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0DC2AC5E0
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 21:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgKIUVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 15:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgKIUVH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 15:21:07 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082B7206C0;
        Mon,  9 Nov 2020 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604953266;
        bh=Zq7Fbdn0fFFAbEzszqLGpAfUjcAlRNEacTRppqvU97c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IN9SWXh1Sb4hz8tVxGQ/oDkR/oGcLVgf8+gtHulU7q2TLM+Xuk6+8l8WAeeQNmUa1
         E9Fq4Bmd7n8EAneNIiWhrywuN9PXo2HE4+ENwhfhQFl8o4i7oWt8VMdMjdIR/wiaKN
         /74VblrzwN9/HrbQXKoBYVGmCGuLAhEk661967vY=
Date:   Mon, 9 Nov 2020 20:20:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Sean Anderson <seanga2@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109202052.GL6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109191909.wfuwpddng4rdn4ca@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Content-Disposition: inline
In-Reply-To: <20201109191909.wfuwpddng4rdn4ca@mobilestation>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 10:19:09PM +0300, Serge Semin wrote:
> On Mon, Nov 09, 2020 at 02:14:22PM +0000, Mark Brown wrote:

> > I'd expect it'd perform better, especially on systems that are
> > apparently struggling for CPU bandwidth like yours seems to.

> CPU-wise. RO-mode won't help in that case. Moreover it will be even
> more errors-prone for the systems with small CPU bandwidth. As I said

Right, these are two separate issues - one is that the client device
has requirements on the transmit data at times when the driver isn't
defining what should be transmitted, the other is that the controller
driver is using full duplex mode even for single duplex data.  I just
happened to notice the second issue while reviewing the change - there
shouldn't be any code for setting the dummy transmit pattern in the
driver in the first place.

> 2) Rx-only with atomic CPU utilization. In order to make sure that the
> CPU keeps up with fetching the data from the Rx FIFO, we have to
> disable the local CPU IRQs while performing the Rx-only transfers, so
> to prevent the Rx FIFO overflow while the CPU is doing something else.

...

> So in all other cases for normal CPU-based SPI-transfers when
> GPIO-based chip-select is available the safest solution would be to
> use a normal Push-Pull mode. In this case we have no risk in getting
> the Rx FIFO overflow unless there is a bug in the code, which is
> fixable anyway.

I'm not clear why we would have issues with the FIFO overflowing in PIO
mode, especially with a GPIO chip select - even if we're forced to tell
the controller how big the transfer is if we're using a GPIO chip select
we could just tell it we're doing a series of FIFO sized transfers?

> Another possible solution for the problem would be to fix the SPI core
> so aside with tx_buf being set to the NULL-pointer, a client driver
> would provide a default level or some specific value being put to the
> SPI bus on Rx-only transfers. If an SPI-controller is capable of
> satisfying the request, then it will accept the transfer. If it's not,
> then the SPI core may try to convert the Rx-only transfer into the
> Full-duplex transfer with the Tx-buffer being initialized with the
> requested level.

We do have support in the core for creating dummy data buffers for
controllers that can't do half duplex - that's the SPI_MUST_TX and
matching SPI_MUST_RX that I mentioned in my initial reply.  Currently we
always zero fill transmit buffers, the expected semantic is that if the
client driver isn't supplying data that means the device doesn't care
what gets sent and it's not clear to me that it isn't sensible to just
keep that like I said earlier, I don't know how common it's going to be
to need this since most half duplex transfers generally are half duplex.
The whole point with the SPI_MUST_ flags was to remove the need for
controller drivers to open code handling this, it was adding
complication and supporting configuration of the dummy data feels like
it's adding room for things to go wrong.

--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+ppKMACgkQJNaLcl1U
h9Bl/wf+LmhUIrwON5He000PAqXl4x2HO04etQKUTjL0S47CfSlurpLTYmYtZx5C
sH6UGjL+b5Dz048YX19u1CD88lSB8LkdnJ9g7ZA19KtygVvdd8b1xHgqahj8+3iH
q0ZADr5mk0Oz5yk79KdsrmMLNrCUTb/dWVWrkSBu0vRBvdImrryJ0nKw8n7lPY+W
J7dFf1fIcZzBVHlSqvTYVVCSd4AIJ16VgZ71qmM+X1Kk0Hn44R85ycq3zNHsng/U
zSUsiZ16/Pf88j3JKM09LAK6qxY6wuyxDHoLjEH/G9HaP03vy3Zh8AuH7Ez2bea/
7a7cILotDDLgKmpOzqRpRCbuUthu1A==
=dMkR
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--
