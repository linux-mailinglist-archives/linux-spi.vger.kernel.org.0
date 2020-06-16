Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8C1FAD43
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFPJ7v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 05:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPJ7u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 05:59:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA0720767;
        Tue, 16 Jun 2020 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592301590;
        bh=H00RGJq5KezVcrQ/vGzLRXHsGQa2G3LnLHyCG7559QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s35iCxf2ApOcJZGyTnKb4vFHqFOY/SexyqbRTgxWkYLnGAD85dUn2XN6AYZkK4Yms
         bl62nwah75Ax2duvcU+bVe2CmlysoY32l9chot9A7Qr1u4UA5fiP/m2ZlZQO/ik3av
         tMj/TY1ARiyudeRqXH3l8XqEFpJspJfUFi6ej97w=
Date:   Tue, 16 Jun 2020 10:59:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Message-ID: <20200616095948.GJ4447@sirena.org.uk>
References: <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615143622.GX4447@sirena.org.uk>
 <VE1PR04MB6638D0C9FE0289FFE13ABA49899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615145556.GY4447@sirena.org.uk>
 <VE1PR04MB66380FD8FB7FCE79AF4B6CD4899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6xTM0kUsJcaNctaW"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66380FD8FB7FCE79AF4B6CD4899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6xTM0kUsJcaNctaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 02:03:40AM +0000, Robin Gong wrote:
> On 2020/06/15 22:56 Mark Brown <broonie@kernel.org> wrote:=20

>         struct list_head transfer_list;
> +
> +#define        SPI_TRANS_DMA_PREP_FAIL BIT(3)  /* prepare dma failed */
> +       u16             flags;

I'd just make this a generic flag for failures before we start
interacting with the hardware rather than specifically this one error
case.  Otherwise this looks fine.

--6xTM0kUsJcaNctaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7omBMACgkQJNaLcl1U
h9CvpQf+Nxs8GAzGWD8q5WQ5Yfk5Dd+UDwg0tf7+zdTr05h6hiN4THe7qjTZBk6+
MC0R19TGfmpOaqHJY8nh3Nr2HY2QUv+ceTtIYVmwxpG+oE9TTE1v5WQTzOTQ5HMV
yq8qU6g8Tfa1uB6BLAchJMy2lBvU/mjNqRnDY4ONnr5qkrmmKgQZycDnilH3ICEy
VVS2cenoNIUooeyGwBCFOO8GnxfPhYtO3P5CLZvFPmg6OEdq0qIbluxYksdknKiR
cBMORkKWR3BEZwuCx2R6xjUk17zxIpc5Km7XmjrZXSSitzONPcMjcaqVq4mtuNAU
5hztHr9mzDtIlWqoD8uLxSczu7wlVg==
=AZSa
-----END PGP SIGNATURE-----

--6xTM0kUsJcaNctaW--
