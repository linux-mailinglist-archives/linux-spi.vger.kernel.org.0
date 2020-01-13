Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479DF138E91
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 11:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAMKJc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 05:09:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgAMKJc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Jan 2020 05:09:32 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BFBAD38E1CB5CD72FF0D;
        Mon, 13 Jan 2020 10:09:30 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 13 Jan 2020 10:09:30 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jan
 2020 10:09:29 +0000
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Brown <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, <chenxiang66@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-spi@vger.kernel.org>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <liusimin4@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
Date:   Mon, 13 Jan 2020 10:09:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200110193119.GI32742@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/01/2020 19:31, Andy Shevchenko wrote:
> On Fri, Jan 10, 2020 at 02:58:54PM +0000, John Garry wrote:
>> On 10/01/2020 14:07, Mark Brown wrote:
>>> On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >
> 
> ...
> 
>>>> I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
>>>> defacto method to describe the SPI NOR-compat part for ACPI - that's what
>>>> I'm using. We could add properties there, but that seems improper.
>>>
>>> OK, so that's just reusing the DT binding in which case everything
>>> that's valid for the DT binding should also be valid for ACPI - I
>>> thought that actually worked automatically without you having to do
>>> anything in the code but ICBW.
>>
>> I thought that it would be improper as we could be mixing ACPI methods to
>> describe the serial bus (SPI Serial Bus Connection Resource Descriptor) and
>> also DT properties which could conflict, like CS active high.
>>
>> However I do see extra properties than "compatible" being added in DSD for
>> PRP0001:
>> https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)
> 

Hi Andy,

> PRP method is only for vendors to *test* the hardware in ACPI environment.
> The proper method is to allocate correct ACPI ID.

Yes, that would seem the proper thing to do. So the SPI NOR driver is 
based on micron m25p80 and compatible string is "jedec,spi-nor", so I 
don't know who should or would do this registration.

> 
> Properties (_DSD in ACPI) may be used in the same way as for DT if we have no
> other means in ACPI specification for them.
> 
>> And if we were to do this, I think that we would need to add some
>> device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI FW
>> parsing for ACPI path - I couldn't see that.
> 
> It's okay as long as you have ACPI ID.

Well there is none AFAIK.

> 
> P.S. Most of the sensor drivers were updated in order to support ACPI PRP
> method due to DIY hobbyist on IoT sector and embedded devices. This should not
> be an official way how we support hardware on ACPI-based platforms.

Yeah, so we could do this. But, as I mentioned already, this could mean 
that we conflicting properties. For this the kernel driver prob should 
only pay attention to properties which ACPI cannot describe.

Even better would be to update the ACPI spec, especially for something 
general like SPI bus width

BTW, Do any of these sensors you mention have any ACPI standardization?

Thanks,
John
