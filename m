Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6A1F795E
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFLOQQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 10:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLOQP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Jun 2020 10:16:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA442067B;
        Fri, 12 Jun 2020 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591971375;
        bh=rjTKmlfjn2R4qsN7ijSXQ0sc9veNt5Fvq/im3PhhshA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4CwAbYngJblvQB3nesA7U2qZLkgHIjF/NVj67Y8cU/ccol3A9zUALDHSHcgU0Mu5
         4L13AmJ32q78+eIY3XXZNuC9GIK+6RCHg7sB80cV9wDyJDhMhkG4tgcNAzeym3RDlB
         zT8D0EvsorW8ymFq4Gj9DgEP4tCvNcnXvBpnLQFg=
Date:   Fri, 12 Jun 2020 15:16:11 +0100
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
Message-ID: <20200612141611.GI5396@sirena.org.uk>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 01:48:41PM +0000, Robin Gong wrote:
> On 2020/06/12 18:14 Mark Brown <broonie@kernel.org> wrote:=20

> > Please look at the formatting of your e-mails - they're really hard to =
read.  The
> > line length is over 80 columns and there's no breaks between paragraphs.

> Sorry for that, seems my outlook format issue, hope it's ok now this time=
 :)

Yes, looks good thanks!

> > Client could enable this feature by choosing SPI_MASTER_FALLBACK freely
> > without any impact on others.

> > SPI_MASTER_FALLBACK.  If this works why would any driver not enable the
> > flag?

> Just make sure little impact if it's not good enough and potential issue =
may
> come out after it's merged into mainline. TBH, I'm not sure if it has tak=
en
> care all in spi core. Besides, I don't know if other spi client need this=
 feature.

It's not something that's going to come up a lot for most devices, it'd
be a mapping failure due to running out of memory or something, but your
point about that being possible is valid.

> > > Any error happen in DMA could fallback to PIO , seems a nice to have,
> > because it could
> > > give chance to run in PIO which is more reliable. But if there is als=
o error in

> > PIO, thus may loop here, it's better adding limit try times here?

> > An error doesn't mean nothing happened on the bus, an error could for
> > example also be something like a FIFO overrun which corrupts data.

> Do you mean fallback to PIO may cause FIFO overrun since some latency
> involved so that this patch seems not useful as expected?

No, I mean that the reason the DMA transfer fails may be something that
happens after we've started putting things on the bus - the bit about
FIFOs is just a random example of an error that could happen.

> > It *could* but only in extreme situations, and again this isn't just ha=
ndling
> > errors from failure to prepare the hardware but also anything that happ=
ens
> > after it.

> Okay, understood your point. You prefer to some interface provided by dma
> engine before dmaengine_prep_slave_sg so that can_dma() can know if
> this dma channel is ready indeed. But unfortunately, seems there is no on=
e....

Well, this is free software and everything can be modified!  The other
option would be framework changes in SPI that allowed us to indicate
=66rom the driver that an error occured before we started doing anything
to the hardware (like happens here) through something like a special
error code or splitting up the API.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jjisACgkQJNaLcl1U
h9Bhxgf/f3T8+uesnT6I1A7PkdLyqPQzcvBKKuMxmr6a6gei+O6Z2E2DXrkgZnBH
egPtk0PkWozxvGSFKHjn0bWeN/cUS6YmM2T9LoXLP3aVYzsY6u1IutoUU6RabAij
AoWbBzfvClylFsQeOyo1FcdDXSRCqAN0nZy8ui8v9etgiQ6fjLSk0GNmmxPZ7eAG
FOwpDRyqmKCXqL66n+XROqHIz9og7wZm7GKJd7TewrCwDaT/MOoqpBN0vwHd7lYj
Ay0dT138sTtsmSXL2ujVLanOV1rwtx8uFSP+8kBapWjpZ5uko6QNs9XJoq1JFKDd
OwnndBidkU1L4Hl3h5BJ/hD59UsqCw==
=3+JR
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
