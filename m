Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1979E355
	for <lists+linux-spi@lfdr.de>; Wed, 13 Sep 2023 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbjIMJQY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Sep 2023 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjIMJP5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Sep 2023 05:15:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0E213B
        for <linux-spi@vger.kernel.org>; Wed, 13 Sep 2023 02:15:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02D43660732C;
        Wed, 13 Sep 2023 10:15:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694596537;
        bh=+x1Lus2omcxwTQh/70pIi5tcxa6KKlOel+MXnr2anU0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hcXsAp5siwSYtRCayPcgeqa3e7E80a/nScSBAx0id8t3e3QvJE0LhZTRx3dwT2NCO
         q2cR4FFecXHuX+sQV4K9YolHUnqVmLq9/hfEqQAwQWIf8+rg4cLoasbOJUYd8eGb1N
         lyfZbNP3MhqJkgpaxazLxCeqyL4LTyMMK/yyc5QBFGGKBYmWld41mA+BTQytRFw6L8
         Tj5qVxT1eF1r6EFTaFKqEHJGoPwMgj9UGWATja2Su7FtARhiPcJpHyZK9L9VX9l61N
         mUdYl5lPw7q3KPnicFNnUKvAhjUZcwurIBTbBkYLQAYKKvMakR9HqEPoVziC5g5Pe/
         h1BTNoISIvWJw==
Message-ID: <93074a59-8747-910e-0b76-4682e827ff73@collabora.com>
Date:   Wed, 13 Sep 2023 11:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH -next v2 19/25] spi: mtk-snfi: Use helper function
 devm_clk_get_enabled()
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>
Cc:     andrew@aj.id.au, avifishman70@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, benjaminfair@google.com,
        broonie@kernel.org, chin-ting_kuo@aspeedtech.com, clg@kaod.org,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        fancer.lancer@gmail.com, florian.fainelli@broadcom.com,
        heiko@sntech.de, jbrunet@baylibre.com, joel@jms.id.au,
        khilman@baylibre.com, linus.walleij@linaro.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        martin.blumenstingl@googlemail.com, matthias.bgg@gmail.com,
        neil.armstrong@linaro.org, olteanv@gmail.com,
        openbmc@lists.ozlabs.org, rjui@broadcom.com, sbranden@broadcom.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
 <20230823133938.1359106-20-lizetao1@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823133938.1359106-20-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Il 23/08/23 15:39, Li Zetao ha scritto:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> Also, devm_clk_get_optional() and clk_prepare_enable() can now be
> replaced by devm_clk_get_optional_enabled().Moreover, the two functions
> mtk_snand_enable_clk() and mtk_snand_disable_clk() no longer are used,
> drop them for clean code.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


