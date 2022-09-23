Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34F95E733B
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIWFGr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 01:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIWFGq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 01:06:46 -0400
X-Greylist: delayed 1300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 22:06:45 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D112644B
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 22:06:45 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7AA01280351C0;
        Fri, 23 Sep 2022 07:06:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 63B37815B; Fri, 23 Sep 2022 07:06:44 +0200 (CEST)
Date:   Fri, 23 Sep 2022 07:06:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH -next 3/6] spi: omap-uwire: Switch to use
 devm_spi_alloc_master()
Message-ID: <20220923050644.GA15095@wunner.de>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <20220920134819.2981033-4-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920134819.2981033-4-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 20, 2022 at 09:48:16PM +0800, Yang Yingliang wrote:
> @@ -476,7 +474,6 @@ static int uwire_probe(struct platform_device *pdev)
>  	if (IS_ERR(uwire->ck)) {
>  		status = PTR_ERR(uwire->ck);
>  		dev_dbg(&pdev->dev, "no functional clock?\n");
> -		spi_master_put(master);
>  		return status;
>  	}
>  	clk_prepare_enable(uwire->ck);

Change this hunk to return PTR_ERR(uwire->ck) directly without
assigning to status first.

> @@ -518,6 +515,7 @@ static int uwire_remove(struct platform_device *pdev)
>  
>  	spi_bitbang_stop(&uwire->bitbang);
>  	uwire_off(uwire);
> +	spi_master_put(uwire->bitbang.master);
>  	return 0;
>  }
>  

No, drop this hunk, it results in a use-after-free.

Thanks,

Lukas
