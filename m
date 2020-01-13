Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE56D139191
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 14:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAMNBJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 08:01:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727289AbgAMNBJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Jan 2020 08:01:09 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 18EF8C44A31786DBE467;
        Mon, 13 Jan 2020 13:01:08 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 13 Jan 2020 13:01:07 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jan
 2020 13:01:07 +0000
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     Mark Brown <broonie@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <xuejiancheng@hisilicon.com>,
        <fengsheng5@huawei.com>,
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
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
Date:   Mon, 13 Jan 2020 13:01:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200113114256.GH3897@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
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

On 13/01/2020 11:42, Mark Brown wrote:
> On Mon, Jan 13, 2020 at 10:09:27AM +0000, John Garry wrote:
>> On 10/01/2020 19:31, Andy Shevchenko wrote:
> 
>>> PRP method is only for vendors to *test* the hardware in ACPI environment.
>>> The proper method is to allocate correct ACPI ID.
> 
>> Yes, that would seem the proper thing to do. So the SPI NOR driver is based
>> on micron m25p80 and compatible string is "jedec,spi-nor", so I don't know
>> who should or would do this registration.
> 

Hi Mark,

> The idiomatic approach appears to be for individual board vendors
> to allocate IDs, you do end up with multiple IDs from multiple
> vendors for the same thing.

So we see sort of approach a lot when vendors integrate 3rd party IP 
into a SoC and then assign some vendor specific ID for that.

But I am not sure how appropriate that same approach would be for some 
3rd party memory part which we're simply wiring up on our board. Maybe 
it is.

> 
>> BTW, Do any of these sensors you mention have any ACPI standardization?
> 
> In general there's not really much standardizaiton for devices,
> the bindings that do exist aren't really centrally documented and
> the Windows standard is just to have the basic device
> registration in the firmware and do all properties based on
> quirking based on DMI information.
> 

OK, so there is always DMI. I hoped to avoid this sort of thing in the 
linux driver :)

Cheers,
John
