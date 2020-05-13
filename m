Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37F51D1E01
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbgEMSwl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMSwk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 14:52:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C8C061A0C
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2020 11:52:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 9so154299pgr.3
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2020 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55S1W6TTYrq5jCy+aRb1ISBrR0y1QRvglHPRUtnEv6Q=;
        b=lBG/Qgo+Ax78eFvqJn8FT+S4IBj5w+CI9qc+N9JxBUxtA1Xt49ES/ypdnWKpnR770Q
         rM0w2m122Ns0meblJH0cAT/hGObZd+38md03rX9plidRUovVVW0FZ9zn+IaRh7XJH3pC
         Yzi7xpwX8KmJWoGU4veJe2a2uJDOG/yUHapRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55S1W6TTYrq5jCy+aRb1ISBrR0y1QRvglHPRUtnEv6Q=;
        b=gV3vZKV6BzFFtaYJ751KQYOG7x+FArw6gBwIbMYPGh9avnO2wMN5KtM6f20pgKFON+
         z7Vj+D0R667uJjC93iVmhFGYcITLZmHNLJuujVELjgGsliqSe8mSnOe+D4LumNfioTn/
         UcTmGn/GEIpBaOCcaesVI8hyjcIZFwB06jlvr3zdtRCrTbmfiO1eBVUgfbSX801htQ8g
         zXPCEMNFRMmfOlLkr2Mc8oM7KG56hadPUaCw8sHWd9GzfM4grmGUV094OHrsb32a7Ws5
         ao111PR+49tRiJQx4unaE6mFh6Q1V7GcHYMCG0GsfEuwA8dxGLSryHcX9/1tcZtoVWX9
         dpRg==
X-Gm-Message-State: AOAM530P1YX8ZzxTtO07SVXUSty2RmeBoCFyGlSJRN5JjeCs+a7FgqA0
        DJ/B37qv/NpfSyPunVhtyQk7QQ==
X-Google-Smtp-Source: ABdhPJzsV6PSMzFfikXn8WgT71tJ22aXWOMIaDLRL+l3D+CRH92hL3qhqme/nvEMAKaBL4tSGo1sFw==
X-Received: by 2002:aa7:939c:: with SMTP id t28mr670237pfe.38.1589395960135;
        Wed, 13 May 2020 11:52:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d126sm248338pfc.81.2020.05.13.11.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:52:39 -0700 (PDT)
Date:   Wed, 13 May 2020 11:52:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200513185238.GN4525@google.com>
References: <1589368382-19607-1-git-send-email-rnayak@codeaurora.org>
 <1589368382-19607-7-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589368382-19607-7-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 04:43:02PM +0530, Rajendra Nayak wrote:
> QSPI needs to vote on a performance state of a power domain depending on
> the clock rate. Add support for it by specifying the perf state/clock rate
> as an OPP table in device tree.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
> Change in v5: OPP cleanup done as the last thing in qcom_qspi_remove()
> 
>  drivers/spi/spi-qcom-qspi.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..c853eba 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -8,6 +8,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_opp.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  
> @@ -139,6 +140,8 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> +	struct opp_table *opp_table;
> +	bool has_opp_table;
>  	/* Lock to protect xfer and IRQ accessed registers */
>  	spinlock_t lock;
>  };
> @@ -235,7 +238,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>  		speed_hz = xfer->speed_hz;
>  
>  	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
> -	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
> +	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
>  	if (ret) {
>  		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
>  		return ret;
> @@ -481,6 +484,20 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  	master->handle_err = qcom_qspi_handle_err;
>  	master->auto_runtime_pm = true;
>  
> +	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
> +	if (IS_ERR(ctrl->opp_table)) {
> +		ret = PTR_ERR(ctrl->opp_table);
> +		goto exit_probe_master_put;
> +	}
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		ctrl->has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> +		goto exit_probe_master_put;
> +	}
> +
>  	pm_runtime_enable(dev);
>  
>  	ret = spi_register_master(master);
> @@ -488,6 +505,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  		return 0;
>  
>  	pm_runtime_disable(dev);
> +	if (ctrl->has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(ctrl->opp_table);
>  
>  exit_probe_master_put:
>  	spi_master_put(master);
> @@ -498,11 +518,16 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  static int qcom_qspi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
>  
>  	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>  	spi_unregister_master(master);
>  
>  	pm_runtime_disable(&pdev->dev);
> +	if (ctrl->has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(ctrl->opp_table);
> +
>

remove 2nd empty line.

Maybe this can be done when the patch is applied if there are no other reasons
to respin the series?

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
