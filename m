Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA567846BD
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHVQQi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbjHVQQh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 12:16:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FFCE4
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 09:16:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RVZ9f3gsrz6J6cZ;
        Wed, 23 Aug 2023 00:12:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 17:16:28 +0100
Date:   Tue, 22 Aug 2023 17:16:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Li Zetao <lizetao1@huawei.com>
CC:     <broonie@kernel.org>, <chin-ting_kuo@aspeedtech.com>,
        <clg@kaod.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <florian.fainelli@broadcom.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <fancer.lancer@gmail.com>, <olteanv@gmail.com>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <linus.walleij@linaro.org>,
        <heiko@sntech.de>, <linux-spi@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH -next 00/25] spi: Use devm_clk_get_*() helper function
 to simplify the drivers.
Message-ID: <20230822171627.00007020@Huawei.com>
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 22 Aug 2023 21:12:12 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks") provides a new helper function for prepared and
> enabled clocks when a driver keeps a clock prepared (or enabled) during
> the whole lifetime of the driver. So where drivers get clocks and enable
> them immediately, it can be combined into a single function
> devm_clk_get_*(). Moreover, the unprepare and disable function
> has been registered to devm_clk_state, and before devm_clk_state is
> released, the clocks will be unprepareed and disable, so it is unnecessary
> to unprepare and disable clocks explicitly when remove drivers or in the
> error handling path.

For all except 2, 12 and 24
they look good to me and I don't think there are any other ordering issues
of the sort we tend to see in devm conversions where things get turned off
later than in pre devm version.

So for those..
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> 
> Li Zetao (25):
>   spi: ar934x: Use helper function devm_clk_get_enabled()
>   spi: armada-3700: Use helper function devm_clk_get_prepared()
>   spi: aspeed: Use helper function devm_clk_get_enabled()
>   spi: ath79: Use helper function devm_clk_get_enabled()
>   spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
>   spi: bcm2835: Use helper function devm_clk_get_enabled()
>   spi: bcm2835aux: Use helper function devm_clk_get_enabled()
>   spi: spi-cadence: Use helper function devm_clk_get_enabled()
>   spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
>   spi: davinci: Use helper function devm_clk_get_enabled()
>   spi: dw-bt1: Use helper function devm_clk_get_enabled()
>   spi: dw-mmio: Use helper function devm_clk_get_*()
>   spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
>   spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
>   spi: meson-spicc: Use helper function devm_clk_get_enabled()
>   spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
>   spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
>   spi: microchip-core: Use helper function devm_clk_get_enabled()
>   spi: mtk-snfi: Use helper function devm_clk_get_enabled()
>   spi: npcm-fiu: Use helper function devm_clk_get_enabled()
>   spi: orion: Use helper function devm_clk_get_enabled()
>   spi: pic32-sqi: Use helper function devm_clk_get_enabled()
>   spi: pic32: Use helper function devm_clk_get_enabled()
>   spi: spl022: Use helper function devm_clk_get_enabled()
>   spi: rockchip: Use helper function devm_clk_get_enabled()
> 
>  drivers/spi/spi-ar934x.c              | 22 ++--------
>  drivers/spi/spi-armada-3700.c         | 18 ++------
>  drivers/spi/spi-aspeed-smc.c          | 16 +------
>  drivers/spi/spi-ath79.c               | 11 +----
>  drivers/spi/spi-axi-spi-engine.c      | 25 +++--------
>  drivers/spi/spi-bcm2835.c             | 11 +----
>  drivers/spi/spi-bcm2835aux.c          | 23 ++--------
>  drivers/spi/spi-cadence.c             | 23 ++--------
>  drivers/spi/spi-cavium-thunderx.c     |  8 +---
>  drivers/spi/spi-davinci.c             | 11 +----
>  drivers/spi/spi-dw-bt1.c              | 23 +++-------
>  drivers/spi/spi-dw-mmio.c             | 20 +++------
>  drivers/spi/spi-fsl-dspi.c            | 12 ++----
>  drivers/spi/spi-lantiq-ssc.c          | 10 +----
>  drivers/spi/spi-meson-spicc.c         | 33 +++------------
>  drivers/spi/spi-meson-spifc.c         | 17 ++------
>  drivers/spi/spi-microchip-core-qspi.c | 29 +++----------
>  drivers/spi/spi-microchip-core.c      |  9 +---
>  drivers/spi/spi-mtk-snfi.c            | 61 ++++-----------------------
>  drivers/spi/spi-npcm-fiu.c            | 14 ++----
>  drivers/spi/spi-orion.c               | 11 +----
>  drivers/spi/spi-pic32-sqi.c           | 27 ++----------
>  drivers/spi/spi-pic32.c               |  8 +---
>  drivers/spi/spi-pl022.c               | 21 +++------
>  drivers/spi/spi-rockchip.c            | 30 +++----------
>  25 files changed, 88 insertions(+), 405 deletions(-)
> 

