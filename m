Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2D35A104
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhDIO2f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 10:28:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2826 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhDIO2f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 10:28:35 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FH0c45dkkz687Sl;
        Fri,  9 Apr 2021 22:18:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 16:28:21 +0200
Received: from [10.47.1.29] (10.47.1.29) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 15:28:20 +0100
Subject: Re: [PATCH 2/2] spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and
 related ifendif protection
To:     Yicong Yang <yangyicong@hisilicon.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
References: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
 <1617881505-51552-3-git-send-email-yangyicong@hisilicon.com>
 <20210408135155.GG4516@sirena.org.uk>
 <26fad983-9e06-333c-c1b9-332c6acfddfa@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3869ef5f-eda6-907d-7565-29ae0bbf5dd0@huawei.com>
Date:   Fri, 9 Apr 2021 15:25:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <26fad983-9e06-333c-c1b9-332c6acfddfa@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.29]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/04/2021 08:17, Yicong Yang wrote:
> On 2021/4/8 21:51, Mark Brown wrote:
>> On Thu, Apr 08, 2021 at 07:31:45PM +0800, Yicong Yang wrote:
>>> The ACPI_PTR() and related IS_ENABLED(CONFIG_ACPI) protection is
>>> redundant, so drop them.
>>
>> The driver supports building without ACPI so are you sure these are
>> redundant?
>>
> 
> yes. we're not using any acpi function in this driver. What ifdef macro
> and ACPI_PTR() protects is struct acpi_device_id, which is defined in
> mod_devicetable.h rather than acpi.h. It can be built when ACPI=n.
> 

I asked the exact same thing, so another version with an updated commit 
message with this info could be useful. Mark's call, though.

Thanks,
John

> some similiar cleanups can be found:
> 6c328c347ac3 ("platform/x86: i2c-multi-instantiate: Drop redundant ACPI_PTR()")
> 846afc1dbcbf ("iio: accel: bma220: Drop ACPI_PTR() and accompanying ifdeffery")
> [...]
> 
> Thanks,
> Yicong
> 
> .
> 

