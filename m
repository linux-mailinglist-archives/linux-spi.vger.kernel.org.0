Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C042803F9
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbgJAQaP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 12:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbgJAQaP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 12:30:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762DB20872;
        Thu,  1 Oct 2020 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601569815;
        bh=esaUB5vTwkDtp+6nWMqkThJ5NMVHUGKMKL83h8x6hoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVB7ea6rVlLPeowmAhK9dnlSWAC8qO49TnA1IRdMFPWVcwNKqDdJ1EjZE5e8RNG6v
         HDrFe6fCL0KQ0m1mpKDoYONvtoc62Mhd9tVB4DziPhONBW/nPVgQxihwEK7DA9rAK+
         +WVn1f7gfCjVaZ1E/+Da/sLOv15xIqHVP8r2UoSo=
Date:   Thu, 1 Oct 2020 17:29:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas.Kopp@microchip.com
Cc:     Tudor.Ambarus@microchip.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] spi: atmel: Exposing effective spi speed
Message-ID: <20201001162915.GP6715@sirena.org.uk>
References: <20200921071036.2091-1-thomas.kopp@microchip.com>
 <DM6PR11MB428354FF073BCB8668D50DDFFB300@DM6PR11MB4283.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYjWXklH5JTzT8n9"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB428354FF073BCB8668D50DDFFB300@DM6PR11MB4283.namprd11.prod.outlook.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TYjWXklH5JTzT8n9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 06:50:08AM +0000, Thomas.Kopp@microchip.com wrote:

> I realized I only sent this to the list, not to you on to/cc. Can you con=
sider=20
> pulling this please?

In cases like this please just resend the patch so people have it in
their inbox, people's workflows tend to be based around handling things
in their inboxes.

--TYjWXklH5JTzT8n9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92A9oACgkQJNaLcl1U
h9C9fQgAgkBSB3bkxhLxGmpEdfF4OfbL+n4ik2BDE9f7SZETEfYCxQQDJ9LSbrOX
DEyoG3Vb612szYBAwqNkMl06DmRjTDoWDhYqr9rFvijFWtoWy9HF+0/I1rVejxJ0
N7lfzARScAe+rtDY0PIyFBGEJE+Z07P63j2UX8U3nz9hhqllxbUOZbcT/TFvM2bO
K5eVM1tc8vTfFFcKAVuq+scITAm0ZutO9JF4lO+GW+lpAVs85r6Io6Ze21mpF8Wy
rR3mWNydalTc2TSyEOx70lPEKQlhOitNAm7wF8Uwip2JmKma9kZ/EqAfSQMMVsN+
iu2MGbJdPJPwvWmwdxr9e77abx/+2A==
=C3hc
-----END PGP SIGNATURE-----

--TYjWXklH5JTzT8n9--
