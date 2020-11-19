Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A888F2B977B
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 17:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgKSQKJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 11:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbgKSQKI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 11:10:08 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C4222256;
        Thu, 19 Nov 2020 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605802207;
        bh=pkWYntOwT/PnZUfibEMXRvwL1Gcj68yCloYFtIvABSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAHN5+xvRmtW52qqhiUEwFwh9SpDmwS+Jg0tXPVs57KOHkapz95VvV/zIrmC3tn8M
         S+ZIEpLBbChr30CXIe+KnIWApaQaQKo3setXS3NFg/0a5N41iuNK6efyobQ5y+052K
         e7Z/XFDAS4hczr6b+7I1el6lY89NBtH1c1oG+SK4=
Date:   Thu, 19 Nov 2020 16:09:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: fix resource leak for drivers without .remove
 callback
Message-ID: <20201119160947.GD5554@sirena.org.uk>
References: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
 <20201119152416.GB5554@sirena.org.uk>
 <20201119153540.zehj2ppdt433xrsv@pengutronix.de>
 <20201119154139.GC5554@sirena.org.uk>
 <20201119160412.nhu2rmwygyh6yg6e@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <20201119160412.nhu2rmwygyh6yg6e@pengutronix.de>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 05:04:12PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 19, 2020 at 03:41:39PM +0000, Mark Brown wrote:
> > On Thu, Nov 19, 2020 at 04:35:40PM +0100, Uwe Kleine-K=F6nig wrote:

> > > (Not sure this makes a difference in real life, are there drivers
> > > without a .probe callback?)

> > Your changelog seemed to say that it would make remove mandatory.

> No, that's not what the patch did. It made unconditional use of
> spi_drv_remove(), but an spi_driver without .remove() was still ok. I
> will reword to make this clearer.

Ah, OK - I hadn't read the patch closely as the description sounded
wrong.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2mMoACgkQJNaLcl1U
h9DyHgf8CQ6aSsrw23q6Kt2ULY0QTBJO9zpVuZfq+qsTcrAZD7y+64Cb8Z9C7mS3
bA6UIXnsXA1GAqm4iDS/S+JPVJ5GRf7+CfC2XJ4r5pCsWuxtonls3+O7rLH4wOuc
SYlulRbmmLUcHEpdJrz4rGGvyY8oJPgwTEP7/RylQFY34z+UNcQ3DBMZ+QC/b/hS
SPLd5s0DG/P3AlDQNjqjv3pRqFxvQlIiS+D3u533umoVaxGw0zKVCX64iByHqKj4
IOOa8+M/x575Bxln/36XzGsZC//QB/6vXhDsLfyDtuf0YDnqomZpkSKRkvKN2Jio
KWo0Xg12iPIpyL0KwP5Tks1jiQ88xQ==
=uAoB
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
