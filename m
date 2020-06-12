Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850721F768A
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFLKOD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 06:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgFLKOB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Jun 2020 06:14:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2322081A;
        Fri, 12 Jun 2020 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591956841;
        bh=expc4CDnEYnki3mJuBqA6Oh/0tPydmqgZtKMrV+jKBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlWUnQDM+u/RIUYixIip7C8RrA/dgIItdp97UwUfbUfXG0D+AFnA3GqyMex8dunyS
         SSPJxRyBr1KPHpnROeSumSMbIX5s2KP/X4HKr/DcNByipe0OMwcLE901IaXMGQ+FRm
         3DI8LIOvmteSGJa/CaOcnr8ReTxNOOAhzakq3Gak=
Date:   Fri, 12 Jun 2020 11:13:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Message-ID: <20200612101357.GA5396@sirena.org.uk>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 02:18:32AM +0000, Robin Gong wrote:
> On 2020/06/11 21: 41 Mark Brown <broonie@kernel.org> wrote:

Please look at the formatting of your e-mails - they're really hard to
read.  The line length is over 80 columns and there's no breaks between
paragraphs.

> > If we were going to do this I don't see why we'd have a flag for this r=
ather than
> > just doing it unconditionally but...

> What do you mean flag here, 'master->flags' or SPI_MASTER_FALLBACK? 'mast=
er->flags'
> could let client fallback to PIO finally and spi core clear this flag onc=
e this transfer done,
> so that DMA could be tried again in the next transfer. Client could enabl=
e this feature by choosing SPI_MASTER_FALLBACK freely without any impact on=
 others.

SPI_MASTER_FALLBACK.  If this works why would any driver not enable the
flag?

> > ...I don't think this can work sensibly - this is going to try PIO if t=
here's *any*
> > error.  We might have had some sort of issue during the transfer for ex=
ample
> > so have some noise on the bus.  Like I said on a prior version of this =
I really

> Any error happen in DMA could fallback to PIO , seems a nice to have, bec=
ause it could
> give chance to run in PIO which is more reliable. But if there is also er=
ror in PIO, thus may loop here, it's better adding limit try times here?   =
=20

An error doesn't mean nothing happened on the bus, an error could for
example also be something like a FIFO overrun which corrupts data.

> > think that we need to be figuring out if the DMA controller can support=
 the
> > transaction before we even map the buffer for it, having the controller=
 just
> > randomly fail underneath the consumer just does not sound robust.

> But dmaengine_prep_slave_sg still may return failure even if anything abo=
ut
> DMA is ok before spi transfer start, such as dma description malloc failu=
re. This
> patch seems could make spi a bit robust...

It *could* but only in extreme situations, and again this isn't just
handling errors from failure to prepare the hardware but also anything
that happens after it.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jVWIACgkQJNaLcl1U
h9Bozgf/UcNkCEZeiELBwx8bUG0lENlWEPOtNj5hIgl5N82SihwmCxoFw94tIgDg
4TQJsn1axD1mvHMA8Lp17W5ez2e+zEfzaAKluwvg7rfk64VIWBb1Am9kX9hq2BIV
N/lzF4sBC5KTJRa5k/tRDagDjAq0bd718Kj4rbXKazcDcHyKhq3JNH+JwPoo3QfH
+5HE3kQ70uqqsHmufQR/kHG/0tXp50ZqvEnSMUzKYZErDwdQ1Fl2RHi/M6sQV6DV
j5SkMSsgFE54nLeKU1HELK1RWz16w5TS+HaYjtHmRdIsaD+CM3buINDkVAfjkHsf
imE/+07m4y/n6nyM28LDJhdDjoM8zQ==
=SHv2
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
