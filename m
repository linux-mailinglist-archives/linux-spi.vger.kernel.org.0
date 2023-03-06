Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527966AC4AE
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCFPWS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 10:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFPWR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 10:22:17 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2202BF3A
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 07:22:16 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z42so9976266ljq.13
        for <linux-spi@vger.kernel.org>; Mon, 06 Mar 2023 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2mkisKma0bo2GeAEB+dhQXhYKz8ANbxEzJ9U4Ikm+E0=;
        b=bIizPdSncfhSymzhTIMugmuioUfw3Y6itp5NktW7SkGwpXONsd1jYQ2zq6N2n6D9Mg
         7OEf2FR9QQXquNYoH5UINrKD99D88XMRUYYEflaY/dGVsOMXa9V+waDtdQmQY0nqVI/i
         WyikS72VhukkE0J9IGRGDq9fvnp8fLbGkcOt72NvrCrePbWqKLkdyZj1SLwmBDcJ3n3N
         VED0YWM1piJRXD9sLbCXam+FFJk/vq+93QqVILGUDfdMKbkfwIHqIEkUJ+WW0yQ59EMM
         1rKgr3A712UZk6gFTcBrfAiKNPp3BPNGyRg/dZciWbFj+5GXtOdnu+kepuhqHkn//qCR
         WE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mkisKma0bo2GeAEB+dhQXhYKz8ANbxEzJ9U4Ikm+E0=;
        b=nNomyiZ9NgudWrs11BdjErj3six70WflDb7/78W4splaHR4Q9ZtVrjQTVjHz0qRKjh
         hsuXtWnNQ3EgFyfTepqF2coq3WrTZQy7qWEhWO2lBIYY49pbsCc6tTZ1B9FT+MSvHgTx
         nxG3H9VnpGg7B1nYIjgsYxzDV/2THbWGDq0LGyGBahmAtIZFXcjiNYKecygWmflWzsIR
         ndV0TLn5W5jiI9p+z8t3e22LKtkuUdlat4SuugMjQ+B1mnkTRa5TVQ0QQxM8QwveXSM2
         AtF6lCwe7NNqZdovQRufkwuqK2SuDEXDjQJQCmjsfHO5IO8F0v2/UMlW+WkVxOeOYoQE
         DA9w==
X-Gm-Message-State: AO0yUKXylXodoOV2oEjJ0XYZZKzvpyWaMal5rL8zq+4nBg/G+2FQrWa+
        CBtiEFVAvu6QJdzqxk0Yrt3Z0YiYtxM=
X-Google-Smtp-Source: AK7set+BfahFUdqT7eMLunvPO8aWh5KFCNq+7QoJS0RQjsVoN3A44wiXQ641Ib2orKaAXNadHiDQtQ==
X-Received: by 2002:a2e:351a:0:b0:295:906d:b98 with SMTP id z26-20020a2e351a000000b00295906d0b98mr3193683ljz.31.1678116134708;
        Mon, 06 Mar 2023 07:22:14 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05651c230c00b002935390c0b3sm1753587ljb.36.2023.03.06.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:22:13 -0800 (PST)
Date:   Mon, 6 Mar 2023 18:22:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 22/87] spi: dw-mmio: Convert to platform remove callback
 returning void
Message-ID: <20230306152212.o7v756zwsrlgrlw5@mobilestation>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-23-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303172041.2103336-23-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 03, 2023 at 06:19:36PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/spi/spi-dw-mmio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 26c40ea6dd12..6ae124c30969 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -328,7 +328,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int dw_spi_mmio_remove(struct platform_device *pdev)
> +static void dw_spi_mmio_remove(struct platform_device *pdev)
>  {
>  	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
>  
> @@ -337,8 +337,6 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(dwsmmio->pclk);
>  	clk_disable_unprepare(dwsmmio->clk);
>  	reset_control_assert(dwsmmio->rstc);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id dw_spi_mmio_of_match[] = {
> @@ -366,7 +364,7 @@ MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
>  
>  static struct platform_driver dw_spi_mmio_driver = {
>  	.probe		= dw_spi_mmio_probe,
> -	.remove		= dw_spi_mmio_remove,
> +	.remove_new	= dw_spi_mmio_remove,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
>  		.of_match_table = dw_spi_mmio_of_match,
> -- 
> 2.39.1
> 
