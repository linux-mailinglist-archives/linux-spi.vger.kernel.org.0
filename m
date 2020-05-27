Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3041E3EC3
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgE0KQQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 06:16:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387852AbgE0KQP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 06:16:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6C0BB16A13684D21B3BA;
        Wed, 27 May 2020 18:16:13 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 27 May 2020
 18:16:03 +0800
Subject: Re: [RFC PATCH 3/3] spi: hisi-sfc-v3xx: Add prepare/unprepare methods
 to avoid race condition
To:     Boris Brezillon <boris.brezillon@collabora.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
 <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
 <20200526114348.6295df6b@collabora.com>
 <5a3cd626-fb5c-d87c-9cfa-3992caad3ebe@hisilicon.com>
 <20200527112036.69506ed5@collabora.com>
CC:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <john.garry@huawei.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <9c2a2f25-1ae5-229a-d446-ab30c69dd008@hisilicon.com>
Date:   Wed, 27 May 2020 18:16:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200527112036.69506ed5@collabora.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2020/5/27 17:20, Boris Brezillon wrote:
> On Wed, 27 May 2020 16:55:00 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
>
>> Hi Boris,
>>
>>
>> On 2020/5/26 17:43, Boris Brezillon wrote:
>>> On Thu, 21 May 2020 19:23:51 +0800
>>> Yicong Yang <yangyicong@hisilicon.com> wrote:
>>>  
>>>> The controller can be shared with the firmware, which may cause race
>>>> problems. As most read/write/erase/lock/unlock of spi-nor flash are
>>>> composed of a set of operations, while the firmware may use the controller
>>>> and start its own operation in the middle of the process started by the
>>>> kernel driver, which may lead to the kernel driver's function broken.
>>>>
>>>> Bit[20] in HISI_SFC_V3XX_CMD_CFG register plays a role of a lock, to
>>>> protect the controller from firmware access, which means the firmware
>>>> cannot reach the controller if the driver set the bit. Add prepare/
>>>> unprepare methods for the controller, we'll hold the lock in prepare
>>>> method and release it in unprepare method, which will solve the race
>>>> issue.  
>>> Okay, so it looks like what we really need is a way to pass sequences
>>> (multiple operations) that are expected to be issued without
>>> interruptions. I'd prefer extending the spi_mem interface to allow that:
>>>
>>> int spi_mem_exec_sequence(struct spi_mem *spimem,
>>> 			  unsigned int num_ops,
>>> 		  	  const struct spi_mem_op *ops);
>>>
>>> struct spi_controller_mem_ops {
>>> 	...
>>> 	int (*exec_sequence)(struct spi_mem *mem,
>>> 			     unsigned int num_ops,
>>> 			     const struct spi_mem_op *op);
>>> 	...
>>> };  
>> The prepare/unprepare hooks is just like what spi_nor_controller_ops provides.
>> Alternatively we can use the interface you suggested, and it'll require
>> upper layer(spi-nor framework, etc) to pack the operations before call
>> spi_mem_exec_sequence().
> We have to patch the upper layers anyway, right?

sure.

>>> The prepare/unprepare hooks are a bit too vague. Alternatively, we
>>> could add functions to grab/release the controller lock, but I'm not
>>> sure that's what we want since some controllers might be able to address
>>> several devices in parallel, and locking the whole controller at the
>>> spi-nor level would prevent that.  
>> I suppose the method is optional and device may choose to use it or not
>> following their own design. And the implementation is rather controller
>> specific, they may choose to lock the whole controller or only the desired
>> device to operate. 
> Yes, this is what I'm complaining about. How can the upper layer know
> when it should call prepare/unprepare? Let's take the SPI NAND case,
> should we prepare before loading a page in the cache and unprepare
> after we're done reading the page, or should we unprepare just after
> the page has been loaded in the cache? BTW, you've not patched the SPI
> NAND layer to call ->prepare/unprepare().

It's already implemented in spi-nor framework. As for sequential operations,
taking read as an example, the call stack looks like:

->spi_nor_read()
---->spi_nor_lock_and_prep()
------->spi_nor_controller_ops->prepare() or spi_mem_prepare() in PATCH 1/3
...
---->spi_nor_read_data() // maybe called several times
...
---->spi_nor_unlock_and_unprep()
------->spi_nor_controller_ops->unprepare() or spi_mem_unprepare() in PATCH 1/3

As for nand flash, I didn't add it in this RFC as I'm not certain where
should prepare/unprepare be called.

If we use spi_mem_exec_sequence() seems we'll do more works to adapt, at least
at spi-nor side. what do you think?


>
>>
>>> BTW, I don't know all the details about this lock or what this FW is
>>> exactly (where it's running, what's his priority, what kind of
>>> synchronization exists between Linux and the FW, ...), but I'm worried
>>> about potential deadlocks here.  
>> For SFC controller, both firmware and the kernel driver will require the
>> lock before a sequence of operations, and single operations like register
>> access for spi-nor flash is implemented atomically. Once the lock is held
>> by firmware/driver, then the controller cannot perform the operations sent
>> by the other one unless the lock is released.
> Yes, that's my point. What prevents the FW from preempting Linux while
> it's holding the lock and waiting indefinitely on this lock. Is the FW
> running on a separate core? Don't you have other IPs with the same kind
> of locks leading to issues if locks are not taken/released in the same
> order? ...

The firmware is running on a separate co-processor so it may not preempt
the linux.

Thanks,
Yicong


> .
>

