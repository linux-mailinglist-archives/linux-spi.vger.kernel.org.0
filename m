Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B4136C82
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 12:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgAJLzm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 06:55:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbgAJLzl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 06:55:41 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id AFF0FA5C9FD9699058BD;
        Fri, 10 Jan 2020 11:55:39 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Jan 2020 11:55:39 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jan
 2020 11:55:39 +0000
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     Mark Brown <broonie@kernel.org>
CC:     <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
Date:   Fri, 10 Jan 2020 11:55:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200109212842.GK3702@sirena.org.uk>
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

On 09/01/2020 21:28, Mark Brown wrote:
> On Thu, Jan 09, 2020 at 03:54:00PM +0000, John Garry wrote:
> 
>>  From checking acpi_spi_add_resource() or anywhere else, I cannot see how
>> SPI_RX_DUAL or the others are set for spi_device.mode. What am I missing?
>> Are these just not supported yet for ACPI? Or should the spi-nor code not be
>> relying on this since we should be able to get this info from the SPI NOR
>> part?
> 

Hi Mark,

> I'm not aware of any work on integrating this sort of stuff into ACPI
> platforms so I think it's just not yet supported in ACPI.  I'm not
> really sure what would be idiomatic for ACPI, figuring it out from what
> the part supports might well be idiomatic there though I don't know how
> common it is for people not to wire up all the data lines even if both
> controller and device support wider transfers. 

OK, so I guess that is why we require the width property from the FW and 
can't blindly rely on SFDP.

  I've got a horrible
> feeling that the idiomatic thing is a combination of that and a bunch of
> per-device quirks.  There may be a spec I'm not aware of though I'd be a
> bit surprised.
> 

I'm not sure on that. I don't see anything in the ACPI spec.

I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the 
defacto method to describe the SPI NOR-compat part for ACPI - that's 
what I'm using. We could add properties there, but that seems improper.

I'll continue to look....

Thanks,
John
