Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6EB14EC2B
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2020 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAaMDX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jan 2020 07:03:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2337 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728374AbgAaMDW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jan 2020 07:03:22 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2C79BC846AEEC4B266A4;
        Fri, 31 Jan 2020 12:03:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 12:03:20 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 12:03:20 +0000
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, <chenxiang66@hisilicon.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <liusimin4@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        <tudor.ambarus@microchip.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <fengsheng5@huawei.com>
References: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk>
 <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk>
 <20200113143403.GQ32742@smile.fi.intel.com>
 <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com>
 <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <136bd652-dcb9-3efa-a92f-2263cbf840ad@huawei.com>
Date:   Fri, 31 Jan 2020 12:03:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 31/01/2020 11:39, Andy Shevchenko wrote:
> On Fri, Jan 31, 2020 at 12:08 PM John Garry <john.garry@huawei.com> wrote:
>>
>> On 13/01/2020 14:34, Andy Shevchenko wrote:
>>> On Mon, Jan 13, 2020 at 02:27:54PM +0000, Mark Brown wrote:
>>>> On Mon, Jan 13, 2020 at 04:17:32PM +0200, Andy Shevchenko wrote:
>>>>> On Mon, Jan 13, 2020 at 4:07 PM Mark Brown <broonie@kernel.org> wrote:
>>>>>> On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
>>>>>>> On 13/01/2020 11:42, Mark Brown wrote:
>>>>
>>>>>>>> The idiomatic approach appears to be for individual board vendors
>>>>>>>> to allocate IDs, you do end up with multiple IDs from multiple
>>>>>>>> vendors for the same thing.
>>>>
>>>>>>> But I am not sure how appropriate that same approach would be for some 3rd
>>>>>>> party memory part which we're simply wiring up on our board. Maybe it is.
>>>>
>>>>>> It seems to be quite common for Intel reference designs to assign
>>>>>> Intel IDs to non-Intel parts on the board (which is where I
>>>>>> became aware of this practice).
>>>>
>>>>> Basically vendor of component in question is responsible for ID, but
>>>>> it seems they simple don't care.
>>>>
>>>> AFAICT a lot of the time it seems to be that whoever is writing
>>>> the software ends up assigning an ID, that may not be the silicon
>>>> vendor.
>>>
>>> ...which is effectively abusing the ACPI ID allocation procedure.
>>>
>>> (And yes, Intel itself did it in the past — see badly created ACPI IDs
>>>    in the drivers)
>>>
>>
>> Hi Mark,
>>

Hi Andy,

>> About this topic of ACPI having no method to describe device buswidth in
>> the resource descriptor, it may be an idea for me to raise a Tianocore
>> feature request @ https://bugzilla.tianocore.org/
>>
> 
> The 19.6.126 describes the SPI resource, in particular:
> 
> ---8<---8<---
> DataBitLength is the size, in bits, of the smallest transfer unit for
> this connection. _LEN is automatically
> created to refer to this portion of the resource descriptor.
> ---8<---8<---
> 
> Is it what you are looking for? (As far as I know most of the
> firmwares simple abuse this field among others)

I didn't think so - I thought that there was a distinction between width 
and length in SPI terms.

So how do you find that most firmwares abuse this field? AFAICS, linux 
kernel doesn't interpret this field at all.

> 
>> There seems to be an avenue there for raising new features for the spec.
>> I (or my org) can't participate in AWSG.
> 
> But have you read 19.6.126?
> 

Maybe some clarification at least could be achieved :)

Cheers,
John
