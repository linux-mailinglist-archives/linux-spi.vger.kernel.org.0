Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1A75FF01
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGXS0Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGXS0X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 14:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F26127;
        Mon, 24 Jul 2023 11:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63CBF61231;
        Mon, 24 Jul 2023 18:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9BEC433C7;
        Mon, 24 Jul 2023 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223181;
        bh=9ffshjawe7ePP3wjstrJWcIuUwVY/hxjZ5v+tNr0cE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4kc+LyD2WNAywx2BV8P/jdKVgycmkJWaEeKrPTpbeNvQHddfkY6nTTpZHgIbPTN6
         ccE2y3JmXGa0gPB71Xid5nKrnsaNR8NO5cgArMCsY61VHWzO6Qpcmadgc/01V/QTEo
         ZPWZ6Lgrpq5UEa2nCzRmL4rYVI/5Ay5B4a23cv0ak0ZMgaXnz9x7wcvJHoCi9zjgZq
         YRa/ZYUvpH2QxNZ+JhImjuLHZmvhSlO++Nl4UlTbRtCvawBD98p/LlQOlDFYJYHOLr
         FzJlbln5S+PvOx3gOg1vEw5d70Fc8QMzpTjUZypJXwAaFzVw2JYt0PzwWOrm8OYJJE
         m53aqydMH5IrQ==
Date:   Mon, 24 Jul 2023 19:26:15 +0100
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
Subject: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks property
Message-ID: <20230724-unscrew-bonnet-3c86da806df3@spud>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="28wonEGCRmvclXn9"
Content-Disposition: inline
In-Reply-To: <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--28wonEGCRmvclXn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
> i.MX8 and i.MX8X both use two clocks for accessing the periphery.
> Add clocks and clock-names properties accordingly.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * None
>=20
>  .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b=
/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 3d9d1db37040..2533e16720f2 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -46,6 +46,14 @@ properties:
>      minItems: 2               # Wrapper and 1 slot
>      maxItems: 5               # Wrapper and 4 slots
> =20
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: per
> +      - const: ipg

What do "per" and "ipg" mean? I assume "per" is peripheral?

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--28wonEGCRmvclXn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL7CRwAKCRB4tDGHoIJi
0iI3AQDshg5lnxWmTPbve9GqCzr04jlWKE5yoBdvebzEYm1IuAD9EAMpX8Eg00mg
uMHk4rKWYCzURW7c9XVHlUskyfRREQ4=
=oqF6
-----END PGP SIGNATURE-----

--28wonEGCRmvclXn9--
