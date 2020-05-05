Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C931C5DB8
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgEEQiO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgEEQiO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 12:38:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093EEC061A0F
        for <linux-spi@vger.kernel.org>; Tue,  5 May 2020 09:38:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so1035269plp.6
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2020 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luCcYzibiHAqsrwgIRj3POtmDDa35yugcUIsAAOot40=;
        b=MAyGVAMZyJo/oMcQG84PQl4YbqtAG2c7SWxWjvlORg+zAKlaMVkPh6jZcKqjxiiqkU
         j1EpVWllG9hKR0QcAtWtOnnDl6jHvEDz8IvUsJp+pNyztK/bEj93JS0MtKNqcbf8rnA8
         TdQN3YzhjTKjkOKPPsrx9bObDHOZ9LsGAto+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=luCcYzibiHAqsrwgIRj3POtmDDa35yugcUIsAAOot40=;
        b=oo4NSzYlIy5ckbrlYyrTi+iiOGBXDat9lrt0fyhd0NtJn1cpyjb/TuavbY4AGJzeR9
         /Y1HE0rIqDHKW2mBGZipn7LabaJjkbjGmUz1kz1Wadzi3WYHCwbkbV4e+rBzcVtK9EBs
         Uq17sNm1xTU9/JhGywv4EekpajqrLtf59ljgszdX1B+kwO0MPCjHZ8+Oe0Qhis/AN1Iw
         qk1033cTi+MoKoQ6SrBAVUBWZJMcnn8KLaRrUyIqjRMld8hHN8ZkFiXKeUxOSYCcxvuD
         CJtzqIfHzgulhWMeA6UbvSreM+8ffRo3rH+OGahK/oEHfQ/ZFk4GRR0hJ8ix5OpJJbwh
         t8FQ==
X-Gm-Message-State: AGi0PuY5MEb0KEv+4L74h52gtZ1o+17tyZ8QBd9dUrIyJUKM4FxeeXPp
        vEyj6QAy8GhgMKyT9VLJMlcmEQ==
X-Google-Smtp-Source: APiQypLHwVgFzIc6p5rvaNU2w6BbNNq4RXORPRe2429s/tVbdXYceAvmwdEyYfv4yP/+tX8H/T5eCA==
X-Received: by 2002:a17:90b:1111:: with SMTP id gi17mr4096115pjb.121.1588696693595;
        Tue, 05 May 2020 09:38:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p190sm2522949pfp.207.2020.05.05.09.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:38:12 -0700 (PDT)
Date:   Tue, 5 May 2020 09:38:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200505163811.GW4525@google.com>
References: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
 <1588507469-31889-7-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588507469-31889-7-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rajendra,

On Sun, May 03, 2020 at 05:34:29PM +0530, Rajendra Nayak wrote:
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
>  drivers/spi/spi-qcom-qspi.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..eb53c00 100644
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
> @@ -498,6 +518,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  static int qcom_qspi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
> +
> +	if (ctrl->has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(ctrl->opp_table);

IIUC there can still be active transfers before the controller is
unregistered. If that is correct the above should be done after the
spi_unregister_master() call below.

>  
>  	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>  	spi_unregister_master(master);
> @@ -512,6 +537,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
>  
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
>  	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
>  
>  	return 0;
