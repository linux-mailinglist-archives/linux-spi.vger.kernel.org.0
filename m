Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1D3DEFC8
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhHCOLK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 10:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236432AbhHCOLK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Aug 2021 10:11:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E558460560;
        Tue,  3 Aug 2021 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627999859;
        bh=N0ZTtrHdIHPT96G9nBYkGdXTL8PsI1Gk6OP7BRI/XWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+8I7RyNPSsLNAcXZ0c7bkXcr6kChyBewrKHP4n4Yvbi+42JeojCborCIczYftJB/
         GKveQlwLIL9FhKlaZEotV+MhPEM8x5WUNZiHV+EgZx5fiwkxyBtFV0ntj5/4u8Nt1H
         tD2jdm2C9kaYGgBrczMmXVoLDXMgoIXSrE9gBkxpLnVNgY+xOm959iOvVLkRbN4DbW
         Z+aAU1iteh/iQzWVUtwGNZaSSsw3PQ3s+5T0YQjxyKyFnH3tgA/3mhA96byevPBy+9
         Fs4bQXWcPeDiByrKpB5ZY4c1OTxZ/TU6nTOvZD3x2Vrhx+4YdDB54GdrCsjqJQ3VbX
         +3n4ivjhRNj7g==
Date:   Tue, 3 Aug 2021 15:10:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v2 4/4] spi: tegra114: Fix set_cs_timing param
Message-ID: <20210803141045.GN4668@sirena.org.uk>
References: <20210803102517.20944-1-Mason.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rzq/nSLlHy1djmXS"
Content-Disposition: inline
In-Reply-To: <20210803102517.20944-1-Mason.Zhang@mediatek.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Rzq/nSLlHy1djmXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 06:25:18PM +0800, Mason Zhang wrote:
> This patch fixed set_cs_timing param, because cs timing delay has
> been moved to spi_device.
>=20
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  drivers/spi/spi-tegra114.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Each individual patch in the series needs to be buildable by itself, if
an earlier commit in the series causes things to fail to build then that
commit needs to be improved so that this doesn't happen.  This supports
things like bisection.

Please also look into how you're sending serieses, these patches aren't
threaded together as normal and there's a weird "***" in the subject of
the first patch.

--Rzq/nSLlHy1djmXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEJTmQACgkQJNaLcl1U
h9D67Qf9EAF3egsc5vOgwsyJ04565RzPgzYINu8phKCoAsP7U3wUTep3WbMcGLOx
lFEMzwwxeT8grDvDqx3wjXvh4hb2SnSlO/6hA2UOEUuqe7K3aB+UvmIxUIdoDdZb
mJSklejnK4Zfb0SDTf8NVYpEvvFDO92LcOvAeDVshuHGfKIbsFE3gCVXlsKmC4id
0ztnP4SFtrwQDKgRf1cUvjJwWpUoKwdctGdzlrwz00OvCJkU+U8VMSss/tZkJUpN
+bhfZp2R0aYi3579ReTPj9RfH0PLTNg1c2oVTVCUD7DRPtmrFvUMj0roggpKtlgp
pn72WZmvyXwLgG0g+n0SbtErGbDITw==
=M79B
-----END PGP SIGNATURE-----

--Rzq/nSLlHy1djmXS--
