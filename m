Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5FF14632E
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 09:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWISE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 03:18:04 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60366 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgAWISE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Jan 2020 03:18:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00N8Hvc6104101;
        Thu, 23 Jan 2020 02:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579767477;
        bh=Yq3CCzVfMMdSjd8t5z7D+2+x4mCzx46IDjOwWPCACHQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WC0+SCrj2KtrN+v9dQAQL+yBP+pK82VS4kRN1iFE5MCViXWPnndv81QktT/Y+fFCt
         NhEeHkF9wLqMcyrijuPpw+qqMyTkCX8Gzi20YnF/oKgZBEu5jUMHE60Fylb+2Fzi9n
         rmQOqgcw5t0UZ7RKW9lo5r74SCfEkpsfZZ2/Op2E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00N8Hvf0009120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 02:17:57 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 02:17:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 02:17:57 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N8HoOF033025;
        Thu, 23 Jan 2020 02:17:52 -0600
Subject: Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <1aa6033a-c9e1-579b-0916-25037c07654d@linux.intel.com>
 <3118e6d5-84f3-cbcf-6a42-761b0d23cb72@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1b9d00c5-82c4-3dc7-960f-5077040626ae@ti.com>
Date:   Thu, 23 Jan 2020 13:48:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3118e6d5-84f3-cbcf-6a42-761b0d23cb72@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 21/01/20 5:17 pm, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> On 15/1/2020 2:21 PM, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>> On 15/1/2020 2:13 PM, Vignesh Raghavendra wrote:
>>> Hi,
>>>
>>> On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
>>>> Add support for the Cadence QSPI controller. This controller is
>>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>>> This driver has been tested on the Intel LGM SoCs.
>>>>
>>>> This driver does not support generic SPI and also the implementation
>>>> only supports spi-mem interface to replace the existing driver in
>>>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>>>> flash memory.
>>>>
>>>
>>>
>>> I am finally able to get spi-mem based cadence-quaspi driver working on
>>> TI platforms with DMA and DAC mode. I have also incorporated changes to
>>> disable DAC and autopolling for your intel SoC:
>>
>> Thanks! a lot for the confirmation, with your changes it is working on
>> TI platform.
>>
>>> https://github.com/r-vignesh/linux/commits/qspi
>>>
>>> (Top two patches are of interest)
>>>
>>> I have tested both DAC and INDAC mode with s25fl flash and everything
>>> seems to be fine. Could you re test the driver on your SoC? 
> 
> while re-testing QSPI_NOR/NAND both didn't work, after few changes from
> patchV6 followed by your changes,
> 
> now QSPI-NOR started working,  soon will be sending updated patch
> version which includes your changes as well as my changes
> 
> without affecting both the platforms(TI and Intel).
> 
> BTW,  Have you tested QSPI-NAND on your platform ? with our patches.

No, I don't have a platform with QSPI-NAND.

Regards
Vignesh

