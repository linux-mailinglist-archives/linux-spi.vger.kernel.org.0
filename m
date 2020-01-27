Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17E1149E7B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2020 05:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgA0EVT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jan 2020 23:21:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44488 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0EVS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Jan 2020 23:21:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00R4L47e048559;
        Sun, 26 Jan 2020 22:21:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580098864;
        bh=0wPXLjmKNP//bAx84i37NKL7d7tEzpelNwIa2cKvRW4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Sjkv/xVdIUqxLoa5NBZcWHdu8LPqsjUgpUyeUvevxcehSgzDIjtK5ITQk8NiDUIA4
         ax5OC/VxdKobTQt0Fb+HpnHVR2/BwVZS2tQ1BDBm+e8NMF9oEA2JcH9IvD6Bp0eHNc
         8pkk/WZlke/4NbRhiSm9TmlY2C3agjatsX7zs8Wk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00R4L4ck001425;
        Sun, 26 Jan 2020 22:21:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 26
 Jan 2020 22:21:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 26 Jan 2020 22:21:03 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00R4L0oJ074810;
        Sun, 26 Jan 2020 22:21:01 -0600
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
 <40ee10f1-0b30-155c-c165-1baa57a22109@ti.com>
 <AM6PR0402MB35573B2313C7FB81D747ABA6E00F0@AM6PR0402MB3557.eurprd04.prod.outlook.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3afe0dde-02f7-8f75-4410-efbdb5f91499@ti.com>
Date:   Mon, 27 Jan 2020 09:51:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <AM6PR0402MB35573B2313C7FB81D747ABA6E00F0@AM6PR0402MB3557.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 23/01/20 5:07 pm, Kuldeep Singh wrote:
> Hi Vignesh,
> 
[...]
>> I did test with s25fl512s with UBIFS and did not see any issue. 
> 
> Thanks Vignesh for this confirmation.
> 
>> Could you try with latest linux master or linux next? There were couple of fixes in the last -rc
>> related to spansion flashes?
> 
> Yes, I have already applied those patches and still facing this issue.
> I am testing with s25fs512s and only able to make it work on 1bit mode and that too by skipping SFDP.

Hmm, why would you need to skip SFDP parsing in 1 bit mode? What
actually fails when SFDP is parsed? Read/write/erase? BTW, did s25fs512s
flash ever with you controller before (i.e is this a regression)?

> Basic read/write works on other modes but not FS utilities.
> Could you please share any pointer to look into which direction. Thanks in advance.
> 

If 1 bit mode works fine, then probably flash FS in 1 bit mode and they
try read only mount in quad mode. Thus try and narrow down if the issue
is in read path vs write path.

Regards
Vignesh

> Thanks
> Kuldeep
> 
>>
>> [1]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
>> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmtd%2Flinux.git%2Fcommit
>> %2F%3Fh%3Dmtd%2Ffixes%26id%3D440b6d50254bdbd84c2a665c7f53ec69dd
>> 741a4f&amp;data=02%7C01%7Ckuldeep.singh%40nxp.com%7Cee345bdf9f654
>> 4ac9f4508d79fd863d9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
>> C637153624041330774&amp;sdata=OyKGl2jn5JDq5KCaVrxAnUh4qSynmAhS%
>> 2FeFiOxJSKtU%3D&amp;reserved=0
>> [2]https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
>> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmtd%2Flinux.git%2Fcomm
>> it%2F%3Fh%3Dmtd%2Ffixes%26id%3Dda2ef8124f20b4ce18d1d3d24fc7b88e68
>> 7e10bb&amp;data=02%7C01%7Ckuldeep.singh%40nxp.com%7Cee345bdf9f65
>> 44ac9f4508d79fd863d9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
>> 7C637153624041330774&amp;sdata=BTRzWWY2z6nZncyktDDIdJFwYTp41S%2
>> Buh99QaJ60e1M%3D&amp;reserved=0
>>
>>> Thanks
>>> Kuldeep
>>>
>>>>
>>>> Regards
>>>> Vignesh
>>>>
>>>>
>>>
>>
>> --
>> Regards
>> Vignesh

-- 
Regards
Vignesh
