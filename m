Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA10492BC3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiARQ7m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 11:59:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35964 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbiARQ7m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 11:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6B061468;
        Tue, 18 Jan 2022 16:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADDDC340E0;
        Tue, 18 Jan 2022 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642525181;
        bh=9PTJ/XgcnmivrDW0z9WRB/MdGxH6X74qSBIj8T+AE2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvC/ucKVkZXPFbp7qMF3dZI3xxC5WEeJRF1tJ9lJGNJhrXEz4b7cECNduabgtXQjZ
         Ffx0yDB53MY2dQRYkKyOwL8Ou/Ul0vXedO4X4eByKRtuBNpPyxnXCTQzCKHMtCHq+2
         05zcgoUixIUj/CESkVmcoBYfAw/G5f/b4r4VK3uX1yXFZRuId0efO6Uoq7sMuPb63X
         GuoviAv5MCf7q2bU94PLM5RklfJgBT2wo7IcPe3440WP2TtUNhOhEkAErtKnS6v4FB
         Fp/teiySF+4LXaFqcSC6/ER+jmpglm0fGFfSi8uZ+SdhJ73DanCdiG9U/VX/sjCddb
         njkz57qkEZBaA==
Date:   Tue, 18 Jan 2022 16:59:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
Message-ID: <Yebx+BwFfKaXchtU@sirena.org.uk>
References: <20220118110928.120640-1-linus.walleij@linaro.org>
 <20220118110928.120640-3-linus.walleij@linaro.org>
 <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="by/8jB+DYYwaZtvu"
Content-Disposition: inline
In-Reply-To: <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--by/8jB+DYYwaZtvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 18, 2022 at 05:27:27PM +0200, Sam Protsenko wrote:
> On Tue, 18 Jan 2022 at 13:11, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Convert the S3C64xx SPI host to use GPIO descriptors.
> >
> > Provide GPIO descriptor tables for the one user with CS
> > 0 and 1.
> >
> > Cc: linux-samsung-soc@vger.kernel.org

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--by/8jB+DYYwaZtvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm8fgACgkQJNaLcl1U
h9AZHgf8CDmZRdB6nQ2WCscgNLzCvuLudfldEB9SfAG/UgUWNgRB+tSYv8zf1Oce
TP+ObyQRVqFtz6VzWzRbl3QI4yLhzRNoAXCq+jaT+aDTcpKWnOLk+hwstwP0V6JP
R9cvOdWGZVUmy0EKsI/VDW2z4bhVX3VhBgLX/XtW9vq4OaHGkryF7GCAcq+jUuOL
ZwPg75kntRa8pss+dISejFVE/VaJdFws8S0uPwWCQXuY/A2U0s8RFRkeLyi8FEI8
pfN5MZPj8vl0AbtV8SZkE8O91HBCYdFxeumzBz/NpvINYiuR3uO0V8VwkvjhhViF
UAgLJ9QXBIarHIF3MN1Kt4Tswuv7eA==
=Q8Zq
-----END PGP SIGNATURE-----

--by/8jB+DYYwaZtvu--
