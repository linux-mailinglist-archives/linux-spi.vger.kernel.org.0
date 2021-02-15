Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4131C32A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 21:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBOUpi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 15:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhBOUph (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 15:45:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4E8164DE0;
        Mon, 15 Feb 2021 20:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613421896;
        bh=WEEuhtnSy8VhEBxkxYgzsBN8isfWgUhZXIWaKLzfWvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OS8Gd6PAKwsY26S3sus9oHdpR+N3J2iZFPv8zLOJvHIqbbVcfxrJcHFZjeMv6YZNx
         bc+4LBpRlyn3jPcFxVLdOy/mg/fu9uCQ99R+W2aVA2/Zm6VtkON3IMi8qAR2l87Tu2
         7XyRAvNnmZezICQPGrJqdVlsHvveradWn/3vfuyeabZltsqNfUbFQ0jzMZdFvQzHyc
         StyrNIRC78ZpoIfKRGBGhXCKRUHHPNCZq3EXj3iD3of+U0HH5gal3NWl8R4wHpjNE9
         Sbd8UPZPGTIblJBZnup204ZUreKEj9imy7tazeOJWhpfwwOfil6tVF/5HVTFCiTcP+
         zphqKnwENW0cg==
Date:   Mon, 15 Feb 2021 20:43:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: lm70llp: Switch to use
 module_parport_driver()
Message-ID: <20210215204359.GB4378@sirena.org.uk>
References: <20210215202353.18515-1-andriy.shevchenko@linux.intel.com>
 <20210215202353.18515-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20210215202353.18515-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2021 at 10:23:53PM +0200, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> Note, device_initcall() is a default for module_init().

Acked-by: Mark Brown <broonie@kernel.org>

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAq3Q4ACgkQJNaLcl1U
h9DYJAf/fjLey2KyF6s5ITR7akoYVHeZvfrce5AFiqsvfynswypHFdPyUcszh3dY
huCF5ttdY6m+doIfXvzdLYHFHPZA8hxyFdVfitOiIBD1dKWxWANvo5cUq1vZ39DM
13jTgGHGkXuG4lGvE/yJYfIWR2WEeGDgkMmLxIe5GrmvkdCViSWJnNhs7DxRH4N6
6jxYBM1D+z9yMzJReCu1IwEdnnhOq2Tcemnp2idPiBDy09d4wKiRDEa099QVaT0v
gcIQVdwEIzRBxi4ubSEkxGNCje/hj1qLW28bC4QRsq8W74CXuVTWfcVKlrI250Ur
PQczhjS84R8WcOXcAmVP73czK/VD6w==
=tfJw
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
