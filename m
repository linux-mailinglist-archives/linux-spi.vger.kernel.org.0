Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B307B8E99
	for <lists+linux-spi@lfdr.de>; Wed,  4 Oct 2023 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjJDVTd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Oct 2023 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJDVTc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Oct 2023 17:19:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D290
        for <linux-spi@vger.kernel.org>; Wed,  4 Oct 2023 14:19:28 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qo9GZ-0005NJ-Hp; Wed, 04 Oct 2023 23:18:47 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     broonie@kernel.org, chin-ting_kuo@aspeedtech.com, clg@kaod.org,
        joel@jms.id.au, andrew@aj.id.au, florian.fainelli@broadcom.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, fancer.lancer@gmail.com,
        olteanv@gmail.com, neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, Li Zetao <lizetao1@huawei.com>
Cc:     lizetao1@huawei.com, linux-spi@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH -next 25/25] spi: rockchip: Use helper function
 devm_clk_get_enabled()
Date:   Wed, 04 Oct 2023 23:18:45 +0200
Message-ID: <16634210.geO5KgaWL5@diego>
In-Reply-To: <20230822131237.1022815-26-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230822131237.1022815-26-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Dienstag, 22. August 2023, 15:12:37 CEST schrieb Li Zetao:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


