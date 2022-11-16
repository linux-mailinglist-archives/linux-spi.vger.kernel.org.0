Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABA62BBF9
	for <lists+linux-spi@lfdr.de>; Wed, 16 Nov 2022 12:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiKPLaz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Nov 2022 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiKPLai (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Nov 2022 06:30:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F34D5D0
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 03:19:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a29so28971749lfj.9
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 03:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fuw2MgmSfRGNvDsFZz9ESp03rn6C/twwPh8Npe/8C6Y=;
        b=pipabV7RMbsiGE/w/fqvfSJlncPrhSWhLU+3cvauKGbwFzzwklL9QNQRsl7+AoRQYq
         LOPybu6zG+tNObLfA+dgQY9V9L6V6cEL8hEBbvl0qfMpkT2HwjrPBIKiIItiuO7vhwHO
         aNgCJbCQbp5eSUZ6Xxbl9ZhX1TLyWu4C3WVas/7nxuXNn8kiQB8tCD/DczPFgS81g7I2
         f4HZIhEavvsnDTh3g7uNkE7USZeZ2cDotVw3oXlRjC1ypWm9TOMfr4XFwJ8ZA5U4ZXFR
         HKwpueAj7lPsdXFxKyIFtBB1Z8GUJfqQzm6hxkRBLOeMwzgtCvU6CRxY1jlbmFUFnwXc
         9/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fuw2MgmSfRGNvDsFZz9ESp03rn6C/twwPh8Npe/8C6Y=;
        b=6uIbafULBC6buGxZj9yNtzsSniLYgRaUodcD70EOREdgmX3twvik14aBp9vOWS7TJY
         tULSH11d18ics+xgpWYsS2VriVnn3ilJGCOKnaO4T7Dfichx9O/FWvNmODYXKtUODj50
         2Ik738jF/wH0JhWZxqkjcefwZ+cDgTkZvsBdDvXW7sJ1p4KZOb0tyiH6omopXtSLxgGG
         LUyl6bRSXXYDa+66rraPNU/4X/t+0SuqDx9cDug8H2v2//lm5ro4hs+aeownlJLkkoGf
         k13A8dv31UZ862rC4vaXUjrze5bAgYwnYLpM5ZCro9+hVx8TDVWwrbKx0o4o9lVwB6VJ
         UsUg==
X-Gm-Message-State: ANoB5plWBHl+faTsnsQqhgylRO0Oo6dywAZOJJRm/K69QuleG41fh9sA
        dwaHmSLxZpSSlI4tem4OoQU=
X-Google-Smtp-Source: AA0mqf5ThvL/fwyFQ3eAseX2bEmbfWK7kQGNQb4v1DzH5hxmte1hMDz5Zb1ElxwNijWlUwtzJY7ifA==
X-Received: by 2002:a05:6512:3589:b0:4a9:2ca6:c14b with SMTP id m9-20020a056512358900b004a92ca6c14bmr7845591lfr.163.1668597563959;
        Wed, 16 Nov 2022 03:19:23 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bf36-20020a05651225a400b004a05837103csm2553779lfb.196.2022.11.16.03.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:19:23 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:19:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     broonie@kernel.org, feng.tang@intel.com,
        linus.walleij@stericsson.com, linux-spi@vger.kernel.org,
        yangyingliang@huawei.com
Subject: Re: [PATCH] spi: dw-dma: decrease reference count in
 dw_spi_dma_init_mfld()
Message-ID: <20221116111921.a3lnx7wgufukfass@mobilestation>
References: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Xiongfeng,

On Wed, Nov 16, 2022 at 05:32:04PM +0800, Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev. Since 'dma_dev' is only used to filter the channel in
> dw_spi_dma_chan_filer(). After using it, we need to use pci_dev_put() to
                         ^               ^            ^
                         |               |            |
                      drop the dot and comma          s/use/call

* Although this could be fixed by Mark on merging the patch in.

> decrease the reference count. Also add pci_dev_put() for the error case.
> 
> Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Nice catch. Thanks for the patch.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/spi/spi-dw-dma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 1322b8cce5b7..ababb910b391 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -128,12 +128,15 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  
>  	dw_spi_dma_sg_burst_init(dws);
>  
> +	pci_dev_put(dma_dev);
> +
>  	return 0;
>  
>  free_rxchan:
>  	dma_release_channel(dws->rxchan);
>  	dws->rxchan = NULL;
>  err_exit:
> +	pci_dev_put(dma_dev);
>  	return -EBUSY;
>  }
>  
> -- 
> 2.20.1
> 
