Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE72712BD05
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2019 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfL1IcE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 28 Dec 2019 03:32:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfL1IcE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 28 Dec 2019 03:32:04 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 672594F001B0703750F1;
        Sat, 28 Dec 2019 16:32:00 +0800 (CST)
Received: from [127.0.0.1] (10.57.64.164) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Dec 2019
 16:31:54 +0800
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, fengsheng <fengsheng5@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20191227002239.GH27497@sirena.org.uk>
From:   kongxinwei <kong.kongxinwei@hisilicon.com>
Message-ID: <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
Date:   Sat, 28 Dec 2019 16:31:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191227002239.GH27497@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.64.164]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2019/12/27 8:22, Mark Brown wrote:
> On Thu, Dec 26, 2019 at 05:21:28PM +0800, Xinwei Kong wrote:
>> this patch will add memory barrier to ensure this "struct dw_spi *dws"
>> to complete data setting before enabling this SPI hardware interrupt.
>> eg:
>> it will fix to this following low possibility error in testing environment
>> which using SPI control to connect TPM Modules
> 
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -288,6 +288,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>>  	dws->rx_end = dws->rx + transfer->len;
>>  	dws->len = transfer->len;
>>  
>> +	smp_mb();
>> +
>>  	spi_enable_chip(dws, 0);
> 
> I'd be much more comfortable here if I understood what this was
> supposed to be syncing - what exactly gets flushed here and why
> is a memory barrier enough to ensure it's synced?  A comment in
> the code would be especially good so anyone modifying the code
> understands this in future.
> 
Because of out-of-order execution about some CPU architecture,
In this debug stage we find Completing spi interrupt enable ->
prodrucing TXEI interrupt -> running "interrupt_transfer" function
will prior to set "dw->rx and dws->rx_end" data, so it will result
in SPI sending error

