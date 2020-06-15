Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167EA1F991B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgFONjJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 09:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbgFONjH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 09:39:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E5B20739;
        Mon, 15 Jun 2020 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592228347;
        bh=3qgnu+0GrnrqQvzQvAd3xvt44NOkgslNZc7hnvZJ0ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaQFo1mjO1ynSgYz/iXeLbPZFVmLmsMORfTDaLAo59EvK2SGMTpYWGtTGpBJAgiYx
         5XVY6lBn7uGKdzbq6jizZLVR/t9EWPYZ4x1PZbWNbGNNfty1ph2HrUg3747QwTE+sK
         g/1RBnsV1QdoNPH/2NVOLxR0LwMgSe6/WlMuVcHk=
Date:   Mon, 15 Jun 2020 14:39:05 +0100
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
Message-ID: <20200615133905.GV4447@sirena.org.uk>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v7CWsE/Dy737oYst"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--v7CWsE/Dy737oYst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 01:35:01PM +0000, Robin Gong wrote:
> On 2020/06/15 20:36 Mark Brown <broonie@kernel.org> wrote:=20

> > If we see an error in transfer_one() it could be from anything, we've n=
o idea
> > what happened on the bus - the controller may have got part way through=
 the
> > transfer before failing.

> Then how about choosing specific error code for such dma not ready case w=
here
> nothing went out on the bus neither?=20

Yes, that's what I suggested.

--v7CWsE/Dy737oYst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nefgACgkQJNaLcl1U
h9DWzwgAgNLfdSBegzo4C8SrkVYTpfvlAgdjrdeptqUR28cvfXCkLWGWKP746yJu
xryCPDQEAA8Yn2LAl8V7oYvPaj+oBAZIzcwv4xcxNZK1h9rLUqmLJkbWkttPHUVx
IcbbLwXlRrlx3orkN3wCIqvzRyRnVQ2/5VDV0Ve2tk/s09hbttNZB/XGX+ZjYXnY
pM/PW4VOskZZ8SG5UU9roeIPPQOsKbTjFOO9A5PZnc6hGszNIS3GTrFwZ1b3X1Mg
ksihianoVYK7jBAPJU/CBNuPj3LOp8EQJzpeGMnnFt4ZQQHssKxA0YbQdETcu7ZS
d9yRgl1CHN1yTDEutwavhC7CgG9rsw==
=0EvL
-----END PGP SIGNATURE-----

--v7CWsE/Dy737oYst--
