Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2C3373CD
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhCKNZi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 08:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233497AbhCKNZg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Mar 2021 08:25:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BFDE64E22;
        Thu, 11 Mar 2021 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615469135;
        bh=B5m68Po8w3os9yQiGJPiV9q82N4dqr6WBL0kdTMcdkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjCyyt+WM9SJMwz8ODdfgJHY+CjecBrvn7ITdIe+B62odgTd8wOZ3iQyhuSnbjvcX
         sqc0wwHGsav2UkHFjtGcxzwcICR3EiqzO8hKLY4onyhcCJ77fMAEXoXRD7NaNNJyU8
         UWhm/x3+SvRfLyd6tnJ4Z3eDDrEhcRFdo2GlbgGKmrt/l9fHJZ/olOm+9g1EvdAeVG
         2Puj4cXlcHRO/mErk8LtYrlvvYME08dFGM1U9q1BITrECCqsPjS7uFiBASzVk0o3JD
         +BjD6F291H+zNPAGUjaBPGsSeQdepziJCmUz5kytJwvm9Ocj4noW9182ZVFbHdu5QA
         x5bzLhYoI8Lsw==
Date:   Thu, 11 Mar 2021 13:24:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Meng.Li@windriver.com
Cc:     linux-kernel@vger.kernel.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] drivers: spi: cadence: set cqspi to the driver_data
 field of struct device
Message-ID: <20210311132423.GC4962@sirena.org.uk>
References: <20210311091220.3615-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20210311091220.3615-1-Meng.Li@windriver.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 11, 2021 at 05:12:20PM +0800, Meng.Li@windriver.com wrote:
> From: Meng Li <Meng.Li@windriver.com>
>=20
> When initialize cadence qspi controller, it is need to set cqspi
> to the driver_data field of struct device, because it will be
> used in function cqspi_remove/suspend/resume(). Otherwise, there
> will be a crash trace as below when invoking these finctions.
> Call trace:
>  cqspi_suspend+0x14/0x44
>  dpm_run_callback+0x50/0x1c0
>  __device_suspend+0x114/0x514

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBKGgYACgkQJNaLcl1U
h9B8TAf/ZGIgTgeFYIlLZOWVbymla/Z5wI3Wo+nVH2QzHbcDMVoRZpBg7jA+CPqm
MEPn3ZooJycb5yS1pMNn7KQx7gkFHacscU9I914ha8ELh13PYVlOBTbYykjXEysM
X34o3Kdx8yfZZ5XeDlkPNJRGWNNBykgIrnrH2ZEqvJ41jweaDuiFXbd+2lpQXcQr
1w02HfMD3JxLnj8quTEPeYtcA2Iulm8rA2pj0+9K5GG7Jr7iFK3L2a04sbCqFeoT
/H1h4rnHFJ4UySFobqJ2iTPetzTBA3teJaka63hTUk7d2m3ISp9+h+x1S434AiMX
0vst4CeAKCrS9yCK52P9JqjPgU99WQ==
=UTwX
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
