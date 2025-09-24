Return-Path: <linux-spi+bounces-10278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B5B9954E
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEE93B208C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270A2DE700;
	Wed, 24 Sep 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BAolSVOj"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C72DAFDB;
	Wed, 24 Sep 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708217; cv=none; b=JR2BZUuUOWX2aYIRcHILi1DzLYEUyxnS050MsKypbdQ/ZDMUn7YqSPeKHTUQM+DvLnDdAJlRN3aqs2keb54ThZ3eIRjh/3lZrJmfJIr/gxSlQTq3waAyM1XUvwXrY5mZsf26uk/v7KALIXbRwNjoh0XF2n9WRlRVjpWCAGAkyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708217; c=relaxed/simple;
	bh=1Dwj4DDAClH57u8KSaffsXuVj3ZkHmFsVkMIZrY6do8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBwG30+0CCc9WMVD9CpUCnDsnsskLp8BJ0nkgX+v6pFXiX2IMvOd7UAw/kqR7qdImPAAl4z0X+gHp0VpHxJiZKPWq2l0q+iRjvCfVEKxJlLJI14Jmr6tUN8d+n9jrV04hBmq0zHoBUNca++7oayBbG2D6vqCdQ2hvDJWaweAMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BAolSVOj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 056951E37;
	Wed, 24 Sep 2025 12:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708126;
	bh=1Dwj4DDAClH57u8KSaffsXuVj3ZkHmFsVkMIZrY6do8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAolSVOjKBUhRwHA2CL+lnxcrodvE1QCeSjHug3yG3qLGIpQrwh/ZsdjAtLBsYmoM
	 vj9CSy4snIVgv5t5KeMCifM+3A8dJlfhNwUIv0dsdLeIcBgTPuxu0bYLwwNTsqFM2n
	 pu7/xUIZcllmNJrp0Jw3fI2v+8VPGng6147wnKvU=
Date: Wed, 24 Sep 2025 13:02:56 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matthias Fend <matthias.fend@emfend.at>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 13/16] leds: Use fwnode_for_each_child_node() instead
Message-ID: <20250924100256.GK28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-14-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-14-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:59AM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/leds/leds-max5970.c     | 2 +-
>  drivers/leds/leds-max77705.c    | 2 +-
>  drivers/leds/rgb/leds-ktd202x.c | 4 ++--
>  drivers/leds/rgb/leds-ncp5623.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> index 285074c53b23..a1e91a06249c 100644
> --- a/drivers/leds/leds-max5970.c
> +++ b/drivers/leds/leds-max5970.c
> @@ -60,7 +60,7 @@ static int max5970_led_probe(struct platform_device *pdev)
>  	if (!led_node)
>  		return -ENODEV;
>  
> -	fwnode_for_each_available_child_node(led_node, child) {
> +	fwnode_for_each_child_node(led_node, child) {
>  		u32 reg;
>  
>  		if (fwnode_property_read_u32(child, "reg", &reg))
> diff --git a/drivers/leds/leds-max77705.c b/drivers/leds/leds-max77705.c
> index b7403b3fcf5e..1e2054c1bf80 100644
> --- a/drivers/leds/leds-max77705.c
> +++ b/drivers/leds/leds-max77705.c
> @@ -191,7 +191,7 @@ static int max77705_add_led(struct device *dev, struct regmap *regmap, struct fw
>  		cdev->brightness_set_blocking = max77705_led_brightness_set_multi;
>  		cdev->blink_set = max77705_rgb_blink;
>  
> -		fwnode_for_each_available_child_node(np, child) {
> +		fwnode_for_each_child_node(np, child) {
>  			ret = max77705_parse_subled(dev, child, &info[i]);
>  			if (ret < 0)
>  				return ret;
> diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
> index 04e62faa3a00..e4f0f25a5e45 100644
> --- a/drivers/leds/rgb/leds-ktd202x.c
> +++ b/drivers/leds/rgb/leds-ktd202x.c
> @@ -391,7 +391,7 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwn
>  	int i = 0;
>  
>  	num_channels = 0;
> -	fwnode_for_each_available_child_node(fwnode, child)
> +	fwnode_for_each_child_node(fwnode, child)
>  		num_channels++;
>  
>  	if (!num_channels || num_channels > chip->num_leds)
> @@ -401,7 +401,7 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwn
>  	if (!info)
>  		return -ENOMEM;
>  
> -	fwnode_for_each_available_child_node(fwnode, child) {
> +	fwnode_for_each_child_node(fwnode, child) {
>  		u32 mono_color;
>  		u32 reg;
>  		int ret;
> diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
> index 7c7d44623a9e..85d6be6fff2b 100644
> --- a/drivers/leds/rgb/leds-ncp5623.c
> +++ b/drivers/leds/rgb/leds-ncp5623.c
> @@ -180,7 +180,7 @@ static int ncp5623_probe(struct i2c_client *client)
>  		goto release_mc_node;
>  	}
>  
> -	fwnode_for_each_available_child_node(mc_node, led_node) {
> +	fwnode_for_each_child_node(mc_node, led_node) {
>  		ret = fwnode_property_read_u32(led_node, "color", &color_index);
>  		if (ret)
>  			goto release_led_node;

-- 
Regards,

Laurent Pinchart

