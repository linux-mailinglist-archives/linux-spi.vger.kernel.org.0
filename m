Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDC610AB6
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJ1Gum (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Oct 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJ1GuV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 02:50:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF81BE432
        for <linux-spi@vger.kernel.org>; Thu, 27 Oct 2022 23:46:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29S6klcZ062303;
        Fri, 28 Oct 2022 01:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666939607;
        bh=VCtpho25tPbljaCVkCTBIp6EEdIZH2Nf/cuzD30AD5E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=trJHXT2Z/3+8FunNLDfjneS6VyPOiaNja0Qq36bIaWA0bp5brHlj8s+7PhdF03MIn
         JqYfaLJjGawkEthygdeFzX2K/W4dzJ8/D7KCzmmh/8mhaYc3aQUKoxueFY/5uxMY8A
         U7LAWEBj+K9EeIXTwCIetmpALgcsDxAUNCt4WA5M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29S6klU1070625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 01:46:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 01:46:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 01:46:46 -0500
Received: from [10.250.234.138] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29S6kiUr017511;
        Fri, 28 Oct 2022 01:46:45 -0500
Message-ID: <32870277-555b-f384-c9e8-2b4225cb2943@ti.com>
Date:   Fri, 28 Oct 2022 12:16:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Re: [PATCH 2/4] spi: intel: Implement adjust_op_size()
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
 <20221025064623.22808-3-mika.westerberg@linux.intel.com>
 <99f962a4-0101-b040-17dc-cec3d877dba8@ti.com>
 <Y1t13q53WbQxDzST@black.fi.intel.com>
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <Y1t13q53WbQxDzST@black.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 10/28/2022 11:55 AM, Mika Westerberg wrote:
> Hi,
>
> On Fri, Oct 28, 2022 at 11:42:09AM +0530, Gole, Dhruva wrote:
>> Hi Mika,
>>
>> On 10/25/2022 12:16 PM, Mika Westerberg wrote:
>>> This allows us to get rid of the checks in the intel_spi_[sh]w_cycle()
>>> and makes it possible for the SPI-NOR core to split the transaction into
>>> smaller chunks as needed.
>> If I understand correctly, the controller ops are called from spi-mem.c, and
>>
>> spi_mem_adjust_op does exist and on it's own does "split a data transfer
>>   operation into multiple ones"
>>
>> So is this really something that you require the controller to do and
>>
>> can we not rely on spi-mem.c to do it's thing instead?
> How does it know the size supported by the hardware? I think this is the
> reason spi_mem_adjust_op was introduced but I may be mistaken.'

The following piece of code might help:

         op->data.nbytes = min3((size_t)op->data.nbytes,
                        spi_max_transfer_size(mem->spi),
                        spi_max_message_size(mem->spi)

I believe this will help it know the size supported by the hardware.

and on the controller side:

in case of cadence I have seen it pickup the fifo depth from DTSI, for eg.

arch/arm64/boot/dts/ti/k3-am62-main.dtsi: cdns,fifo-depth = <256>;

>
>> I would like to point you to another controller spi-cadence-quadspi.c
>>
>> that also doesn't have it's own adjust_op_size but I haven't seen any issues
>> as such
>>
>> inspite. This is because everything first goes through spi-mem.c then onto
>> the controllers drivers.
> Well Intel SPI driver did not not have any issues previously either
> because it handled the read/write split internally but SFDP read is done
> through "register read side" which only supported max 64-byte read until
> now :-)

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

