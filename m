Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F62ED5D8
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAGRmD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 12:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbhAGRmD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 12:42:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBEF6233FB;
        Thu,  7 Jan 2021 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610041282;
        bh=ka0nkpDU2h1gSL1xu+E2qHPvU660nT51WYpv2eqNhKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7YgNieZmdHd/yNCSNq6pfizmmYQGoiTBFTO+ZGX7Ergwh+Nqa2HSPxOltj89nSl8
         5nO8HB5p6C+M0gur5IXieEdVhBIqquYVj57QFKTcSL7PeGdxuTB02DVaPK2csyW3j3
         xBnr08hX97l807PdmImJ4tbkZBxbP70SxBeooc+ZOC9NTx4PEUypJdSYqg/VUicXTR
         Bqdamr49wObgud5b8HlZ0Cd6AbYs4d0Iz6B1U6QhLyUoyw4n1nacREhUMhWuSFup5e
         5RTreYoyVj9aQSQQs7aYhlyd7hpC+mkDW7RKBLKjWzgko4vYszbLjMVPRy/qf6SvzP
         nvggNd3hoYt7g==
Date:   Thu, 7 Jan 2021 17:40:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gustav Wiklander <gustavwi@axis.com>
Cc:     Gustav Wiklander <gustav.wiklander@axis.com>, kernel@axis.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Fix so the module is autoloaded when built
 as external
Message-ID: <20210107174052.GH4726@sirena.org.uk>
References: <20210104153436.20083-1-gustav.wiklander@axis.com>
 <20210104213437.GM5645@sirena.org.uk>
 <124e3214-37b9-524b-7888-a31e8cb455da@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <124e3214-37b9-524b-7888-a31e8cb455da@axis.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2021 at 10:44:21AM +0100, Gustav Wiklander wrote:
> On 1/4/21 10:34 PM, Mark Brown wrote:
> > On Mon, Jan 04, 2021 at 04:34:35PM +0100, Gustav Wiklander wrote:

> > > The spi framework sets the modalias for the spi device to belong in
> > > either the acpi device table or the SPI device table. It can never
> > > be in the OF table. Therefore the spidev driver should populate the
> > > spi device table rather than the OF table.

> > Why is this a good solution rather than ensuring the the OF IDs can be
> > used directly?

> You suggestion is of course a solid alternative forward. However, the
> downside with supporting the OF device table for automatic module loading is
> that a lot of spi device drivers must be updated. Also

Is the module code too limited to cope with more than one table?

> If adding support of OF device table the spi device drivers must now include
> a MODULE_DEVICE_TABLE(of,...) as the spi device alias will no longer match
> the alias in the module.

> This command gives 186 spi device drivers.

How about SPI drivers that already have an OF table and expect it to
work, I rather suspect we have a lot of cases where people are adding
SPI IDs to DT that don't appear in the module tables and frankly I think
that's a reasonable expectation.  If there's an issue here beyond
missing MODULE_DEVICE_TABLEs in drivers I'd expect it to be fixed in the
core, otherwise we're just leaving sharp edges for everyone.

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3R6QACgkQJNaLcl1U
h9Bu5Qf/dzgvPJikJ4h7m5GFppKSZKhqXVVxbUCHh4ZllWu7bO3Sn2IK4Ut/tPh5
FhkILkesGWvBuMZf39eORvreabn6xgYMfb2ki+luJOaWDQ5bkr91hy69+djJEa72
8Aj4XOHqAAeYpoW6RcC+CxE5ZP5+3X9uBh6TVfQMGAOZZw17irSkh62ERLWSHz1+
GmjiYEHJvMvWYSV32tWootBNpQX8logz/HheuL0gr4BP6ddyZoruZPrMJB1GhQ2t
S+cUOcOheeSTfWEJtjw6Mq6ylO5d1eNAmAUgHt/WOP0SJDQdXIFEO5SxEbiRHX6A
4sLLrqWLIP7bY8qitkuBwd1vJw7+8w==
=K5nM
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
