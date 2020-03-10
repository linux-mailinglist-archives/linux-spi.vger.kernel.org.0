Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58BA18048D
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCJROG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 13:14:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCJROG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 13:14:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A8EC1FB;
        Tue, 10 Mar 2020 10:14:06 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BCF3F67D;
        Tue, 10 Mar 2020 10:14:05 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:14:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Vladimir Oltean <olteanv@gmail.com>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Message-ID: <20200310171403.GL4106@sirena.org.uk>
References: <20200310073313.21277-1-michael@walle.cc>
 <4beb5200a76f2d817be7276444543de4@walle.cc>
 <ea6ffa30ddc2459d07935e5e61a41172@walle.cc>
 <CA+h21hqMoPhbq8YG0UeV1kP0iXApYsJvb9MZjPGX54dm2U-KnQ@mail.gmail.com>
 <76923af394f334337a3cac125c270087@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sCNd3Ivk/oijKKf1"
Content-Disposition: inline
In-Reply-To: <76923af394f334337a3cac125c270087@walle.cc>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2020 at 03:12:45PM +0100, Michael Walle wrote:
> Am 2020-03-10 14:02, schrieb Vladimir Oltean:

> > I'm testing LS1028A with IOMMU_DEFAULT_PASSTHROUGH=y and I didn't have
> > time to change my setup now. I've also sent a v3 to my patch series
> > which is going to conflict with this one, sorry.

> No worries, its easy enough to rebase.

> > I would have picked
> > your patch up with my series but I didn't have the right environment
> > to test it.

> I'll resend a v2 once your series is working.

Since it looks like your series might need another spin anyway I'm
thinking it's sensible to apply this now and you rebase instead?  Cuts
down on the number of pending patches if nothing else (unless the
testing stuff gets sorted out of course).

--sCNd3Ivk/oijKKf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nytsACgkQJNaLcl1U
h9CFXAf9Fs1LfShbPgNXymA2EJASuKmlCDxY/9JGibPArY1h+qg7eMbJsbijndm2
iXclHhId06fmvFubASnkilFQmkiJRa8xQ9f0nc5bAU0im4gKeMaO95GzMzoyrCa4
SPLpHEjJLWqD/aW9ewH7Hr5Q9Z45QvmGW/43go97TgXv5CTwwZzcEuLDSabSFUaR
mVvqUpQGy+dnRCebK5XVt31+n5SSJ8ma6c8e6QcO8qRbJzf5Nq4hxg1eH+vYNAkR
vQGIiF3wL9aMu9JbLmTFSPe/yj+WSGr9jDNPT6NgbR54XxwCzFVjAQx21Nj7xVIe
+PQK4vngYCQTN36fg6XPznpD7EeEYA==
=+Mos
-----END PGP SIGNATURE-----

--sCNd3Ivk/oijKKf1--
