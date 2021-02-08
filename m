Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7E31312A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBHLn3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 06:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhBHLkF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 06:40:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7FDB60231;
        Mon,  8 Feb 2021 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612784364;
        bh=fXiLNXReQfld+xbc46qmq3iVlzicDqpwgPmJEH/S3H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrTebOaNFKbCVYwZHPHOpXFYNtg5zSGTrby0xKtOkggKxXOVhqeuXHWCRV1HHwsOG
         VYXCR8Oki+jh1KES6cx1ESLUQoHlr4GWrduobBvpnXnjDK/joonZmik+nVs+LdYoLu
         5StBjKQvacuJ49MQbTXcsheAdqOLA2TBqNKn7+gKho96D0qyOn9nzf5UV+nHqKUU3J
         b/PVkYNrnQfRUo55lCVqPL7DvY7bsdT2nyN3CnFrRZ/amA6T6ujH2OABvlDwC3XDPE
         MT9pxSSY05j/sN/OGTODlI3JkFiNql5M3FDHFBvpDsrdrXpr5wF+Sl15CvnO0ZAwM+
         UT5S8RBySCTQw==
Date:   Mon, 8 Feb 2021 11:38:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] include: linux: spi: Change provied to provide in the
 file spi.h
Message-ID: <20210208113832.GC8645@sirena.org.uk>
References: <20210208113359.31269-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20210208113359.31269-1-unixbhaskar@gmail.com>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2021 at 05:03:59PM +0530, Bhaskar Chowdhury wrote:
>=20
> s/provied/provide/

Provide is a correctly spelt word but it makes no sense in context, I
guess you mean provided.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhIrcACgkQJNaLcl1U
h9BHAQf9FevPZGFF4iQ3pCPS24vEaLRD8YC9luaHmgZW7MBhmBIs/ca6lVIajNgR
VGIQIN3H3cSh74VImlJL/gM9ipyd9u9wGuW/zohvvdckS9UBD/V87vQTP/O21cn3
RoIkR0TZSApjTST+vJoZNpflomtT5a5tY6WSBUk2mx37XY8WlVOsKsQ/lOinrCOz
Qhg661HLWdOg33sxODmZ4Cop63lYiOQaUULZ+wZJRFeunIYTVT8Zgj36kYxmRCgc
qg3yS89ofhdqT7UcG8TkDBM1oPVsaSXDB01MTljCLQuHbDLqx0tJ3S4biQHmfXkr
smGp6q6gvw7H2KGEllaWKN68v25vFw==
=RbJ/
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
