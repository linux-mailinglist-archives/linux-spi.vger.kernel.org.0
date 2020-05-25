Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814041E1270
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEYQOp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 12:14:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42421 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEYQOp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 12:14:45 -0400
X-Originating-IP: 157.36.22.112
Received: from localhost (unknown [157.36.22.112])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 08342E0005;
        Mon, 25 May 2020 16:14:39 +0000 (UTC)
Date:   Mon, 25 May 2020 21:44:36 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     broonie@kernel.org, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, john.garry@huawei.com, vigneshr@ti.com,
        miquel.raynal@bootlin.com
Subject: Re: [RFC PATCH 3/3] spi: hisi-sfc-v3xx: Add prepare/unprepare
 methods to avoid race condition
Message-ID: <20200525161436.c5h6d27pm3jptwbo@yadavpratyush.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
 <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yicong,

On 21/05/20 07:23PM, Yicong Yang wrote:
> The controller can be shared with the firmware, which may cause race
> problems. As most read/write/erase/lock/unlock of spi-nor flash are
> composed of a set of operations, while the firmware may use the controller
> and start its own operation in the middle of the process started by the
> kernel driver, which may lead to the kernel driver's function broken.
> 
> Bit[20] in HISI_SFC_V3XX_CMD_CFG register plays a role of a lock, to
> protect the controller from firmware access, which means the firmware
> cannot reach the controller if the driver set the bit. Add prepare/
> unprepare methods for the controller, we'll hold the lock in prepare
> method and release it in unprepare method, which will solve the race
> issue.

I'm trying to understand the need for this change. What's wrong with
performing the lock/unlock procedure in hisi_sfc_v3xx_exec_op()? You can 
probably do something like:

  hisi_sfc_v3xx_lock();
  ret = hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
  hisi_sfc_v3xx_unlock();
  return ret;

What's the benefit of making upper layers do this? Acquiring the lock is 
a simple register write, so it should be relatively fast. Unless there 
is a lot of contention on the lock between the firmware and kernel, I 
would expect the performance impact to be minimal. Maybe you can run 
some benchmarks and see if there is a real difference.

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/spi/spi-hisi-sfc-v3xx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
> index e3b5725..13c161c 100644
> --- a/drivers/spi/spi-hisi-sfc-v3xx.c
> +++ b/drivers/spi/spi-hisi-sfc-v3xx.c
> @@ -18,6 +18,7 @@
>  #define HISI_SFC_V3XX_VERSION (0x1f8)
>  
>  #define HISI_SFC_V3XX_CMD_CFG (0x300)
> +#define HISI_SFC_V3XX_CMD_CFG_LOCK BIT(20)
>  #define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
>  #define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
>  #define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
> @@ -41,6 +42,34 @@ struct hisi_sfc_v3xx_host {
>  	int max_cmd_dword;
>  };
>  
> +int hisi_sfc_v3xx_op_prepare(struct spi_mem *mem)
> +{
> +	struct spi_device *spi = mem->spi;
> +	struct hisi_sfc_v3xx_host *host;
> +	u32 reg = HISI_SFC_V3XX_CMD_CFG_LOCK;
> +
> +	host = spi_controller_get_devdata(spi->master);
> +
> +	writel(reg, host->regbase + HISI_SFC_V3XX_CMD_CFG);
> +
> +	reg = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
> +	if (!(reg & HISI_SFC_V3XX_CMD_CFG_LOCK))
> +		return -EIO;

IIUC, you are checking if you actually got the lock, and you won't get 
the lock if the firmware is using the controller. So, is it a good idea 
to give up so easily? Maybe we should do this in a loop at some 
intervals, and only error out when we reach a number of failed attempts?

> +
> +	return 0;
> +}
> +
> +void hisi_sfc_v3xx_op_unprepare(struct spi_mem *mem)
> +{
> +	struct spi_device *spi = mem->spi;
> +	struct hisi_sfc_v3xx_host *host;
> +
> +	host = spi_controller_get_devdata(spi->master);
> +
> +	/* Release the lock and clear the command register. */
> +	writel(0, host->regbase + HISI_SFC_V3XX_CMD_CFG);
> +}
> +
>  #define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
>  #define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
>  
> @@ -163,7 +192,15 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
>  					 u8 chip_select)
>  {
>  	int ret, len = op->data.nbytes;
> -	u32 config = 0;
> +	u32 config;
> +
> +	/*
> +	 * The lock bit is in the command register. Clear the command
> +	 * field with lock bit held if it has been set in
> +	 * .prepare().
> +	 */
> +	config = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
> +	config &= HISI_SFC_V3XX_CMD_CFG_LOCK;

This will unlock the controller _before_ the driver issues 
hisi_sfc_v3xx_read_databuf(). I'm not very familiar with the hardware, 
but to me it seems like it can lead to a race. What if the firmware 
issues a command that over-writes the databuf (I assume this is shared 
between the two) before the driver gets a chance to copy that data to 
the kernel buffer?
  
>  	if (op->addr.nbytes)
>  		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
> @@ -248,6 +285,8 @@ static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
>  
>  static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
>  	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
> +	.prepare	= hisi_sfc_v3xx_op_prepare,
> +	.unprepare	= hisi_sfc_v3xx_op_unprepare,
>  	.exec_op = hisi_sfc_v3xx_exec_op,
>  };
>  

FWIW, the other two patches in the series look good to me given you can 
justify the need for having the API.

-- 
Regards,
Pratyush Yadav
