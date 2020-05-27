Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF41E3DA1
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 11:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgE0Jdf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 05:33:35 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53739 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgE0Jdf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 05:33:35 -0400
X-Originating-IP: 157.36.30.198
Received: from localhost (unknown [157.36.30.198])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 75CEB1BF207;
        Wed, 27 May 2020 09:33:29 +0000 (UTC)
Date:   Wed, 27 May 2020 15:03:25 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, john.garry@huawei.com, vigneshr@ti.com,
        miquel.raynal@bootlin.com
Subject: Re: [RFC PATCH 3/3] spi: hisi-sfc-v3xx: Add prepare/unprepare
 methods to avoid race condition
Message-ID: <20200527093325.247l6tnxaicsqdst@yadavpratyush.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
 <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
 <20200525161436.c5h6d27pm3jptwbo@yadavpratyush.com>
 <6a41fb13-e746-54f3-24ef-197384dde6ab@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a41fb13-e746-54f3-24ef-197384dde6ab@hisilicon.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/05/20 04:18PM, Yicong Yang wrote:
> Hi Pratyush,
> 
> On 2020/5/26 0:14, Pratyush Yadav wrote:
> > Hi Yicong,
> >
> > On 21/05/20 07:23PM, Yicong Yang wrote:
> >> The controller can be shared with the firmware, which may cause race
> >> problems. As most read/write/erase/lock/unlock of spi-nor flash are
> >> composed of a set of operations, while the firmware may use the controller
> >> and start its own operation in the middle of the process started by the
> >> kernel driver, which may lead to the kernel driver's function broken.
> >>
> >> Bit[20] in HISI_SFC_V3XX_CMD_CFG register plays a role of a lock, to
> >> protect the controller from firmware access, which means the firmware
> >> cannot reach the controller if the driver set the bit. Add prepare/
> >> unprepare methods for the controller, we'll hold the lock in prepare
> >> method and release it in unprepare method, which will solve the race
> >> issue.
> > I'm trying to understand the need for this change. What's wrong with
> > performing the lock/unlock procedure in hisi_sfc_v3xx_exec_op()? You can 
> > probably do something like:
> >
> >   hisi_sfc_v3xx_lock();
> >   ret = hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
> >   hisi_sfc_v3xx_unlock();
> >   return ret;
> 
> if doing like this, suppose we perform a sequential operations like below:
> 
> lock()->exec_op(cmd1)->unlock()->lock()->exec_op(cmd2)->unlock()->lock()->exec_op(cmd3)->unlock()
>                        ^==========^is unlocked          ^==========^is unlocked
> 
> As shown above, we cannot lock the device continuously during the whole operations.

Correct. My argument is based on the assumption that lock() and unlock() 
are cheap/fast operations. If you spend very little time in lock() and 
unlock(), it doesn't make a big difference if you do all 3 operations in 
one go or one at a time.

In other words, since register write should be pretty fast, locking and 
unlocking should be pretty fast. If we don't spend a lot of time in 
lock() and unlock(), we don't gain a lot of performance by reducing 
those calls.

> But if we use upper layer method then it looks like
> 
> prepare()->exec_op(cmd1)->exec_op(cmd2)->exec_op(cmd3)->unprepare()
>         ^locked here                                              ^unlocked here
> 
> we can hold the lock during the all 3 operations' execution.

If you still think doing all operations in one go is a better idea, I  
like Boris's idea of batching operations and its worth considering.
 
> > What's the benefit of making upper layers do this? Acquiring the lock is 
> > a simple register write, so it should be relatively fast. Unless there 
> > is a lot of contention on the lock between the firmware and kernel, I 
> > would expect the performance impact to be minimal. Maybe you can run 
> > some benchmarks and see if there is a real difference.
> >
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  drivers/spi/spi-hisi-sfc-v3xx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
> >> index e3b5725..13c161c 100644
> >> --- a/drivers/spi/spi-hisi-sfc-v3xx.c
> >> +++ b/drivers/spi/spi-hisi-sfc-v3xx.c
> >> @@ -163,7 +192,15 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
> >>  					 u8 chip_select)
> >>  {
> >>  	int ret, len = op->data.nbytes;
> >> -	u32 config = 0;
> >> +	u32 config;
> >> +
> >> +	/*
> >> +	 * The lock bit is in the command register. Clear the command
> >> +	 * field with lock bit held if it has been set in
> >> +	 * .prepare().
> >> +	 */
> >> +	config = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
> >> +	config &= HISI_SFC_V3XX_CMD_CFG_LOCK;
> > This will unlock the controller _before_ the driver issues 
> > hisi_sfc_v3xx_read_databuf(). I'm not very familiar with the hardware, 
> > but to me it seems like it can lead to a race. What if the firmware 
> > issues a command that over-writes the databuf (I assume this is shared 
> > between the two) before the driver gets a chance to copy that data to 
> > the kernel buffer?
> 
> It won't unlock the controller if it has been locked in prepare(). It will clear
> the other bits in the register other than the lock bit. For single operations, as 
> prepare() method is not called, the bit is 0 and it won't change here.

Right. I misread the code. Sorry.

-- 
Regards,
Pratyush Yadav
