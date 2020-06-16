Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80BD1FADE8
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgFPK1W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgFPK1C (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 06:27:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D932074D;
        Tue, 16 Jun 2020 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592303221;
        bh=h+uJjTNyXThELVktOw4GwJ+7MZ17efhM9W2zSlxhrfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6bU3A0EaWVwqB76C7G7Q8IPA9+8NDlndx78P4FO5p55YBIboAQ+ng5RuIHbh7arj
         cDq2IabAY/pe4YgW8N+oycWxtz82vqVOx9X8cA2CW3t6pe1ufX8DiWIRg6MbpwFL4a
         4lfwdoblwodIxGq5kz8hB3BKYLT1P24WTfkeaTDQ=
Date:   Tue, 16 Jun 2020 11:26:59 +0100
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
Message-ID: <20200616102659.GK4447@sirena.org.uk>
References: <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615143622.GX4447@sirena.org.uk>
 <VE1PR04MB6638D0C9FE0289FFE13ABA49899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615145556.GY4447@sirena.org.uk>
 <VE1PR04MB66380FD8FB7FCE79AF4B6CD4899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200616095948.GJ4447@sirena.org.uk>
 <VE1PR04MB66387499F9AF80A68F720529899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qE0/TkNoJLLGUzs4"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66387499F9AF80A68F720529899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qE0/TkNoJLLGUzs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 10:13:08AM +0000, Robin Gong wrote:
> On 2020/06/16 Mark Brown <broonie@kernel.org> wrote:

> > I'd just make this a generic flag for failures before we start interacting with the
> > hardware rather than specifically this one error case.  Otherwise this looks
> > fine.

> So rename to SPI_TRANS_DMA_FAIL? I think at least DMA is MUST for fallback
> case...

This is not purely for DMA, it's just about the failure having occurred
before the transfer started.  How about _FAIL_NO_START?

--qE0/TkNoJLLGUzs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7onnIACgkQJNaLcl1U
h9Cs0Qf8CdBZ6A+/Gn/ijwLKgPntYUIu7iNkeoHkhYqOXmt1S4e0m5GoT+ROMOLV
k1elBNRfWqVdKJfHMzmk5wANM+F5XqTCOpWx0SErZRiSHMFb5V8gClcNBYTNL/eU
3A/I62fz09JL/onIv3qEkUTsWvL3Rq7VG0mAsJvL27oMRecxS0EwEGW33kaY9axI
59Irl+2GcI/oQchTMzeHBdBMd5bqdGjDvI2xSrqnbyip+/G1p6xHPmYRyypcl+AZ
X976ervmpNe4o3XKh80pDajyx5aKgyQxgtB7cjE2UPSKXAgVhG+N8LWRwoAw03+y
1fXXMrymNw+yvlVU0QNEuMOYGRjTFg==
=9EtT
-----END PGP SIGNATURE-----

--qE0/TkNoJLLGUzs4--
