Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891BF4C014F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 19:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiBVSbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 13:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiBVSbA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 13:31:00 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56DEFF99
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 10:30:34 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 909CE82133;
        Tue, 22 Feb 2022 19:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1645554631;
        bh=RG7G/4yRq2MgeSa72YQHUwoZ6w+iE30qGeH5RtbZkvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zM0ErT2XDjL6MAyXaFydSAcOYL9oSRYQ5KxMaXMal6Q31qwyEofpuZs4p0rlaxAHy
         8DlVdRwz3HfgU70hKl5GCdydx8cy5mabTZeaZU+gdopcy75k97/ELJWDrdqbL1eVMC
         bQBGi0M55NsffH4MHw2yfBHM136lZczmO+hxW0JWjsAzphhlLCRb4WLousvjNKrAvB
         gxM9Ye7TNwqxLsmkUCZ6VV1vilLawbieqkmk6wjSC1GKMdoZWyohrwJkX2CrSxV5qg
         Vvj3sZOK0EVyQ0RwDVOLShG8Jgf3DP0irsg+y8oXNVZZzATxSiC01v19teRqZ8xc0u
         mIO5pESenoPTQ==
Message-ID: <8060ae0e-700e-3b72-3ab9-e7ca8e19ad9e@denx.de>
Date:   Tue, 22 Feb 2022 19:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
 <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
 <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
 <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/22/22 16:49, Dinh Nguyen wrote:
> 
> 
> On 2/21/22 11:05, Marek Vasut wrote:
>> On 2/21/22 17:38, Dinh Nguyen wrote:
>>>
>>>
>>> On 2/20/22 22:32, Marek Vasut wrote:
>>>> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
>>>> leads to data abort, disable DAC to avoid triggering it:
>>>>
>>>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>>>> [0400d3e9] *pgd=00000000
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>> ---
>>>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>>>> b/drivers/spi/spi-cadence-quadspi.c
>>>> index b808c94641fa6..65f2c2449be09 100644
>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata 
>>>> intel_lgm_qspi = {
>>>>   };
>>>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>>>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>> +    .quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>   };
>>>>   static const struct cqspi_driver_platdata versal_ospi = {
>>>
>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>
>> Is this DAC really not working on socfpga gen5 or is there some other 
>> issue ?
> 
> I don't know the answer to this question. What is the DAC in the QSPI 
> module and how do I go about testing it?

DAC = direct access.

How do you go about testing this -- compile kernel with/without this 
patch, boot on SoCFPGA Gen5 with QSPI NOR attached, the kernel crashes 
without this patch on imprecise external abort.
