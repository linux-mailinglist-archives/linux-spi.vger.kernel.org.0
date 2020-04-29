Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CED1BE0AE
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD2OVS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 10:21:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42339 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727779AbgD2OVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Apr 2020 10:21:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588170076; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=JKe1JfOxr0f9z7wtEyL/EQpt0pt2j2AM74fYD+ythHI=; b=HSOYSKuNHQglM+7S29wZ8Yn0+nM94X1BX8vjPvf4/5D+hKyC2kuC5JEN8eR60b2fZS1yRI11
 AS4va0PgjvjdQ0qVO/BO+oz7032B5SHL/1/osYcbynA7X7pB6VuH5gSJrrELrzoRmvtIkwii
 QOZZ2EBLm5j9BkI2aQT9dmN9SxU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea98d55.7fe604e8e500-smtp-out-n05;
 Wed, 29 Apr 2020 14:21:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F22CEC433D2; Wed, 29 Apr 2020 14:21:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.131.182.194] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E48ABC433CB;
        Wed, 29 Apr 2020 14:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E48ABC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 15/17] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-16-git-send-email-rnayak@codeaurora.org>
 <20200429004945.GP4525@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a0722696-bc66-3841-0ab1-0108b4f33d9f@codeaurora.org>
Date:   Wed, 29 Apr 2020 19:51:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429004945.GP4525@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/29/2020 6:19 AM, Matthias Kaehlcke wrote:
> Hi,
> 
> On Tue, Apr 28, 2020 at 07:03:03PM +0530, Rajendra Nayak wrote:
>> QSPI needs to vote on a performance state of a power domain depending on
>> the clock rate. Add support for it by specifying the perf state/clock rate
>> as an OPP table in device tree.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Alok Chauhan <alokc@codeaurora.org>
>> Cc: Akash Asthana <akashast@codeaurora.org>
>> Cc: linux-spi@vger.kernel.org
>> ---
>>   drivers/spi/spi-qcom-qspi.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
>> index 3c4f83b..724a658 100644
>> --- a/drivers/spi/spi-qcom-qspi.c
>> +++ b/drivers/spi/spi-qcom-qspi.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/spi/spi.h>
>>   #include <linux/spi/spi-mem.h>
>>   
>> @@ -139,6 +140,8 @@ struct qcom_qspi {
>>   	struct device *dev;
>>   	struct clk_bulk_data *clks;
>>   	struct qspi_xfer xfer;
>> +	struct opp_table *opp_table;
>> +	bool has_opp_table;
>>   	/* Lock to protect xfer and IRQ accessed registers */
>>   	spinlock_t lock;
>>   };
>> @@ -235,7 +238,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>>   		speed_hz = xfer->speed_hz;
>>   
>>   	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
>> -	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
>> +	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
>>   	if (ret) {
>>   		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
>>   		return ret;
>> @@ -481,6 +484,20 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>   	master->handle_err = qcom_qspi_handle_err;
>>   	master->auto_runtime_pm = true;
>>   
>> +	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
>> +	if (IS_ERR(ctrl->opp_table)) {
>> +		ret = PTR_ERR(ctrl->opp_table);
>> +		goto exit_probe_master_put;
>> +	}
>> +	/* OPP table is optional */
>> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
>> +	if (!ret) {
>> +		ctrl->has_opp_table = true;
>> +	} else if (ret != -ENODEV) {
>> +		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
>> +		return ret;
> 
> 		goto exit_probe_master_put;

thanks for catching this. will fix and respin.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
