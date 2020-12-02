Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654E22CC306
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 18:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLBRHf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 12:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgLBRHf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 12:07:35 -0500
Date:   Wed, 2 Dec 2020 17:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606928814;
        bh=MyMwYBkiI14vmyyRX388WZLYw4mGzAn+6NXmfixPeqw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzMrq/jDD66p/nF8elHTEQO7zhdO0esGBN10Qp2oGZUOT7D9Xn16VVN1T3YqXAgiK
         uysHBq9Y7rL7kiwacQEf9+Li0JryPwcgAPdY3cKX9lXciJ2gV592RL6SbJhC2fJPX6
         89bsjgEnV+EwpzVzJDqrXp0y6q4yihOW7Zsf8KJo=
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/7] spi: qspi-tegra: Add Tegra186 and Tegra194 QSPI
 compatibles
Message-ID: <20201202170622.GK5560@sirena.org.uk>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline
In-Reply-To: <1606857168-5839-5-git-send-email-skomatineni@nvidia.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 01:12:45PM -0800, Sowjanya Komatineni wrote:
> QSPI controller on Tegra186 and Tegra194 is similar to Tegra210
> QSPI controller in terms of transferring command, address and data
> in multiple transfers.

Given that you're adding the driver in the same series this doesn't
really seem like it needs a separate patch.

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HyY0ACgkQJNaLcl1U
h9Co/Qf+Jqs5JNbV6+G1TiKNUxPzvyD8sydxRs+VmNiHFqZ5Xfswl3n6LRW32tqQ
dDbESVZRPBzoFPBjnrCAiFgOWZz526xSfGhdGjdGY2fVswWGsDs8Q4IfBz0hUzgH
Z3uZ56o07LflmtTuNfNGYxU6Ia2vmsdo6m0R5YNb4tm8OmgYtWshxluG9pk+dBoF
+gEWOyaMKzHNRtD/mLmerLqI6+K8QstyAfyU/RWA+V7QgsrBnwBZOAszi+0MuUiZ
X8pYZAfmoruH0+PMtNUOnPp0vm5afuR/tLeu9Esk2fzz8soy/gtfgOupvzZZ1Cr7
1Dqvolk32ARjxrce/IAczi37gUmWDA==
=k4Cc
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--
