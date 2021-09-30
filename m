Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DF41D9EF
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350918AbhI3Mht (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 08:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350920AbhI3Mht (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Sep 2021 08:37:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB2C06176D;
        Thu, 30 Sep 2021 05:36:06 -0700 (PDT)
Received: from [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1] (unknown [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 423711F44C22;
        Thu, 30 Sep 2021 13:36:04 +0100 (BST)
Subject: Re: [PATCH] Revert "spi: modify set_cs_timing parameter"
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, linux-spi@vger.kernel.org,
        enric.balletbo@collabora.com, dafna3@gmail.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20210930120700.2564-1-dafna.hirschfeld@collabora.com>
 <20210930122513.GX4199@sirena.org.uk>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <28f8af42-4535-ef9f-e521-712d37e2cb72@collabora.com>
Date:   Thu, 30 Sep 2021 14:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930122513.GX4199@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

hi, thanks for the fast feedback

On 30.09.21 14:25, Mark Brown wrote:
> On Thu, Sep 30, 2021 at 02:07:00PM +0200, Dafna Hirschfeld wrote:
>> This reverts commit 04e6bb0d6bb127bac929fb35edd2dd01613c9520.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
> 
>> This revert the commit 'spi: modify set_cs_timing parameter'
>> and its following commit
>> 'spi: mediatek: fix build warnning in set cs timing'.
> 
> Which is not what the commit message nor the paste of the full hash
> claimed :/

What is the paste of the full hash?
Since the second commit is only a warning fixes I thought it is cumbersome to
send two separate reverting patches. Should I?

> 
>> Those commits cause regression on mt8173 elm device. The EC either is not
>> able to register or it sends numerous amount of errors:
> 
>> cros-ec-i2c-tunnel 1100a000.spi:ec@0:i2c-tunnel0: Error transferring EC i2c message -71
>> cros-ec-spi spi0.0: EC failed to respond in time.
> 
> Do we have any analysis as to why?  Do these devices use timing
> parameters in some way for example, or do the values written out to the
> device change in some way?
> 
> You've provided no analysis here so it's hard to tell if this is just
> some random change that happens to change code generation slighly or if
> there's some actual reason why this might fix something.  I'll note that
> as far as I can see there are no users of this API upstream so I'm
> guessing that you've got some out of tree consumer driver which uses the
> API, it's possible that there was some error in updating that driver to
> the new interface which is causing the issue.

Actually the original commit not only change that callback 'set_cs_timing' but it also
calls 'mtk_spi_set_hw_cs_timing' directly from the function "mtk_spi_prepare_message".
So this actually influences all devices bound to this driver (in upstream)
I did some printing and it does change values that are written to registers.

Thanks,
Dafna


> 
