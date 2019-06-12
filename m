Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D884B41E09
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2019 09:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407554AbfFLHnC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jun 2019 03:43:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406728AbfFLHnB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jun 2019 03:43:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AB99660F3A; Wed, 12 Jun 2019 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560325378;
        bh=akNFareB34O+WoELW9a+vXLpK/S7e9w6RCo5AwPjb2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b6L0hfL3FpRwBcfm7DqTiSOJXV1qO+cKG6vdFUKA92yPW42Gg4GSTg7oWylS6l0CP
         NT1Qa14L+91OHy3VP0yw1NC7oTgFa8WU/nEZ+rwAXpxqniua5APd1uwAV5WysKbNeq
         U4zu3+X2m030hPWSus3HgHdDx30BlqWfec1xEzII=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.131.117.43] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F04D960CF1;
        Wed, 12 Jun 2019 07:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560325377;
        bh=akNFareB34O+WoELW9a+vXLpK/S7e9w6RCo5AwPjb2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U/s1AWqwx7q0I8Ng/jLB1n8gUT0Mk/9P2K9ccSQ7OCjYnbfmz3j/qMd/2j7W+KCy8
         E34Zus5a4XaR6M5L9kZwN0qpKgm6ECocxs25r9Fw3cev2eJHHhQZJNVk4z+w5ABMnd
         ThX+4IziXS3BDPUulhM0GRvNTDLUqxX6Tbi1AUG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F04D960CF1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
To:     Viresh Kumar <viresh.kumar@linaro.org>, swboyd@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
Date:   Wed, 12 Jun 2019 13:12:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/11/2019 4:24 PM, Viresh Kumar wrote:
> On 20-03-19, 15:19, Rajendra Nayak wrote:
>> From: Stephen Boyd <swboyd@chromium.org>
>>
>> Doing this allows us to call this API with any rate requested and have
>> it not need to match in the OPP table. Instead, we'll round the rate up
>> to the nearest OPP that we see so that we can get the voltage or level
>> that's required for that OPP. This supports users of OPP that want to
>> specify the 'fmax' tables of a device instead of every single frequency
>> that they need. And for devices that required the exact frequency, we
>> can rely on the clk framework to round the rate to the nearest supported
>> frequency instead of the OPP framework to do so.
>>
>> Note that this may affect drivers that don't want the clk framework to
>> do rounding, but instead want the OPP table to do the rounding for them.
>> Do we have that case? Should we add some flag to the OPP table to
>> indicate this and then not have that flag set when there isn't an OPP
>> table for the device and also introduce a property like 'opp-use-clk' to
>> tell the table that it should use the clk APIs to round rates instead of
>> OPP?
>>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---

[]...

> 
> I see a logical problem with this patch.
> 
> Suppose the clock driver supports following frequencies: 500M, 800M,
> 1G, 1.2G and the OPP table contains following list: 500M, 1G, 1.2G
> (i.e. missing 800M).
> 
> Now 800M should never get programmed as it isn't part of the OPP
> table. But if you pass 600M to opp-set-rate, then it will end up
> selecting 800M as clock driver will round up to the closest value.

correct

> 
> Even if no one is doing this right now, it is a sensible usecase,
> specially during testing of patches and I don't think we should avoid
> it.
> 
> What exactly is the use case for which we need this patch ? 
Like the changelog says 'This supports users of OPP that want to
specify the 'fmax' tables of a device instead of every single frequency
that they need'

so the 'fmax' tables basically say what the max frequency the device can
operate at for a given performance state/voltage level.

so in your example it would be for instance

500M, Perf state = 2
1G, Perf state = 3
1.2G, Perf state = 4

Now when the device wants to operate at say 800Mhz, you need to set the
Perf state to 3, so this patch basically avoids you having to put those additional
OPPs in the table which would otherwise look something like this

500M, Perf state = 2
800M, Perf state = 3 <-- redundant OPP
1G, Perf state = 3
1.2G, Perf state = 4

Your example had just 1 missing entry in the 'fmax' tables in reality its a lot more,
atleast on all qualcomm platforms.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
