Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3372DEA54
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLRUl6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 15:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgLRUl6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Dec 2020 15:41:58 -0500
Date:   Fri, 18 Dec 2020 20:41:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608324077;
        bh=EO5DKg/J2N3fqUQx4Bo6zO96z1Rm0SCzL3yMl3UL5xo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTWooaXYeyj0GlG1hIPoys+JgKQkE0UhQJblM+rerAEGTH+Da/jEldiaS3YIuVfj6
         rw7dPMfhZX2GbM0b9sWWO+bg5K5XFB7fGIpfZN2wn1MjeTrd/UM5yq33r1AqB9Mtxt
         loX6TYyXZFYvAfaBzQPgtYGmrLicI2s8Ggng+qZPF7XyIv41xPuS8i/ENyZsn/oYBC
         woPUeH561cz6qWcik0/SmMXRAW92dKSctk1LOVxwxto4XfY9URgz3l8G1I6PAg4qXz
         XE89WBTpxw1+Q7bQ7gqJcJAd4PHqnPwKyHxoGxXAzEGUDHm93J8WGLzQDfv+GjFncY
         kb04dCKQRruFQ==
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        lukas@wunner.de, bbrezillon@kernel.org,
        tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
Message-ID: <20201218204102.GF5333@sirena.org.uk>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
 <20201218092106.skwej2g6bk3oksbb@ti.com>
 <20201218105759.43789ccf@collabora.com>
 <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
 <20201218191936.hb6sq7zr3zdirar7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20201218191936.hb6sq7zr3zdirar7@ti.com>
X-Cookie: Password:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 19, 2020 at 12:49:38AM +0530, Pratyush Yadav wrote:

> Anyway, if the SPI maintainers think this is worth it, I won't object.

This gets kind of circular, for me it's a question of if there's some
meaningful benefit from using the feature vs the cost to support it and
=66rom the sounds of it we don't have numbers on the benefits from using
it at present.

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/dE90ACgkQJNaLcl1U
h9DvAAf/XmZq+AlzG4Q3Oydn2OQmtPfGB6QLybKV5qBqk5sQYzG5XRwlYXdCSXgc
6je3SXKlqQUA+02ncjwG5DxjzjV8RSb8tEUwfQjowMm3jcGpk77K8QXC6RvJKfTJ
ARY5NXoJO9PKJZTeNxrUMT50j/8daZywKN9yycr1GN7dIrP9xmP0u2N/Mn2Y5h/d
MoffzBnmGSEhwuUNzwRj9vVpFqHRYSj8WHWsADBbgMxkqwHlJGLMbu3YUqGX9YD0
FvWhN17C8DAsuHly0LGtI1Fy9SuRq9u6oNqqmaKqi/X3hQA0uXrGLC6gd0rEBovs
Mu1hQUmSKbtq4frwYYX3muF2uV54nA==
=dasX
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
