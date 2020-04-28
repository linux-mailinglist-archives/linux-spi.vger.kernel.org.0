Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25F91BD059
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD1XEZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 19:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726431AbgD1XEY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Apr 2020 19:04:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E1C03C1AD
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2020 16:04:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so72682plr.11
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2020 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSsy1ygM1BDs51F1GbcG8UXkEqb70z5oMMLFkPxYsgA=;
        b=jKDnZ33HB7ZcGRyKUq6bAEk49pA5hrq+M98P3hotNW/sjDg3UVzFz2zZipYauwUi3t
         h0GTAYzesuGLBbDhYaZxl1d5rsSYyvKnL1btTfXYa8SHa9OGIhs2B9MqQF/U+0xMDKAA
         depD2eW08eF/lKwYQCdorJgAq97Aag4bpIVAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSsy1ygM1BDs51F1GbcG8UXkEqb70z5oMMLFkPxYsgA=;
        b=TS8i9ZH0Qfa5qvzMlEOE+zqikvikp0GaCpiN/z2wMNKxD5eI8Ms1iesZ39ycRvDHox
         D+Is/kVAgANi34/Tr2Y3n0BCL0CjKGz1DAmgA1fSvW7wQbzQTYQZSiiXnnms3KSnPglB
         LVWq5zf2R5tO3ZDo3/iv/kSvbfUTxzu3qTer6CTg9zzZ57CwRelFI7OjDWW5B+nHTBFe
         2AVJTwnch98H2LDGgtESiT6eEq/GeSBvKJA8NrFjhalZp5joMg3oJOAJ5Bls7s33k9hh
         C3EsaWLVykiP5MVQa57yVQVtH0YNQd904dYXt+S2vw5rMYi/5cUMXmOl7AMKA8BKzJGc
         kjoQ==
X-Gm-Message-State: AGi0PuawXU08xqng2oJHfHEJzHI3dbX/V41rFhz3n9r69hYqAHqLZpSr
        QmTzyabPN4mJ18n+nUTDU2nPeQ==
X-Google-Smtp-Source: APiQypJEdKFVlT1c+cl9kFH+eXgc50EVz7/lIRVgEziupIY9ZLK2G+50Qx9FWS7gk15l1MqknfnB4g==
X-Received: by 2002:a17:902:dc83:: with SMTP id n3mr30555779pld.133.1588115062459;
        Tue, 28 Apr 2020 16:04:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w125sm14224097pgw.22.2020.04.28.16.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 16:04:21 -0700 (PDT)
Date:   Tue, 28 Apr 2020 16:04:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 02/17] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
Message-ID: <20200428230420.GJ4525@google.com>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588080785-6812-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 28, 2020 at 07:02:50PM +0530, Rajendra Nayak wrote:
> geni spi needs to express a perforamnce state requirement on CX
> depending on the frequency of the clock rates. Use OPP table from
> DT to register with OPP framework and use dev_pm_opp_set_rate() to
> set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
> This patch has a dependency on the 'PATCH 01/17' in this series,
> due to the changes in include/linux/qcom-geni-se.h
> Its ideal if this and the previous patch gets merged via the
> msm tree (once reviewed and ack'ed)
> Greg has already responded he is fine with it for serial.
> 
>  drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c397242..51186c3 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -7,6 +7,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spi/spi.h>
> @@ -95,7 +96,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>  {
>  	unsigned long sclk_freq;
>  	unsigned int actual_hz;
> -	struct geni_se *se = &mas->se;
>  	int ret;
>  
>  	ret = geni_se_clk_freq_match(&mas->se,
> @@ -112,9 +112,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>  
>  	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>  				actual_hz, sclk_freq, *clk_idx, *clk_div);
> -	ret = clk_set_rate(se->clk, sclk_freq);
> +	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
>  	if (ret)
> -		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
> +		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
>  	return ret;
>  }
>  
> @@ -561,6 +561,17 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	mas->se.wrapper = dev_get_drvdata(dev->parent);
>  	mas->se.base = base;
>  	mas->se.clk = clk;
> +	mas->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
> +	if (IS_ERR(mas->se.opp_table))
> +		return PTR_ERR(mas->se.opp_table);
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		mas->se.has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
> +		return ret;
> +	}
>  
>  	spi->bus_num = -1;
>  	spi->dev.of_node = dev->of_node;
> @@ -596,6 +607,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>  spi_geni_probe_runtime_disable:
>  	pm_runtime_disable(dev);
>  	spi_master_put(spi);
> +	if (mas->se.has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(mas->se.opp_table);
>  	return ret;
>  }
>  
> @@ -604,6 +618,9 @@ static int spi_geni_remove(struct platform_device *pdev)
>  	struct spi_master *spi = platform_get_drvdata(pdev);
>  	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>  
> +	if (mas->se.has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(mas->se.opp_table);
>  	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>  	spi_unregister_master(spi);
>  
> @@ -617,6 +634,9 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
>  	struct spi_master *spi = dev_get_drvdata(dev);
>  	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>  
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
> +
>  	return geni_se_resources_off(&mas->se);
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
