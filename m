Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C62079EE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405168AbgFXRJi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jun 2020 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405358AbgFXRJg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Jun 2020 13:09:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC02C061573
        for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2020 10:09:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so1442785pfb.1
        for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2020 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9MySW4mbbBRod9QicumBO9ww7psBdNIV6ZgeYYG3ji8=;
        b=gF21QlSigEqiKv7/jVfmhqua9KO64A4aVbVCZVSLvBaDQxKJevZAxFOLUwNNYPO678
         oayFnL1yrtvZgJRSW+vlUylUtSudu9ugCMeZBvkv9I9z7EExjeqvz6p4jELGHqNp2bxM
         vGhMKmBo4E1ScaprADwWQWgpWVjbFKRrdMXUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MySW4mbbBRod9QicumBO9ww7psBdNIV6ZgeYYG3ji8=;
        b=qnw449p9y20enCc4EvaPv1OTM7KeR+FXfvgBCKOzbYi9uzP3gpA1NHY304TNJ4wc2l
         20y/es3nUMT9ZQCMOb4aNoJFcVchCRyEVaa0VbZmh0K7NU2sm97d+Je+V4wcK9EMJOPm
         9EzdnNZEA4z4beXvphqWP+kCCpBr0Fs1aCHAvflseqvucTcmfNH5D/zAl62ZLvlsmofw
         bXiH1rA2QUvYp/wDLi7KzLjnW40WFFe2vwZARFKlWqCRRz/BOB64wbFbjw4Klzzi48WA
         mKbs6JgTP/GLOW63Edbt2B9n+lO/MukDk80TKQzhwRf+/LgHJwZavgiNWlYop8fstsl3
         ficA==
X-Gm-Message-State: AOAM5315joQDB9Ep3ZCUetypGsIhbBq2gCJShx/ycc7WymSoujVgaLRE
        Uf1YSLM56zZj3PX5PLnSBIJEBA==
X-Google-Smtp-Source: ABdhPJycIWyjj9ea8bDVyXiRPwvu/3OunzszllngvVvuQDju1IWGrE2OaTYnFqWhsLFiJtbA+QzeZQ==
X-Received: by 2002:a62:a110:: with SMTP id b16mr23448214pff.102.1593018574868;
        Wed, 24 Jun 2020 10:09:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id k7sm10422125pgh.46.2020.06.24.10.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 10:09:34 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:09:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, robdclark@gmail.com, robdclark@chromium.org,
        stanimir.varbanov@linaro.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200624170933.GB39073@google.com>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

do you plan to land this in your tree?

I know you hate contentless pings, but since you acked this patch and
usually don't seem to do that when patches go through your tree I want
to make sure we aren't in a situation where everybody thinks that the
patch will go through someone else's tree.

Thanks

Matthias

On Mon, Jun 15, 2020 at 05:32:44PM +0530, Rajendra Nayak wrote:
> QSPI needs to vote on a performance state of a power domain depending on
> the clock rate. Add support for it by specifying the perf state/clock rate
> as an OPP table in device tree.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
> No functional change in v6, rebased over 5.8-rc1
> 
>  drivers/spi/spi-qcom-qspi.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..ef51982 100644
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
> @@ -498,11 +518,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
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
>  
>  	return 0;
>  }
> @@ -512,6 +536,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
>  
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
>  	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
>  
>  	return 0;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
