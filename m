Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1E478F0
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 06:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFQEHK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 00:07:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfFQEHJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 00:07:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CFBD260779; Mon, 17 Jun 2019 04:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560744427;
        bh=fnXV3qMdXMwHiyNp+B4dIgHawcwKCfrjYzO+/aW82ms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N5zPEPhqz4s76LUp4qXdOb5ZhO7paU+yiHqIfbsXW1WLdYhdMbuKoLkv0wUwMKQXy
         lmHQsEo0utTl1a6oRB6bBUelYXlw4Zl0Sga05zYCKET/ouXcZwQtL+H/LPH9Sv7Opq
         1cwE2vnWm4pHKg8DVSMss1ueRo3N7pPFDtivHDe0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89D7360779;
        Mon, 17 Jun 2019 04:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560744426;
        bh=fnXV3qMdXMwHiyNp+B4dIgHawcwKCfrjYzO+/aW82ms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k4ofmJu8qI7RpsRw+XS/AbEB5+R2R7P9AchQpn/sccKrjcFY2l5PYEmLLiTG4Hy9V
         XlIODHSfkxOoIXZv0OUmwI/pkEgP3TOKjBPQpX4YugWF5bd17aNlT04aJsIYCy6hl3
         8OqHQ7sdht6t3V+/X9QjXm3FI4HtAvc86U7spKtE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89D7360779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
To:     Viresh Kumar <viresh.kumar@linaro.org>, swboyd@chromium.org,
        vincent.guittot@linaro.org, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
 <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
 <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
 <20190614052732.4w6vvwwich2h4cgu@vireshk-i7>
 <20190617035058.veo7uwqjrpa6kykt@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a912c8b2-080d-7ab7-670b-b687ec3a2c92@codeaurora.org>
Date:   Mon, 17 Jun 2019 09:37:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617035058.veo7uwqjrpa6kykt@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/17/2019 9:20 AM, Viresh Kumar wrote:
> On 14-06-19, 10:57, Viresh Kumar wrote:
>> Hmm, so this patch won't break anything and I am inclined to apply it again :)
>>
>> Does anyone see any other issues with it, which I might be missing ?
> 
> I have updated the commit log a bit more to clarify on things, please let me
> know if it looks okay.
> 
>      opp: Don't overwrite rounded clk rate
>      
>      The OPP table normally contains 'fmax' values corresponding to the
>      voltage or performance levels of each OPP, but we don't necessarily want
>      all the devices to run at fmax all the time. Running at fmax makes sense
>      for devices like CPU/GPU, which have a finite amount of work to do and
>      since a specific amount of energy is consumed at an OPP, its better to
>      run at the highest possible frequency for that voltage value.
>      
>      On the other hand, we have IO devices which need to run at specific
>      frequencies only for their proper functioning, instead of maximum
>      possible frequency.
>      
>      The OPP core currently roundup to the next possible OPP for a frequency
>      and select the fmax value. To support the IO devices by the OPP core,
>      lets do the roundup to fetch the voltage or performance state values,
>      but not use the OPP frequency value. Rather use the value returned by
>      clk_round_rate().
>      
>      The current user, cpufreq, of dev_pm_opp_set_rate() already does the
>      rounding to the next OPP before calling this routine and it won't
>      have any side affects because of this change.

Looks good to me. Should this also be documented someplace that dev_pm_opp_set_rate()
would not be able to distinguish between its users trying to scale CPU/GPU's vs IO
devices, so its the callers responsibility to round it accordingly before calling the
API?

>      
>      Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>      Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>      [ Viresh: Massaged changelog and use temp_opp variable instead ]
>      Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
