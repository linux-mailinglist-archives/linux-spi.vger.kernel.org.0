Return-Path: <linux-spi+bounces-10760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BABF738A
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494FA189E756
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2C4341671;
	Tue, 21 Oct 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCqn6gBm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CC34166E;
	Tue, 21 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058755; cv=none; b=qKflnI0ZwQ6FN5DMZ/XG3IunyiGD+JFIMPR9qJ8HIA2SyJQ+Ss4a1MeaFjmKnAEiFvi4yDaiNfLiwpmG1zUPitzMNabLopnztf47rK4vdmYzoSvUdBao/RIhS2WurulzDtIciDHL9pdejZn76BwaMJow/PtDq8w213MyIf2/nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058755; c=relaxed/simple;
	bh=kgIjj9uR8Jvjy33POPBKd/lc3YtLEJRDArJqooGp22c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfHQnUAn+6Oo1zls+NavdMoOZPJjfKflwMPPVGF8sYQSLV2UaYP0ppCYR68txyCaz5QkUPC5V29i5CPpMCWFiW55zMZJABCi2ze61t6oS12tP4CTT+RjZSBa0qmApNRK8EYDVNZzH5Gv1AIKmXluvQcdu4FVnjn2M5u+tIW8kWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCqn6gBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF70C4CEF1;
	Tue, 21 Oct 2025 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761058753;
	bh=kgIjj9uR8Jvjy33POPBKd/lc3YtLEJRDArJqooGp22c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCqn6gBmVvgQCojwdIjqSMKnW6EvNR8FWpX7heL36fMOgouCzKkr5EQOjxOY2yXkr
	 5jDTzNMustvfBVFFX3uqVSVtYzrFF3651I5JcJmt4WPaCoOloW+fzmevhEFyJL7xrP
	 9wc3gk8vHc6PuHmESE73rRNyaufoBf6o/Xl6yUMEJAXZ8jGORqW+a1bHsNGe3n+jUi
	 Bsgd/1/8eUusChHn+D8cyMXmbLSY7Keg0VqpgKtCYznZ4TkwmO4pOD6T2gpzcIIzeo
	 Mc3X0pm27z45uIh+g9RNCyW5gd8zLMDwbs8m1ppG623zp7OoiA311lNPf3DOgJZKjc
	 JRM/mFXybT3Vw==
Date: Tue, 21 Oct 2025 15:59:09 +0100
From: Lee Jones <lee@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: sprd-sc27xx: Integrate power off and reboot
 support
Message-ID: <20251021145909.GI475031@google.com>
References: <20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de>
 <20251007-sc27xx-mfd-poweroff-v1-1-89a2f919b731@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007-sc27xx-mfd-poweroff-v1-1-89a2f919b731@abscue.de>

On Tue, 07 Oct 2025, Otto Pflüger wrote:

> The SC27xx PMICs allow restarting and powering off the device. Since
> this functionality is rather simple and not configurable in any way,
> make it part of the main PMIC driver.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 152 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index d6b4350779e6aecfa19d9fa21b9174447d589e33..28dc82002e3c8eb7748c45f9f1bdadea4feb8206 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -10,6 +10,7 @@
>  #include <linux/mfd/sc27xx-pmic.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  #include <uapi/linux/usb/charger.h>
> @@ -21,10 +22,48 @@
>  #define SPRD_SC2730_IRQ_BASE		0x80
>  #define SPRD_SC2730_IRQ_NUMS		10
>  #define SPRD_SC2730_CHG_DET		0x1b9c
> +
> +#define SPRD_SC2730_PWR_PD_HW		0x1820
> +#define SPRD_SC2730_SOFT_RST_HW		0x1824
> +#define SPRD_SC2730_SLP_CTRL		0x1a48
> +#define SPRD_SC2730_RST_STATUS		0x1bac
> +#define SPRD_SC2730_SWRST_CTRL0		0x1bf8
> +
>  #define SPRD_SC2731_IRQ_BASE		0x140
>  #define SPRD_SC2731_IRQ_NUMS		16
>  #define SPRD_SC2731_CHG_DET		0xedc
>  
> +#define SPRD_SC2731_PWR_PD_HW		0xc2c
> +#define SPRD_SC2731_SLP_CTRL		0xdf0
> +#define SPRD_SC2731_RST_STATUS		0xee8
> +
> +/* PMIC power off and reset definition */
> +#define SPRD_SC2730_LDO_XTL_EN		BIT(2)
> +#define SPRD_SC2730_SLP_LDO_PD_EN	BIT(0)
> +
> +#define SPRD_SC2731_LDO_XTL_EN		BIT(3)
> +#define SPRD_SC2731_SLP_LDO_PD_EN	BIT(0)
> +
> +#define SPRD_PMIC_PWR_OFF		BIT(0)
> +#define SPRD_PMIC_RESET			BIT(0)
> +#define SPRD_PMIC_SOFT_RST_EN		BIT(4)
> +
> +#define HWRST_STATUS_SECURITY		0x02
> +#define HWRST_STATUS_RECOVERY		0x20
> +#define HWRST_STATUS_NORMAL		0x40
> +#define HWRST_STATUS_ALARM		0x50
> +#define HWRST_STATUS_SLEEP		0x60
> +#define HWRST_STATUS_FASTBOOT		0x30
> +#define HWRST_STATUS_SPECIAL		0x70
> +#define HWRST_STATUS_PANIC		0x80
> +#define HWRST_STATUS_CFTREBOOT		0x90
> +#define HWRST_STATUS_AUTODLOADER	0xa0
> +#define HWRST_STATUS_IQMODE		0xb0
> +#define HWRST_STATUS_SPRDISK		0xc0
> +#define HWRST_STATUS_FACTORYTEST	0xe0
> +#define HWRST_STATUS_WATCHDOG		0xf0
> +#define HWRST_STATUS_MASK		0xff
> +
>  /* PMIC charger detection definition */
>  #define SPRD_PMIC_CHG_DET_DELAY_US	200000
>  #define SPRD_PMIC_CHG_DET_TIMEOUT	2000000
> @@ -48,6 +87,14 @@ struct sprd_pmic_data {
>  	u32 irq_base;
>  	u32 num_irqs;
>  	u32 charger_det;
> +
> +	u32 poweroff_reg;
> +	u32 slp_ctrl_reg;
> +	u32 slp_ctrl_mask;
> +
> +	u32 reset_reg;
> +	u32 rst_sts_reg;
> +	u32 swrst_ctrl_reg;
>  };
>  
>  /*
> @@ -59,12 +106,26 @@ static const struct sprd_pmic_data sc2730_data = {
>  	.irq_base = SPRD_SC2730_IRQ_BASE,
>  	.num_irqs = SPRD_SC2730_IRQ_NUMS,
>  	.charger_det = SPRD_SC2730_CHG_DET,
> +
> +	.poweroff_reg = SPRD_SC2730_PWR_PD_HW,
> +	.slp_ctrl_reg = SPRD_SC2730_SLP_CTRL,
> +	.slp_ctrl_mask = SPRD_SC2730_LDO_XTL_EN | SPRD_SC2730_SLP_LDO_PD_EN,
> +
> +	.reset_reg = SPRD_SC2730_SOFT_RST_HW,
> +	.rst_sts_reg = SPRD_SC2730_RST_STATUS,
> +	.swrst_ctrl_reg = SPRD_SC2730_SWRST_CTRL0,
>  };
>  
>  static const struct sprd_pmic_data sc2731_data = {
>  	.irq_base = SPRD_SC2731_IRQ_BASE,
>  	.num_irqs = SPRD_SC2731_IRQ_NUMS,
>  	.charger_det = SPRD_SC2731_CHG_DET,
> +
> +	.poweroff_reg = SPRD_SC2731_PWR_PD_HW,
> +	.slp_ctrl_reg = SPRD_SC2731_SLP_CTRL,
> +	.slp_ctrl_mask = SPRD_SC2731_LDO_XTL_EN | SPRD_SC2731_SLP_LDO_PD_EN,
> +
> +	.rst_sts_reg = SPRD_SC2731_RST_STATUS,
>  };
>  
>  enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> @@ -149,6 +210,79 @@ static const struct regmap_config sprd_pmic_config = {
>  	.max_register = 0xffff,
>  };
>  
> +static int sprd_pmic_poweroff(struct sys_off_data *off_data)
> +{
> +	struct sprd_pmic *ddata = off_data->cb_data;
> +	const struct sprd_pmic_data *pdata = ddata->pdata;
> +
> +	regmap_clear_bits(ddata->regmap, pdata->slp_ctrl_reg,
> +			  pdata->slp_ctrl_mask);
> +
> +	regmap_write(ddata->regmap, pdata->poweroff_reg, SPRD_PMIC_PWR_OFF);
> +
> +	mdelay(1000);
> +
> +	pr_emerg("Unable to poweroff system\n");

Why not dev_err()?

> +	return NOTIFY_DONE;
> +}
> +
> +static int sprd_pmic_restart(struct sys_off_data *off_data)
> +{
> +	struct sprd_pmic *ddata = off_data->cb_data;
> +	const struct sprd_pmic_data *pdata = ddata->pdata;
> +	u32 reboot_mode;
> +
> +	if (!off_data->cmd)
> +		reboot_mode = HWRST_STATUS_NORMAL;
> +	else if (!strcmp(off_data->cmd, "recovery"))
> +		reboot_mode = HWRST_STATUS_RECOVERY;
> +	else if (!strcmp(off_data->cmd, "alarm"))
> +		reboot_mode = HWRST_STATUS_ALARM;
> +	else if (!strcmp(off_data->cmd, "fastsleep"))
> +		reboot_mode = HWRST_STATUS_SLEEP;
> +	else if (!strcmp(off_data->cmd, "bootloader"))
> +		reboot_mode = HWRST_STATUS_FASTBOOT;
> +	else if (!strcmp(off_data->cmd, "panic"))
> +		reboot_mode = HWRST_STATUS_PANIC;
> +	else if (!strcmp(off_data->cmd, "special"))
> +		reboot_mode = HWRST_STATUS_SPECIAL;
> +	else if (!strcmp(off_data->cmd, "cftreboot"))
> +		reboot_mode = HWRST_STATUS_CFTREBOOT;
> +	else if (!strcmp(off_data->cmd, "autodloader"))
> +		reboot_mode = HWRST_STATUS_AUTODLOADER;
> +	else if (!strcmp(off_data->cmd, "iqmode"))
> +		reboot_mode = HWRST_STATUS_IQMODE;
> +	else if (!strcmp(off_data->cmd, "sprdisk"))
> +		reboot_mode = HWRST_STATUS_SPRDISK;
> +	else if (!strcmp(off_data->cmd, "tospanic"))
> +		reboot_mode = HWRST_STATUS_SECURITY;
> +	else if (!strcmp(off_data->cmd, "factorytest"))
> +		reboot_mode = HWRST_STATUS_FACTORYTEST;
> +	else
> +		reboot_mode = HWRST_STATUS_NORMAL;
> +
> +	regmap_update_bits(ddata->regmap, pdata->rst_sts_reg,
> +			   HWRST_STATUS_MASK, reboot_mode);
> +
> +	/*
> +	 * On SC2731, this part is skipped because there is no reset register
> +	 * and the restart must be performed using the watchdog.
> +	 */
> +	if (pdata->reset_reg) {
> +		regmap_set_bits(ddata->regmap, pdata->swrst_ctrl_reg,
> +				SPRD_PMIC_SOFT_RST_EN);
> +
> +		regmap_write(ddata->regmap, pdata->reset_reg, SPRD_PMIC_RESET);
> +
> +		mdelay(1000);
> +
> +		pr_emerg("Unable to restart system\n");

dev_err()

> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int sprd_pmic_probe(struct spi_device *spi)
>  {
>  	struct sprd_pmic *ddata;
> @@ -204,6 +338,24 @@ static int sprd_pmic_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	ret = devm_register_sys_off_handler(&spi->dev, SYS_OFF_MODE_RESTART,
> +					    192, sprd_pmic_restart, ddata);

Define all magic numbers.

> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to register restart handler: %d\n",
> +			ret);

Use 100-chars everywhere to prevent these line feeds.

> +		return ret;
> +	}
> +
> +	ret = devm_register_sys_off_handler(&spi->dev,
> +					    SYS_OFF_MODE_POWER_OFF,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    sprd_pmic_poweroff, ddata);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to register poweroff handler: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	ret = devm_of_platform_populate(&spi->dev);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to populate sub-devices %d\n", ret);
> 
> -- 
> 2.50.0
> 

-- 
Lee Jones [李琼斯]

