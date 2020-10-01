Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641E32803A0
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgJAQOm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 12:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbgJAQOm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 12:14:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10D320759;
        Thu,  1 Oct 2020 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601568881;
        bh=QfU1X7o6CMv2QgATvf/sDmoCIsKFJq810j1nD3jmnHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujOpC++6SqUikoMRcuslDHokLz1aTcwJc9LWD9k9kpYnnPIJi6IdR0ZjQSd8iHJhm
         EjvA2C/6W/bOeLKovX3iX9nng/J1vOwmhQRG1tAwQ0dMdxogy3iS+g7tC60pxicO5m
         evfOJEMZMYm6seqxrkH56mhbO5SbcnYCIkjka3ls=
Date:   Thu, 1 Oct 2020 17:13:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 0/9] Some fixes for spi-s3c64xx
Message-ID: <20201001161340.GM6715@sirena.org.uk>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20201001152246eucas1p1ee289b8a85b707f7496355c081623796@eucas1p1.samsung.com>
 <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 05:21:39PM +0200, =C5=81ukasz Stelmach wrote:
> This is a series of fixes created during porting a device driver (these
> patches will be released soon too) for an SPI device to the current kerne=
l.

There appeared to be a number of outstanding review comments (misleading
commit message on patch 7, some concerns about the non-CMU case), please
address those.

Please don't send new patches in reply to old ones, it buries them in
threads and can make it hard to follow what's going on.

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92ADMACgkQJNaLcl1U
h9Dvbwf/RxRHBrkQpmJBwvP6aCwHfrBFfZdf8prH5Yv/UlBniia8LJYK7YX2R8/Y
Cu+5SvplgHueBk53qt+oQ0M5iv1DOn4TbXyhsZXUqwlyKh4tGb+LKpRrc8AR09Sp
nYuTT/+AuBsxWdG3aUdILbsEeqtj8k7krbLz8qrd6wsi9idAaZtsFuIMNhVmRcuv
mvxTFebn/PKTNeC1win9D668cSe6oRcDVbuD/GUsYZA+CuVnOi/jR/ZQn6rv9Q+Y
jyWtAWBfl+bRe+yQqwITfaiLzeu0Y1CizmsO14piuAoNhxUEinhE+7FlJlgf44Jx
uQ/xxgm8jvwtQV3zbUlXM6ybioqPnw==
=ZotW
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
