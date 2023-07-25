Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D07762214
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGYTOL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYTOL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 15:14:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3911B8;
        Tue, 25 Jul 2023 12:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE98E61884;
        Tue, 25 Jul 2023 19:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE35C433C7;
        Tue, 25 Jul 2023 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690312448;
        bh=o+O/Jk71dzlERNjmO1aGiXrhRze1SOzo9ZcDuG2HzRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txQoh0Xv0YRWkHlNo1ZViUjjr40HJHDtEl+xS+rJzK92bEbyR6O5cqzhN4K+6gHtl
         zYiyfc3a/8rVD8bGT3fK+C3t+qtzj6/6uyT9GLzqATSjFGNqll8XOi622i8sh5zdPO
         ujWY/5TfNDKJfkntyj4MSP2k5C6T5CHGVOtBch5FU8BaVf+0//7XBIu6vuKY4fmvYd
         FSxyaNugucGnKRKjYXizjw+Fdi8y4jun72+tARmcE7OElGyZqhakBbQJNAb8qAhq/B
         4ShRMaJXRt/gj1wTH1Ta9XB0q7JfNZ7RWCulPFtDwhEj8rtHjQ5bjwID0vBpdf3OWk
         AfefvidnnxEyA==
Date:   Tue, 25 Jul 2023 20:14:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <20230725-catwalk-reviver-ed7611a15f54@spud>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
 <20230724-unscrew-bonnet-3c86da806df3@spud>
 <1908243.taCxCBeP46@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lbf0SnNYlJcLd10g"
Content-Disposition: inline
In-Reply-To: <1908243.taCxCBeP46@steina-w>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Lbf0SnNYlJcLd10g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 07:31:55AM +0200, Alexander Stein wrote:
> Am Montag, 24. Juli 2023, 20:26:15 CEST schrieb Conor Dooley:
> > On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
> > > i.MX8 and i.MX8X both use two clocks for accessing the periphery.
> > > Add clocks and clock-names properties accordingly.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > Changes in v2:
> > > * None
> > >=20
> > >  .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++++=
++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.ya=
ml
> > > b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml index
> > > 3d9d1db37040..2533e16720f2 100644
> > > --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > >=20
> > > @@ -46,6 +46,14 @@ properties:
> > >      minItems: 2               # Wrapper and 1 slot
> > >      maxItems: 5               # Wrapper and 4 slots
> > >=20
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: per
> > > +      - const: ipg
> >=20
> > What do "per" and "ipg" mean? I assume "per" is peripheral?
>=20
> Actually I don't know what "ipg" stands for. It's a quite common name on =
i.MX=20
> platforms though. I opted for the names currently used in the DT. The dri=
ver=20
> doesn't care for the names currently.

FWIW, my motivation was wondering how someone would know which clock to
put in which.

> But cross-checking the reference manual these clocks seems to be called "=
jpeg"=20
> and "ips", individually for both jpeg encoder and decoder.

Hm, that seems confusing TBH. The reference manual is where I would be
going to try and figure out the numbers.

> Mirela (added to recipients): As the original author of the DT nodes, cou=
ld=20
> you provide additional information regarding the clock names?

That'd be great, thanks.

--Lbf0SnNYlJcLd10g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAe+gAKCRB4tDGHoIJi
0o1UAQC1cnVwXp98JS4HvqzNrw9c8F55gRCUOnjji9asmPeD5AD/WfP3b0aAYSf5
0s/cT0K7cT5JAZnGFpCHwNLOPy1h2g0=
=IYFs
-----END PGP SIGNATURE-----

--Lbf0SnNYlJcLd10g--
