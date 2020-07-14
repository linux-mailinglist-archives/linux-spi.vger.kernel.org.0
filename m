Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2C21ED19
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgGNJoW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 05:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgGNJoW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 05:44:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376F421D7A;
        Tue, 14 Jul 2020 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594719860;
        bh=WIzzL2vxmexuuKMhffrG8LZui4Dea/ANs5K0xx4zolE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cg7mYIXAqtB0Frw9eTLIzy3AqMaN8uzdBgVihAY/uCka7Fn7d6nvxK4PoCWN3i8lf
         R4jgxKw1+mE/hX2r0+VcjCG9NrEsln/oLoqK8QNSiDdAlRckCgOVMzb/YvTEAOoJo2
         dtajleBa1Jm7t1eqcoWxZWHkmoDc8iwHhxXjQb5Y=
Date:   Tue, 14 Jul 2020 10:44:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] spi: Use clk_prepare_enable and clk_disable_unprepare
Message-ID: <20200714094406.GA4900@sirena.org.uk>
References: <1594717754-25428-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <1594717754-25428-1-git-send-email-zhangqing@loongson.cn>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 05:09:14PM +0800, Qing Zhang wrote:
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
>=20
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  drivers/spi/spi-coldfire-qspi.c | 4 ++--

Are you sure that ColdFire uses the common clock framework?

>  drivers/spi/spi-omap-uwire.c    | 4 ++--

It makes life easier if you send per-driver patches, that makes it
easier for driver maintainers to review things and means that issues
with a change in one driver won't hold up another.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8NfmMACgkQJNaLcl1U
h9BIbAf/R2GkeQj9D8dfvZvUp0id4vPtJwbTq/q26CQepJMwZC34jt2JA0XnTtnf
58YhpL1GG9S1rcA8KGict63K+v9IsC+YoQwtfDWQpwRUCJ7dCSpZJCAxDSMbsUrl
TAg1bFo37gqb4zzeNBOohrp40QhAL/XV+Y8N4Eih6Sf3lBmeEPKqdLuLMumBPriR
ZCoOEiArZMhAbSvLsCzNVRI7j0Bc3jqqQxTHDu8VxQI/4OETK/cM63UQdfKeFETv
013BOyx+E4Ig7es5SfB1KNKIAWM44q3M4/R/MAGQs8iZZBL15pvio9QcZNyaorU/
3RnU7uo0TMOq5QORtscA1JRNVpIvOA==
=TPc/
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
