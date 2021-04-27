Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4336C4F2
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhD0LTt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 07:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235428AbhD0LTs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 07:19:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C127613BF;
        Tue, 27 Apr 2021 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619522344;
        bh=snapJygytCAC7W4IpyhkUu7fX9WB6rVftgdIkNZ2O8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKM+nv7nMx7mmYPaW0NXiuc9C6Duq7x8capq5ItRO86Tk+fTH7IFRl8WNJyB2c8DI
         ovtJpLxakBdtZfuCNPTWqsg4jmT+sLlLVXYeZMdzR9OyqgDrq30QjJFnbWjpYEMFzO
         jkzWr44lRTbmdSWryrD36bNrQhIWM4iFDSiMnRCN9ppPE7JqrnGYqjQjsJZHcuq0wO
         NQN01tJMee1Y2y4jGp8JxlQxK0N+yp9xlsJYfycQBcbJr0HuPHgiGFoHsaHZ+7rf1q
         4WI05QmIBUwoVyL+Nng6cY9ZzmzqVYGeXE6hIGI6kAC8xIvKw9MmQFIPIdi7eQAGMI
         RDjX7WS9BN7PQ==
Date:   Tue, 27 Apr 2021 12:18:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] spi: imx: add a check for speed_hz before
 calculating the clock
Message-ID: <20210427111833.GE4605@sirena.org.uk>
References: <AM6PR04MB56233BE0FFF7E5D80527B54CF3419@AM6PR04MB5623.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB56233BE0FFF7E5D80527B54CF3419@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 08:33:06AM +0000, Clark Wang wrote:

> However, I notice that you have applied this patch to the next branch?
> Will you revert this patch?
> I think you may want to apply this patch I sent before.
>=20
> Author: Clark Wang <xiaoning.wang@nxp.com>
> Date:   Mon Dec 14 17:05:04 2020 +0800
>=20
>     spi: imx: add 16/32 bits per word support for slave mode

Oh, in this case what happened is that you sent your speed_hz patch as a
reply to this patch so the speed_hz patch looked like a replacement for
it which confused both me and the tooling.

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH8wgACgkQJNaLcl1U
h9DMLwf+NKyMmVK4y7T2GP2ci3AwgNAu07mU/e45UW20mWjpQzHFEJhKMmcQuUdx
VVx66rRHtdjAihHT0RubsAhixL51Arq3jE2Wzwd1sqRzHeGP3P54io9JX5gt2/7N
yUgkQdxuxlkP53nrmuKEaQtU17T5uP+zK3V8WdDd6fSeHKFdzTixR29ZX1v6oE1Q
ZKtwa0Fp662TWMLKIBR0PYVtqdF6XBqL6iy4TwENPXVObc0+5fMR018zfhom9QKG
rRH2Z0f71o7/2NTnbuQOyEk7+zNrtJT2NCBCyLrQGNb3sXWE6fC3je7wcTUNVOjC
3GmVcVNMr1QcL2gIIYAec0J4eFj9kg==
=KEgz
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
