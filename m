Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1841462D5
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 08:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWHqq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 02:46:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWHqq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Jan 2020 02:46:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00N7kb5G072953;
        Thu, 23 Jan 2020 01:46:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579765597;
        bh=k2ZMVkvCNf/Gfser3QIkUsbMUcA2ylnSbCBWpeJbj8g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V88w8LBki/lQMA2Vpahcoa8g28fnHSTcwPz4tcMxf/QK+e/o5PchB6Y8rIulpxN91
         Mwj6D8e+pZUPlGHhH07RGtSQcqaNRaL8QjsHOCj1jA5CWa4E63ipFDGq5OG59ojdji
         BKh5yaeLtAxvmCHN5U0aP4eTrtVjGwi7xEswEgQE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N7kb3C121133;
        Thu, 23 Jan 2020 01:46:37 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 01:46:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 01:46:37 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N7kXrc046191;
        Thu, 23 Jan 2020 01:46:34 -0600
Subject: Re: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for
 the Cadence QSPI controller
To:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <40ee10f1-0b30-155c-c165-1baa57a22109@ti.com>
Date:   Thu, 23 Jan 2020 13:17:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 23/01/20 12:54 pm, Kuldeep Singh wrote:
> Hi Vignesh,
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> owner@vger.kernel.org> On Behalf Of Vignesh Raghavendra
>> Sent: Wednesday, January 15, 2020 11:43 AM
>> To: Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com>; broonie@kernel.org; linux-
>> spi@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: robh+dt@kernel.org; dan.carpenter@oracle.com;
>> cheol.yong.kim@intel.com; qi-ming.wu@intel.com
>> Subject: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the
>> Cadence QSPI controller
>>
>> Caution: EXT Email
>>
>> Hi,
>>
>> On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
>>> Add support for the Cadence QSPI controller. This controller is
>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>> This driver has been tested on the Intel LGM SoCs.
>>>
>>> This driver does not support generic SPI and also the implementation
>>> only supports spi-mem interface to replace the existing driver in
>>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support
>>> SPI-NOR flash memory.
>>>
>>
>>
>>
>> I am finally able to get spi-mem based cadence-quaspi driver working on TI
>> platforms with DMA and DAC mode. I have also incorporated changes to
>> disable DAC and autopolling for your intel SoC:
>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.co
>> m%2Fr-
>> vignesh%2Flinux%2Fcommits%2Fqspi&amp;data=02%7C01%7Ckuldeep.singh%
>> 40nxp.com%7Ccbd14ac527ae4298a28808d7998219e6%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C637146656365872638&amp;sdata=jAR7lmry
>> R9fdqF3e4A2dQzF0Q0fYxMvM7sNhx8lvoy0%3D&amp;reserved=0
>>
>> (Top two patches are of interest)
>>
>> I have tested both DAC and INDAC mode with s25fl flash and everything seems
>> to be fine. Could you re test the driver on your SoC? Feel free to fold it into
>> your series if everything works.
> 
> Is JFFS2/UBIFS a valid use case here? And were you able to test the same?
> I see few issues with Spansion flashes (s25fs) in framework and couldn’t make FS utilities run.
> On the other hand, file systems on other flashes (ex: micron, mt25qu) are showing positive results.
> 

I did test with s25fl512s with UBIFS and did not see any issue. Could
you try with latest linux master or linux next? There were couple of
fixes in the last -rc related to spansion flashes?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=mtd/fixes&id=440b6d50254bdbd84c2a665c7f53ec69dd741a4f
[2]https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=mtd/fixes&id=da2ef8124f20b4ce18d1d3d24fc7b88e687e10bb

> Thanks
> Kuldeep
> 
>>
>> Regards
>> Vignesh
>>
>>
> 

-- 
Regards
Vignesh
