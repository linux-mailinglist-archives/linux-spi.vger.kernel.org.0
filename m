Return-Path: <linux-spi+bounces-2178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE01897A3D
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 22:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81653280D7B
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F21154BE2;
	Wed,  3 Apr 2024 20:47:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A8155A25
	for <linux-spi@vger.kernel.org>; Wed,  3 Apr 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177260; cv=none; b=VUxqxDo5YidAt8o3ZpzgrbXXnrTzaAjGd8SXrBvv+g4TsYxr8hHy8eb0z6HKBcOOz2iTxsUYJLncVKlPPNKvzfSvwPGY6GqVDtvEul4C58J2xW69vPsZDvVPQMupDAA/1kGVudpebkGQdOcfIr+DtfnntcJQ0los7oN1A2Oa2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177260; c=relaxed/simple;
	bh=WRGBXt3Q9FQDtJDgYZEE7owtFQclfiRMvwtWshFj3Vo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBvVxjzFaP2xWh5y5ubc9HNXr4+B3sYX7qMfHiBxo51q/sBZMgqCDQsTjnwLpcofP9apgv1DGDhBUlcybClQMbTiGA5c2jEa2Ggk6j/JW8KHF1QwLKYUIhTh26QvDcI8mZhDbMc4uk9a6wN8vrRra7z9KVVQ9w0NEbnfxhjY/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 6732ed81-f1fb-11ee-a9de-005056bdf889;
	Wed, 03 Apr 2024 23:47:36 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Apr 2024 23:47:36 +0300
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v3 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329114730.360313-4-ckeepax@opensource.cirrus.com>

Fri, Mar 29, 2024 at 11:47:30AM +0000, Charles Keepax kirjoitti:
> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> 
> On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually.
> 
> Check for the presence of the "01fa-cirrus-sidecar-instances" property
> in the SDCA extension unit's ACPI properties to confirm the presence
> of these two amplifiers and if they exist add them manually onto the
> SPI bus.

...

> +#include <dt-bindings/gpio/gpio.h>

Hmm... Is it requirement by gpiolib-swnode? (I haven't looked at the use cases,
I'm not the author of this idea, hence the Q).

> +#include <linux/acpi.h>

You need array_size.h (and perhaps overflow.h) and property.h.

...

> +static struct spi_board_info ampl_info = {
> +	.modalias		= "cs35l56",
> +	.max_speed_hz		= 2000000,

Maybe HZ_PER_MHZ from units.h?

> +	.chip_select		= 0,
> +	.mode			= SPI_MODE_0,
> +	.swnode			= &ampl,
> +	.use_fwnode_name	= true,
> +};
> +
> +static struct spi_board_info ampr_info = {
> +	.modalias		= "cs35l56",
> +	.max_speed_hz		= 2000000,

Ditto.

> +	.chip_select		= 1,
> +	.mode			= SPI_MODE_0,
> +	.swnode			= &ampr,
> +	.use_fwnode_name	= true,
> +};

...

> +static const struct software_node_ref_args cs42l43_cs_refs[] = {

Please, use SOFTWARE_NODE_REFERENCE().

> +	{
> +		.node		= &cs42l43_gpiochip_swnode,
> +		.nargs		= 2,
> +		.args		= { 0, GPIO_ACTIVE_LOW },
> +	},
> +	{
> +		.node		= &swnode_gpio_undefined,
> +		.nargs		= 0,
> +	},
> +};
> +
> +static const struct property_entry cs42l43_cs_props[] = {
> +	{
> +		.name		= "cs-gpios",
> +		.length		= ARRAY_SIZE(cs42l43_cs_refs) *
> +				  sizeof(struct software_node_ref_args),
> +		.type		= DEV_PROP_REF,
> +		.pointer	= cs42l43_cs_refs,
> +	},

You want PROPERTY_ENTRY_REF_ARRAY().. 

> +	{}
> +};

...

> +#if IS_ENABLED(CONFIG_ACPI)

No need (see below)?

> +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> +{
> +	static const int func_smart_amp = 0x1;
> +	struct fwnode_handle *child_fwnode, *ext_fwnode;
> +	unsigned long long function;
> +	unsigned int val;
> +	int ret;

> +	if (!is_acpi_node(fwnode))
> +		return false;

Dup, your loop will perform the same effectivelly.

> +	fwnode_for_each_child_node(fwnode, child_fwnode) {

> +		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
> +
> +		ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &function);
> +		if (ACPI_FAILURE(ret) || function != func_smart_amp) {
> +			fwnode_handle_put(fwnode);
> +			continue;
> +		}

acpi_get_local_address() (it has a stub for CONFIG_ACPI=n).

> +		ext_fwnode = fwnode_get_named_child_node(child_fwnode,
> +				"mipi-sdca-function-expansion-subproperties");
> +		if (!ext_fwnode) {

> +			fwnode_handle_put(fwnode);

Are you sure?

> +			continue;
> +		}
> +
> +		ret = fwnode_property_read_u32(ext_fwnode,
> +					       "01fa-cirrus-sidecar-instances",
> +					       &val);
		
> +
> +		fwnode_handle_put(ext_fwnode);

> +		fwnode_handle_put(fwnode);

Are you sure?

> +		if (!ret)
> +			return !!val;
> +	}
> +
> +	return false;
> +}

...

> -	device_set_node(&priv->ctlr->dev, fwnode);
> +	if (has_sidecar) {
> +		ret = software_node_register(&cs42l43_gpiochip_swnode);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to register gpio swnode: %d\n", ret);
> +			return ret;
> +		}

> +		ret = device_create_managed_software_node(&priv->ctlr->dev, cs42l43_cs_props, NULL);

No, this must not be used (I'm talking about _managed variant), this is a hack
for backward compatibility.

> +		if (ret) {
> +			dev_err(priv->dev, "Failed to add swnode: %d\n", ret);
> +			goto err;
> +		}

> +

Redundant blank line.

> +	} else {
> +		device_set_node(&priv->ctlr->dev, fwnode);
> +	}
>  
>  	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
>  	if (ret) {
>  		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
> +		goto err;
> +	}
> +
> +	if (has_sidecar) {
> +		if (!spi_new_device(priv->ctlr, &ampl_info)) {
> +			ret = -ENODEV;
> +			dev_err(priv->dev, "Failed to create left amp slave\n");
> +			goto err;
> +		}
> +
> +		if (!spi_new_device(priv->ctlr, &ampr_info)) {
> +			ret = -ENODEV;
> +			dev_err(priv->dev, "Failed to create right amp slave\n");
> +			goto err;
> +		}
>  	}
>  
> +	return 0;
> +
> +err:
> +	if (has_sidecar)
> +		software_node_unregister(&cs42l43_gpiochip_swnode);
> +
>  	return ret;
>  }

Wondering why don't you use return dev_err_probe() / ret = dev_err_probe() /
dev_err_probe(ret)?

> +static int cs42l43_spi_remove(struct platform_device *pdev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);

platform_get_drvdata()

> +	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);

Is this dev the same as &pdev->dev?

> +	bool has_sidecar = cs42l43_has_sidecar(fwnode);
> +
> +	if (has_sidecar)
> +		software_node_unregister(&cs42l43_gpiochip_swnode);
> +
> +	return 0;
> +};

-- 
With Best Regards,
Andy Shevchenko



