Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F11C96FB
	for <lists+linux-spi@lfdr.de>; Thu,  7 May 2020 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEGRBR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 May 2020 13:01:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:46331 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbgEGRBR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 May 2020 13:01:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588870876; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Q6e681XAMJUtZBJD87mrFbPc1YIIh9lR85Q2LRLTHXs=; b=GjmF/yAMIfLSKvZ37lQvaGg0PP5py7CqYRcmCbi2pJeLcbA7OJUgIiSV6O355nTELCKXrdm0
 PARE7r1pHq8gxezaGbM+XE5uJCAkY//Gz+onnik4FJx3IQYs1/1SYJvrKETnScY2Wm5x5cqM
 F80Ui+efOFAr6Y/lHF3T2WBR2iY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb43ec2.7fc2d7a710a0-smtp-out-n03;
 Thu, 07 May 2020 17:00:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B138FC432C2; Thu,  7 May 2020 17:00:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.131.209.195] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5532C433D2;
        Thu,  7 May 2020 17:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5532C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
References: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
 <1588507469-31889-3-git-send-email-rnayak@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <acc7baf9-86a3-6c78-4d62-99d4b1baa12e@codeaurora.org>
Date:   Thu, 7 May 2020 22:30:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1588507469-31889-3-git-send-email-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/3/2020 5:34 PM, Rajendra Nayak wrote:
> geni spi needs to express a perforamnce state requirement on CX
> depending on the frequency of the clock rates. Use OPP table from
> DT to register with OPP framework and use dev_pm_opp_set_rate() to
> set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
> This patch has a dependency on the 'PATCH 1/6' in this series,
> due to the changes in include/linux/qcom-geni-se.h
> Its ideal if this and the previous patch gets merged via the
> msm tree (once reviewed and ack'ed)
> Greg has already responded he is fine with it for serial.

Mark, would you be able to review/ack this patch so it can be
taken in via the msm tree? 'PATCH 1/6' is Ack'd by Greg, and its
going to land via the msm tree as well.

> 
>   drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c397242..bc2916f 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -7,6 +7,7 @@
>   #include <linux/log2.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/qcom-geni-se.h>
>   #include <linux/spi/spi.h>
> @@ -95,7 +96,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>   {
>   	unsigned long sclk_freq;
>   	unsigned int actual_hz;
> -	struct geni_se *se = &mas->se;
>   	int ret;
>   
>   	ret = geni_se_clk_freq_match(&mas->se,
> @@ -112,9 +112,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>   
>   	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>   				actual_hz, sclk_freq, *clk_idx, *clk_div);
> -	ret = clk_set_rate(se->clk, sclk_freq);
> +	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
>   	if (ret)
> -		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
> +		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
>   	return ret;
>   }
>   
> @@ -561,6 +561,17 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	mas->se.wrapper = dev_get_drvdata(dev->parent);
>   	mas->se.base = base;
>   	mas->se.clk = clk;
> +	mas->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
> +	if (IS_ERR(mas->se.opp_table))
> +		return PTR_ERR(mas->se.opp_table);
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		mas->se.has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> +		return ret;
> +	}
>   
>   	spi->bus_num = -1;
>   	spi->dev.of_node = dev->of_node;
> @@ -596,6 +607,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>   spi_geni_probe_runtime_disable:
>   	pm_runtime_disable(dev);
>   	spi_master_put(spi);
> +	if (mas->se.has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(mas->se.opp_table);
>   	return ret;
>   }
>   
> @@ -604,6 +618,9 @@ static int spi_geni_remove(struct platform_device *pdev)
>   	struct spi_master *spi = platform_get_drvdata(pdev);
>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>   
> +	if (mas->se.has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(mas->se.opp_table);
>   	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>   	spi_unregister_master(spi);
>   
> @@ -617,6 +634,9 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
>   	struct spi_master *spi = dev_get_drvdata(dev);
>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>   
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
> +
>   	return geni_se_resources_off(&mas->se);
>   }
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
