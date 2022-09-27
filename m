Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D75EB8F9
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 05:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiI0Dpa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0Dp3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 23:45:29 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB6B089C
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 20:45:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id EF80F30000CCF;
        Tue, 27 Sep 2022 05:45:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D2D7E10C2; Tue, 27 Sep 2022 05:45:25 +0200 (CEST)
Date:   Tue, 27 Sep 2022 05:45:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <20220927034525.GA32253@wunner.de>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926142933.2299460-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[+cc Geert, who originally came up with "spi_controller"]

On Mon, Sep 26, 2022 at 10:29:32PM +0800, Yang Yingliang wrote:
> Introduce devm_spi_alloc_controller() to wrap __devm_spi_alloc_controller(),
> with this wrapper, the drivers can use it to update to the modern naming.
[...]
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -778,6 +778,12 @@ static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
>  	return __devm_spi_alloc_controller(dev, size, true);
>  }
>  
> +static inline struct spi_controller *devm_spi_alloc_controller(struct device *dev,
> +							       unsigned int size)
> +{
> +	return __devm_spi_alloc_controller(dev, size, false);
> +}
> +
>  extern int spi_register_controller(struct spi_controller *ctlr);
>  extern int devm_spi_register_controller(struct device *dev,
>  					struct spi_controller *ctlr);

This doesn't really make sense I'm afraid.  The umbrella term
"spi_controller" can refer to either a master or a slave.
One has to specify on allocation which of the two is desired.

An API which purports to allow allocation of the umbrella term
but defaults to a master behind the scenes seems misleading to me.

Thanks,

Lukas
