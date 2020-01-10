Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A222B137072
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgAJO66 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 09:58:58 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728137AbgAJO66 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 09:58:58 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 02E66D8DC01B37666DED;
        Fri, 10 Jan 2020 14:58:56 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Jan 2020 14:58:55 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jan
 2020 14:58:55 +0000
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     Mark Brown <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <xuejiancheng@hisilicon.com>,
        <fengsheng5@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <liusimin4@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
Date:   Fri, 10 Jan 2020 14:58:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200110140726.GB5889@sirena.org.uk>
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

On 10/01/2020 14:07, Mark Brown wrote:

+ Mika, Andy

> On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >
Hi Mark,

>> I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
>> defacto method to describe the SPI NOR-compat part for ACPI - that's what
>> I'm using. We could add properties there, but that seems improper.
> 
> OK, so that's just reusing the DT binding in which case everything
> that's valid for the DT binding should also be valid for ACPI - I
> thought that actually worked automatically without you having to do
> anything in the code but ICBW.

I thought that it would be improper as we could be mixing ACPI methods 
to describe the serial bus (SPI Serial Bus Connection Resource 
Descriptor) and also DT properties which could conflict, like CS active 
high.

However I do see extra properties than "compatible" being added in DSD 
for PRP0001:
https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)

And if we were to do this, I think that we would need to add some 
device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI 
FW parsing for ACPI path - I couldn't see that.

Thanks,
John
