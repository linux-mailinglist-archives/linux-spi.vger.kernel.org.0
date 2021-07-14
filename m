Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AFB3C88A4
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGNQbd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 12:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhGNQbd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 12:31:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76DF861377;
        Wed, 14 Jul 2021 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626280122;
        bh=zFogal56+5VzoMhhb7Ry/HoN4yIF0xXrIgUmAs09/Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yuztd/HCEv2nl+0zA9Bpkj9BqVlK0EKI5kYmyLN4bmllexBJLOXkXUXR6G5NW1aMH
         45RJud20VaiMsbxVes4ZwZhnQT0+lP6lMzvNY41kD3K0pHz5tgtmJWT3HC+Fec61kh
         MxQ+CBgbclSto3VPPC8yiGV/RsdrWtJ/zXeVOdEiND+VpwRcljPkJP46XG16/dct7+
         1FwqxTkzBkzTX8tK0MWsiNo7x28iCjKb0Bx7xyzY+oQqgILDvJK5iryIuGW6Oj0z5B
         QKTAAb9ci5C8gJFenH/uky7Ou8J27jQWyXAkz5w5F8H8ukru5Mf701wmFViffOjiSB
         PPKun2v3BD/vw==
Date:   Wed, 14 Jul 2021 17:28:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Nandan, Apurva" <a-nandan@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Message-ID: <20210714162805.GE4719@sirena.org.uk>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com>
 <20210713182550.GG4098@sirena.org.uk>
 <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2021 at 06:52:12PM +0530, Nandan, Apurva wrote:
> On 13-Jul-21 11:55 PM, Mark Brown wrote:
> > On Tue, Jul 13, 2021 at 12:57:41PM +0000, Apurva Nandan wrote:

> >> cadence-quadspi controller doesn't allow an address phase when
> >> auto-polling the busy bit on the status register. Unlike SPI NOR

> > Would it not be better to only disable this on NAND rather than
> > disabling it completely?

> I am not sure how it is possible currently in the controller, could you
> please suggest a way? Also, should we have this logic of checking flash
> device type in the cadence-quadspi controller? SPI controller should be
> generic to all flash cores right?

Surely the controller can tell if an address phase (or other unsupported
feature) is present?

> In my opinion, it shouldn't harm as spi-nor core doesn't depend on HW
> polling anyways and auto-HW polling is a minor overhead.

Flash stuff seems to quite often end up happening when the system is
heavily loaded for other reasons, it's much more of an issue with things
that are done more with PIO but still seems useful to avoid having to
poll in software, either it'll reduce CPU load or reduce latency and
increase throughput.

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvEJQACgkQJNaLcl1U
h9AxFQf/WTaUN7hfuj94ba7jlHJH48lJ0H/pxdhV7O4Iy77V2V9LWohjaYuw7ZKh
syOb2yUT6S2QpNo7nPuW3BQoGkDB0jvQnLmy/jzzKW6K6qU/fGEkzPpn6WX6tA3A
+KW0mKB5W4r3zgVbPK4+ieduJ1QehvuE5QpnPiEDjl22wIz5rTMASiSUyOstwv+/
iViSM2i9TL2CvmXs45F33W2AizBA658lw3VfuxDh9q1tFI3scKDoQCS5fHH2f4bK
P7kZgEiMeg5ZRj4Aeo/v1EkyQPkybonKTenhlZio/D8Nv7wl/hvWN9AwegeMDMta
IjCoUE/O4YdqTJ+t52NiCEbztMZsVQ==
=dalX
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
