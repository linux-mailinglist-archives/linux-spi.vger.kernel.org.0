Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECCB75FEC1
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjGXSFG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 14:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXSFE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 14:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF59170F;
        Mon, 24 Jul 2023 11:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B3A061367;
        Mon, 24 Jul 2023 18:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3330C433C8;
        Mon, 24 Jul 2023 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690221898;
        bh=CAoflnTwe94yGJqZQj4Ul2RQGZ3TwNts/jFgOPaKF78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKLSQL3Zm6gw03tQtEzPPFIb4BA8Z9CBEdy7kx7Y0rhqyGLkg9iiQnNDfaoig6Lsb
         ocRjgj9Qx1tWYGO0MHbb3sDVJ2Z1MALwJuaj16Clibqh7jeYvT8h6r4APBM7oaQo6C
         huv9PUcjaeoBMZjMpSmGIDcQjIm2iQ/UjIDpOKneBWueijam7KKBtFucv3uZGW0PS6
         avIb6oVLP0HDrCl+wJqsNi7GHmOQhbOZXB0nACci4CUVfe0AzgSq3TV8/6pT5gsGvE
         sQ1ObgLJH/DENR3eXg4jYN2oqNV9yLU4qi/ojgUZN9CRtwEyEwZ4fPVl9b0F7zeXmf
         MxqxSkOSoIE9A==
Date:   Mon, 24 Jul 2023 19:04:52 +0100
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
Subject: Re: [PATCH v2 1/3] dt-bindings: media: amphion: Fix subnode pattern
Message-ID: <20230724-march-geography-cf35b5589ce9@spud>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PrQcu0f5/2leJ+es"
Content-Disposition: inline
In-Reply-To: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PrQcu0f5/2leJ+es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 02:20:58PM +0200, Alexander Stein wrote:
> DT nodes use dashes instead of underscore. Adjust pattern to also fix
> warnings regarding nodes in arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
>=20
> Fixes: 38ad8b32f3af ("dt-bindings: media: amphion: add amphion video code=
c bindings")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--PrQcu0f5/2leJ+es
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL69RAAKCRB4tDGHoIJi
0sjtAQCT5BNmU7oQNEtpMY0RSS6rZduTZAdo9i/nHj1ckp6pDAEAwspsvK7GviX1
1JLoNXkEnfIVPWsK/oWgwtoalCSOoQc=
=ujEk
-----END PGP SIGNATURE-----

--PrQcu0f5/2leJ+es--
