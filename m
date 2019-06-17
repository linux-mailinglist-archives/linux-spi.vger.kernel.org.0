Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5947947
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFQEZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 00:25:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfFQEZI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 00:25:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7616160735; Mon, 17 Jun 2019 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560745506;
        bh=5HZNkcP2zjhga4bMIOWXDoG0/nXxrlZAjw0ECMvGYK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kQVJ9Osh3eNJuFAi59AX3O0oOU/n2R1TLKeFsvszpLQZT49bJMj86kNYSvp7k6e+J
         5RPT6GNe3kh9dMasg/eJlxZnFiHsAI9fTu/bzk9oq1kQaQ2tikD3pkVWsd3LaXag9a
         hTlnLJOVQjC7nbGJBX0MOWdSTiKTWm5+JadThbZ8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D977860735;
        Mon, 17 Jun 2019 04:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560745505;
        bh=5HZNkcP2zjhga4bMIOWXDoG0/nXxrlZAjw0ECMvGYK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G3dth9pBIldbPRyid5w1N1yL/bTUx8NuG1TbpDv3Y2g4jKBqOHr9ICd/Ucdl2ISGf
         zpAQa/+hK2ijNE1odvZQHhIT8OEW/U9CuNLp5iSChIt6UAp8Sz4aHfprpBQPeE1gcH
         FgAekDIFTXanc5VeqZtXhzbOybouHaMjoY15PVN8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D977860735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     swboyd@chromium.org, vincent.guittot@linaro.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
 <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
 <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
 <20190614052732.4w6vvwwich2h4cgu@vireshk-i7>
 <20190617035058.veo7uwqjrpa6kykt@vireshk-i7>
 <a912c8b2-080d-7ab7-670b-b687ec3a2c92@codeaurora.org>
 <20190617041721.5xdr3kl4xxe6gy4m@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a97f991d-539a-ce22-834b-ce19944e4f57@codeaurora.org>
Date:   Mon, 17 Jun 2019 09:55:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617041721.5xdr3kl4xxe6gy4m@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/17/2019 9:47 AM, Viresh Kumar wrote:
> On 17-06-19, 09:37, Rajendra Nayak wrote:
>>
>>
>> On 6/17/2019 9:20 AM, Viresh Kumar wrote:
>>> On 14-06-19, 10:57, Viresh Kumar wrote:
>>>> Hmm, so this patch won't break anything and I am inclined to apply it again :)
>>>>
>>>> Does anyone see any other issues with it, which I might be missing ?
>>>
>>> I have updated the commit log a bit more to clarify on things, please let me
>>> know if it looks okay.
>>>
>>>       opp: Don't overwrite rounded clk rate
>>>       The OPP table normally contains 'fmax' values corresponding to the
>>>       voltage or performance levels of each OPP, but we don't necessarily want
>>>       all the devices to run at fmax all the time. Running at fmax makes sense
>>>       for devices like CPU/GPU, which have a finite amount of work to do and
>>>       since a specific amount of energy is consumed at an OPP, its better to
>>>       run at the highest possible frequency for that voltage value.
>>>       On the other hand, we have IO devices which need to run at specific
>>>       frequencies only for their proper functioning, instead of maximum
>>>       possible frequency.
>>>       The OPP core currently roundup to the next possible OPP for a frequency
>>>       and select the fmax value. To support the IO devices by the OPP core,
>>>       lets do the roundup to fetch the voltage or performance state values,
>>>       but not use the OPP frequency value. Rather use the value returned by
>>>       clk_round_rate().
>>>       The current user, cpufreq, of dev_pm_opp_set_rate() already does the
>>>       rounding to the next OPP before calling this routine and it won't
>>>       have any side affects because of this change.
>>
>> Looks good to me. Should this also be documented someplace that dev_pm_opp_set_rate()
>> would not be able to distinguish between its users trying to scale CPU/GPU's vs IO
>> devices, so its the callers responsibility to round it accordingly before calling the
>> API?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0fbc77f05048..bae94bfa1e96 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -751,8 +751,11 @@ static int _set_required_opps(struct device *dev,
>    * @dev:        device for which we do this operation
>    * @target_freq: frequency to achieve
>    *
> - * This configures the power-supplies and clock source to the levels specified
> - * by the OPP corresponding to the target_freq.
> + * This configures the power-supplies to the levels specified by the OPP
> + * corresponding to the target_freq, and programs the clock to a value <=
> + * target_freq, as rounded by clk_round_rate(). Device wanting to run at fmax
> + * provided by the opp, should have already rounded to the target OPP's
> + * frequency.
>    */

Perfect, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
