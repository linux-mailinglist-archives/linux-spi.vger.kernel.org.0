Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A680B2199EF
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGIHa4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 03:30:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:35792 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgGIHa4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 03:30:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594279855; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=eX6swdK+GyKO1zLMYL5rWu0Mc8+iIL0pLhWcHpoCOpA=; b=rI0xbyqT1/A7iedCLYImInd70w+LXS59jWg2SE3MJXylUBgN8E43HVZhZA5gLxi/tfnAdkiy
 ZH3RZoxRzpr+JQjgjKjtoFuWQHkiqmjMLR98Vs/6JvCgFFeXnfdVSEUFrzjknokNm30d9Y2J
 1+0snajKVq6A0rD8ozsZbBK8CBk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f06c7a2a33b1a3dd4234738 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 07:30:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54116C433CB; Thu,  9 Jul 2020 07:30:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.43.98] (unknown [157.44.103.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C647C433CA;
        Thu,  9 Jul 2020 07:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C647C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime
 resume
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        georgi.djakov@linaro.org, swboyd@chromium.org,
        mkshah@codeaurora.org, ctheegal@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <c7956e65-d21b-8844-45d7-de06b8d3d4f0@codeaurora.org>
Date:   Thu, 9 Jul 2020 13:00:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Doug,

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

Should we fail to resume if error is returned from 'opp_set_rate'?

'spi_geni_prepare_message' use to fail for any error from 
'opp_set_rate'  before patch series "Avoid clock setting if not needed".

But now it's possible that 'prepare_message' can return success even 
when opp are not at desired state(from previous resume call).

Regards,

Akash

>   
>   static int __maybe_unused spi_geni_suspend(struct device *dev)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

