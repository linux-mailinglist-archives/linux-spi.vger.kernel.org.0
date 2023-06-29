Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84187423A8
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjF2KEU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 06:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjF2KDT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 06:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307335A0;
        Thu, 29 Jun 2023 03:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE416150F;
        Thu, 29 Jun 2023 10:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92293C433C8;
        Thu, 29 Jun 2023 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688032890;
        bh=kngVDLP8EcWTRovA9cLhs0xFzxZUA7xOIHboqdV01U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0BLJlO8gT3Iqiftb5RTJ6sq+b/SsmTV2gA48rAlDujffJb1uEhZ8OMw2+wJ4JFOV
         kNEBoFSYxrYzN9zQR8JXrWstgFq4Z6htB7Igy8pNiRclBid5fsHwkQAoEy/d/N+Wvf
         MxOCW0rgBlQncrMhTmtFD9XVe+RWrCQunY8YrMp98WKO1D+gjYVhN7WsyxsvCrPYx+
         H7aAMe885NUocgLYoTr1OsX6GtdfEzkIVjJNU6cjltZvwlU3Uxkk3i5PwVwSAkCbwU
         Yyzvj7cDKKVTOEQwFrbOT+SwRqItjkCykidwGM/cVjaa8rOeZGhSOg5eQPu+/NHP0W
         l+eZE9mwQPP0g==
Date:   Thu, 29 Jun 2023 11:01:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for
 GPI DMA mode
Message-ID: <c06c55b1-0f68-4e3a-9209-88af62452c82@sirena.org.uk>
References: <20230629095847.3648597-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H47GxCSHNIPs3G2z"
Content-Disposition: inline
In-Reply-To: <20230629095847.3648597-1-dmitry.baryshkov@linaro.org>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--H47GxCSHNIPs3G2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 12:58:47PM +0300, Dmitry Baryshkov wrote:
> The GPI DMA mode requires for TX DMA to be prepared. Force SPI core to
> provide TX buffer even if the caller didn't provide one by setting the
> SPI_CONTROLLER_MUST_TX flag.
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000010
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--H47GxCSHNIPs3G2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdVnQACgkQJNaLcl1U
h9DtNQf/TW/qPprxaVj2PfFoD0k/lOuQA6EIJQcteiLv/P4D6DEXyb/WLLLJn2l+
bk5cO8AFJdqHVuRVwdb47fQEX7JWRtU9T0Rg1brWme6xTls6yZ+uxPBPmf+XFsio
ajI8fZGwW6Sj42oNLnRgB6guDWz4SBmWHS5ZuWL6hxzSPAaiNbXyLuH7D/Ze3DAn
KWEhOJt6DOG6T0bhfXWiokCbudopGbjsQhM8RqgkUUIJHBXl8FaIukG4Du56/uIz
ztyYvQdqdZAj8vVoN7HfEjIFECGtnSEa//UbZf3WzjSTubOXNDJJkR7PsQNY6z2C
PV7PUKgFsZvokTO9MJdAUywGDFjQ3A==
=YGCJ
-----END PGP SIGNATURE-----

--H47GxCSHNIPs3G2z--
