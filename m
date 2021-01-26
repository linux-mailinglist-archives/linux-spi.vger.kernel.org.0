Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F501303CF0
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jan 2021 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbhAZMZa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jan 2021 07:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404434AbhAZMYx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Jan 2021 07:24:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE1C230FD;
        Tue, 26 Jan 2021 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611663852;
        bh=AlItFwZ97s0AnDx+0w4Em4lUmWNA/amNqEP3kSbNmu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBiBf+SMb4i+zIvS3TIMwC+1E1dR0vsd/PQWAk/UhFTKyOP13x1e3amrL5s09sWpU
         g3TCAgdsR1yIkMK1s+jgoRENps4qdS2hYgNSXQxqIKb706GzZospexptPgi9hd/PO2
         B0keLfcZqWAMROrF5AtOMuZtq/9i2ikmR23WpKt1bsQCmolIlIvEoUWev1XdnKl698
         u4/O9GPDjcCuma2t+3f/yZ4IK/mobP+Ev3d8cGL5ac4hkht13Fm+EVNG/6mdDGJseX
         K4HkwMFO4Q2IyN+n6Krvhkqp88+/mKb0QmH8kbwIfQGxrX5kHV52GMDEXEFoa8esU0
         kPZzdHNwl+UXg==
Date:   Tue, 26 Jan 2021 12:23:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        robh+dt@kernel.org, lukas@wunner.de, bbrezillon@kernel.org,
        p.yadav@ti.com, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: clock: tegra: Add clock ID
 TEGRA210_CLK_QSPI_PM
Message-ID: <20210126122330.GA4839@sirena.org.uk>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
 <1608585459-17250-2-git-send-email-skomatineni@nvidia.com>
 <YA/o/stKkt7I0tg1@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <YA/o/stKkt7I0tg1@ulmo>
X-Cookie: I don't understand you anymore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 26, 2021 at 11:03:42AM +0100, Thierry Reding wrote:

> Since the TEGRA210_CLK_QSPI_PM symbol isn't used by the driver patches
> directly, would you mind dropping this so that I can pick it up into the
> Tegra tree along with the DT updates?

Sure, can you send me a revert commit dropping it?  Or it might be fine
just to double commit it, I suspect git will work things out when
merging.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAQCcEACgkQJNaLcl1U
h9CSLggAhJ8SfztEACe/4iC0FxJR/9vnf21Q6E54ZR+tHUW/Bcijw0G/5SYroT0K
xxB8QgBnQ3odJFdh7cUsjFIRAOvEiXDXIDYFzvvI2Rlhgu73kaFg5kP0YD49TkAN
H48PpL9gFMElvxYqkI7porZJNzbVHDb6JUqA13NPnaCPMVLtfpHMI/jKlalFEH6A
3HOHOhNXqYc2n7nLYJVmMjv67UfMChdlE6nNq3pGJzgAX7MgWu2d6xNeCXwlx37E
HCOuVndzlJAeQJuM5ZfCb0aXlTDKtc/4qPigcrVHEALUwRJ1LRWXrl8iXCWhDFFe
rjjzw0RVUrMYMzowYvVO5KCzqeILTg==
=OCkc
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
