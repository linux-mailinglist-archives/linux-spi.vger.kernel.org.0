Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BAD23ECE6
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHGLvK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 07:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgHGLvK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 Aug 2020 07:51:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EE02075D;
        Fri,  7 Aug 2020 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596801070;
        bh=32ICotjIyNNWkXaOINpjxUnYeW8iqTjjb8pHUgr5ccg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSZrTt4ObpLfEnBvvixZhHoma3EdrnuvSFbklHJCxzjOk9JcDv3jUUF6H7hwUaXJn
         L5TEkvICKneIGGgUl/0kHMt/vsR60cZw9EcJ1+ij/QHlNsBc73j5+ExfBTjMCodLjS
         Z20sQ6+CgcenNBw8e1e2FN011lE9nB5stpR6Pgqg=
Date:   Fri, 7 Aug 2020 12:50:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 23/41] ARM: s3c24xx: move spi fiq handler into platform
Message-ID: <20200807115045.GF5435@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-23-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-23-krzk@kernel.org>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 08:20:40PM +0200, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The fiq handler needs access to some register definitions that
> should not be used directly by device drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tQBQACgkQJNaLcl1U
h9CCwQf9H+v8zRt71X23du7fGHjes+KdpGpxon0dxFg4Oa+k6LbFzkyH/SJ9kXNk
5Ymwb6DhbvK7xWKP/trSvDm4iiG77lOw01JlGZvfk0yuwHTiqxdlKeIRwllptK0o
yi5k6n0UkyOqidzvRHKAY3qCxn7ze5PicFrVoaF835u8PqcfJ/wLzojQnCr/fui4
kEl83qK8LM/2C5JCosLMXrtl4moVLxBM1J/AXVamIIstm3vWWhpSU37jJUXInXCa
HiGTeqE/HIrSXKoLpy3/AQm6uZBG2b5lHsRQsnqwGZRYLO0H8/PfjvmcX/nKiBow
GLIzcyPsQuCDhjLxOTtF6TP+/JStjg==
=WzR3
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
