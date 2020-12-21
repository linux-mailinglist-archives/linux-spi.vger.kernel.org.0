Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05D12DFE30
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 17:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLUQvu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 11:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLUQvt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Dec 2020 11:51:49 -0500
Date:   Mon, 21 Dec 2020 16:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608569469;
        bh=yaViPjdmmsCzAeL0va1vlA3tAOMvU2QaaNbTzhk/M2U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWiBh9ZTafNuO4cox7HBuO1CJjjbyRjmEGOPidRxtKWcZCXUr1hFutQORYEO6hPa4
         r6N/mb174I1cKh8kJvDVb2Ay3q+pKikPwhfWQam6HQVLukKgL9ug9X0yozFgssd5IC
         qYtbhN//od4WHh/LEkzdIXdugeu/Zyi9hQAefE3iO6hOYx9kHCgErtLeu1h9pKHbtD
         Nz3kO0hPcUmaW6XdkSIs2erF129lcL8ht1RRIlFbfB6lbO0JuQJJ7wSSToSqlCsVmO
         LxYLkNfKdFhQL2WRPKvHLNLI6W7lRHVg5Y+uaUQQWh8vOhFeUrhdSP2BLYHIMj7OHN
         muxd/uwoL8szw==
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        lukas@wunner.de, bbrezillon@kernel.org,
        tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
Message-ID: <20201221165053.GA4521@sirena.org.uk>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
 <20201218092106.skwej2g6bk3oksbb@ti.com>
 <20201218105759.43789ccf@collabora.com>
 <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
 <20201218191936.hb6sq7zr3zdirar7@ti.com>
 <20201218204102.GF5333@sirena.org.uk>
 <20201218204414.GG5333@sirena.org.uk>
 <c9343475-44b2-c9c4-1790-f6b50ec9c1bd@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <c9343475-44b2-c9c4-1790-f6b50ec9c1bd@nvidia.com>
X-Cookie: Remember: use logout to logout.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 18, 2020 at 02:01:56PM -0800, Sowjanya Komatineni wrote:

> From quick check, I see HW dummy cycles transfer of 128KB shows 18 Mb/s
> while SW transfer of bytes shows 17.3 MB/s on average.

OK, it's not going to revolutionize the world or anything but that's
definitely a speedup.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/g0mkACgkQJNaLcl1U
h9D/FggAgryOP3kQjSN2Lz4KeSPSrsKO6HHCcgeCbfox61nIVRcJVOBKpJX0nuU+
dbPP8gBvK3GNt/9J/WKP3k+LYD5NUfyq1lARlDe+WpU7P8VkE9TNpjctDFS2PiyO
6asDGI7iPahkE0iBmGAPqWyiUngS3X7PdN2/uuv4uSf7Fs45+f98se+GLKGa+ryK
UUTJg3DPwqmMrFqArDETTmVj7/urqREQo/gYUHtQgc7H8KCOOquuXeeOYa5dres2
GEiFGR08bDJNX2nJ3xAHtLYRJw6DZnD421m5O+FG6pxNh8AfsHQTDnvEIq2TyA0O
3D+sPY0zkYYNDEnjixQtJ8ycT5Qgdw==
=a44r
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
