Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF612CEA96
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgLDJOi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 04:14:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44962 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgLDJOh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 04:14:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 224221F45EF9
Subject: Re: [PATCH] spi: spi-geni-qcom: Use the new method of gpio CS control
To:     Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benson Leung <bleung@chromium.org>
References: <20201202214935.1114381-1-swboyd@chromium.org>
 <CAHNYxRwMD4XahHXWW9z7b=VCOEsdPe5Df4CohNwmBy_ijWJ62g@mail.gmail.com>
 <160695172591.2717324.17788035024164242534@swboyd.mtv.corp.google.com>
 <160695644776.2717324.633265815704005177@swboyd.mtv.corp.google.com>
 <CAD=FV=WDYdfURHWf8qGOSwT+7Y5i=9FMgRn5hYZA-oTfR6KoFQ@mail.gmail.com>
 <160704063968.1580929.17834773484656581141@swboyd.mtv.corp.google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8d864844-11d8-0eae-d85c-29136f035c1b@collabora.com>
Date:   Fri, 4 Dec 2020 10:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <160704063968.1580929.17834773484656581141@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 4/12/20 1:10, Stephen Boyd wrote:
> Quoting Doug Anderson (2020-12-03 12:06:10)
>> On Wed, Dec 2, 2020 at 4:47 PM Stephen Boyd <swboyd@chromium.org> wrote:
>>>
>>> And that is wrong. With even more investigation and Doug's eagle eyes it
>>> seems that the cros-ec driver is overriding the spi::mode to clear out
>>> the SPI_CS_HIGH bit that the spi core sets in there when using the gpio
>>> descriptors. I'll send a patch for cros-ec-spi shortly.
>>
>> So do we need any coordinating here, are we OK w/ trogdor devices
>> being broken for a short period of time?
>>
>> I think the device tree changes switching to use GPIO for chip select
>> is already queued in linux-next.  That means if we land this patch
>> before the fix to cros_ec [1] then we'll end up in a broken state.
>> Would we be able to do some quick landing to get the cros-ec fix into
>> v5.10 and then target the SPI patch for 5.11?
> 
> I don't think it really matters if the two patches meet up in linux-next
> or cros-ec is fast tracked, but it would be bad if this patch was merged
> without the cros-ec one. One option would be to apply the cros-ec fix to
> the spi tree along with this patch (or vice versa) so that a bisection
> hole isn't created. Or this patch can wait for a while until cros-ec is
> fixed. I'm not the maintainer here so it's really up to Mark and
> Enric/Benson.
> 

I am fine either way. I'm fine with pick all the patches and go through the
chrome/platform tree if Mark is agree (I think this patch has no other
dependencies and the patch applies cleanly to my tree) or all can go through the
Mark's tree. If I need to an IB I can also do it without problems.

I'll leave Mark to decide who has much experience solving this kind of problems.

Thanks,
 Enric


>>
>> [1] https://lore.kernel.org/r/20201203011649.1405292-2-swboyd@chromium.org/
