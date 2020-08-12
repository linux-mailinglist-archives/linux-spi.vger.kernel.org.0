Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B919242515
	for <lists+linux-spi@lfdr.de>; Wed, 12 Aug 2020 07:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHLFsj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Aug 2020 01:48:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLFsg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Aug 2020 01:48:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597211315; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=pcchFqlGO204owbj4tYlSsiQCb+7lLvPn9Lhykdi2Js=; b=r9endyL46qeUm9rha6L2oLkLUituluSVEv0XeFSp3x4KHpa1jGDNqqVhxIytf8QtCReBlZed
 ky3LvmJQsE0n0ohRVW5bzzHnFIzE4KoF16U+y08/YwUfoSOBw719Nn5s/1Pt3IT5e1ZnXoU0
 YJg+kaofJRZP3JK6vMco+zZUYMw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f33829a668ab3fef6fec7d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 05:48:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AEF3C43391; Wed, 12 Aug 2020 05:48:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.15] (unknown [61.1.229.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 339F8C433C6;
        Wed, 12 Aug 2020 05:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 339F8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 03/11] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-scsi@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-4-rnayak@codeaurora.org>
 <CALAqxLV2TBk9ScUM6MeJMCkL8kJnCihjQ7ac5fLzcqOg1rREVQ@mail.gmail.com>
 <CALAqxLWg3jJKJFLnnne-mrQEnH=m7R_9azCGaGnEmFYR4EMh=A@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ec5eeb21-48e4-5dcc-583a-ac9419659e44@codeaurora.org>
Date:   Wed, 12 Aug 2020 11:18:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWg3jJKJFLnnne-mrQEnH=m7R_9azCGaGnEmFYR4EMh=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 8/12/2020 7:03 AM, John Stultz wrote:
> On Tue, Aug 11, 2020 at 4:11 PM John Stultz <john.stultz@linaro.org> wrote:
>>
>> On Wed, Mar 20, 2019 at 2:49 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>
>>> geni serial needs to express a perforamnce state requirement on CX
>>> depending on the frequency of the clock rates. Use OPP table from
>>> DT to register with OPP framework and use dev_pm_opp_set_rate() to
>>> set the clk/perf state.
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>> ---
>>>   drivers/tty/serial/qcom_geni_serial.c | 15 +++++++++++++--
>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>
>> Hey,
>>    I just wanted to follow up on this patch, as I've bisected it
>> (a5819b548af0) down as having broken qca bluetooth on the Dragonboard
>> 845c.
>>
>> I haven't yet had time to debug it yet, but wanted to raise the issue
>> in case anyone else has seen similar trouble.
> 
> So I dug in a bit further, and this chunk seems to be causing the issue:
>> @@ -961,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>>                  goto out_restart_rx;
>>
>>          uport->uartclk = clk_rate;
>> -       clk_set_rate(port->se.clk, clk_rate);
>> +       dev_pm_opp_set_rate(port->dev, clk_rate);
>>          ser_clk_cfg = SER_CLK_EN;
>>          ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>>
> 
> 
> With that applied, I see the following errors in dmesg and bluetooth
> fails to function:
> [    4.763467] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
> failed to find OPP for freq 102400000 (-34)
> [    4.773493] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
> failed to find OPP for freq 102400000 (-34)
> 
> With just that chunk reverted on linus/HEAD, bluetooth seems to work ok.

This seems like the same issue that was also reported on venus [1] because the
clock frequency tables apparently don;t exactly match the achievable clock
frequencies (which we also used to construct the OPP tables)

Can you try updating the OPP table for QUP to have 102400000 instead of the
current 100000000 and see if that fixes it?

[1] https://lkml.org/lkml/2020/7/27/507

> 
> thanks
> -john
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
