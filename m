Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3632C700
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhCDAao (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388021AbhCCU0V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 15:26:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE3CB64EEF;
        Wed,  3 Mar 2021 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614803141;
        bh=LpWfD3rHOMB8ouLQKR28xxNUDGgTmhb/W2lE5TK/P+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9i/j7DGzpTHEwhTMj8BxosEZ4cA5oYZJ1VEFwssB9oBjFm/nKPQdka6ntnA8xJ02
         CjOEUSKsPA/N92SA4Sys4VLRazprYVSRI8WK9kw5wlZC+NOtTBnJKEJytp+xL7VD6Q
         W7z7DOM3LWGa8gMANWlZre8EmSWcKb46OCRs5BV6ZczRHcOMgxCj5QhGhPhupyzN4d
         fKrlOGSxd1k0nPyhjizFoxCRJVHpxcunuIqFzJj2SakAPWjQO6vID7n2eWqRZSfDuu
         KP3Lnkt1MY6uJtn12wKGNChX9qrVTNuaJ1uGL4TO5d/cd+58u4DfdaWa2iOw4Jgz1Y
         VqU4W6O6IqprQ==
Date:   Wed, 3 Mar 2021 20:24:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] parport: Introduce module_parport_driver() and
 use it
Message-ID: <20210303202432.GD5027@sirena.org.uk>
References: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Results are not typical.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 03, 2021 at 11:16:39AM +0200, Andy Shevchenko wrote:
> Introduce module_parport_driver() and use it.
> Greg or Mark, since we have this series tagged, can somebody of you pick it up?

Greg, are you OK with me applying this?

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA/8H8ACgkQJNaLcl1U
h9B45Qf/Sqb09N87wbsEpeYUOOY8kyQrdv8nbqrSyTDFuZ3rBies2Zuw//T43SKI
RqZmWxyBe/+BrsGEutC/uAV9zmT7HS2m7Swa6+zK8neQFCSdByKAktpnlfAcitul
Q+k3utLpDj8mNvpz1693rRikopZGX7o9kjcn4hP5p5Ds9RoZPOhnHGFDM31gmGTy
ky1iXC82GEi/Kf+IVdLOKr0rvHYWjyynfQBDPAZvFhtB5fCtAU39vKeiL1A3c8z/
PfIDMuNC6of/e7IZAkDNZ6mHL52fE/35jqS6UOW1a7vToWfGY1aQ9njzQu52k5jW
X2nRcs00YTzr+PyohhrjwhCXthFymw==
=wg95
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
