Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE8497FFB
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 13:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbiAXMxt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 07:53:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiAXMxt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 07:53:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8F00B80F9E;
        Mon, 24 Jan 2022 12:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192FC340E1;
        Mon, 24 Jan 2022 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643028826;
        bh=Y0OL+x+SRLGEYswoXHiqhwdDrUNADi5qHnZQcYYK6X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQ1mA40JEOyF5ctlOBwPFol4BTafm2QYqPk03jsFzdeK8aiAM55Oz2rnt36TiiGdM
         3hgnDdxsPg+ZI2A6fuWPAuzQFvzbJ2n464D38xZaKxMwA70Jm68DDS7Y/0TeyEVtpf
         ElafEPLyRxQBEV4r6jrl2esTIanXCS7ncQb1Ln+UJEDCA0KWjiR4cZAkefa4xnpvzf
         vt3bA95Ez7dvy3wXgA5EDAC75LasEtDdtJ7z/HejtlJSDKZ6m5YRoixE8407vOPE0j
         esuEIz0XCj85LWQ7fQWVTti94spR/Ta9kbuqq5haQCPRq//1f5vxjdvBDKE+okucMY
         bm2VKSQe+ZaSQ==
Date:   Mon, 24 Jan 2022 12:53:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 3/3 v3] spi: s3c64xx: Convert to use GPIO descriptors
Message-ID: <Ye6hVXXjqq+Zvoyz@sirena.org.uk>
References: <20220118230915.157797-1-linus.walleij@linaro.org>
 <20220118230915.157797-3-linus.walleij@linaro.org>
 <CAPLW+4=6A=FLKOum48VNUaGBUUXBa=sMYRn4n1_nTtR8a+0YQA@mail.gmail.com>
 <CAHp75VftUNC6xFVRJqJhTqHwLvehtT+2+M9j_TsnhAyOf039rQ@mail.gmail.com>
 <CAPLW+4mP0thEi0RbFa0p=_awMwRQ21T6JwW9tTz0gweP6ycVzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDgO9ZN3DDnugHxw"
Content-Disposition: inline
In-Reply-To: <CAPLW+4mP0thEi0RbFa0p=_awMwRQ21T6JwW9tTz0gweP6ycVzA@mail.gmail.com>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NDgO9ZN3DDnugHxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 22, 2022 at 12:18:11AM +0200, Sam Protsenko wrote:

> It was already pointed out earlier AFAIR. Personally I don't think
> it's too major to send v4. But theoretically speaking, maybe it would
> be even better this way:

>     u32 fb_delay = cs ? cs->fb_delay & 0x3 : 0;

Please don't use the terery operator where not required, it's not a
legibility aid.

--NDgO9ZN3DDnugHxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHuoVQACgkQJNaLcl1U
h9DPsQf+Pboi7lVBiMvo9vvQ7oCRon/RJd6wXKohFgdg6cUYyzRU2DpeYvAmLKn1
HFgFfyUDtT2ewRBfFbspFsXYSW0skwZeuwEUF6nfRWtprwaOP5LiK9+a3i3fm76x
w6cB0BFOwg9/BdSxWkOn79hrZloRwS73vjbrSASN3EOnlQUfr1U+n4qAngE5/Y7v
EqLFq7CohWkT6+XtBaamjqM595qNjZnaawHcONRfrifZ/Bp8NlY9Ull/wl4pCo9C
3i98/ZVSfHj5lKOPgFV8MH9JEn/kTWB0lCVG/wgyuVDft+CixsfeYskuRevEhafd
WCXz33IIAt873iNiFjpMGVRYOAyY5g==
=yxpg
-----END PGP SIGNATURE-----

--NDgO9ZN3DDnugHxw--
