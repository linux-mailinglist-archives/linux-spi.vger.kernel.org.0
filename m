Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161754C03E6
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiBVVd2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 16:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVVd1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 16:33:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863523617C
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 13:33:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2297561793
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 21:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AD9C340E8;
        Tue, 22 Feb 2022 21:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645565580;
        bh=yuWCeOH0unFpupIMxXk4oLAg0HFmr5o3zFa8dyR56c0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sU/Qya5y0P9N1HTYvBMD9n+UsNZY6hfx0yM/4Vzq0nH1XutG/OGjyWjeo82lT6Ovh
         rL4X+rS0GYjfmO2drURIHTmtbf0Nd16/If8rXvqOMlPjG4rerIx3tGYdOlPFrkzHXX
         yEva7AgUT8SG8+r092Ng+8BjT6e9eQ4/xIy4jyKV5U/jiWegccIkdI+qsR81ANPpcN
         jfWm4pfVdEd+LF3/0ONs5rVUauR12ogWI4dPAkgx+r6xwFcnc/6G7GEFYcLrdEt3JQ
         sGcby2E6rQeVqPgjCRJDP2YW1l0V+hCzji+EtdDSM9P2rjT4AxrbU0vx1Npb0khWoc
         lfw9SlF7BBTOw==
Message-ID: <8dc7a7d6-d24f-b3a6-32b9-64cdb8c6f3be@kernel.org>
Date:   Tue, 22 Feb 2022 15:32:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
 <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
 <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
 <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
 <8060ae0e-700e-3b72-3ab9-e7ca8e19ad9e@denx.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <8060ae0e-700e-3b72-3ab9-e7ca8e19ad9e@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/22/22 12:30, Marek Vasut wrote:
> On 2/22/22 16:49, Dinh Nguyen wrote:
>>
>>
>> On 2/21/22 11:05, Marek Vasut wrote:
>>> On 2/21/22 17:38, Dinh Nguyen wrote:
>>>>
>>>>
>>>> On 2/20/22 22:32, Marek Vasut wrote:
>>>>> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
>>>>> leads to data abort, disable DAC to avoid triggering it:
>>>>>
>>>>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>>>>> [0400d3e9] *pgd=00000000
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>>> ---
>>>>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>>>>> b/drivers/spi/spi-cadence-quadspi.c
>>>>> index b808c94641fa6..65f2c2449be09 100644
>>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>>> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata 
>>>>> intel_lgm_qspi = {
>>>>>   };
>>>>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>>>>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>> +    .quirks = CQSPI_DISABLE_DAC_MODE | 
>>>>> CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>   };
>>>>>   static const struct cqspi_driver_platdata versal_ospi = {
>>>>
>>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>>
>>> Is this DAC really not working on socfpga gen5 or is there some other 
>>> issue ?
>>
>> I don't know the answer to this question. What is the DAC in the QSPI 
>> module and how do I go about testing it?
> 
> DAC = direct access.
> 
> How do you go about testing this -- compile kernel with/without this 
> patch, boot on SoCFPGA Gen5 with QSPI NOR attached, the kernel crashes 
> without this patch on imprecise external abort.

Hmm...I just tested v5.17-rc3 on a C5 board and QSPI looks to be working 
fine:

[    1.744489] spi-nor spi1.0: found n25q512ax3, expected mt25qu02g
[    1.750534] dma-pl330 ffe01000.pdma: Reset Channel-0  CS-f FTC-40000
[    1.756941] spi-nor spi1.0: n25q512ax3 (65536 Kbytes)
[    1.762369] 2 fixed-partitions partitions found on MTD device 
ff705000.spi.0
[    1.769425] Creating 2 MTD partitions on "ff705000.spi.0":
[    1.774925] 0x000000000000-0x000000800000 : "Flash 0 Raw Data"
[    1.781942] 0x000000800000-0x000008000000 : "Flash 0 jffs2 Filesystem"
[    1.788468] mtd: partition "Flash 0 jffs2 Filesystem" extends beyond 
the end of device "ff705000.spi.0" -- size truncated to 0x3800000

Dinh
