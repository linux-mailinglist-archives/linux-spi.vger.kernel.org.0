Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1B6AE7EB
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCGRIC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCGRHn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 12:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4DA59FA;
        Tue,  7 Mar 2023 09:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E826147F;
        Tue,  7 Mar 2023 17:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A4C433B0;
        Tue,  7 Mar 2023 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678208468;
        bh=tKFTmiEx5lWVMe9kc/4siOWPAS1vRgintq9BdapPuw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqt5/BmZ7eO+af/HjVRQiU3sw8JOtHGp6EMO4dWuOwrg2LueVE87FwMwbJmSMbDw3
         ws29jqaUjUDjYiikTtt7/iKYg+2yrYf4T2JYLdR/uOCpmU1RmrY5zY6A63gtW5rM+x
         DmiW0/1nByleyTnwwYj1Q66go/nxAjY8OGVSo4KWOto0Z75wa5ysvNT77Nh88lPcIm
         kdDMXsZCBZ0GbSeik/wu87szoip24bAwSGhB4IwTpJH8yCVAVCuT2KqcDQtesriupl
         JAFNPocJHQredNufuxvTfWTr5qcifQwWUjloMf3yohaiWo14eqm5mjyT1XK3IaJ4T9
         RGF37doTHhI7Q==
Date:   Tue, 7 Mar 2023 17:00:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Anand Gore <anand.gore@broadcom.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, Han Xu <han.xu@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jay Fang <f.fangjian@huawei.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-spi@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 00/87] spi: Convert to platform remove callback returning
 void
Message-ID: <ddcda593-f8e9-43a4-bba6-dae31e8d6b39@sirena.org.uk>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wo9frzy+aFktTPxK"
Content-Disposition: inline
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Wo9frzy+aFktTPxK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 06:19:14PM +0100, Uwe Kleine-K=F6nig wrote:

>   spi: mpc512x-psc: Convert to platform remove callback returning void
>   spi: mpc52xx-psc: Convert to platform remove callback returning void

As well as the Raspberry Pi patch dropped due to build failures I also
dropped these two as they conflicted with Rob's refactoring of that
driver, nothing especially complex but since there's stuff to resend
anyway...

--Wo9frzy+aFktTPxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHbb4ACgkQJNaLcl1U
h9DDDQf/eo3lXns3dzYdzJYf8MxUxafb8rgDkge5kzhM/iS9lEnDcJX8Vno7IHOa
iZ7/NuWC1p4ofFyl04/WPa94f4hEYWTNqXgQ4TuEq9SRTyOTwZsqpS33uEc9v0zm
3/ja2SHHOw97vKeI+1IjK8fycKlOze/YwzP38U0UTECpJou6+41HYgRgx8L+J3Js
zILjs+qw1DhbaslGny+CEV6juxQO2LcIoNjdQYfWSbN4leZdcg8cW1+Obbr8KLen
nbcN3szhArY3SvbxgXR5muD5yNFtETWVBmVtjlT0mBXX4Lzgj7Pf0SgN1haH9bq/
jlQbNnEEvvkvGVicjB7wmDlS6gOoKw==
=fVjM
-----END PGP SIGNATURE-----

--Wo9frzy+aFktTPxK--
