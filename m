Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CD20D162
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jun 2020 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgF2Slj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 14:41:39 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53952 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728977AbgF2Slh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jun 2020 14:41:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593456096; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6GnZAkEI1r1nA5A52DYDoAMItSEI8yJzTvouDxd8dkQ=; b=TKDulegJuc2l/BD5+FA7z6U/9DR8Xo5xCZpHdpz4JYCAoxj1bJJlKfsHjxIPvBZ7xemUNovO
 u3z45/bDrDxUL0579fIAwA+CgogquSvjxn/pMZKH2khREjpRrvy4/YifpFqk6y0WjPQK6Dx4
 g7OiqxTzYfF6NhV5kiadvaRM6kk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ef9c91a117610c7fffdca68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 10:57:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD12AC433CB; Mon, 29 Jun 2020 10:57:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.50.61.98] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E426C433C6;
        Mon, 29 Jun 2020 10:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E426C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
To:     Matthias Kaehlcke <mka@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, robdclark@gmail.com,
        robdclark@chromium.org, stanimir.varbanov@linaro.org,
        viresh.kumar@linaro.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com> <20200624171537.GL5472@sirena.org.uk>
 <20200624173948.GC39073@google.com> <20200624174417.GM5472@sirena.org.uk>
 <20200624175536.GD39073@google.com> <20200624180005.GO5472@sirena.org.uk>
 <20200624181245.GE39073@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <9f622661-480a-c207-3c15-65b4a4f1b65c@codeaurora.org>
Date:   Mon, 29 Jun 2020 16:27:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624181245.GE39073@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/24/2020 11:42 PM, Matthias Kaehlcke wrote:
> On Wed, Jun 24, 2020 at 07:00:05PM +0100, Mark Brown wrote:
>> On Wed, Jun 24, 2020 at 10:55:36AM -0700, Matthias Kaehlcke wrote:
>>> On Wed, Jun 24, 2020 at 06:44:17PM +0100, Mark Brown wrote:
>>
>>>> Wait, so *some* of the series should go together but not other bits?
>>>> But you want them split up for some reason?
>>
>>> Yes, this will almost certainly be the case, even if not for this patch.
>>> I brought this up earlier (https://patchwork.kernel.org/cover/11604623/#23428709).
>>
>> I'm not really reading any of this stuff for the series as a whole, as
>> far as I could tell I'd reviewed all my bits and was hoping whatever
>> random platform stuff needs sorting out was going to be sorted out so I
>> stopped getting copied on revisions :(
> 
> Sorry this caused you extra work, I only fully realized this when the series
> was basically ready to land :(
> 
> Avoiding unnecessary revision spam is another good reason to not combine
> technically unrelated patches in a single series.
> 
> If I notice similar series in the future I'll try to bring it up early.
> 
>>> For the QSPI patch you could argue to just take it through QCOM since the SPI
>>> patch of this series goes through this tree, up to you, I just want to make
>>> sure everybody is on the same page.
>>
>> If there are some part of this that don't have a connection with the
>> rest of the series and should be applied separately please split them
>> out and send them separately so it's clear what's going on.
> 
> Rajendra, IIUC you have to re-spin this series anyway, please split it
> up in self-contained chunks.

Thanks, I'll respin these as separate patches, the only reason to club them
was because they all added 'similar' support in all these different drivers.
Sorry for the delay, I had been out a bit and I just got back.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
