Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9252345457
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFNFyi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 01:54:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNFyi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jun 2019 01:54:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 782F860909; Fri, 14 Jun 2019 05:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560491676;
        bh=wd1M0evBIXLEcGJx9iw3rlVbAxOCmtJoFg2feFLTumI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bOnuHxO8vepWrGxy5wP0hMkl/8iRkQ6gb+h6IQ12M7loZUuxZRddpRhAciAGH/8MA
         P+k2GbzqrJRMRiTFRr/zTMtT2zr2AE7SArtWjGKwQx+UjmDMIPlCcxdqeSFAYgBsYn
         OY3USkRnR3WlbVrgBCedBeGlRZJBMeTDyCd4v9PI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 254356079C;
        Fri, 14 Jun 2019 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560491675;
        bh=wd1M0evBIXLEcGJx9iw3rlVbAxOCmtJoFg2feFLTumI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q1sGLGHqf3Og6g5QfKfG4218AP0shAWBRRrGCeuKdQJBYFYQQ/S/aPj6MOLclGqJ5
         KfHv4VOLijzIkPbNk0r6sDct0BGaiOvf5sl9xTqTkwSFeVR26QSejf2TOJ6fKEGnok
         sgNekPch6PEJN8RCCUSSNLedhogOCiYDnRe9dgoU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 254356079C
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
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <b29c1754-d719-4d7b-806f-9ea25a8b528f@codeaurora.org>
Date:   Fri, 14 Jun 2019 11:24:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> Now, the request to change the frequency starts from cpufreq
> governors, like schedutil when they calls:
> 
> __cpufreq_driver_target(policy, 599 MHz, CPUFREQ_RELATION_L);
> 
> CPUFREQ_RELATION_L means: lowest frequency at or above target. And so
> I would expect the frequency to get set to 600MHz (if we look at clock
> driver) or 700MHz (if we look at OPP table). I think we should decide
> this thing from the OPP table only as that's what the platform guys
> want us to use. So, we should end up with 700 MHz.
> 
> Then we land into dev_pm_opp_set_rate(), which does this (which is
> code copied from earlier version of cpufreq-dt driver):

so before we land into dev_pm_opp_set_rate() from a __cpufreq_driver_target()
I guess we do have a cpufreq driver callback that gets called in between?
which is either .target_index or .target

In case of .target_index, the cpufreq core looks for a OPP index
and we would land up with 700Mhz i guess, so we are good.

In case of .target though the 'relation' CPUFREQ_RELATION_L does get passed over
to the cpufreq driver which I am guessing is expected to handle it in some way to
make sure the target frequency set is not less than whats requested? instead of
simply passing the requested frequency over to dev_pm_opp_set_rate()?

Looking at all the existing cpufreq drivers upstream, while most support .target_index
the 3 which do support .target seem to completely ignore this 'relation' input that's
passed to them.

drivers/cpufreq/cppc_cpufreq.c:	.target = cppc_cpufreq_set_target,
drivers/cpufreq/cpufreq-nforce2.c:	.target = nforce2_target,
drivers/cpufreq/pcc-cpufreq.c:	.target = pcc_cpufreq_target,

> This kind of behavior (introduced by this patch) is important for
> other devices which want to run at the nearest frequency to target
> one, but not for CPUs/GPUs. So, we need to tag these IO devices
> separately, maybe from DT ? So we select the closest match instead of
> most optimal one.

yes we do need some way to distinguish between CPU/GPU devices and other
IO devices. CPU/GPU can always run at fmax for a given voltage, that's not true
for IO devices and I don't see how we can satisfy both cases without
clearly knowing if we are serving a processor or an IO device, unless the
higher layers (cpufreq/devfreq) are able to handle this somehow without
expecting the OPP layer to handle the differences.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
