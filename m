Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA1219B8B
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGIIzr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 04:55:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61429 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgGIIzr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 04:55:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594284946; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=u5pWM02G/lO8GGvz/lXNVeUoqV1SpfqF+W43CpXRMM0=; b=obOtKnNkYk4w7BVR4cPlkwNnSvySlFYxqhoIF80Q6gwwkICEBmOkaNkrEFm8dSXECv9urYAi
 6odNhrgf0wcyJh34yI29dvbmqzAq9K0/mfPuwz+npCtsP2LDzJYc0k1XP5YGe4kiD53MoMm9
 RFTLvXTAj8xwmoGaS1DEx3N203Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f06db92c746eb6f00de562c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 08:55:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 775A4C433CB; Thu,  9 Jul 2020 08:55:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.11] (unknown [61.3.20.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F593C43387;
        Thu,  9 Jul 2020 08:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F593C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime
 resume
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, swboyd@chromium.org,
        mkshah@codeaurora.org, ctheegal@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <23e53f2b-02b0-2c9b-a165-4ca5a2c84a89@codeaurora.org>
Date:   Thu, 9 Jul 2020 14:25:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/9/2020 5:09 AM, Douglas Anderson wrote:
> In the patch ("spi: spi-geni-qcom: Avoid clock setting if not needed")
> we avoid a whole pile of clock code.  As part of that, we should have
> restored the clock at runtime resume.  Do that.
> 
> It turns out that, at least with today's configurations, this doesn't
> actually matter.  That's because none of the current device trees have
> an OPP table for geni SPI yet.  That makes dev_pm_opp_set_rate(dev, 0)
> a no-op.  This is why it wasn't noticed in the testing of the original
> patch.  It's still a good idea to fix, though.

good catch, without this (and with OPP tables added) we would end up removing
the performance vote on suspend and never put it back unless the rate changes.
Perhaps a similar change would be needed for spi-qcom-qspi too?

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
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
>   drivers/spi/spi-geni-qcom.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 97fac5ea6afd..e5ece1bcc4ad 100644
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
> @@ -670,7 +674,13 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	return geni_se_resources_on(&mas->se);
> +	ret = geni_se_resources_on(&mas->se);
> +	if (ret)
> +		return ret;
> +
> +	dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
> +
> +	return 0;
>   }
>   
>   static int __maybe_unused spi_geni_suspend(struct device *dev)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
