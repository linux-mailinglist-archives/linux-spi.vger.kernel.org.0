Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230357B50FC
	for <lists+linux-spi@lfdr.de>; Mon,  2 Oct 2023 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjJBLQV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Oct 2023 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbjJBLQU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Oct 2023 07:16:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315BBD;
        Mon,  2 Oct 2023 04:16:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F203C433C8;
        Mon,  2 Oct 2023 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696245377;
        bh=QlUTCFA1oTOCFIM4Yfd3zKJNi3jrP5i38bPj93frt8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6/fsF4XFSq61oX2l95CBmNaJvTnuWOMdJxe/xU2w4U/Ybg4cPK1TmEKfM0OiAZ9E
         3J09S7dE/fmWO+V3ui07y8nIcwd4Nc+ou98+HRismiU/SFeL0SKApPwpEjYvGqMOF0
         htI483C8aFx46zI+3w5p2TrJTKCOJ4G/12h+aPqZJbgug+eA/0D9NjnLgStC3gSNkw
         /+qv1MIdzzbm77rDaQFMk70rpcKmO70LjiTsMM1GxqHVDf2n2LaBqfzsNaVpViKGY2
         MfGA01zxNX/YDhBy7E+idQWyTZJuAWdG4E+/hpViZmqLdOTH36XKLsaYiPVbxWF3qV
         nRSZyIuGFifKg==
Date:   Mon, 2 Oct 2023 12:16:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks property
Message-ID: <20231002-outhouse-mothproof-f969384a7f8a@spud>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
 <20230724-unscrew-bonnet-3c86da806df3@spud>
 <1908243.taCxCBeP46@steina-w>
 <20230726170141.GA1568248-robh@kernel.org>
 <AS4PR04MB9244D1BD535A188356683DD58F12A@AS4PR04MB9244.eurprd04.prod.outlook.com>
 <c835120d-8a2f-4542-8df9-4d6a2218ddf1@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jN7rkPBS7BoOo2NB"
Content-Disposition: inline
In-Reply-To: <c835120d-8a2f-4542-8df9-4d6a2218ddf1@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jN7rkPBS7BoOo2NB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 11:18:56AM +0200, Hans Verkuil wrote:
> Rob, Conor,
>=20
> On 09/08/2023 22:43, Mirela Rabulea wrote:
> >> -----Original Message-----
> >> From: Rob Herring <robh@kernel.org>
> >> Sent: Wednesday, July 26, 2023 8:02 PM
> >> To: Alexander Stein <alexander.stein@ew.tq-group.com>
> >> Cc: Conor Dooley <conor@kernel.org>; Mirela Rabulea
> >> <mirela.rabulea@nxp.com>; Ming Qian <ming.qian@nxp.com>; Shijie Qin
> >> <shijie.qin@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Mauro Carvalho
> >> Chehab <mchehab@kernel.org>; Krzysztof Kozlowski
> >> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org=
>;
> >> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> >> Fabio Estevam <festevam@gmail.com>; Mark Brown <broonie@kernel.org>;
> >> Anson Huang <Anson.Huang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> >> Pengutronix Kernel Team <kernel@pengutronix.de>; linux-
> >> media@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org; linux-spi@vger.kernel.org
> >> Subject: [EXT] Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add cl=
ocks
> >> property
> >>
> >> Caution: This is an external email. Please take care when clicking lin=
ks or
> >> opening attachments. When in doubt, report the message using the 'Repo=
rt this
> >> email' button
> >>
> >>
> >> On Tue, Jul 25, 2023 at 07:31:55AM +0200, Alexander Stein wrote:
> >>> Am Montag, 24. Juli 2023, 20:26:15 CEST schrieb Conor Dooley:
> >>>> On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
> >>>>> i.MX8 and i.MX8X both use two clocks for accessing the periphery.
> >>>>> Add clocks and clock-names properties accordingly.
> >>>>>
> >>>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> Is this patch OK or do you want changes?
>=20
> It's a bit unclear.

It's unclear to me too at this point, but I wonder if the names should
just be removed and replaced by descriptions in the clocks property?

One of the responses here mentioned that the names aren't even needed by
hardware.

--jN7rkPBS7BoOo2NB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRqmdAAKCRB4tDGHoIJi
0qGQAP97iMMZlqq+3vxqkpPgXgm6yNcRHH31ON2+khFqo8bg9QD9Gxhbw/pI7pRY
rz8plw1T8Pof/Co/E8HYmIJD+mc5LwU=
=mAR6
-----END PGP SIGNATURE-----

--jN7rkPBS7BoOo2NB--
