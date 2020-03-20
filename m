Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B23118CD85
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCTMLU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 08:11:20 -0400
Received: from foss.arm.com ([217.140.110.172]:48248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgCTMLU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Mar 2020 08:11:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB8331B;
        Fri, 20 Mar 2020 05:11:19 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5882D3F85E;
        Fri, 20 Mar 2020 05:11:19 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:11:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: atmel-quadspi: Add verbose debug facilities to
 monitor register accesses
Message-ID: <20200320121117.GA3961@sirena.org.uk>
References: <20200320065058.891221-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20200320065058.891221-1-tudor.ambarus@microchip.com>
X-Cookie: Laugh when you can
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 06:51:01AM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> This feature should not be enabled in release but can be useful for
> developers who need to monitor register accesses at some specific places.

Looks a lot like the trace regmap would give you....

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl50suEACgkQJNaLcl1U
h9D1fAf/VQnn06p5m4B5/lqhwYYKIVVW6P9u/0hBvpkxfRGfRDTxHr4lEOVO+9me
fiHiUJiG7hRJZ7gkf9nT+yr/NG/Feih+70C7F2fkrNqflZqi7iFWEJHrT8gPjri0
zuSkqgYo7kLnkBlrrcgaI+00KK3J15c59SZNJa9Qes/3VWtfa0jSi3x2WgAMPuGm
z5YDPYMTAe6dqSYkYfU14FrWN+p7/039ylhVcwzWZ3aActb7Kjuw4+ND9S7u203b
+9j4IeIXpbSCEkE19P3ZczIbiCJJ0fmgZiDkNPL4WGUSDsE3jvLxcKpKSKKRuo0B
o9T+CGXY/Htz//y4U+jLBI9Cg3BMYA==
=JInW
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
