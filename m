Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470324BE617
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiBURFw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 12:05:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiBURFw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 12:05:52 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99325EA2
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 09:05:26 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id EE35A839E8;
        Mon, 21 Feb 2022 18:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1645463122;
        bh=MSz97Ok2WcDikqXWZWabTtGV8Oe9JZS2xZ315ZdOTVo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YUnfGvC+LR45xGtajmGM2V12xy//bDbIODRdJ5DEcau/moms4m2IBnISnKAYieNNp
         Nk+lT3F2zgjPD3L/ARLKVzkbIhfrNaXY8302bvrTnP1osz2V416jFoIHvR1By5xYKU
         Ro/JzRExUoF1g5CFEN5pUrU2FE/PhC34aa7G9y/PijB6CwudL+H40T/Zuwp7Hb0UmC
         SeWG4zEn5xcRLGafdngTyRciKvsfj3sTDkM6UD2L5kz4p/BWEZQCde44wZoewed7Ib
         cXKzfu40tQG83Un5llr2wAJ3P57fkMlsUy4Xg6tGjmV8dCE1W2cxetg+ksqD6QSIGV
         TS0WBmH7Lsxog==
Message-ID: <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
Date:   Mon, 21 Feb 2022 18:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
 <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
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

On 2/21/22 17:38, Dinh Nguyen wrote:
> 
> 
> On 2/20/22 22:32, Marek Vasut wrote:
>> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
>> leads to data abort, disable DAC to avoid triggering it:
>>
>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>> [0400d3e9] *pgd=00000000
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>> b/drivers/spi/spi-cadence-quadspi.c
>> index b808c94641fa6..65f2c2449be09 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata 
>> intel_lgm_qspi = {
>>   };
>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>> +    .quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
>>   };
>>   static const struct cqspi_driver_platdata versal_ospi = {
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Is this DAC really not working on socfpga gen5 or is there some other 
issue ?
