Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93BE23EC97
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHGLe4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 07:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgHGLe4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 Aug 2020 07:34:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C82E22C9F;
        Fri,  7 Aug 2020 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596800095;
        bh=tXBo25R0Y+4AIZzZGupXC8450DFRTM3yjoapLt4VqKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJUZtmpa+yUWbnaqqJxL8gX6L+5u4GbVyMpIGe/1a0sQqdZibg4ol0RHlqURrggQf
         j1IaHsPs+MLSrrmCqkzV9C9tb9SXq9GEAoWurbcsmIlVotZLwfvK02jMiZy+IENBFW
         e0i/KRcj5BQO4xz08YK+R9h86XuQikMbMUu9a9vI=
Date:   Fri, 7 Aug 2020 12:34:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 20/41] ARM: s3c24xx: move regs-spi.h into spi driver
Message-ID: <20200807113431.GD5435@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-20-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-20-krzk@kernel.org>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 08:20:37PM +0200, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The file is mostly specific to the driver, the few bits that
> are actually used by the platform code get moved to mach/map.h
> instead.

Acked-by: Mark Brown <broonie@kernel.org>

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tPEYACgkQJNaLcl1U
h9D36wf+PRVDv26bxJzdzNv1s/fYpLppZOssLMHcxN+lOdauOOsa5m0C7iV/d0EZ
WIq02xtYnwXSVCiQj7I6HnEEWdVmut0lo88HjJYTmT5WV8Lgcsijy5tY6P3p/yTu
AF1qPbox7ymfK2O3W6Z5RKpUHWQiJJr5cZKcN6EmDbdf0E3qM5uXGwAdaUmtSrnt
1IcZiUAso+lshS28dhovciTO/ezzp7v/6YYNYA5nD2PSNpl+u/dWZ2lm/HGR7cs9
NOXfX8PTTx06z9N9DGwbgxho1lONB4kni4DIuB/YUGdrf9eU4O/Pt/PdRy+kDhdX
LxFe3KVOkfJBttE6XRFFpyWio1LaRw==
=oEjc
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
