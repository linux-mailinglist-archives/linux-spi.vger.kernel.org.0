Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83F4877A0
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 13:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiAGMcc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jan 2022 07:32:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58102 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiAGMcb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jan 2022 07:32:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B0561E48
        for <linux-spi@vger.kernel.org>; Fri,  7 Jan 2022 12:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9B3C36AE0;
        Fri,  7 Jan 2022 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641558750;
        bh=kp1Fh13yuN/6oTYNzmkZT8dJSVc9lv3TzG9DOylJH9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFLPcdJVYPmkTg31LMlBbys2lJUzdZeQ0NK/l9+vdwvPzupDmuIDE4NZDu84XQiV1
         xVDReaF2OlhrGSTTZeqrqGR99yHPFp/sX7zyNRYMYjeZImYL+yrb9mZtr6qg2AqA1Y
         1DZNAGudEDBXCiwOrceCm6CHbPuyHadaxcZPrstWLtNOFD5O6MTQPGwAxe/vu9RNJW
         lNPnsHL/MLy4QvlEvLa5RXHJTP1Sl9KdCpB7OvCr1f/64/cmXkAmKdXjgdK9hZOJ/h
         HiJx26Dl3ceRxswCuX3F039J1Mfw7nxGGUyRUN8Q2wKyZqumL8t5IlcxrqGCvcebso
         E2TjzjnKqa1WA==
Date:   Fri, 7 Jan 2022 12:32:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Message-ID: <Ydgy2TAodUMYG2EW@sirena.org.uk>
References: <20210904013140.2377609-1-kuba@kernel.org>
 <20210906113012.GA4309@sirena.org.uk>
 <20220106195621.0315ef77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jvdtnBTiMyPX+FoW"
Content-Disposition: inline
In-Reply-To: <20220106195621.0315ef77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Cookie: teamwork, n.:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jvdtnBTiMyPX+FoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 07:56:21PM -0800, Jakub Kicinski wrote:
> On Mon, 6 Sep 2021 12:30:12 +0100 Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> Mark, was this ever applied? I don't see it in linux-next.

If it's not in -next it's not been applied.  This is one of the hazards
of sending things with random subject lines, they get buried and missed
much more easily...

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--jvdtnBTiMyPX+FoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHYMtkACgkQJNaLcl1U
h9BL3wf+NsnFNNZnFZwbowpWdg8LtVsPzaE/sChUfHO5woCvLGsmBsW2MU+jAhUV
aOTA42zj4XeFAaN0tgSlC1beeW10fOJnfqU7sqfBdBZmGjwRx9IidMefLCVQgwzW
GLB8QsEIDD8Ckha28g4Hu2iYMuIjCyY2A28ZSPzwX3pds4M14oU4dzdNSd0br00y
LDRRrtQj4Snk2SmQYS5Q6O83+nwtLO4L3PkIZR9uD7LYvCvCRf/f30ltTkBWx3yO
0MLyL+qg/h01BVbgCqL1g/TIufO0bGp1MwEv8VVymZ5JNmWW9ZvEGuruKKFReZyQ
vcPQj28PsaxBiUXtkJIBXarDB3ieCA==
=ONIx
-----END PGP SIGNATURE-----

--jvdtnBTiMyPX+FoW--
