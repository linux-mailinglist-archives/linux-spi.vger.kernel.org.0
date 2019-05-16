Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34420821
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEPN2A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 09:28:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbfEPN2A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 May 2019 09:28:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 100A1A62E0E2FA847E79;
        Thu, 16 May 2019 21:27:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 21:27:53 +0800
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master
To:     Mark Brown <broonie@kernel.org>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
 <20190516095148.GA5598@sirena.org.uk>
CC:     <axel.lin@ingics.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <albeu@free.fr>,
        <lorenzo.bianconi@redhat.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <0569fc4c-c6b0-4971-f6f7-800084fb1824@huawei.com>
Date:   Thu, 16 May 2019 21:27:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190516095148.GA5598@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2019/5/16 17:51, Mark Brown wrote:
> On Thu, May 16, 2019 at 03:56:56PM +0800, YueHaibing wrote:
> 
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>> Call Trace:
>>  dump_stack+0xa9/0x10e
>>  ? __list_del_entry_valid+0x45/0xd0
>>  ? __list_del_entry_valid+0x45/0xd0
>>  __kasan_report+0x171/0x18d
>>  ? __list_del_entry_valid+0x45/0xd0
>>  kasan_report+0xe/0x20
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

Thanks, got it.

> 

