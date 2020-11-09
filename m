Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBA2ABE2B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgKIODu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgKIODu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 09:03:50 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A05920867;
        Mon,  9 Nov 2020 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604930629;
        bh=0qWoR1msH12ErNOfjXIHiUCH+yFjvnvefxpiB9RfPxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRs15LHircWzvXOo5eAGcE1LTAtxbL4/0ZY88LI86gw7Ho0CwqdiuVsSEAQIGcUv1
         9I95eKzIRan+x1t7Duk9Jp1J5q71sIvNo0ijBwWxGhLnAcqvNWBnm09ukjE8xqjK7x
         RUnP9miyPzSp53rkkKslalwQownd4flZ5FKmtZ60=
Date:   Mon, 9 Nov 2020 14:03:35 +0000
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
Subject: Re: [PATCH 05/32] spi: dw: Introduce DW_SPI_CAP_POLL_NODELAY
Message-ID: <20201109140335.GC6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-6-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-6-damien.lemoal@wdc.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 07, 2020 at 05:13:53PM +0900, Damien Le Moal wrote:
> On slow systems, i.e. systems with a slow CPU resulting in slow context
> switches, calling spi_delay_exec() when executing polled transfers
> using dw_spi_poll_transfer() can lead to RX FIFO overflows. Allow
> platforms to opt out of delayed polling by introducing the
> DW_SPI_CAP_POLL_NODELAY DW SPI capability flag to disable
> the execution of spi_delay_exec() in dw_spi_poll_transfer().

This feels like it should be done based on something like a cutoff for
sufficiently small delays rather than with a capability - it's tuning,
not a property of the system.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pTDcACgkQJNaLcl1U
h9ANcwf/YmBAqrHq0UScXKCySZxkuvWStVH14/YdQZtvZPP/q+momYYX4pc3kd/c
TBpsNlmcayA1zutuPZnLrGDvbvZveMzTmNelO1tPR3Of2cCvVzxsg7ll9McnW0tO
lQH/+nQTFzmRa2VmkMwf4qOSjkmBmtTZxn7tEJeuXLHNzNXWuChhNxTaDe8nVW16
YgDEFpyJP4apsxGFPAbFEgvPmbdz38L0VIlKE7779QjJ+s2l2npzVFpB9kVAPYX0
InWN9ZugvH0NFUo1vP2s6Ap57nSDtx2uNiY8YC+Q2O9tJYEp8ayKAFvh2pMQaq1k
s9tHGmXcudhAm0qR5VH22WaH1cXUTw==
=zXja
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
