Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CA2D2A29
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 13:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgLHMBm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 07:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbgLHMBm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 07:01:42 -0500
Date:   Tue, 8 Dec 2020 12:00:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607428861;
        bh=CBQSi6PKztjqUgxk419gS/DryqtOYYkMFnnxVFbXx0Y=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4bOgPlNS5iQYzzkTl2j28rYGF0FG8zaxY9NImBfb+fkJ524NyWlZxTAC/qfXLxWH
         jLpx3rhjlDhPo1lEnPvkvMhX9gIIB3E8yQOSsWg3p0A7H4JfHzqzzD+XaZTj0f3S5N
         AUpMa/KGQar521yJnsa7wRq5paLWRrIc/xIcPQZ+1Jh4dmzUQGZo0msNEJbX6q2mri
         vKnASg2O90dKQPZdwYW1lMvwc9eZ9Jzp2dY3TSCZkxXxDpxKRUogbpg+Vp7Hx9jnZv
         eYHYriCiujajhyrRHCAluPiRv+hrx1xZ7pVn7O0WOldPG6dVoPiOC332MuOE3bw6fW
         5V56Xp47Q27XQ==
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <20201208120054.GA6686@sirena.org.uk>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
 <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
 <be8291fc-8e69-b577-d8f4-20aeca0b45cc@nvidia.com>
 <20201204185223.GF4558@sirena.org.uk>
 <df8d6f25-c8cc-3b41-e4df-8e26c9b93475@nvidia.com>
 <20201204224648.GI4558@sirena.org.uk>
 <77693de0-4e9e-79b9-0f73-0eaa35ace8e0@nvidia.com>
 <70f69d4c-8a99-3893-76ea-7860eedb11fa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <70f69d4c-8a99-3893-76ea-7860eedb11fa@nvidia.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 07, 2020 at 04:02:15PM -0800, Sowjanya Komatineni wrote:

> So by having it in spi_message, controller driver can get dummy cycles info
> a head of transfers so it can program this along with address bytes transfer
> phase.

That sounds fine.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PavYACgkQJNaLcl1U
h9CrPAf8CQnIcnqAp5ROHWyjcUofYCkNVIbU2QRyhZfad0a36Ce4BupVuE7ZCQyL
1RytxfKhsiNPdf4pHIkDRFxiJO2Slh/mD1toWATh23oI5UYfs+RNR3fmhgcjYAo9
y5QSyGNIpdDOftUP6J8jcDVloCO+bdax0EipQNVbc23TIkCo5Dd68n24ZZEWf4Mx
pdDDmQhMyzQSIGdqyUMJq/xW2B6WiyjTTqp6TzJuQ+gFUXPV9qoZJF2YsdJfV1rj
zHCrmqDYDu0Y0iRrhTtfRFtDmV45g8ldvVfkjT0l0eB9EoYhIEbLqziOr35K3k+n
TG3hC1700kHUbeionqR5iLFGmMffsQ==
=yvw2
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
