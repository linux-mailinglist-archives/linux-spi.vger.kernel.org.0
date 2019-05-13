Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7C1BC07
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfEMRgr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 13:36:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34138 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfEMRgr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 13:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kb6pZsLnPSgZzNq/FKqOreEM4N+a0pBeuIb+A8f7BJA=; b=QbCBXz/ZyCP00PNgBt6ru6K+s
        oT9DBYqCoIXhbFjo+AsTJ8zmYQGpZPyqmlV2Sru7py7smwD5vRRrjtaB1ICjjdLurDjiEd1G81lsG
        9g6Dfby3PEjozxEr9koAUUY6kbKhRGq/Nvzwwi914k8KHI86/Qb+M0lWW3NG74B2o2ARU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQEsN-0007Ex-Eb; Mon, 13 May 2019 17:36:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8B28F1129232; Mon, 13 May 2019 18:36:32 +0100 (BST)
Date:   Mon, 13 May 2019 18:36:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190513173632.GF5168@sirena.org.uk>
References: <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
 <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
 <20190118191202.GG6260@sirena.org.uk>
 <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
 <20190123175609.GG7503@sirena.org.uk>
 <CB6BCD42-60F9-493A-B05B-FC27C125E982@martin.sperl.org>
 <20190512085409.GM21483@sirena.org.uk>
 <02F11B40-F747-4E57-9E37-1DD010D54CBC@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <02F11B40-F747-4E57-9E37-1DD010D54CBC@martin.sperl.org>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 09:21:40AM +0200, kernel@martin.sperl.org wrote:
> > On 12.05.2019, at 10:54, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, May 09, 2019 at 09:47:08PM +0200, Martin Sperl wrote:

> > IIRC the mapping is deliberately done late in order to minimize the
> > amount of time we're consuming resources for the mapping, there were
> > some systems that had limited DMA channels.  However I don't know how
> > big a concern that is in this day and age with even relatively old
> > systems.

> We may be able to make the mapping early or late.

> The place where it REALLY makes a difference is when we are running
> in the Pump (because of async or because of multiple threads writing
> to the same spi bus via spi_sync)

Yeah, it's definitely not a common case issue.

> > For the case where we do have the message pump going one thing it'd be
> > good to do is overlap more of the admin work around the messages with
> > other transfers - ideally we'd be able to kick off the next transfer
> > from within the completion of a DMA.  I need to have a dig around and
> > figure out if I have any hardware that can actually support that, last
> > time I looked at this my main system needed to kick everything up to the
> > thread due to hardware requirements.

> But to get all this done I fear it will definitely require api changes
> and thus a new kind of pump.

Yes, it'd need new APIs - probably along the same lines as the prior
ones where we provide finer grained ops.  The stuff with
finalize_current_message() was working towards that.

> Maybe the pump can get shared by multiple spi (master) controller. This
> would help when there are say 4 devices connected each to a separate
> controller and then transferring short messages that would get handled
> by polling - that would mean 4 CPUs just polling, which is also consuming
> lots of cpu cycles. If we could pool this polling

But then we can't have all the cores in our multi-core system polling so
everything will be slower!

> I am starting to wonder if there is a means to make the wakeup of threads=
=20
> fast/priority to keep the latency on spi_sync minimal - essentially
> yielding the CPU to the =E2=80=9Cright=E2=80=9D thread (so making a yield=
 cheap).

> But let us see how far we get before we can tackle this...

> Form a performance/thru-put perspective I guess it may be relevant to
> extend the spi_test framework to also gather performance/latency
> statistics so that we have a means to compare actual performance
> numbers and avoid regressions.

For that sort of instrumentation ftrace/perf is probably already going
to be more than enough, just needs a bit of setup and learning curve
with the tooling.

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZqx8ACgkQJNaLcl1U
h9AX9Qf8CyNib8QR5rBuAxiW1HGgWpODD1Asz/0yEdhgKifMF5Gb//e7NZVG4vu+
y8AnD9v55HfHZhhkoNhZ7PUyhoxM1TbEpIFw6W6y6w15fe7cnrOCRoRsFI2RqlOy
QKqkXiTc9tyqYlzc6TfflHgsfnS2GFrOTCHu57/Z881uQvNZ6IjjdT214SOXE8PV
8v5wcksqKAbGIFHG5ffHv+JOhuP7UcjQCKD2GcXaFKRkAQn2Y5Itxxh3tm5zgM7E
RIAoDOk1M2FK3hcGZtVN3lGG98TS3OgRx4Y/T8cc9ibCOPS+4k6RVPAQuSkk152c
l6WDBLNjSW+4vURuOpxJqLttQzUqLg==
=MMyI
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
