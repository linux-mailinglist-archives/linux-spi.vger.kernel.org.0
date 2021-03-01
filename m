Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A255B327F75
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 14:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhCAN13 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 08:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235308AbhCAN10 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 08:27:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6C3164DBD;
        Mon,  1 Mar 2021 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614605205;
        bh=y235OLLbbPJD5I84kL0KJV6s4+cN8jpOh60zl77HMVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjwYrxF0OKO1FHQA/5DKflI1JOZOptfYnYr4F1sxxaDBJZqrFd6rNCyfvYuzKnv4z
         hVxlqDZ8qhGumH/XbRpaa3cX17b6qVsU0VIAeD02JViJ4omNqNLbaOmkDhhQzJp08P
         FrzZPn19iaUtPmE2+jWX2NJAm7uxPa6s5yyAIqz9+Vd8nJr3uGBhQ71bKVB/gAP1QI
         +PBP7t5HmFAaQxms7ezuv9F9pOqqO77K8k8ptsJpFTW2jmFvDkQrbcxwevSG/568e9
         F/tSA1RSGlgDwgzFTUOrWIWH+Ci0TqAVySwvA/JrCDm5UN0R6FjicU2ixaUzKkn0uo
         XkP8NigNWX1Ww==
Date:   Mon, 1 Mar 2021 13:25:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for imx8dxl
Message-ID: <20210301132539.GB4628@sirena.org.uk>
References: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
 <20210301103230.1816168-3-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20210301103230.1816168-3-kuldeep.singh@nxp.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 04:02:29PM +0530, Kuldeep Singh wrote:

> This patch is dependent on
> https://patchwork.kernel.org/project/spi-devel-general/patch/1614593046-2=
3832-1-git-send-email-kuldeep.singh@nxp.com/

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

That's a DT binding YAML conversion patch, why would there be a
dependency on it?

>=20
>  drivers/spi/spi-nxp-fspi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

This needs a DT binding update adding the new compatible.

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA861IACgkQJNaLcl1U
h9DqcAf/UqwancFfxEoW7LdZHLWClxvwX2qbMjZKbxjefy/N55bvEaqOz9RuZsD7
ZyAbse27gIEB8x7jrBTQw0fSP38TrilHL2rgBqtC67DJA9NXpiFIkPphDbEoSzPz
SQ1FBZxqVOspVoxRUQlKlPJmrT4YTGgB3ZodtKhZ/KJTdPwk273ladeCHNmTd+fV
BqnV/g9EFdz0/FYXRYZUCY7gpZv+/T86TEKRRgAVqN5cDh3wWzQ2IoUOHf54IBWm
DjKheYdyh8mKo8kfIMukBT4/n5qqNgoTH+aQ2UUjVHJP5LX+OlVFsZmS4ekrmrku
HXVztGhTvtna47uvw36taDMAx7/mcw==
=qU6p
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
