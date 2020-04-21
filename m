Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A71B2E05
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 19:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgDURQC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 13:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgDURQB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 13:16:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC37C2070B;
        Tue, 21 Apr 2020 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587489361;
        bh=vDzVgMJnbG1fs/XIUuFyDIIrwEN+7nL3b23WtKtmo7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BX+G4c+j75vOGjtLYL+EaCsk7FHXbwmN+VNWcYQ7zJzQxNu7cuGX1bdVKUTDRgnH4
         zDVkl0K0uE90TuZL5jE3vKwbH9QNFOnIm9qlgO+h9IGdwnua/Nxzuojtcj+4PIBgPp
         Dbf9HHI6Eaeum62BeGfhBzaPAG0SaUpbz8MpvnKs=
Date:   Tue, 21 Apr 2020 18:15:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-ID: <20200421171558.GE4540@sirena.org.uk>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-2-kdasu.kdev@gmail.com>
 <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
 <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2020 at 10:11:52AM -0700, Florian Fainelli wrote:

> > Applied to

> >     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

> It would be nice if the URL could be clickable, e.g.:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7

That then doesn't work with git itself unfortunately, someone's got to
loose out :/

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6fKk0ACgkQJNaLcl1U
h9Cebgf+JgKrBse64QXap8uRDtDUn7gakR6XZU0cC6Qaxn3TsCwpaow/VgocC3Wz
rhVDWwTAGjZ2QG8VbV/uprXbg/uU7VAlpsAv1a9UaiR6beaRlyYOjI8VyjkWkLzm
mD5x6Yf7UKQRMC/Szjn2KPEW6hhfSZrtTtlKd8+BQGxTbq6tat+OKDKIUE1Q3Qln
k+I5HHRgNLhrLtMluFkRVaDhx5m+mA8keIjg8iPAj3xJU1Mm2Nzz3Lnha97ekjx5
6RaVPtAKE+D2b7Om5YM0AgTPZHPlxNO/AwjSBAxAhLUIUz1pl5IT7hibYAQQDLR2
W+oNGlumpwZqfOV049aMB4g41rBrEQ==
=1WXq
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
