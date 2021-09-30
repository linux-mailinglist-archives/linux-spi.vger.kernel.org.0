Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEB41DB57
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351586AbhI3No4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 09:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351414AbhI3Nox (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 09:44:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DEA861211;
        Thu, 30 Sep 2021 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633009391;
        bh=Ipx8IDO4kCqX8IkrH3s5LY+e6LHzDltWwtgallL5o8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6hGwT3q0LAQFScM7gMsY8r+D7IMvf/gmTOFHOqRpQOATFGKDDNFxUJP4vIvIzPu+
         pGrTzj2EayoM9brB3TAWb91OUlKulaJDesFYmoPI9lWq6Q+14LVWNjhxiGvtd9wycf
         JyJSB0NYj3cShK30KMYXOooUyw52+25WABrPsfxuJpLPiGD+MY3rqVy/7R7WcQE6Bw
         qzngf4bsALEGhofwWt7gGWlhAiV+9dzZyXiQ2p3rBajOavbwnujBjoQhnv9rQjPNup
         +J1w3dfDWOuJFD58iuFEJlcsHQukOCxU62WGKUJKo6ZLSd8CTPOEZG0HuHrclo9cuV
         JJx5IpVsHvsqw==
Date:   Thu, 30 Sep 2021 14:42:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     kernel@collabora.com, linux-spi@vger.kernel.org,
        enric.balletbo@collabora.com, dafna3@gmail.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] Revert "spi: modify set_cs_timing parameter"
Message-ID: <20210930134220.GZ4199@sirena.org.uk>
References: <20210930120700.2564-1-dafna.hirschfeld@collabora.com>
 <20210930122513.GX4199@sirena.org.uk>
 <28f8af42-4535-ef9f-e521-712d37e2cb72@collabora.com>
 <20210930124630.GY4199@sirena.org.uk>
 <bce800ff-9b3e-500b-6a42-9a60d3a0c590@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vM12nk/63StVgfqY"
Content-Disposition: inline
In-Reply-To: <bce800ff-9b3e-500b-6a42-9a60d3a0c590@collabora.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vM12nk/63StVgfqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 30, 2021 at 03:06:52PM +0200, Dafna Hirschfeld wrote:
> On 30.09.21 14:46, Mark Brown wrote:
> > On Thu, Sep 30, 2021 at 02:36:01PM +0200, Dafna Hirschfeld wrote:

> > > Actually the original commit not only change that callback 'set_cs_timing' but it also
> > > calls 'mtk_spi_set_hw_cs_timing' directly from the function "mtk_spi_prepare_message".
> > > So this actually influences all devices bound to this driver (in upstream)
> > > I did some printing and it does change values that are written to registers.

> > OK, so that's something that should have been in the commit log,
> > preferrably in a more detailed form that identifies what the change is.
> > However changing the values written out is clearly not the intent of the
> > patch and it is a substantially better API so can we not just fix things
> > so that the old values are written out?  Why are we jumping straight to
> > a revert here?

> It could be that the values written to the register in the new version of "mtk_spi_set_hw_cs_timing" are the same
> as with the previous version. I didn't check that. The difference is that before that patch
> the function was not called so it was a dead code. Now it is called and causes erros.

> Without the datasheet it is hard to know how to fix it. I responded to that patch two days ago explaining
> that but Mason Zhang didn't respond yet.

The hardware supports register readback (it's doing a read/modify/write
to set the new values) so it should be possible to look at what the
default values that get written out are and work out what the default
parameters should be set to to give the same effect (instead of 1 which
is what's currently used).  I would say just skip the delays if they are
zero but that means that if only one device on a bus has a delay
configured there'd be problems.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--vM12nk/63StVgfqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFVvrsACgkQJNaLcl1U
h9Dvgwf8D/QgRgGL7+atgjRw9nrUP2dqOjbRukvgflD12pYe5ijMEvL6BFICSt4L
T1sOe/K5W6GTKGOKlEZXqHZOtyYSvZfeOkIj/NhvmQzxfwLoDO20UuK/5nILt7Xb
h5qP9YOjJHOfWUlZCg/r07K7V5r3CyIwjRbayLxAdC1kpaihkQH1Z5js5q2Is4w/
SAamMil0l6tzMEXEorBK4fT3KJfA4rtIMe1u/npdwXw+50dO/zPEWWtTFyHIGzuJ
O0oG+4pAEF9brMYzPTnq+c6AHGRQdCoD/nEoGrVHm8IBkqxnq7FM10/NjBH2RVPc
pwUyQs1Cn163hgBK2eh8xWk9oMJy9g==
=XIiO
-----END PGP SIGNATURE-----

--vM12nk/63StVgfqY--
