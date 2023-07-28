Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AC7671CE
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjG1Q0j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG1Q0i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 12:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EDB2D60;
        Fri, 28 Jul 2023 09:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A3C62198;
        Fri, 28 Jul 2023 16:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F4BC433C7;
        Fri, 28 Jul 2023 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690561596;
        bh=nmUkwJGlCYdx9/jRhhqhnLL1pgkciaibSCGGSZ3HRfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCAzQsMvRXfM2BeGixJvA2c1o7QmBvNDtzURBHD7CkTxGJV7sSuQwAymjl8J7hDeH
         t6kRYNKvov+CY5yslmyojN6Gea/1zXKbEnB44JzMjMyBxELPvP2QV6GDna/DIN1EFW
         gV4EmpQdJQuE3HDdX3q0z30WeXbqWf/f1uySh9SFcHswpLruVXNFZOe/GlNaAfUDwI
         P9W8t7f89wbDDHe1nlLed7u2/PBYV9DwE3ad/Bh1AyVmyjy3+4WYa6N7hCY10cM4xU
         6ca5ySZrbImY24CwO/GExYo+JIDqCOF8lE2XUmI0XMjA5VihjrONiJEhOY3zSSuX5X
         iUkKaTQPt3kwA==
Date:   Fri, 28 Jul 2023 17:26:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: fspi: Add power-domains to the DT bindings
Message-ID: <20230728-shortcake-luckily-1b5d5db48a50@spud>
References: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NXLbKfCjNqB7h3qo"
Content-Disposition: inline
In-Reply-To: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NXLbKfCjNqB7h3qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 08:08:04AM +0200, Alexander Stein wrote:
> i.MX8(X) based SoC use a power domain. Allow supplying this domain in
> bindings.

Sure.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Do=
cumentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> index a813c971ecf65..7fd5911454800 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> @@ -45,6 +45,9 @@ properties:
>        - const: fspi_en
>        - const: fspi
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--NXLbKfCjNqB7h3qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMPsOAAKCRB4tDGHoIJi
0gWmAP42/DW7JOWcv9X/m5FRRfW0qRV1ZDc1vmz9CldNMnvypAEAu1n7nZURx8wI
t4hS+VcA+kcrjA8PsUk3RepzJvgNTgs=
=oiwv
-----END PGP SIGNATURE-----

--NXLbKfCjNqB7h3qo--
