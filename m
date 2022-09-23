Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7D5E7387
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 07:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIWFzW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 01:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIWFzV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 01:55:21 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C31CDCE8;
        Thu, 22 Sep 2022 22:55:19 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5C284280044E8;
        Fri, 23 Sep 2022 07:55:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 44C7E4F1BA; Fri, 23 Sep 2022 07:55:18 +0200 (CEST)
Date:   Fri, 23 Sep 2022 07:55:18 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
        corbet@lwn.net, broonie@kernel.org
Subject: Re: [PATCH -next] Documentation: devres: add missing SPI helper
Message-ID: <20220923055518.GA17668@wunner.de>
References: <20220917122639.1896965-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917122639.1896965-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Sep 17, 2022 at 08:26:39PM +0800, Yang Yingliang wrote:
> Add devm_spi_alloc_master() and devm_spi_alloc_slave() to devres.rst.
> They are introduced by commit 5e844cc37a5c ("spi: Introduce device-managed
> SPI controller allocation").
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 76cc256c9e4f..1bd6f38dd7e3 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -437,6 +437,8 @@ SLAVE DMA ENGINE
>  
>  SPI
>    devm_spi_register_master()
> +  devm_spi_alloc_master()
> +  devm_spi_alloc_slave()
>  
>  WATCHDOG
>    devm_watchdog_register_device()

Putting the alloc functions above the register function would
probably be more in line with how they're used.  Apart from that:

Reviewed-by: Lukas Wunner <lukas@wunner.de>
