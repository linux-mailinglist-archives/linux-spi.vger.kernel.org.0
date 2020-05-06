Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2974E1C6E35
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgEFKTX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 06:19:23 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64784 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728314AbgEFKTW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 May 2020 06:19:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588760361; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=IcUq3JaTDMqeMJ20mOeLmSvjfCk1bKlvregH4GOb4ZI=; b=xFXp8/aStK9cBqyvLoUAQLqtCHI2CdD0mQaWlhM6zNeRomXXdK6qTTtiOurBmuBAjp6NsGTF
 AIjly7dZjwjxbL0jmnS+6uS/I5V09rcX297+Z70dL/AYdSChk4mJVCLRyCvNG5Iv/D4Akavg
 DReFws3WUfjB8AExR1+CNYx3P7Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E989C432C2; Wed,  6 May 2020 10:19:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.131.199.84] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5D44C433F2;
        Wed,  6 May 2020 10:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5D44C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
References: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
 <1588507469-31889-7-git-send-email-rnayak@codeaurora.org>
 <20200505163811.GW4525@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <66551105-c296-36ce-0ca7-2240c2af7db0@codeaurora.org>
Date:   Wed, 6 May 2020 15:49:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505163811.GW4525@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/5/2020 10:08 PM, Matthias Kaehlcke wrote:
> Hi Rajendra,
> 
> On Sun, May 03, 2020 at 05:34:29PM +0530, Rajendra Nayak wrote:
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
>> index 3c4f83b..eb53c00 100644
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
>> +		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
>> +		goto exit_probe_master_put;
>> +	}
>> +
>>   	pm_runtime_enable(dev);
>>   
>>   	ret = spi_register_master(master);
>> @@ -488,6 +505,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>   		return 0;
>>   
>>   	pm_runtime_disable(dev);
>> +	if (ctrl->has_opp_table)
>> +		dev_pm_opp_of_remove_table(&pdev->dev);
>> +	dev_pm_opp_put_clkname(ctrl->opp_table);
>>   
>>   exit_probe_master_put:
>>   	spi_master_put(master);
>> @@ -498,6 +518,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>   static int qcom_qspi_remove(struct platform_device *pdev)
>>   {
>>   	struct spi_master *master = platform_get_drvdata(pdev);
>> +	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
>> +
>> +	if (ctrl->has_opp_table)
>> +		dev_pm_opp_of_remove_table(&pdev->dev);
>> +	dev_pm_opp_put_clkname(ctrl->opp_table);
> 
> IIUC there can still be active transfers before the controller is
> unregistered. If that is correct the above should be done after the
> spi_unregister_master() call below.

ah, true. i should have read the comment below :)

>>   
>>   	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>>   	spi_unregister_master(master);
>> @@ -512,6 +537,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>>   	struct spi_master *master = dev_get_drvdata(dev);
>>   	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
>>   
>> +	/* Drop the performance state vote */
>> +	dev_pm_opp_set_rate(dev, 0);
>>   	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
>>   
>>   	return 0;

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
