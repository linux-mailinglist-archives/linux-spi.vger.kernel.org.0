Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDD3306AE
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 04:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhCHD5l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 7 Mar 2021 22:57:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:3293 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhCHD5Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 7 Mar 2021 22:57:24 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Dv4GX4m1xz142kb;
        Mon,  8 Mar 2021 11:54:28 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 8 Mar
 2021 11:57:18 +0800
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
To:     Lukas Wunner <lukas@wunner.de>
CC:     <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
        <huangdaode@huawei.com>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210307143636.GA10974@wunner.de>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <331fa0f5-7052-0dac-e375-df25789c56b6@huawei.com>
Date:   Mon, 8 Mar 2021 11:57:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210307143636.GA10974@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/3/7 22:36, Lukas Wunner wrote:
> On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
>> +static int hisi_spi_setup(struct spi_device *spi)
>> +{
>> +	struct hisi_spi *hs = spi_controller_get_devdata(spi->controller);
>> +	struct hisi_chip_data *chip;
>> +
>> +	/* Only alloc on first setup */
>> +	chip = spi_get_ctldata(spi);
>> +	if (!chip) {
>> +		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>> +		if (!chip)
>> +			return -ENOMEM;
>> +		spi_set_ctldata(spi, chip);
>> +	}
> [...]
>> +	master = devm_spi_alloc_master(dev, 0);
> 
> It would seem simpler to just pass "sizeof struct hisi_chip_data"
> to devm_spi_alloc_master(), thus obviating the need to allocate
> it on first incocation of the ->setup hook.
> 
Hi Lukas,

Thanks for your review. "struct hisi_chip_data" is the private data
of per-spi device, not the spi controller. So I think this method
is not suitable here. Maybe we can allocate "struct hisi_spi" in
this way.


Thanks
Jay



