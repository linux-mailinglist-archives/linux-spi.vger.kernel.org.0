Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7762182A8
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGHIj5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 04:39:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11259 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728121AbgGHIj4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 04:39:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594197595; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=4dQVarAM3wGiNoLl2bz5daF0OQcsMFRvodrSI3IQvBk=; b=qwXnmjEV7QnVr62+HaOOb1Nnqh6IiNO1ulk8iqR4SHcLmeckts7k6uNbpJC7DSwM1QMciBxe
 Goin1mLOSAvGpxSVam+Rsfjgfh7BOkNIN9QO6P/1QqcJv8Zh09M9007JOeibc9bb41W4Btqa
 RoGlMzda8QocNkQMpRjFYNCXkbk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f058655a33b1a3dd481efc8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Jul 2020 08:39:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39ABDC43387; Wed,  8 Jul 2020 08:39:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.11] (unknown [61.3.23.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20184C433CA;
        Wed,  8 Jul 2020 08:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20184C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 0/2] spi: spi-qcom-qspi: Avoid some per-transfer overhead
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, Akash Asthana <akashast@codeaurora.org>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mkshah@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20200707201641.2030532-1-dianders@chromium.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <5b62bf01-cb06-abda-aada-8a11b4a3935c@codeaurora.org>
Date:   Wed, 8 Jul 2020 14:09:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707201641.2030532-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/8/2020 1:46 AM, Douglas Anderson wrote:
> 
> Not to be confused with the similar series I posed for the _other_
> Qualcomm SPI controller (spi-geni-qcom) [1], this one avoids the
> overhead on the Quad SPI controller.
> 
> It's based atop the current Qualcomm tree including Rajendra's ("spi:
> spi-qcom-qspi: Use OPP API to set clk/perf state").  As discussed in
> individual patches, these could ideally land through the Qualcomm tree
> with Mark's Ack.
> 
> Measuring:
> * Before OPP / Interconnect patches reading all flash takes: ~3.4 seconds
> * After OPP / Interconnect patches reading all flash takes: ~4.7 seconds
> * After this patch reading all flash takes: ~3.3 seconds

Thanks Doug, I saw similar benefit on my setup with these patches. They do help
reduce the (unnecessary) additional overhead so it makes sense to merge these
along with the OPP/Interconnect patches in-order to avoid the regression.

Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
> [1] https://lore.kernel.org/r/20200702004509.2333554-1-dianders@chromium.org
> [2] https://lore.kernel.org/r/1593769293-6354-2-git-send-email-rnayak@codeaurora.org
> 
> 
> Douglas Anderson (2):
>    spi: spi-qcom-qspi: Avoid clock setting if not needed
>    spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms
> 
>   drivers/spi/spi-qcom-qspi.c | 45 ++++++++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 10 deletions(-)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
