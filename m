Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2D34DD44
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 02:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC3AxL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 20:53:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14949 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhC3AxK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 20:53:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8W8l0zXvzrbfD;
        Tue, 30 Mar 2021 08:51:03 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 08:53:01 +0800
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
To:     Mark Brown <broonie@kernel.org>, Tian Tao <tiantao6@hisilicon.com>
CC:     <linux-spi@vger.kernel.org>
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
Date:   Tue, 30 Mar 2021 08:53:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210329152157.GB5166@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/3/29 23:21, Mark Brown 写道:
> On Mon, Mar 29, 2021 at 04:58:36PM +0800, Tian Tao wrote:
>
>> +	spi_data = (struct davinci_spi_of_data *)
>> +			of_device_get_match_data(&pdev->dev);
>> +	if (!spi_data)
> If we need to cast away from void * that's most likely pointing at a
> bug.

Even with of_match_device, there is still a type conversion，as follows

spi_data = (struct davinci_spi_of_data *)match->data;

Using of_device_get_match_data instead of of_match_device doesn't look 
like a problem from the code, other spi drivers do the same thing


