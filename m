Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8241E1E8D
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgEZJaV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgEZJaV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 05:30:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C4C03E97E
        for <linux-spi@vger.kernel.org>; Tue, 26 May 2020 02:30:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B4F152A0297;
        Tue, 26 May 2020 10:30:19 +0100 (BST)
Date:   Tue, 26 May 2020 11:30:16 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com, richard@nod.at,
        john.garry@huawei.com, linux-spi@vger.kernel.org,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [RFC PATCH 3/3] spi: hisi-sfc-v3xx: Add prepare/unprepare
 methods to avoid race condition
Message-ID: <20200526113016.58e6687a@collabora.com>
In-Reply-To: <20200526112752.6dd0da2c@collabora.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
        <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
        <20200525161436.c5h6d27pm3jptwbo@yadavpratyush.com>
        <20200526112752.6dd0da2c@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 26 May 2020 11:27:52 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Mon, 25 May 2020 21:44:36 +0530
> Pratyush Yadav <me@yadavpratyush.com> wrote:
> 
> > Hi Yicong,
> > 
> > On 21/05/20 07:23PM, Yicong Yang wrote:  
> > > The controller can be shared with the firmware, which may cause race
> > > problems. As most read/write/erase/lock/unlock of spi-nor flash are
> > > composed of a set of operations, while the firmware may use the controller
> > > and start its own operation in the middle of the process started by the
> > > kernel driver, which may lead to the kernel driver's function broken.
> > > 
> > > Bit[20] in HISI_SFC_V3XX_CMD_CFG register plays a role of a lock, to
> > > protect the controller from firmware access, which means the firmware
> > > cannot reach the controller if the driver set the bit. Add prepare/
> > > unprepare methods for the controller, we'll hold the lock in prepare
> > > method and release it in unprepare method, which will solve the race
> > > issue.    
> > 
> > I'm trying to understand the need for this change. What's wrong with
> > performing the lock/unlock procedure in hisi_sfc_v3xx_exec_op()? You can 
> > probably do something like:
> > 
> >   hisi_sfc_v3xx_lock();
> >   ret = hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
> >   hisi_sfc_v3xx_unlock();
> >   return ret;
> > 
> > What's the benefit of making upper layers do this? Acquiring the lock is 
> > a simple register write, so it should be relatively fast. Unless there 
> > is a lot of contention on the lock between the firmware and kernel, I 
> > would expect the performance impact to be minimal. Maybe you can run 
> > some benchmarks and see if there is a real difference.
> >   
> > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > ---
> > >  drivers/spi/spi-hisi-sfc-v3xx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 40 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
> > > index e3b5725..13c161c 100644
> > > --- a/drivers/spi/spi-hisi-sfc-v3xx.c
> > > +++ b/drivers/spi/spi-hisi-sfc-v3xx.c
> > > @@ -18,6 +18,7 @@
> > >  #define HISI_SFC_V3XX_VERSION (0x1f8)
> > >  
> > >  #define HISI_SFC_V3XX_CMD_CFG (0x300)
> > > +#define HISI_SFC_V3XX_CMD_CFG_LOCK BIT(20)
> > >  #define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
> > >  #define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
> > >  #define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
> > > @@ -41,6 +42,34 @@ struct hisi_sfc_v3xx_host {
> > >  	int max_cmd_dword;
> > >  };
> > >  
> > > +int hisi_sfc_v3xx_op_prepare(struct spi_mem *mem)
> > > +{
> > > +	struct spi_device *spi = mem->spi;
> > > +	struct hisi_sfc_v3xx_host *host;
> > > +	u32 reg = HISI_SFC_V3XX_CMD_CFG_LOCK;
> > > +
> > > +	host = spi_controller_get_devdata(spi->master);
> > > +
> > > +	writel(reg, host->regbase + HISI_SFC_V3XX_CMD_CFG);
> > > +
> > > +	reg = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
> > > +	if (!(reg & HISI_SFC_V3XX_CMD_CFG_LOCK))
> > > +		return -EIO;    
> > 
> > IIUC, you are checking if you actually got the lock, and you won't get 
> > the lock if the firmware is using the controller. So, is it a good idea 
> > to give up so easily? Maybe we should do this in a loop at some 
> > intervals, and only error out when we reach a number of failed attempts?
> >   
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void hisi_sfc_v3xx_op_unprepare(struct spi_mem *mem)
> > > +{
> > > +	struct spi_device *spi = mem->spi;
> > > +	struct hisi_sfc_v3xx_host *host;
> > > +
> > > +	host = spi_controller_get_devdata(spi->master);
> > > +
> > > +	/* Release the lock and clear the command register. */
> > > +	writel(0, host->regbase + HISI_SFC_V3XX_CMD_CFG);
> > > +}
> > > +
> > >  #define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
> > >  #define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
> > >  
> > > @@ -163,7 +192,15 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
> > >  					 u8 chip_select)
> > >  {
> > >  	int ret, len = op->data.nbytes;
> > > -	u32 config = 0;
> > > +	u32 config;
> > > +
> > > +	/*
> > > +	 * The lock bit is in the command register. Clear the command
> > > +	 * field with lock bit held if it has been set in
> > > +	 * .prepare().
> > > +	 */
> > > +	config = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
> > > +	config &= HISI_SFC_V3XX_CMD_CFG_LOCK;    
> > 
> > This will unlock the controller _before_ the driver issues 
> > hisi_sfc_v3xx_read_databuf(). I'm not very familiar with the hardware, 
> > but to me it seems like it can lead to a race. What if the firmware 
> > issues a command that over-writes the databuf (I assume this is shared 
> > between the two) before the driver gets a chance to copy that data to 
> > the kernel buffer?  
> 
> Like Pratyush said, I don't see why you need to expose new
> prepare/unprepare steps. Looks like something entirely controller
> specific.

Sorry, this comment is misplaced, just like my understanding of the
problem :-).
