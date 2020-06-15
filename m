Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FACB1F9A66
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgFOOgZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgFOOgZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 10:36:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5FE206B7;
        Mon, 15 Jun 2020 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592231784;
        bh=ype2UwsEJQA9RCKVIpGpA9vIFkTyIQOQ4sKP1eAXFbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRnd9myuAlE2K1Nj2iURRl7w9qJ8EkYdNdH+K+1/phMf0kpQoAY1Pxp7TJ1JfE1Bv
         IS0K9Zxia4mxtl4V1nzuqvNO6G2NXNI+bmmTQPTgW5XKEnO5J9uL2LHNVwhcwBS3Ik
         ag3vadWejMFiNKgNM8XdbJeap+BU3716MyK6XAPQ=
Date:   Mon, 15 Jun 2020 15:36:22 +0100
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
Message-ID: <20200615143622.GX4447@sirena.org.uk>
References: <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6yuPXOSZRpyw7iEV"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6yuPXOSZRpyw7iEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 02:18:54PM +0000, Robin Gong wrote:
> On 2020/06/15 21:39 Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jun 15, 2020 at 01:35:01PM +0000, Robin Gong wrote:

> > > Then how about choosing specific error code for such dma not ready
> > > case where nothing went out on the bus neither?

> > Yes, that's what I suggested.

> Seems not easy to find a suitable error value, how about EBADR which
> sounds like no any available dma_async_tx_descriptor got by calling dmaen=
gine_prep_slave_sg?=20

> #define EBADR           53      /* Invalid request descriptor */

We could also pass in a flag that could be set separately to the error
code to indicate that nothing had happened to the hardware yet.

--6yuPXOSZRpyw7iEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nh2UACgkQJNaLcl1U
h9CGngf9FJjxiiGTABi3SIsOJXFnGblWLqB3vln9SMDIbAPj/yGiDdpERP2vrY1W
7k5dVCoCvMS3H85xHNvGXPWcWiAMdr2kvxYtHSOXafk/x18RNkFypSPrJGNH8aFa
bJAFTdhXBNO1Tzkfyv8jEXenmexA8Zvr98tiCjY6y1KzVIxXUS76Z0m610y3t01m
tBtsjAkAXoKe7N00fwx6mhZKwOlOmj7xXhETXAWGi7hMipmWTMlBDfijumFNivy0
ZmZdGZkr7H8rmKS664LAce29F1vBAGJ1DDCR7uZPNz0Tv2hT7gOTadOvuionzbvw
c1zT5i2KtlUGpSNfABZa0rmrPwY5dg==
=DUZv
-----END PGP SIGNATURE-----

--6yuPXOSZRpyw7iEV--
