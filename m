Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79C75FEFD
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGXSZX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 14:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGXSZW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 14:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F19127;
        Mon, 24 Jul 2023 11:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E9B60FDF;
        Mon, 24 Jul 2023 18:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F8CC433C8;
        Mon, 24 Jul 2023 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223120;
        bh=mb3WzOz9sDRsuKTLFt0WobyazeaXTOQ4Jxnw8Uz0lRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmFOml8OGY1jKerJf2GVKw8Brk582ZiuAdFYJAK6DsLN5xHYbMQgmAHe2eH0YSJDq
         4yvWLEfsguq6+Zquscav4+VQieo0Clty9yzqhq32w51Xi7iG/JyEg0GMwfMc8kcqsb
         55Pt6w2odwLI9FCLufhv2eEVhBDyA3fLdnK8prm5GZRCCgqXIhjcpztuc3D1PCq2Cc
         QqlxAkqk1cHEdeNNh0NAZrGk05tjPW65Xp5F0UmQl9DO8WDwe1ivwbAJLnBOcvTgEc
         pBCh7fySAYVIb04Likrm0RHbkaSLrMfZdTcNt0su0lKHbC64xiU8pkWrlRWeoVc1v8
         KxRc8BadTPfyA==
Date:   Mon, 24 Jul 2023 19:25:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: lpspi: Add power-domains
Message-ID: <20230724-enzyme-embellish-9c56a80e8ab3@spud>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lUQU8qgyOB+3G8hJ"
Content-Disposition: inline
In-Reply-To: <20230724122101.2903318-2-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lUQU8qgyOB+3G8hJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 02:20:59PM +0200, Alexander Stein wrote:
> i.MX8(X) based SoC use a power domain. Allow supplying this domain in
> bindings.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

(btw, please send cover letters for multi-patch series)

> ---
> Changes in v2:
> * None
>=20
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/D=
ocumentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index e91425012319..727c5346b8ce 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -63,6 +63,9 @@ properties:
>      maximum: 2
>      default: 1
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

--lUQU8qgyOB+3G8hJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL7CCgAKCRB4tDGHoIJi
0khTAP4zYzdP6VMUFHgzJuvCwQY3mtaU6P6SnyccBy4MCatmsAD/QrUAUZI2J3Gj
S4XEPa4xvWMyeOgOc7I7AWL6C8Byrw0=
=cOtn
-----END PGP SIGNATURE-----

--lUQU8qgyOB+3G8hJ--
