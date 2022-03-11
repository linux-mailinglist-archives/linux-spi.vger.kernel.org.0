Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923224D6366
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiCKO07 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Mar 2022 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiCKO07 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Mar 2022 09:26:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76D11C8841
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 06:25:55 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 3so15301078lfr.7
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 06:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Svr3BQ8kPy8g/QHdtlGO2Uf6Ovoo4+/ex4Ln6wfXXus=;
        b=Z61ptgr10rkxZGB/1qBe/+a/s99dVAJtEtEJeYwz+E6FIfBp2Zh0zRXdBQAaTI56vB
         CoCXcJ2dnrmuLrleI3pT2uBdbFLLdDr6DLV33iVUmJfzZF0yDbAl/JqR/ZO03jU/HnXI
         oPIKGL21nAVtwHdK8yhihf/CfspNM9d5KlsU9MenFSE0cZyvlXtbKVfk4XIPdZGhi2yE
         ltqvAMfc8hMcS8JaH3CgBb7Xtfn9vz4zoFecKRwWXE9rYQWGl81CrhbEFrrkarlV0aiY
         p6rCjGsQ31ibZ9X7y6reIxilq6wSv0CBLm69nR5anarn7pRq/+8v86ks5JvnekKA9llr
         oSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Svr3BQ8kPy8g/QHdtlGO2Uf6Ovoo4+/ex4Ln6wfXXus=;
        b=Cr5ZtGiYJ49ZJX/hIYlUAlgW9ybk+QJkn3cRkeJmAKgKTTXqr3Hb6jrVIXuRnKFH4l
         q1jKay1P0AEOFpDGUKvh2h0Yl0zheUY3hUCU2BSxZi5rIlBKIIjOESz3XYb1ApLvFkOZ
         ccXeZVVdsUP37mcyirIehP5R+NShaReRswnSIhI8sXT9pvpZ3sohBxygx3FKlTGfUEY1
         oSUrqw5swo5TxQ/2JQH3bDTE62KIGTgDQqFmo5GCXhnQFNItJS/taxFoN8T8TyjWPRpi
         0/k1QqQN5edL/5Fdy7TangHzcYDsSeF7ar+xcRFx67B1fvrpJjcElnB5vZZXVBwabYVD
         ahrQ==
X-Gm-Message-State: AOAM530mNGVBxG17DxHv19/ZbMzlFzxFTMpl4/LnYYhae7WB/NryNnkj
        GnOrMb/1ITStxaNg34oRsSE=
X-Google-Smtp-Source: ABdhPJw7zMLw4c0sn3FoHFK7Q7tj4YmjrFIjZXvouFXmX1VnCjajB0iJyL6nhVqW7/bGmdqfIOY/mg==
X-Received: by 2002:a05:6512:3e21:b0:448:53c7:178e with SMTP id i33-20020a0565123e2100b0044853c7178emr6645238lfv.374.1647008752964;
        Fri, 11 Mar 2022 06:25:52 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id y23-20020ac24477000000b00445bbae3d96sm1646179lfl.177.2022.03.11.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:25:52 -0800 (PST)
Date:   Fri, 11 Mar 2022 17:25:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
Message-ID: <20220311142550.haw5jnrjycavr43m@mobilestation>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Niklas

On Tue, Mar 01, 2022 at 11:17:20AM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Simply deasserting reset just ensures that the hardware is taken out of
> reset, if it was booted with the hardware reset asserted.
> 
> In order actually reset the SPI controller, we need to assert reset before
> deasserting.
> 
> By doing this, we ensure that the hardware is not in some bad state, and we
> ensure that the hardware registers get set to their reset default, clearing
> any setting set by e.g. a bootloader.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 5101c4c6017b..eb1dacb45ca2 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -289,6 +289,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(dwsmmio->rstc);
>  		goto out_clk;
>  	}

> +	reset_control_assert(dwsmmio->rstc);
> +	udelay(2);

Do we really need this? dw_spi_add_host() is doing a sort of soft reset
anyway by calling the dw_spi_hw_init() method. Do you have a real
platform, which requires to do a full hard-reset?

What about the self-reset based controllers?

-Sergey

>  	reset_control_deassert(dwsmmio->rstc);
>  
>  	dws->bus_num = pdev->id;
> -- 
> 2.35.1
