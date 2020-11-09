Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD42ABE64
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgKIOQD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgKIOQD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 09:16:03 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB914206ED;
        Mon,  9 Nov 2020 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604931362;
        bh=En9Ed05eGm/mVXemcKM0+v+qUqkketwqoNTG9zmUgq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McKic9AMlk5ie8beb/Xzbfn6jBvWtBX6LbQjd3Kv8c7DEMYvXVbM6FKyRcqnA0vU8
         cgw/f/iYm5OoAdXuNZ3JxEz12UhM9e26T2Nwrhut0K5Mb/Az2dNFgo42flFbVBjrkN
         jnUUghXs18eVMeOfbOBCDyfUdVbB18Vk0Y1DFdsw=
Date:   Mon, 9 Nov 2020 14:15:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Message-ID: <20201109141548.GE6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <53859725-ca0b-5f57-9147-10346707b3cb@gmail.com>
 <BL0PR04MB65145CB4FC66106B62E179CEE7EC0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <db97cbfb-0d42-9c45-e770-37a3c38d79c7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <db97cbfb-0d42-9c45-e770-37a3c38d79c7@gmail.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 07, 2020 at 08:52:24AM -0500, Sean Anderson wrote:

> I think if it is detectable at runtime it should be, instead of relying
> on compatible strings. That way causes less future grief to anyone
> porting a device possibly using DFS_32.

Yes, runtime enumeration is generally preferred.  Having the compatible
string is nice in case some quirks are discoverd but for things that
can be enumerated there's less that can go wrong if we do so.

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pTxMACgkQJNaLcl1U
h9CCzwf/SOaVjDOfJ3WO2PcRpeRE277pJrANK1utzq6zRVou8PJIN+wBkqgHEYcr
P2w4049o4LKkvZOCXYn69ZznYDkM75uV7oWtRWOOu+ltmyWTYNTf1bqxYJVuVp98
ZJdHyesJpsVgVvKW5athUt1+zh6A1cOBNel0Klu5E3pY6i7JHQFMp+E33sFV+wiC
KGEx3Y89sAkQRMLmrlbTctOMhODPxQuEx+a/9Yjgg39AYrikjOijlub7mPHE4PcB
IEEuZUBSCtwhJ2s0W3DL9ycrfrMSdjVduXNK9X6MJafqNP1UDeCW6LsqKZVgSBWG
Yh8sK9idMtmFzUG+lU+5JZVq9f9bnA==
=GnrL
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
