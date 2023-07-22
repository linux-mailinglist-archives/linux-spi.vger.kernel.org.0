Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF875DBB3
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jul 2023 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGVKXk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Jul 2023 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGVKXi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Jul 2023 06:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634526A2;
        Sat, 22 Jul 2023 03:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EBB608CC;
        Sat, 22 Jul 2023 10:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37DDC433C7;
        Sat, 22 Jul 2023 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690021416;
        bh=LVpry3JQcRfweSWVW+qHmCd7TVCS1vwarNOOKIiPAhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIv4wCuKGYeEXAznxf8l8vffBm9GHK8UAZAOPq1rr83YBrsqs6UF6qHk/7JM31fXS
         GlyLFnxPcbL7aZm2u7MlIpLPxlrzhkk5QyxSJ5iqyJfCuzN5ijeCUee3gA89rZN9/H
         2fTtWuh6wzypd8PFHUKgRMy/BA7xc03kzcDhTZJ9NHMBJiBClmOCGbNWNrATcvcoBS
         fp4IHgCNSRTbNQA83/c8q8NCcLh0cwfQzPcEOLs/f87asO3seS11mx6A3NeytmnHKU
         aoM3vZCZvFEaYJpDAwC3/Mkhc0JGznk18VTWjF1UD1dxME8lGaZvt5Tf2gDaUzKuiK
         YbOsyCf1TqdVw==
Date:   Sat, 22 Jul 2023 11:23:30 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: media: amphion: Fix subnode pattern
Message-ID: <20230722-freedom-finer-bb9ec5b4de3f@spud>
References: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5O67FFq6sP1I1WLQ"
Content-Disposition: inline
In-Reply-To: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5O67FFq6sP1I1WLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 01:10:18PM +0200, Alexander Stein wrote:
> DT nodes use dashes instead of underscore. Adjust pattern to also fix
> warnings regarding nodes in arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
>=20
> Fixes: 38ad8b32f3af ("dt-bindings: media: amphion: add amphion video code=
c bindings")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/media/amphion,vpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/D=
ocumentation/devicetree/bindings/media/amphion,vpu.yaml
> index a9d80eaeeeb6..90d273b9fdd7 100644
> --- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
> @@ -47,7 +47,7 @@ patternProperties:
>      $ref: ../mailbox/fsl,mu.yaml#
> =20
> =20
> -  "^vpu_core@[0-9a-f]+$":
> +  "^vpu-core@[0-9a-f]+$":
>      description:
>        Each core correspond a decoder or encoder, need to configure them
>        separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8=
QXP SoC

Per the bot, you have some examples you need to update as a result.

Thanks,
Conor.

--5O67FFq6sP1I1WLQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLuuIgAKCRB4tDGHoIJi
0taSAQCKo+Tet5Wt2GlgR1ixWbP/Ut4IFcz4lV/NxuNARBpqkAD/Y+sZPWaywqIi
6gz4LZbtFx4c0/8rUZETje42Zmmh1wg=
=27sY
-----END PGP SIGNATURE-----

--5O67FFq6sP1I1WLQ--
