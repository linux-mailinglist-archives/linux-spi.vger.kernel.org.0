Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B861A6776
	for <lists+linux-spi@lfdr.de>; Mon, 13 Apr 2020 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgDMODT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Apr 2020 10:03:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52765 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730248AbgDMODQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Apr 2020 10:03:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586786594; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=qhJil9YUxNlGzvVoOFb/1gH7xdIkydJzl1S9v+bheZM=; b=smZsIdY7gQ0qPQ7H80mLmZY8nPHPU5IQ3xWb52uPkf3ucBiRNIz/9VrSXdzgywCewd6eMan/
 crlP3HWIFCnzQT+tAvMsF+uGMQggeCvIH/YlrSLCApzxj8YmaGpJR9R6cocdH/zyquPEoDq1
 5xbmzMY1O2CE9OysJ70KhU6zynI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e947107.7f59ab7ff7a0-smtp-out-n03;
 Mon, 13 Apr 2020 14:02:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73ABBC43637; Mon, 13 Apr 2020 14:02:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.111.193.245] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEFA9C433CB;
        Mon, 13 Apr 2020 14:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEFA9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 03/21] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-4-git-send-email-rnayak@codeaurora.org>
 <20200409182021.GT199755@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ef2fc62f-bc43-5689-d1a5-d1b28342b7d6@codeaurora.org>
Date:   Mon, 13 Apr 2020 19:32:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409182021.GT199755@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/9/2020 11:50 PM, Matthias Kaehlcke wrote:
> Hi Rajendra,
> 
> On Wed, Apr 08, 2020 at 07:16:29PM +0530, Rajendra Nayak wrote:
>> geni spi needs to express a perforamnce state requirement on CX
>> depending on the frequency of the clock rates. Use OPP table from
>> DT to register with OPP framework and use dev_pm_opp_set_rate() to
>> set the clk/perf state.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: Alok Chauhan <alokc@codeaurora.org>
>> Cc: Akash Asthana <akashast@codeaurora.org>
>> Cc: linux-spi@vger.kernel.org
>> ---
>>   drivers/spi/spi-geni-qcom.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index c397242..ce387dc 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/log2.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/qcom-geni-se.h>
>>   #include <linux/spi/spi.h>
>> @@ -95,7 +96,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>>   {
>>   	unsigned long sclk_freq;
>>   	unsigned int actual_hz;
>> -	struct geni_se *se = &mas->se;
>>   	int ret;
>>   
>>   	ret = geni_se_clk_freq_match(&mas->se,
>> @@ -112,9 +112,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>>   
>>   	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>>   				actual_hz, sclk_freq, *clk_idx, *clk_div);
>> -	ret = clk_set_rate(se->clk, sclk_freq);
>> +	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
>>   	if (ret)
>> -		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
>> +		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
>>   	return ret;
>>   }
>>   
>> @@ -553,6 +553,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   	if (!spi)
>>   		return -ENOMEM;
>>   
>> +
>>   	platform_set_drvdata(pdev, spi);
>>   	mas = spi_master_get_devdata(spi);
>>   	mas->irq = irq;
>> @@ -561,6 +562,8 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   	mas->se.wrapper = dev_get_drvdata(dev->parent);
>>   	mas->se.base = base;
>>   	mas->se.clk = clk;
>> +	mas->se.opp = dev_pm_opp_set_clkname(&pdev->dev, "se");
> 
> As commented on the serial patch, it seems an error check is needed
> and the OPP table saved in 'struct geni_se' is never used.

right, I explained about the OPP table in the other patch.

> 
>> +	dev_pm_opp_of_add_table(&pdev->dev);
> 
> This function could also fail for multiple reasons, so the return value
> should be checked.
> 
>  From patch "[01/21] opp: Manage empty OPP tables with clk handle" it seems
> ignoring errors is intended to be able to operate when no OPP table is
> specified. But even with that you want to return in case of certain errors,
> like an invalid OPP table, out of memory or -EPROBE_DEFER.

Thats correct, my intention of not checking the errors was in cases where its
optional, and I did not want to break anything with existing DT. I will go back and
check if its indeed possible for it to return a -EPROBE_DEFER and others which
I should handle.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
