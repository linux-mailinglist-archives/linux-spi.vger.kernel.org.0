Return-Path: <linux-spi+bounces-4115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A99D9436A4
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 21:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE41B20AAE
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62BE3BBE3;
	Wed, 31 Jul 2024 19:43:42 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B51805E;
	Wed, 31 Jul 2024 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455022; cv=none; b=Cod1LkBGooM8MYdqAC0ustifK7/KJwNwNC7evIumowQmCmqDjqQVDTgj21hfcXT10U+xq8AoBgjLviYFEN5weh1L4qpEPNjG7yItfa7DVLDNYvXEtQEBi+3Jq8lFwQSEgQptDSzuN5WFGIGQ0NoeCqgEYwv4eYxsB/iX528Kd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455022; c=relaxed/simple;
	bh=fyMMWq0FoeH7PUl8TbT0u97X8HOomSa0etdreH5oW0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UACD+jqiJvkIld8HHH1BcSl9o+u0jjjimtIBUiiOaoeOadn6v3u6nbeVVCWS0vn93oCl03PE+j8KhbBID3S9dnhdScyNFtAPS91NGMGgRsqzGP0f6nuPAZbQjwFTwcRBLxWmAwZcpcrOsjIBpeS3twWiq+0eAEwK+G+zds6i2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac5.versanet.de ([83.135.90.197] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sZFEN-00075I-7Y; Wed, 31 Jul 2024 21:43:27 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Dmitrii Osipenko <dmitry.osipenko@collabora.com>,
 Mark Brown <broonie@kernel.org>, Urja <urja@urja.dev>,
 linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
Date: Wed, 31 Jul 2024 21:43:24 +0200
Message-ID: <3399645.RL5eaSpR8r@diego>
In-Reply-To: <20240730180903.81688-1-sebastian.reichel@collabora.com>
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 30. Juli 2024, 20:05:05 CEST schrieb Sebastian Reichel:
> When I converted rk808 to device managed resources I converted the rk808
> specific pm_power_off handler to devm_register_sys_off_handler() using
> SYS_OFF_MODE_POWER_OFF_PREPARE, which is allowed to sleep. I did this
> because the driver's poweroff function makes use of regmap and the backend
> of that might sleep.
> 
> But the PMIC poweroff function will kill off the board power and the
> kernel does some extra steps after the prepare handler. Thus the prepare
> handler should not be used for the PMIC's poweroff routine. Instead the
> normal SYS_OFF_MODE_POWER_OFF phase should be used. The old pm_power_off
> method is also being called from there, so this would have been a
> cleaner conversion anyways.
> 
> But it still makes sense to investigate the sleep handling and check
> if there are any issues. Apparently the Rockchip and Meson I2C drivers
> (the only platforms using the PMICs handled by this driver) both have
> support for atomic transfers and thus may be called from the proper
> poweroff context.
> 
> Things are different on the SPI side. That is so far only used by rk806
> and that one is only used by Rockchip RK3588. Unfortunately the Rockchip
> SPI driver does not support atomic transfers. That means using the
> normal POWER_OFF handler would introduce the following error splash
> during shutdown on all RK3588 boards currently supported upstream:
> 
> [   13.761353] ------------[ cut here ]------------
> [   13.761764] Voluntary context switch within RCU read-side critical section!
> [   13.761776] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x3ac/0x404
> [   13.763219] Modules linked in:
> [   13.763498] CPU: 0 UID: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.10.0-12284-g2818a9a19514 #1499
> [   13.764297] Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
> [   13.764812] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   13.765427] pc : rcu_note_context_switch+0x3ac/0x404
> [   13.765871] lr : rcu_note_context_switch+0x3ac/0x404
> [   13.766314] sp : ffff800084f4b5b0
> [   13.766609] x29: ffff800084f4b5b0 x28: ffff00040139b800 x27: 00007dfb4439ae80
> [   13.767245] x26: ffff00040139bc80 x25: 0000000000000000 x24: ffff800082118470
> [   13.767880] x23: 0000000000000000 x22: ffff000400300000 x21: ffff000400300000
> [   13.768515] x20: ffff800083a9d600 x19: ffff0004fee48600 x18: fffffffffffed448
> [   13.769151] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000048
> [   13.769787] x14: fffffffffffed490 x13: ffff80008473b3c0 x12: 0000000000000900
> [   13.770421] x11: 0000000000000300 x10: ffff800084797bc0 x9 : ffff80008473b3c0
> [   13.771057] x8 : 00000000ffffefff x7 : ffff8000847933c0 x6 : 0000000000000300
> [   13.771692] x5 : 0000000000000301 x4 : 40000000fffff300 x3 : 0000000000000000
> [   13.772328] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000400300000
> [   13.772964] Call trace:
> [   13.773184]  rcu_note_context_switch+0x3ac/0x404
> [   13.773598]  __schedule+0x94/0xb0c
> [   13.773907]  schedule+0x34/0x104
> [   13.774198]  schedule_timeout+0x84/0xfc
> [   13.774544]  wait_for_completion_timeout+0x78/0x14c
> [   13.774980]  spi_transfer_one_message+0x588/0x690
> [   13.775403]  __spi_pump_transfer_message+0x19c/0x4ec
> [   13.775846]  __spi_sync+0x2a8/0x3c4
> [   13.776161]  spi_write_then_read+0x120/0x208
> [   13.776543]  rk806_spi_bus_read+0x54/0x88
> [   13.776905]  _regmap_raw_read+0xec/0x16c
> [   13.777257]  _regmap_bus_read+0x44/0x7c
> [   13.777601]  _regmap_read+0x60/0xd8
> [   13.777915]  _regmap_update_bits+0xf4/0x13c
> [   13.778289]  regmap_update_bits_base+0x64/0x98
> [   13.778686]  rk808_power_off+0x70/0xfc
> [   13.779024]  sys_off_notify+0x40/0x6c
> [   13.779356]  atomic_notifier_call_chain+0x60/0x90
> [   13.779776]  do_kernel_power_off+0x54/0x6c
> [   13.780146]  machine_power_off+0x18/0x24
> [   13.780499]  kernel_power_off+0x70/0x7c
> [   13.780845]  __do_sys_reboot+0x210/0x270
> [   13.781198]  __arm64_sys_reboot+0x24/0x30
> [   13.781558]  invoke_syscall+0x48/0x10c
> [   13.781897]  el0_svc_common+0x3c/0xe8
> [   13.782228]  do_el0_svc+0x20/0x2c
> [   13.782528]  el0_svc+0x34/0xd8
> [   13.782806]  el0t_64_sync_handler+0x120/0x12c
> [   13.783197]  el0t_64_sync+0x190/0x194
> [   13.783527] ---[ end trace 0000000000000000 ]---
> 
> To avoid this we keep the SYS_OFF_MODE_POWER_OFF_PREPARE handler for the
> SPI backend. This is not great, but at least avoids regressions and the
> fix should be small enough to allow backporting.
> 
> As a side-effect this also works around a shutdown problem on the Asus
> C201. For reasons unknown that skips calling the prepare handler and
> directly calls the final shutdown handler.
> 
> Fixes: 4fec8a5a85c49 ("mfd: rk808: Convert to device managed resources")
> Cc: stable@vger.kernel.org
> Reported-by: Urja <urja@urja.dev>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

On a QNAP-TS433:
Tested-by: Heiko Stuebner <heiko@sntech.de>

Change itself also looks nice and it definitly helps my qnap-mcu patches.
Because the mcu needs to turn off its parts before and till now I worked
around the issue by occupying another priority, while it should simply
be part of the prepare + default-prio stage, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



> ---
>  drivers/mfd/rk8xx-core.c  | 15 +++++++++++++--
>  drivers/mfd/rk8xx-i2c.c   |  2 +-
>  drivers/mfd/rk8xx-spi.c   |  2 +-
>  include/linux/mfd/rk808.h |  2 +-
>  4 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index 5eda3c0dbbdf..757ef8181328 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -692,10 +692,11 @@ void rk8xx_shutdown(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(rk8xx_shutdown);
>  
> -int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap)
> +int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap, bool is_spi)
>  {
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
> +	enum sys_off_mode pwr_off_mode = SYS_OFF_MODE_POWER_OFF;
>  	const struct mfd_cell *cells;
>  	int dual_support = 0;
>  	int nr_pre_init_regs;
> @@ -785,10 +786,20 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
>  
> +	/*
> +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
> +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
> +	 * handler, so we are using the prepare handler as a workaround.
> +	 * This should be removed once the Rockchip SPI driver has been
> +	 * adapted.
> +	 */
> +	if (is_spi)
> +		pwr_off_mode = SYS_OFF_MODE_POWER_OFF_PREPARE;
> +
>  	if (device_property_read_bool(dev, "rockchip,system-power-controller") ||
>  	    device_property_read_bool(dev, "system-power-controller")) {
>  		ret = devm_register_sys_off_handler(dev,
> -				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
> +				    pwr_off_mode, SYS_OFF_PRIO_HIGH,
>  				    &rk808_power_off, rk808);
>  		if (ret)
>  			return dev_err_probe(dev, ret,
> diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
> index 69a6b297d723..a2029decd654 100644
> --- a/drivers/mfd/rk8xx-i2c.c
> +++ b/drivers/mfd/rk8xx-i2c.c
> @@ -189,7 +189,7 @@ static int rk8xx_i2c_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap),
>  				     "regmap initialization failed\n");
>  
> -	return rk8xx_probe(&client->dev, data->variant, client->irq, regmap);
> +	return rk8xx_probe(&client->dev, data->variant, client->irq, regmap, false);
>  }
>  
>  static void rk8xx_i2c_shutdown(struct i2c_client *client)
> diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
> index 3405fb82ff9f..20f9428f94bb 100644
> --- a/drivers/mfd/rk8xx-spi.c
> +++ b/drivers/mfd/rk8xx-spi.c
> @@ -94,7 +94,7 @@ static int rk8xx_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
>  				     "Failed to init regmap\n");
>  
> -	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
> +	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap, true);
>  }
>  
>  static const struct of_device_id rk8xx_spi_of_match[] = {
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index 69cbea78b430..be15b84cff9e 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -1349,7 +1349,7 @@ struct rk808 {
>  };
>  
>  void rk8xx_shutdown(struct device *dev);
> -int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap);
> +int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap, bool is_spi);
>  int rk8xx_suspend(struct device *dev);
>  int rk8xx_resume(struct device *dev);
>  
> 





