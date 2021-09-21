Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C941334D
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhIUMYl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 08:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhIUMYk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Sep 2021 08:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5A4E61100;
        Tue, 21 Sep 2021 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632226992;
        bh=a6EcEIKj8SQWyXhzLdKEBCNafkswc9g5HNWLH+iPZRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6gUmBtST7U4Twq/dBvPGR+yGestsCCIL6ioq1r9XuT1eLbFLSXYJuLnppTR1ZuVe
         BkjX6HFmznr9NpUEiSsWg4ML98buhC2/kKXrcdp2lFUOPU6JrgYyUpVPpFl/KrnmZP
         BJNaffrKzIFpMGW4pLBtGuRnVIA/g5QIkFgx4+WUfe2VHpKk06hJ95NZ9VAaI7+DFc
         MnxJvbQxrBF4huDo/0jZzxZxY8rjqC6o3uY6H/lTA6wYQySmA1FpUI4H6thddQVHrH
         Vvser9fv91QvQgZifiB67TDaGWvlPHHPx2Gm8wO0T0J2b+zaM5PwMynLnyWuYms1mI
         gusJtASevAj9Q==
Date:   Tue, 21 Sep 2021 13:22:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <20210921122228.GB9990@sirena.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <871r5j6nlw.fsf@igel.home>
 <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
 <87wnna6hdc.fsf@igel.home>
 <YUkOdoqccsbEh08C@shell.armlinux.org.uk>
 <87sfxyfklo.fsf@igel.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <87sfxyfklo.fsf@igel.home>
X-Cookie: Will it improve my CASH FLOW?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 21, 2021 at 09:34:11AM +0200, Andreas Schwab wrote:

> Reverting them will break module autoloading that previously worked.
> This is a _regression_.

We know.  As I said in my earlier mail there's regressions both ways:

  https://lore.kernel.org/linux-spi/87sfxyfklo.fsf@igel.home/T/#mb7811e507ee8a6d33ee5ab268a6eca676b746fce

This is messy, we're aware of of the complications and I fear any
thorough fix is going to involve a full audit of all SPI drivers which
is a bunch of work.

Please stop this, it's not contributing constructively to addressing the
problem and engaging with your mails takes time away from the people who
are trying to do so.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFJzoMACgkQJNaLcl1U
h9BVEgf8CkHAH2onHX3M9qSnZge24GueTfwYoespWT1WU39Gb8vzmR9TXv0bkVZq
cNkgcJUAI6UP/zvgM+JeIB9k9NpxNwjgt9+JWUFYNKiwQ1e9AXETLnTG+kJkNcxW
/bnCOcu/l4cPiwQ29T4LHsa63u2TXpkvYdQPbN+6tvNCZuc9AG/aUyupVIamPEQS
7hnWqoae0lvS79O/r7OAgVOKO0/yVeGCTadD5926k9H8Vp1DG7E6KEypQloe5ecb
z4x6Dor42MdfTCgsMcmkRzy6DAigrR55kWyCw5+FhkLT1n6CZfagxXfxpTfQZKiQ
qCmjt8KyWvOJuVaudOI2Tn7/1mVQvA==
=gUn3
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
