Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9407C4BFD71
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 16:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiBVPtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 10:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiBVPtq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 10:49:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1557A40A20
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 07:49:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9FB0616A6
        for <linux-spi@vger.kernel.org>; Tue, 22 Feb 2022 15:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBAAC340E8;
        Tue, 22 Feb 2022 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645544960;
        bh=BsW03FpKV3fK6Sf+1f0i1qDmCs2WQGza4qvhy3BBtVU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g1Vk3Vxt4tN28+YOqky77EkI+Gi3yD87lClcyq7vVXVDH/snettpn4vAunmJwha1m
         DPJH4sPAP8RBkElVvD/52OQ1hW/50Bb+YiwN3O885KvwqwWrg9KdTiti8mIBP5nF1C
         TrE9BPIurM4kXDO8qVA++u4PLrDDt2HzTCy69UCla14yubqfHDa/Twjq01UaCydAVS
         BNkuOTJqTgMSiQORjPWDEkasjUlJYmOUh2nqyOw269n9CW/nAHkPklFgLSStxpTmTw
         G3UNSFRB33NWUk2tH72CkVRJUWHj0bVLzqtuB6jISNBx4g8KVyn+o9LhXHUu12nHRs
         0qn16atUTlZiQ==
Message-ID: <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
Date:   Tue, 22 Feb 2022 09:49:18 -0600
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
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
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



On 2/21/22 11:05, Marek Vasut wrote:
> On 2/21/22 17:38, Dinh Nguyen wrote:
>>
>>
>> On 2/20/22 22:32, Marek Vasut wrote:
>>> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
>>> leads to data abort, disable DAC to avoid triggering it:
>>>
>>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>>> [0400d3e9] *pgd=00000000
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>> ---
>>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>>> b/drivers/spi/spi-cadence-quadspi.c
>>> index b808c94641fa6..65f2c2449be09 100644
>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata 
>>> intel_lgm_qspi = {
>>>   };
>>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>>> +    .quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>   };
>>>   static const struct cqspi_driver_platdata versal_ospi = {
>>
>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> 
> Is this DAC really not working on socfpga gen5 or is there some other 
> issue ?

I don't know the answer to this question. What is the DAC in the QSPI 
module and how do I go about testing it?

Dinh
