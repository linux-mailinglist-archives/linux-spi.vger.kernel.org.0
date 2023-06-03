Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656297212AA
	for <lists+linux-spi@lfdr.de>; Sat,  3 Jun 2023 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFCU1Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 3 Jun 2023 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjFCU1Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 3 Jun 2023 16:27:24 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECED2123
        for <linux-spi@vger.kernel.org>; Sat,  3 Jun 2023 13:27:23 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 0b25cecc-024d-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 23:27:22 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:27:21 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 18/43] spi: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZHuiKT-CezPbPDkh@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-19-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-19-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thu, Jun 01, 2023 at 08:34:09AM +0300, Nikita Shubin kirjoitti:
> - find register range from the device tree
> - provide clock access via of
> - use_dma as a DT node

...

> +static struct ep93xx_spi_info *ep93xx_spi_get_platdata(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;

> +	if (np && of_property_read_bool(np, "ep9301,use-dma"))

Excessive check for np to be NULL, this is implied by the _read_bool() anyway.

> +		dt_spi_info.use_dma = 1;

> +	return &dt_spi_info;
> +}

...

> +	master->dev.of_node = pdev->dev.of_node;

device_set_node();

-- 
With Best Regards,
Andy Shevchenko


