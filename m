Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428E2E7BC5
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 19:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3SGg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 13:06:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:49794 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgL3SGg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Dec 2020 13:06:36 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 21C701C0B92; Wed, 30 Dec 2020 19:05:38 +0100 (CET)
Date:   Wed, 30 Dec 2020 19:05:37 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Pavel Machek <pavel@denx.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
Message-ID: <20201230180537.GA23860@duo.ucw.cz>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-12-30 14:57:08, Lad Prabhakar wrote:
> Use __maybe_unused for the suspend()/resume() hooks and get rid of
> the CONFIG_PM_SLEEP ifdefery to improve the code.
>=20
> Suggested-by: Pavel Machek <pavel@denx.de>

Acked-by: Pavel Machek <pavel@denx.de>

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX+zBcQAKCRAw5/Bqldv6
8pewAJ4xdjYX4Irj/PA7PyoUmjHnxKd1iQCfbq140zLJ5upDysm/Y487vJEw6Ew=
=vHD6
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
