Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987F56AEC34
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCGRxW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCGRxC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 12:53:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39812A145
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 09:47:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZbOi-0001A8-23; Tue, 07 Mar 2023 18:46:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZbOJ-002XP1-FG; Tue, 07 Mar 2023 18:46:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZbOI-0034GD-GY; Tue, 07 Mar 2023 18:46:22 +0100
Date:   Tue, 7 Mar 2023 18:46:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        Heiko Stuebner <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-sunxi@lists.linux.dev, Anand Gore <anand.gore@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-spi@vger.kernel.org,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-xtensa@linux-xtensa.org, Andi Shyti <andi@etezian.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Jay Fang <f.fangjian@huawei.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-aspeed@lists.ozlabs.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nancy Yuen <yuenn@google.com>, Chen-Yu Tsai <wens@csie.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Joel Stanley <joel@jms.id.au>,
        Orson Zhai <orsonzhai@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Tali Perry <tali.perry1@gmail.com>,
        linux-riscv@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Andy Gross <agross@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Han Xu <han.xu@nxp.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Patrick Venture <venture@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, openbmc@lists.ozlabs.org,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 00/87] spi: Convert to platform remove callback returning
 void
Message-ID: <20230307174622.vluzrlicw2gdn7hq@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <ddcda593-f8e9-43a4-bba6-dae31e8d6b39@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="subqk3tp4gcmon6z"
Content-Disposition: inline
In-Reply-To: <ddcda593-f8e9-43a4-bba6-dae31e8d6b39@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--subqk3tp4gcmon6z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Tue, Mar 07, 2023 at 05:00:47PM +0000, Mark Brown wrote:
> On Fri, Mar 03, 2023 at 06:19:14PM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> >   spi: mpc512x-psc: Convert to platform remove callback returning void
> >   spi: mpc52xx-psc: Convert to platform remove callback returning void
>=20
> As well as the Raspberry Pi patch dropped due to build failures I also
> dropped these two as they conflicted with Rob's refactoring of that
> driver, nothing especially complex but since there's stuff to resend
> anyway...

Fine for me. Given that my queue of patches to convert the remove
callbacks is quite big, there is no pressure from my side to get these
all in. 84 from 87 is great already, I'll care about the remaining 3
patches (and the few drivers that don't return 0 in .remove()) later.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--subqk3tp4gcmon6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQHeGsACgkQwfwUeK3K
7AmJQAf+OLFnhHHVOJXrgsKSMBVT9Qycgk1Nx3JjIocPvU73GYAc8BXwKRUCjb2G
yTOGAdCjHSEwQuDZxv2NhBd/vpxLkpD7iy/doYJxHT2UMPWV54rl6CFYJEHlJPqW
Z/Ml4CO3hzmB4BXtCN8RnFyPLmswQObzaXX8HL2DGHB1XE8S1ih7F9Kal3TQISuT
hZmmMMLaoUtmq5BdGPNybIlL7hGGrMoH0ej+lkPelgMI+QnFAQ6ge26Uc1x9lkDb
M9w96TPGO6fCBhTV7g21HUUO1P1MsEqJqTPxwUxg+iatcXPmt/w55d07QZQbST7b
W1YrIAGbAt6hkfVtrrUIlqw3J57gTA==
=WgaT
-----END PGP SIGNATURE-----

--subqk3tp4gcmon6z--
