Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7B1E0F77
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgEYN1j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 09:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388737AbgEYN1j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 09:27:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF7C2070A;
        Mon, 25 May 2020 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590413258;
        bh=YoFRZefk/Go4CvbhR0PvrdsFKUaehxtVPeSJ88VYCkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KANHk/u+jIlGhMLFQ+yII/qMvYi7vti+H/M4KF9DA5bh0W/kyj1A7fkcBNuu+CXe+
         kHuX3qTRNMcmvE37Q3qoi4e27X0JL7JvL0jXdfO8SjSTGZwLPLJdiUNIcIEz1yG/mW
         mClhznzxcgVpzBIs2Bxz8zb4jH2K1w5V9Zv8Imt4=
Date:   Mon, 25 May 2020 14:27:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Timo =?iso-8859-1?B?U2NobPzfbGVy?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Message-ID: <20200525132735.GG4544@sirena.org.uk>
References: <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
 <20200525113106.GB4544@sirena.org.uk>
 <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
 <20200525125743.GF4544@sirena.org.uk>
 <a663d610-56d8-1c2d-90ad-4d128a2fa3a8@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <a663d610-56d8-1c2d-90ad-4d128a2fa3a8@pengutronix.de>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 03:12:05PM +0200, Marc Kleine-Budde wrote:
> On 5/25/20 2:57 PM, Mark Brown wrote:
> > On Mon, May 25, 2020 at 02:41:31PM +0200, Marc Kleine-Budde wrote:
> >> On 5/25/20 1:31 PM, Mark Brown wrote:

> >> The core could merge several half duplex transfers (until there's as c=
s_change)
> >> into a single full duplex transfer.

> > Yes, that is what I am suggesting.

> Where in the SPI stack do you see such a "merge" function? One point to c=
larify
> is when and where to allocate and free the memory for the contiguous full=
 duplex
> buffers.

My first thought would be about the same point as we're rewriting to
handle MUST_TX and MUST_RX in map_msg() which does similar allocations
and deallocations to insert dummy data for controllers that need them.

> >> I think spi_write_then_read() can be extended to generate one full dup=
lex
> >> transfer instead on two half duplex ones it does a memcpy() anyways.

> > This has the same problem as doing it in any other driver code - it
> > causes a needless incompatibility with three wire and single duplex
> > devices. =20

> What about the note "portable code should never use this for more than 32=
 bytes"
> in spi_write_then_read()? The CAN driver in question may read more than 3=
2 bytes
> of data.

I think that comment is actually not valid any more - we used to use a
fixed statically allocated buffer in write_then_read() but added the
option to fall back onto allocating one dynamically if another user was
running or the transfer was too big.

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Lx8YACgkQJNaLcl1U
h9B5Dwf+Nb0Y72rxDJYz31zxtSePYg23wFswccy4280iAkIcWoMJkffzIpNnd6/k
nn/tJvLg9vt7nnkCRv+a9RXBpLOHughiGTEojzSerkrqLkDEED21ZF+LmgQK4Qwr
ORu3nHDWmW46BNo9/Syr7+vDUcPbx11A6LY7/W6f1LMXAXzKHZulq2gcykRgi21I
30jryinvYDsb2nrKRhzNBDASIgyLiNUkOpPGVsN0rXY1K8Avt7Gua8LzRR1ztACM
r4I3zCdiR4lZ6UJ9ioEpvWd6jqGYsbcDBJGCDHjtUJSgNvqzwr7e9KerHz0IS2+P
LLhgvEFtAZjQUJKkM2vkOezK0Ft0JQ==
=Yw0T
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
