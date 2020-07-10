Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63BA21ADCF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgGJER3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jul 2020 00:17:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50049 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgGJER2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jul 2020 00:17:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594354647; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=O9zhu2Dphpft1snZ7vrzgZ8RN04Y/HeAiDq4LhF8xv8=; b=svROGCk/NzXYviE7kMnDN4aWY2IpOOi4DczTbMtCZLliPcXXeAuRfPzt95C86nV9ym1bgJM7
 Ca4Ni1vE1C7ZJAYgsOI6dHiBwKdWHQu2TvNC9pMy3TxylghWRluCxuxtC2SGr6NfKAy0V9rL
 mDdH1hj0YtOzYDbotJwUm0KkDWA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f07ebd7c431f7323bf5adf8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 04:17:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3442C43387; Fri, 10 Jul 2020 04:17:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.11] (unknown [117.247.20.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FF5EC433C8;
        Fri, 10 Jul 2020 04:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FF5EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Set the clock properly at runtime
 resume
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, georgi.djakov@linaro.org,
        Akash Asthana <akashast@codeaurora.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        ctheegal@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20200709074037.v2.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <378698e8-bd1e-5cea-7ca3-0560759e561a@codeaurora.org>
Date:   Fri, 10 Jul 2020 09:47:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709074037.v2.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/9/2020 8:10 PM, Douglas Anderson wrote:
> In the patch ("spi: spi-geni-qcom: Avoid clock setting if not needed")
> we avoid a whole pile of clock code.  As part of that, we should have
> restored the clock at runtime resume.  Do that.
> 
> It turns out that, at least with today's configurations, this doesn't
> actually matter.  That's because none of the current device trees have
> an OPP table for geni SPI yet.  That makes dev_pm_opp_set_rate(dev, 0)
> a no-op.  This is why it wasn't noticed in the testing of the original
> patch.  It's still a good idea to fix, though.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
> Sending this as a separate patch even though I think the patch it's
> fixing [1] hasn't landed yet.  I'd be happy if this was squashed into
> that patch when landing if that suits everyone, but it could land on
> its own too.
> 
> Like the patch it's fixing, this needs to target the Qualcomm tree in
> order to avoid merge conflicts.
> 
> [1] https://lore.kernel.org/r/20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid
> 
> Changes in v2:
> - Return error from runtime resume if dev_pm_opp_set_rate() fails.
> 
>   drivers/spi/spi-geni-qcom.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 97fac5ea6afd..0e11a90490ff 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -79,6 +79,7 @@ struct spi_geni_master {
>   	u32 tx_wm;
>   	u32 last_mode;
>   	unsigned long cur_speed_hz;
> +	unsigned long cur_sclk_hz;
>   	unsigned int cur_bits_per_word;
>   	unsigned int tx_rem_bytes;
>   	unsigned int rx_rem_bytes;
> @@ -116,6 +117,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>   	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
>   	if (ret)
>   		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
> +	else
> +		mas->cur_sclk_hz = sclk_freq;
> +
>   	return ret;
>   }
>   
> @@ -670,7 +674,11 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	return geni_se_resources_on(&mas->se);
> +	ret = geni_se_resources_on(&mas->se);
> +	if (ret)
> +		return ret;
> +
> +	return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
>   }
>   
>   static int __maybe_unused spi_geni_suspend(struct device *dev)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
