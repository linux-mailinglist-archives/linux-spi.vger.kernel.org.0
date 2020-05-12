Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5D1CEA13
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 03:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgELBWX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 21:22:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4391 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbgELBWX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 21:22:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 145B24DB18404248E0B4;
        Tue, 12 May 2020 09:22:21 +0800 (CST)
Received: from [10.166.215.142] (10.166.215.142) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 09:22:14 +0800
Subject: Re: [PATCH -next] spi: spi-amd: Remove spi_master_put in
 amd_spi_remove()
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200507115550.139457-1-weiyongjun1@huawei.com>
 <158921769453.22432.2365518895564552869.b4-ty@kernel.org>
 <20200511172920.GJ8216@sirena.org.uk>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <566833d4-23e9-6ab6-e7bb-245678d25ee2@huawei.com>
Date:   Tue, 12 May 2020 09:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511172920.GJ8216@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.142]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/5/12 1:29, Mark Brown wrote:
> On Mon, May 11, 2020 at 06:22:01PM +0100, Mark Brown wrote:
>> On Thu, 7 May 2020 11:55:50 +0000, Wei Yongjun wrote:
>>> The call to spi_master_put() in amd_spi_remove() is redundant and
>>> may causes user after free since the master have been freed by
>>> spi_unregister_master(), so remove it.
>>
>> Applied to
>>
>>    local tree spi/for-5.7
> 
> No it wasn't, sorry for the noise here.
> 

I saw similar patch has been merged, so we do not need this patch any more.

7b9c94bd13cc ("spi: amd: Fix refcount underflow on remove")

Links:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7b9c94bd13cc9dc9c0c4932ebacf756ae612d52a

Regards,
Wei Yongjun
