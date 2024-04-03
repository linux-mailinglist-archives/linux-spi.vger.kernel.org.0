Return-Path: <linux-spi+bounces-2176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165208979BA
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 22:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94AC1F27185
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21D155A30;
	Wed,  3 Apr 2024 20:21:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81261552FD
	for <linux-spi@vger.kernel.org>; Wed,  3 Apr 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175699; cv=none; b=HaQXhJJX3IyrD2USomm0bkmo5XuwWNGVCgyjOArFfVhr6og0DkTyyvZmHMQU6AaSOFq1snoc/OPFgVdTwpWz6o+JtHWanH+0/eJi8UZthpCPZQRs2n67lsS/HxGhCj4hjNux8leSSREtmNeP0O0NvDKnrGk0ZGAwoZAGBzrN38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175699; c=relaxed/simple;
	bh=6ik5zYeoSy13e/6i/ggDabkweeldqQoJRkzAijEiRh8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpkCMV7bUqxwByZC0dY/WzsIW4PubwnrW3zujiW3LsQrKSPvsdtkcThlm1hZlZ/35dtZgikZ6gW/kTXNqvCnWSHsTvICjKXJvZ+AsN2EkVoU7rCgg/OV8HHQQf+///ZmBfJlfDD85maraF6js/jAIjFJMZya1iQP7D2clgjJPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id c0efb0c7-f1f7-11ee-abf4-005056bdd08f;
	Wed, 03 Apr 2024 23:21:29 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Apr 2024 23:21:28 +0300
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <Zg26SKlGtwRvoUDW@surfacebook.localdomain>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329114730.360313-2-ckeepax@opensource.cirrus.com>

Fri, Mar 29, 2024 at 11:47:28AM +0000, Charles Keepax kirjoitti:
> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
> 
>         cs-gpios = <&gpio1 0 0>, <0>;
> 
> Here the second chip select is native. However, when using swnodes
> there is currently no way to specify a native chip select. The
> proposal here is to register a swnode_gpio_undefined software node,
> that can be specified to allow the indication of a native chip
> select. For example:
> 
> static const struct software_node_ref_args device_cs_refs[] = {
> 	{
> 		.node  = &device_gpiochip_swnode,
> 		.nargs = 2,
> 		.args  = { 0, GPIO_ACTIVE_LOW },
> 	},
> 	{
> 		.node  = &swnode_gpio_undefined,
> 		.nargs = 0,
> 	},
> };
> 
> Register the swnode as the gpiolib is initialised and
> check in swnode_get_gpio_device if the returned node matches
> swnode_gpio_undefined and return -ENOENT, which matches the behaviour
> of the device tree system when it encounters a 0 phandle.

...

> +const struct software_node swnode_gpio_undefined = {
> +	.name = "gpio-internal-undefined",

This name is still too generic, perhaps "software-node-undefined-gpio"?

> +};
> +EXPORT_SYMBOL_GPL(swnode_gpio_undefined);

Maybe we can start using namespaces?

...

> +	if (!strcmp(gdev_node->name, "gpio-internal-undefined"))

Probably it needs a definition to avoid typos in case somebody wants to change
the name.

#define	GPIOLIB_SWNODE_UNDEFINED	"..."

?

> +		return ERR_PTR(-ENOENT);

...

>  static int __init gpiolib_debugfs_init(void)
>  {
> +	int ret;
> +
> +	ret = software_node_register(&swnode_gpio_undefined);
> +	if (ret < 0) {
> +		pr_err("gpiolib: failed to register swnode: %d\n", ret);
> +		return ret;
> +	}
> +
>  	/* /sys/kernel/debug/gpio */
>  	debugfs_create_file("gpio", 0444, NULL, NULL, &gpiolib_fops);
> +
>  	return 0;
>  }
>  subsys_initcall(gpiolib_debugfs_init);

I believe now it's time to get __exitcall to be implemented. Actually the above
already needs that. Besides that, what you are adding doesn't belong to debugfs
AFAICS. And why it can't be done in gpiolib-swnode.c?

-- 
With Best Regards,
Andy Shevchenko



