Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E335DF9B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhDMM7g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 08:59:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3399 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbhDMM7Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Apr 2021 08:59:25 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FKQZz15JVz5pg0;
        Tue, 13 Apr 2021 20:56:11 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 13
 Apr 2021 20:59:03 +0800
Subject: Re: [PATCH] spi: SPI_HISI_KUNPENG should depend on ARCH_HISI
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Wei Xu <xuwei5@hisilicon.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huangdaode@huawei.com>
References: <d93934dfdbb4d35e35371517de3b64c144aeb5ef.1618316782.git.geert+renesas@glider.be>
 <20210413124715.GE5586@sirena.org.uk>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <46a47db2-338e-2ca4-0eac-c2b129ee7b7d@huawei.com>
Date:   Tue, 13 Apr 2021 20:59:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210413124715.GE5586@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/4/13 20:47, Mark Brown wrote:
> On Tue, Apr 13, 2021 at 02:27:23PM +0200, Geert Uytterhoeven wrote:
>> The HiSilicon Kunpeng SPI controller is only present on HiSilicon
>> Kunpeng SoCs.  Hence add a dependency on ARCH_HISI, to prevent asking
>> the user about this driver when configuring a kernel without Hisilicon
>> platform support.
> 
> Are you *sure* about this?  HiSilicon produce a wide range of SoCs with
> very diverse target markets, this driver looks like it's for enterprise
> stuff while most things guarded by that config option look like they're
> for embedded applications.
SPI_HISI_KUNPENG does not depend on ARCH_HISI.


Thanks,
Jay



