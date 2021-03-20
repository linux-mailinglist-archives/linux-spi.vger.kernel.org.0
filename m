Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37EC342C82
	for <lists+linux-spi@lfdr.de>; Sat, 20 Mar 2021 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTLum (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 20 Mar 2021 07:50:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3910 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhCTLuM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 20 Mar 2021 07:50:12 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F2bRC1pDgz5dxh;
        Sat, 20 Mar 2021 17:43:03 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Sat, 20
 Mar 2021 17:44:58 +0800
Subject: Re: [PATCH V2] spi: Add HiSilicon SPI Controller Driver for Kunpeng
 SoCs
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>,
        <linuxarm@huawei.com>
References: <1616061024-57818-1-git-send-email-f.fangjian@huawei.com>
 <20210318132821.GH5469@sirena.org.uk>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <49383980-62e4-08b2-f594-e00abab44749@huawei.com>
Date:   Sat, 20 Mar 2021 17:44:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210318132821.GH5469@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dear Mark,

On 2021/3/18 21:28, Mark Brown wrote:
> On Thu, Mar 18, 2021 at 05:50:24PM +0800, Jay Fang wrote:
> 
>> Changes in v2:
>> - Use a more specific name (Kunpeng SoCs) for this driver.
> 
>>  drivers/spi/spi-hisi.c | 505 +++++++++++++++++++++++++++++++++++++++++++++++++
> 
>> +config SPI_HISI
>> +	tristate "HiSilicon SPI Controller for Kunpeng SoCs"
> 
> You've changed the display name for the driver but the Kconfig symbol
> and filename are still very generic - can you update them as well
> please?
> 
Will change.

Thanks

> Otherwise this looks good.
> 


