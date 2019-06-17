Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308B7478E6
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 06:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfFQEEO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 00:04:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfFQEEO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 00:04:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91D4060779; Mon, 17 Jun 2019 04:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560744252;
        bh=PYHnmpPKNQezYb6d7XsHr1kzQDKcd5CpbPQ9GTSBk7M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HrP5+sQUQWwwnDh7bqcYMPTFEDH9Lzt9kn3ys1kffJNNBMhJMvNTbHPkLOnF1CJ4Y
         cHCbC3lGJHCiL3kbi5NDet+By7SQMIRwMSKFg/Me8Ic73YIut8gQTSPij/fkxJyspC
         LuAbXR5PM9rpWVCKn4nyiNKO6NqQiqdnb59O5ApA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFF9E60779;
        Mon, 17 Jun 2019 04:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560744251;
        bh=PYHnmpPKNQezYb6d7XsHr1kzQDKcd5CpbPQ9GTSBk7M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QAfyryVjJ0aYRrxwywXTHc0J2mthJdf5wry79zhqxHn5/Ou6Z5q/xyvyB3Q5oiwUz
         3EEs8MFhVFJKpBouxy47nAqxic69sVbpT+RcHHAvPmdXXdyMsvy7y6QroSohBPDxbT
         yJRiortH6undkk09yJ5+YWY7CjzuEmRB0/BcLEfE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFF9E60779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 02/11] OPP: Make dev_pm_opp_set_rate() with freq=0 as
 valid
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, swboyd@chromium.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-3-rnayak@codeaurora.org>
 <20190614063210.lfsquoycronah3fe@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <37e7ff9e-6bfa-585e-1ca6-f8e079dd0aef@codeaurora.org>
Date:   Mon, 17 Jun 2019 09:34:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614063210.lfsquoycronah3fe@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/14/2019 12:02 PM, Viresh Kumar wrote:
> On 20-03-19, 15:19, Rajendra Nayak wrote:
>> For devices with performance state, we use dev_pm_opp_set_rate()
>> to set the appropriate clk rate and the performance state.
>> We do need a way to *remove* the performance state vote when
>> we idle the device and turn the clocks off. Use dev_pm_opp_set_rate()
>> with freq=0 to achieve this.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   drivers/opp/core.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> What about this instead ?

yes, this works, thanks for updating the patch.

> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2fe96c2363a3..9accf8bb6afc 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -711,7 +711,7 @@ static int _set_required_opps(struct device *dev,
>   
>          /* Single genpd case */
>          if (!genpd_virt_devs) {
> -               pstate = opp->required_opps[0]->pstate;
> +               pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
>                  ret = dev_pm_genpd_set_performance_state(dev, pstate);
>                  if (ret) {
>                          dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
> @@ -729,7 +729,7 @@ static int _set_required_opps(struct device *dev,
>          mutex_lock(&opp_table->genpd_virt_dev_lock);
>   
>          for (i = 0; i < opp_table->required_opp_count; i++) {
> -               pstate = opp->required_opps[i]->pstate;
> +               pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
>   
>                  if (!genpd_virt_devs[i])
>                          continue;
> @@ -770,14 +770,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   
>          if (unlikely(!target_freq)) {
>                  if (opp_table->required_opp_tables) {
> -                       /* drop the performance state vote */
> -                       dev_pm_genpd_set_performance_state(dev, 0);
> -                       return 0;
> +                       ret = _set_required_opps(dev, opp_table, NULL);
>                  } else {
> -                       dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> -                               target_freq);
> -                       return -EINVAL;
> +                       dev_err(dev, "target frequency can't be 0\n");
> +                       ret = -EINVAL;
>                  }
> +
> +               goto put_opp_table;
>          }
>   
>          clk = opp_table->clk;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
