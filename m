Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603B62C8DD9
	for <lists+linux-spi@lfdr.de>; Mon, 30 Nov 2020 20:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgK3TS7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Nov 2020 14:18:59 -0500
Received: from mxout04.lancloud.ru ([89.108.124.63]:45700 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgK3TS6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Nov 2020 14:18:58 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru CD021206FF58
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH for-5.10] spi: rpc-if: Fix use-after-free on unbind
To:     Lukas Wunner <lukas@wunner.de>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de>
 <9534f4fb-6f5e-b538-6903-e702a7301b1d@omprussia.ru>
 <20201129113548.GA2587@wunner.de>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <31f68249-2499-7ca6-9804-aad39e94b3b6@omprussia.ru>
Date:   Mon, 30 Nov 2020 22:18:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201129113548.GA2587@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.150.93]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/29/20 2:35 PM, Lukas Wunner wrote:

>>> rpcif_spi_remove() accesses the driver's private data after calling
>>> spi_unregister_controller() even though that function releases the last
>>> reference on the spi_controller and thereby frees the private data.
>>
>> OK, your analysis seems correct (sorry for the delay admitting this :-).
> 
> Thanks!  Is it okay to take this for an Acked-by?

   Not yet. :-)

>> Not sure why spi_unregister_controller() drops the device reference
>> while spi_register_controller() itself doesn't allocate the memory... 
> 
> Yes, that's exactly what I'm trying to move away from with
> devm_spi_alloc_master() (introduced in v5.10-rc5 by 5e844cc37a5c).
> The API as it has been so far has made it really easy to shoot oneself
> in the foot.

   Maybe it needs to be fixed, rather than using the managed device API?

>>> Fix by switching over to the new devm_spi_alloc_master() helper which
>>> keeps the private data accessible until the driver has unbound.
>>
>>    Perhaps the order of the calls in the remove() method could be reversed? 
> 
> I'm not familiar with power management on these Renesas controllers
> but rpcif_disable_rpm() calls pm_runtime_put_sync(), which I assume
> may put the controller to sleep.

   Sigh, that's a stupid typo on my part, being fixed now to pm_runtim_disable()...

> SPI transfers may still be ongoing until spi_unregister_controller()
> returns.  Specifically, this function unbinds and unregisters all
> SPI slaves attached to the controller and the slaves' drivers may
> need to perform SPI transfers to quiesce interrupts on the slaves etc.
> 
> Thus, the correct order is to call spi_unregister_controller() first
> and only then perform further teardown steps.  So the order in
> rpcif_spi_remove() seems correct to me.

   OK. :-)

> The only thing that looks confusing is that rpcif_enable_rpm() calls
> pm_runtime_enable(), whereas rpcif_disable_rpm() calls
> pm_runtime_put_sync().  That looks incongruent.

   Do you need a link to the fix (it a whole patchset of minor fixes)?

> Thanks,
> 
> Lukas

MBR, Sergei
