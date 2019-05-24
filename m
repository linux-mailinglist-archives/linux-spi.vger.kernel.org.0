Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14863290B0
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2019 08:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbfEXGEC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 May 2019 02:04:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbfEXGEC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 May 2019 02:04:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 60D4860C8B; Fri, 24 May 2019 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558677840;
        bh=+LXeINwGo6CiisA+JrfBkpcV33DtSDYcwasClLqFltM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MnQgEBJBFX7Jr6ZKTlpvPMRJlQPlORXWJeNHd18+CdO6x9V93JYSt8nqTFP73lTVe
         Kc87IbU8eSlsJ0klkz6GlvCLKXc6yFpvAFoopfpj6hJVstNPzdnt9epwSyXMx7viOQ
         idTFVhIbOwNG/+qmb2jqYeYdR78lpVY7V7ALMvB0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA5026063A;
        Fri, 24 May 2019 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558677838;
        bh=+LXeINwGo6CiisA+JrfBkpcV33DtSDYcwasClLqFltM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WtaCR2+wyWWFjJzU9+IBN0PVFNR69TJTy4vvAyk+MUIWQoA6bLptg7h6mGWmvgSYC
         ceLZ777Tzuy2Vfg1oiS6jsaRdeMMBSozslhkgH9uA3OjPW/L2iqMfhWCfqhoBEh3TL
         vBuirdXrib/G+OD5P4nw7QuflaX7JS6fFb70beys=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA5026063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 00/11] DVFS in the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, swboyd@chromium.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org,
        vincent.guittot@linaro.org
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190521062248.ogjetb2rwtqekflx@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <85dbc630-f526-c06f-8a8b-9bbc3b794693@codeaurora.org>
Date:   Fri, 24 May 2019 11:33:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521062248.ogjetb2rwtqekflx@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/21/2019 11:52 AM, Viresh Kumar wrote:
> On 20-03-19, 15:19, Rajendra Nayak wrote:
>> This is a v2 of the RFC posted earlier by Stephen Boyd [1]
>>
>> As part of v2 I still follow the same approach of dev_pm_opp_set_rate()
>> API using clk framework to round the frequency passed and making it
>> accept 0 as a valid frequency indicating the frequency isn't required
>> anymore. It just has a few more drivers converted to use this approach
>> like dsi/dpu and ufs.
>> ufs demonstrates the case of having to handle multiple power domains, one
>> of which is scalable.
>>
>> The patches are based on 5.1-rc1 and depend on some ufs fixes I posted
>> earlier [2] and a DT patch to include the rpmpd header [3]
>>
>> [1] https://lkml.org/lkml/2019/1/28/2086
>> [2] https://lkml.org/lkml/2019/3/8/70
>> [3] https://lkml.org/lkml/2019/3/20/120
> 
> Hi Rajendra,
> 
> I am inclined to apply/push this series for 5.3-rc1, will it be
> possible for you to spend some time on this at priority ?

Hey Viresh, I was on vacation, just got back. I will refresh this series
and address your previous feedback, I haven't received much feedback for the
driver changes :/ but we can atleast review and get the OPP layer changes
finalized. thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
