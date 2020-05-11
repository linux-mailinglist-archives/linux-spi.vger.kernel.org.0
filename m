Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C441CE1B1
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgEKR3Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 13:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgEKR3X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 13:29:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6AF206D6;
        Mon, 11 May 2020 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589218163;
        bh=zgTH/hvJfIRnb5g4gab7CE2kKa9dxTSLjfiVX2KI6aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8O/Coe63iXm+lYoq38cwOSFg7lfEVLAgQOqTD4UTAyHIFyLpUWFlyY/r0cXHvpSC
         MmOU9Y0vz27RiOiAHS/oql0Tl2uA4s3DS0lJwBZ9QRSIGmBeQSubImCuK9qlkykRyu
         lNXwqXfpVstrBDhQyGoi2Figu3vSNrd6Vcyi6ySM=
Date:   Mon, 11 May 2020 18:29:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] spi: spi-amd: Remove spi_master_put in
 amd_spi_remove()
Message-ID: <20200511172920.GJ8216@sirena.org.uk>
References: <20200507115550.139457-1-weiyongjun1@huawei.com>
 <158921769453.22432.2365518895564552869.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <158921769453.22432.2365518895564552869.b4-ty@kernel.org>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 06:22:01PM +0100, Mark Brown wrote:
> On Thu, 7 May 2020 11:55:50 +0000, Wei Yongjun wrote:
> > The call to spi_master_put() in amd_spi_remove() is redundant and
> > may causes user after free since the master have been freed by
> > spi_unregister_master(), so remove it.
>=20
> Applied to
>=20
>    local tree spi/for-5.7

No it wasn't, sorry for the noise here.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65i3AACgkQJNaLcl1U
h9BZhgf/To5Opp1U5IvZBJmxD4iQoXnz/vU/Skvv+eM07mxrZ43FOdR9dJ3BiKBU
uXJXHA8L6z9bjtK2HQIQfKzsZVIFmAKkhZ4Kx1TpCGAu/ZFOQMnUHKDbDuWSSW88
lgW1bM4c2iQ6nIjezmMbB5hr1Bh2OagO+uaCK89Hd0YrSpMsxPGK3YitN+KNkEG2
MmPBbwpsW9z3Zf2z4F/Tqov7E3UTkiLdjO3l4yCBEaBbGok+GwgCi602sPs55B3P
BC9OpIlI3ElAOvzWr9WGsdgrMK2csS8johbF2nebiJIKZ55NT+nE6PlhDnH85cKZ
iQigArp8qPSNYtppnK6Gb3vhEISfmg==
=lyAT
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
