Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDE487A05
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 16:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiAGP60 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jan 2022 10:58:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58368 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiAGP60 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jan 2022 10:58:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BED660C9B
        for <linux-spi@vger.kernel.org>; Fri,  7 Jan 2022 15:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E022DC36AEB;
        Fri,  7 Jan 2022 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641571105;
        bh=FWc89+X3C1L5FEJaIak13QcYUm9IRftxtCGOW8il/mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbnTmUgJpQDw/TkQtSpoRbNQgmo6vjhxVQocBh8pvXK4N3dWQ7h6VhSon+rbv0UUf
         PFhF3mi0WlVsTtvwflik6yDFR0yD0qyrh113rXJVnPBVXoLgt42R2KWKnlIripfAG9
         KbDv27TchQ2K4deTVGoaRpBG+ps0+9BZAbOVw7AoYQOE3mBk0XMwtoASuCehXwl8ca
         AT7GqEdMECFAz9e9JbqHaNHzvCptftrrTskPeOk2pYP/+gwaZDfUUnf5g4EAcmU2f8
         Xqs34dtoTP/cQjOFrlCCVRR6hUoaF66h67cXj92SND/VCczjkZ+q8Z1Y2EnIkgAgUF
         GnsOIlIQvwY/g==
Date:   Fri, 7 Jan 2022 15:58:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Message-ID: <YdhjHfDCCfd98zZu@sirena.org.uk>
References: <20210904013140.2377609-1-kuba@kernel.org>
 <20210906113012.GA4309@sirena.org.uk>
 <20220106195621.0315ef77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <Ydgy2TAodUMYG2EW@sirena.org.uk>
 <20220107075007.4cb5bbac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G50NCm3/DBVuUAou"
Content-Disposition: inline
In-Reply-To: <20220107075007.4cb5bbac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Cookie: teamwork, n.:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--G50NCm3/DBVuUAou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 07, 2022 at 07:50:07AM -0800, Jakub Kicinski wrote:
> On Fri, 7 Jan 2022 12:32:25 +0000 Mark Brown wrote:

> > Sending content free pings adds to the mail volume (if they are seen at
> > all) which is often the problem and since they can't be reviewed
> > directly if something has gone wrong you'll have to resend the patches
> > anyway, so sending again is generally a better approach though there are
> > some other maintainers who like them - if in doubt look at how patches
> > for the subsystem are normally handled.

> I think it's best if I take this patch via networking, then. It's
> trivial and the merge window is afoot, anyway.

No, it's a random cleanup that doesn't touch networking at all, only
SPI.  No reason for it to bypass anything.

--G50NCm3/DBVuUAou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHYYxwACgkQJNaLcl1U
h9A4AAf/bbjN2Ays1eRF5Vv70vgTvYRdAdhvkducuLjNvnZe/jiujLlrn8N9npqK
Pq2Ku60RB4jplHqbiE0Yoozznw6OnEJ+4WcbeEFOhOIgU5UVJ6T/LvsEpA8bpt33
WL0DuT4+LQ/HAW0a89iaJ96Pv3UweP0aevlwikwvaelTNq9q/Rw9ViWw1XLPrBXt
BjgfloWkh/MAcjDPYSMsnRN61blDv/xI6dolozt3UYu1bgMt6H3x9hLsvA6IIfib
wwUP5ktBXsYDgCqqs/oSp2cxlkvzzRI8rvPVRS8hlIeIbrXR4FWRyhTIH8vzMwim
gB1rnZzSTAqADxZZ0e1JyfEhEXS4eQ==
=HkIu
-----END PGP SIGNATURE-----

--G50NCm3/DBVuUAou--
