Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC5784659
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbjHVPzy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjHVPzx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 11:55:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E61BE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 08:55:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RVYnd4n4Yz6D8d1;
        Tue, 22 Aug 2023 23:54:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 16:55:25 +0100
Date:   Tue, 22 Aug 2023 16:55:24 +0100
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
Subject: Re: [PATCH -next 02/25] spi: armada-3700: Use helper function
 devm_clk_get_prepared()
Message-ID: <20230822165524.000062a8@Huawei.com>
In-Reply-To: <20230822131237.1022815-3-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
        <20230822131237.1022815-3-lizetao1@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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


> @@ -909,10 +901,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
>  
>  static void a3700_spi_remove(struct platform_device *pdev)
>  {
> -	struct spi_controller *host = platform_get_drvdata(pdev);
> -	struct a3700_spi *spi = spi_controller_get_devdata(host);
> -
> -	clk_unprepare(spi->clk);
Hi.

No point in keeping an empty remove function.  Drop the whole thing now
there is nothing to do.

Jonathan

>  }
>  
>  static struct platform_driver a3700_spi_driver = {

