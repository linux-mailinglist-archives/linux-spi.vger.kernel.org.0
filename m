Return-Path: <linux-spi+bounces-3739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73899276D4
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E51F286127
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BC1AC221;
	Thu,  4 Jul 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2fy9YDEE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6607E9;
	Thu,  4 Jul 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098389; cv=none; b=Zn0n3fzRrf44BvIh1fgG4/VcFMx+j1RFG/HutXe9kWCL2T5Z4F5/QBZwnQKZkBluIvDwpjVveqh3GVmP54+dpWdpAaaOIrKarJQ+XL0798cyOblMCTggrfc4qQN8TyzrhZatSJsn44f+URk5HlQmRvuFghnDj3Ay5aaoGPCCVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098389; c=relaxed/simple;
	bh=fr9VTxP3EMKYu6iAweQ5TeL5jGzD+I3zD4zVkfgV38c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXYH+nvx4AnyrG+5VyGLcWf6D+FsTaXaiMiuvswztvKdhUh5ZrSdNVeFP3u83egioD1EwC/+VQT+CYOWwZuY3sKRNdoPb/4DuZbM3Y7jhkZQCYV4e2+lTOI4IdtkE9u2JQ4WIBW8n0IvJHOsyuQgN6Ddjzq2vjeF+kQlS5Xrlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2fy9YDEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6943DC3277B;
	Thu,  4 Jul 2024 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720098389;
	bh=fr9VTxP3EMKYu6iAweQ5TeL5jGzD+I3zD4zVkfgV38c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2fy9YDEEsW9nE2YfxGCxk+dtvffq5AyxiFcmz6J/4XAJwDWRUl1pr2vGKCAZNQ9xg
	 sgNY3p9bv/VKTZ0oLxLsyKh1I3N0saBb1RiAQPvRuTYjksw/b4QYUpXxHRHcKvnTPQ
	 mU8AtmT7iEj6tUhDgIi0FwE6QXiwMLl4AeMiRtQo=
Date: Thu, 4 Jul 2024 15:06:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/7] mikrobus: Add mikroBUS driver
Message-ID: <2024070400-grievance-unmolded-fa66@gregkh>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-6-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-6-9e6c148bf5f0@beagleboard.org>

On Thu, Jun 27, 2024 at 09:56:16PM +0530, Ayush Singh wrote:
> Adds support for SPI mikroBUS addon boards with configuration based on
> device tree. The goal is to get a minimal version in mainline to sort
> out the device tree structure that should be used.
> 
> A mikroBUS board can use any combination of the following based protocols:
> I2C, SPI, UART, PWM, Analog, GPIO with possibility of all pins being used
> as GPIO instead of their original purpose. This requires the driver to be
> flexible and identify the type of board based on the compatible string.

So this has nothing to do with greybus?  Or am I thinking of something
else?

> +menuconfig MIKROBUS
> +	tristate "Module for instantiating devices on mikroBUS ports"
> +	depends on GPIOLIB
> +	help
> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> +	  board socket standard that offers maximum expandability with
> +	  the smallest number of pins. The mikroBUS driver instantiates
> +	  devices on a mikroBUS port described mikroBUS manifest which is
> +	  passed using a sysfs interface.
> +
> +

Remove extra blank line.

> +	  Say Y here to enable support for this driver.

This isn't needed.

> +
> +	  To compile this code as a module, chose M here: the module
> +	  will be called mikrobus.ko
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 153a3f4837e8..f10f1414270b 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-$(CONFIG_MIKROBUS)		+= mikrobus.o
> diff --git a/drivers/misc/mikrobus.c b/drivers/misc/mikrobus.c
> new file mode 100644
> index 000000000000..bf160a0e8903
> --- /dev/null
> +++ b/drivers/misc/mikrobus.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0:
> +/*
> + * Copyright 2024 Ayush Singh <ayush@beagleboard.org>
> + */
> +
> +#define pr_fmt(fmt) "mikrobus:%s: " fmt, __func__

KBUILD_MODNAME?  Also, why is this needed at all, as you are a
bus/subsystem you should never need a pr_*() call, but instead just use
dev_*() ones instead.

> +
> +#include <linux/device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +
> +struct mikrobus_spi_cs_item {
> +	const char *cs_name;
> +	u32 cs;

Documentation?  What is "cs"?  More vowels please...

> +};
> +
> +/**
> + * struct mikrobus_port - MikroBUS Driver
> + *
> + * @dev: underlying platform_device

Why must this be a platform device?  What requires that?

> + * @board_ocs: board device tree changeset
> + * @pinctrl: mikroBUS pinctrl
> + * @mikrobus_spi_cs: list of supported chipselect address and name
> + * @mikrobus_spi_cs_count: length of mikrobus_spi_cs
> + * @spi_ctrl: spi controller of mikroBUS connector
> + * @spi_dev: spi mikroBUS board
> + */
> +struct mikrobus_port {
> +	struct platform_device *dev;
> +	struct of_changeset board_ocs;
> +	struct pinctrl *pctrl;
> +
> +	struct mikrobus_spi_cs_item *spi_cs;
> +	int spi_cs_count;
> +	struct spi_controller *spi_ctrl;
> +	struct spi_device *spi_dev;

What controls the lifespan of this object?  You have multiple devices
pointed to here with different lifecycles, what controls this one?

> +};
> +
> +/*
> + * mikrobus_pinctrl_select: Select pinctrl state for mikrobus pin

Either use kerneldoc or not, should be /** right?

> + *
> + * @port: mikrobus port
> + * @pinctrl_selected: pinctrl state to be selected
> + */
> +static int mikrobus_pinctrl_select(struct device *dev,
> +				   const char *pinctrl_selected)
> +{
> +	int ret;
> +	struct pinctrl_state *state;
> +	struct mikrobus_port *mb = dev_get_drvdata(dev);
> +
> +	state = pinctrl_lookup_state(mb->pctrl, pinctrl_selected);
> +	if (IS_ERR(state))
> +		return dev_err_probe(dev, PTR_ERR(state),
> +				     "failed to find state %s",
> +				     pinctrl_selected);
> +
> +	ret = pinctrl_select_state(mb->pctrl, state);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to select state %s",
> +				     pinctrl_selected);
> +
> +	dev_dbg_ratelimited(dev, "setting pinctrl %s", pinctrl_selected);

Why rate limited?  What is going to cause this to spam the log?

> +
> +	return 0;
> +}
> +
> +/*
> + * mikrobus_lookup_cs - lookup mikroBUS SPI chipselect by name
> + *
> + * @mb: mikroBUS port
> + * @cs_name: chipselect name

Use "chipselect" instead of "cs" everywhere please.

> + */
> +static int mikrobus_lookup_cs(const struct mikrobus_port *mb,
> +			      const char *cs_name)
> +{
> +	for (int i = 0; i < mb->spi_cs_count; ++i) {
> +		if (strcmp(cs_name, mb->spi_cs[i].cs_name) == 0)
> +			return mb->spi_cs[i].cs;
> +	}
> +
> +	return -1;

what does -1 mean?  Use real error numbers please.

> +}
> +
> +static int mikrobus_spi_set_cs(struct device *dev, struct device_node *np)
> +{
> +	struct mikrobus_port *mb = dev_get_drvdata(dev);
> +	const char *temp_str;
> +	int reg_len;
> +	int ret, i;
> +	u32 *reg = NULL;
> +
> +	reg_len = of_property_count_strings(np, "spi-cs");
> +	/* Use default cs if spi-cs property not present */
> +	if (reg_len <= 0) {
> +		reg_len = 1;
> +		reg = devm_kmalloc_array(dev, reg_len, sizeof(*reg),
> +					 GFP_KERNEL);
> +		if (!reg)
> +			return -ENOMEM;
> +
> +		ret = mikrobus_lookup_cs(mb, "default");
> +		if (ret < 0)
> +			goto free_reg;
> +
> +		reg[0] = ret;
> +	} else {
> +		reg = devm_kmalloc_array(dev, reg_len, sizeof(*reg),
> +					 GFP_KERNEL);
> +		if (!reg)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < reg_len; ++i) {
> +			ret = of_property_read_string_index(np, "spi-cs", i,
> +							    &temp_str);
> +			if (ret < 0)
> +				goto free_reg;
> +
> +			ret = mikrobus_lookup_cs(mb, temp_str);
> +			if (ret < 0)
> +				goto free_reg;
> +
> +			reg[i] = ret;
> +		}
> +	}
> +
> +	ret = of_changeset_add_prop_u32_array(&mb->board_ocs, np, "reg", reg,
> +					      reg_len);
> +	if (ret < 0)
> +		goto free_reg;
> +
> +	ret = of_changeset_apply(&mb->board_ocs);
> +	if (ret < 0)
> +		goto free_reg;
> +
> +	devm_kfree(dev, reg);
> +	return 0;
> +
> +free_reg:
> +	devm_kfree(dev, reg);
> +	return ret;
> +}
> +
> +static int of_register_mikrobus_device(struct mikrobus_port *mb,
> +				       struct device_node *np)
> +{
> +	const char *temp_str;
> +	int i, pinctrl_count, ret;
> +	struct spi_device *spi_dev;
> +	struct device *dev = &mb->dev->dev;

That's some pointer dereferencing without checking anything, what could
go wrong...

Why don't you have your own real device?  Why are you relying on a
platform device without actually showing your device anywhere in the
kernel's device topology?  Are you sure that is ok?


> +
> +	pinctrl_count = of_property_count_strings(np, "pinctrl-apply");
> +	if (pinctrl_count < 0)
> +		return dev_err_probe(dev, pinctrl_count,
> +				     "Missing required property pinctrl-apply");
> +
> +	for (i = 0; i < pinctrl_count; ++i) {
> +		ret = of_property_read_string_index(np, "pinctrl-apply", i,
> +						    &temp_str);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mikrobus_pinctrl_select(dev, temp_str);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to set pinctrl");
> +	}
> +
> +	if (mb->spi_ctrl && !mb->spi_dev &&
> +	    of_device_is_compatible(np, "mikrobus-spi")) {
> +		ret = mikrobus_spi_set_cs(dev, np);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to set SPI chipselect");
> +
> +		spi_dev = of_register_spi_device(mb->spi_ctrl, np);
> +		if (IS_ERR(spi_dev))
> +			return dev_err_probe(dev, PTR_ERR(spi_dev),
> +					     "Failed to register SPI device");
> +		mb->spi_dev = spi_dev;
> +	}
> +
> +	return 0;
> +}
> +
> +static int of_register_mikrobus_board(struct mikrobus_port *mb)
> +{
> +	struct device *dev = &mb->dev->dev;
> +	int board_len, i, ret;
> +	struct device_node *np;
> +
> +	board_len = of_count_phandle_with_args(dev->of_node, "board", NULL);
> +	for (i = 0; i < board_len; ++i) {
> +		np = of_parse_phandle(dev->of_node, "board", i);
> +		if (!np) {
> +			ret = dev_err_probe(dev, -ENODEV, "Board not found");
> +			goto free_np;
> +		}
> +
> +		ret = of_register_mikrobus_device(mb, np);
> +		if (ret < 0)
> +			goto free_np;
> +
> +		of_node_put(np);
> +	}
> +
> +	return 0;
> +free_np:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +static int mikrobus_port_probe(struct platform_device *pdev)
> +{
> +	int ret, i;
> +	struct mikrobus_port *mb;
> +	struct device_node *np;
> +	struct device *dev = &pdev->dev;
> +
> +	mb = devm_kmalloc(dev, sizeof(*mb), GFP_KERNEL);
> +	if (!mb)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, mb);
> +
> +	of_changeset_init(&mb->board_ocs);
> +	mb->dev = pdev;
> +	mb->pctrl = NULL;
> +	mb->spi_ctrl = NULL;
> +	mb->spi_dev = NULL;
> +	mb->spi_cs = NULL;
> +	mb->spi_cs_count = 0;
> +
> +	mb->pctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(mb->pctrl))
> +		return dev_err_probe(dev, PTR_ERR(mb->pctrl),
> +				     "failed to get pinctrl [%ld]",
> +				     PTR_ERR(mb->pctrl));
> +
> +	np = of_parse_phandle(dev->of_node, "spi-controller", 0);
> +	if (np) {
> +		mb->spi_ctrl = of_find_spi_controller_by_node(np);
> +		if (mb->spi_ctrl) {
> +			ret = of_property_count_u32_elems(dev->of_node,
> +							  "spi-cs");
> +			if (ret < 0) {
> +				dev_err(dev, "Missing property spi-cs");
> +				goto free_np;
> +			}
> +
> +			mb->spi_cs_count = ret;
> +
> +			ret = of_property_count_strings(dev->of_node,
> +							"spi-cs-names");
> +			if (ret < 0) {
> +				dev_err(dev, "Missing property spi-cs-names");
> +				goto free_np;
> +			}
> +
> +			if (mb->spi_cs_count != ret) {
> +				ret = dev_err_probe(
> +					dev, -EINVAL,
> +					"spi-cs and spi-cs-names out of sync");
> +				goto free_np;
> +			}
> +
> +			mb->spi_cs = devm_kmalloc_array(dev, mb->spi_cs_count,
> +							sizeof(*mb->spi_cs),
> +							GFP_KERNEL);
> +			if (!mb->spi_cs) {
> +				ret = -ENOMEM;
> +				goto free_np;
> +			}
> +
> +			for (i = 0; i < mb->spi_cs_count; ++i) {
> +				of_property_read_u32_index(dev->of_node,
> +							   "spi-cs", i,
> +							   &mb->spi_cs->cs);
> +				of_property_read_string_index(
> +					dev->of_node, "spi-cs-names", i,
> +					&mb->spi_cs->cs_name);
> +			}
> +		}
> +	}
> +	of_node_put(np);
> +
> +	ret = of_register_mikrobus_board(mb);
> +	if (ret < 0)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to register mikrobus board");
> +
> +	return 0;
> +
> +free_np:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +static void mikrobus_port_remove(struct platform_device *pdev)
> +{
> +	struct mikrobus_port *mb = dev_get_drvdata(&pdev->dev);
> +
> +	spi_unregister_device(mb->spi_dev);
> +
> +	of_changeset_revert(&mb->board_ocs);
> +}
> +
> +static const struct of_device_id mikrobus_port_of_match[] = {
> +	{ .compatible = "mikrobus-connector" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mikrobus_port_of_match);
> +
> +static struct platform_driver mikrobus_port_driver = {
> +	.probe = mikrobus_port_probe,
> +	.remove = mikrobus_port_remove,

Again, why is this a platform driver?  Why is a platform device used at
all here?

> +	.driver = {
> +		.name = "mikrobus",
> +		.of_match_table = mikrobus_port_of_match,
> +	},
> +};
> +
> +static const struct bus_type mikrobus_bus_type = {
> +	.name = "mikrobus",
> +};
> +
> +static int mikrobus_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&mikrobus_bus_type);
> +	if (ret) {
> +		pr_err("bus_register failed (%d)", ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&mikrobus_port_driver);
> +	if (ret)
> +		pr_err("driver register failed [%d]", ret);

It fails yet you leave your bus around?  Not good :(

thanks,

greg k-h

