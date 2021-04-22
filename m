Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E88367F95
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhDVLdq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 07:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDVLdq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 07:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E7AE61437;
        Thu, 22 Apr 2021 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619091191;
        bh=xDI5eBS6F8rcLcIPh61XOe2+dJaGm9SUWLO+i/3wDEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klqkOjqP58KBuOUzOjZcbTqU+IHWbHLgD5mNITfHiV5MOR/IesC1BiJE+k7oi/Eqo
         YNLecqUr1s9bsU3G9DerapMvLI2O/Gl3x6o0VMAuj5meWORdeGeqhjecXbABqYPv5N
         pW2tA5dvxfqR4BbZMZQEt8GhQRshGm829PrAYSYznvMz7W/dkhUPe8J+5ckN4Hu5+1
         ifdoxXowq0CI4Y7zd1ss7RF6YY0ZA1JGU5OgCFPCAaFyvsG3UgH4z9BKatpw3mWtTp
         vGlqu1odNCkXTwQ46J+a0ZkqG8AXg4udisj4WuSHmRxDVWQ1ZfUIel1zrGjEXKqolL
         zXeY39LnOvKtg==
Date:   Thu, 22 Apr 2021 12:32:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: stm32-qspi: fix debug format string
Message-ID: <20210422113243.GA4572@sirena.org.uk>
References: <20210421140653.3964725-1-arnd@kernel.org>
 <20210421150510.GA36785@sirena.org.uk>
 <CAK8P3a0CWp_H-tm2QcZyH1FDXwzMgxY_9dc1Y8pA28MQKT-q=A@mail.gmail.com>
 <b970a557-b869-c867-3825-370a36feef68@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <b970a557-b869-c867-3825-370a36feef68@foss.st.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 09:30:16AM +0200, Patrice CHOTARD wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Regarding this issue, how do you prefer to proceed ?=20

To repeat my original mail:

> > On Wed, Apr 21, 2021 at 5:05 PM Mark Brown <broonie@kernel.org> wrote:

> >> This doesn't apply against current code, please check and resend.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCBXtoACgkQJNaLcl1U
h9DZQwgAhkjv/7njL5nJTDc2PAZGesegUWMrkNDFhg1F/m51cNUxuvc8HAp7J/es
m6enbXoKdkgnjrXhH5dxirBRFwssxZlcrG75ijEkdxrjMWbMapSGEzCtGm/QB+9r
x+cCm7JbvSPF4CCnCjXC208uoSAfG6WPp/rLLKAWaY/WBaZyoQhvTJl5sp/MAMdC
p4taxgGXF/h5E+TLy3HeBlaPTldnBgfxPql0UNWDkwsfjM3ti/HWmHQ2G5MiwdJ5
zoasbWnlDJi3FDIWRF+qKIx1c6FraYEZCRe19dz2yWpLH2OblrFGqgFTkQG/5IxR
hDvxq5PzgaZV7UrC49z5T9fLI00kQA==
=H99h
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
