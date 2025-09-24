Return-Path: <linux-spi+bounces-10279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C769B99568
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541194C5C5E
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A442DCF6F;
	Wed, 24 Sep 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="M6+umNyh"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EB2DCF45;
	Wed, 24 Sep 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708237; cv=none; b=TDTeeOX6qDG1QCTroerosiA+pCnQ8VqtHFGEkPP+1V3NJaoxq9UeyM9nbTQ4nfVrUpggZdKchyZqP+UOivZ8lMfrxKLwGAqnGqbslMRWrh2YL6QkWarvmQ42sCaN8XAY+Y/YkPisHmYMlK/MAkzOthGkotRaznJLgnB16OojHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708237; c=relaxed/simple;
	bh=6cHySMqB+nzdaLylF7tksdYECDnHe6+rUeyfobW53Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAyN2+dkqjuOWTnmYdSfCaUcslZtTmGl+X9pmqGvuvN8fGEj4DEHHPipHqAlhJzEhTVwNspPE+fL6PvS0waOt8dMgwDKMpjv9RV22+/1F0vq4+l2JoaQet+gpzaiSa0JffPyzk8aT6zJIye7DJ7Q2urztYIvP5i3UlZpGEZGNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=M6+umNyh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id A60761E31;
	Wed, 24 Sep 2025 12:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708147;
	bh=6cHySMqB+nzdaLylF7tksdYECDnHe6+rUeyfobW53Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6+umNyhbn87M0CQ8scvEmsXjFyyLqnw083DoAJO+dHBIlcBry/x8wBh+0zKGjNxv
	 tD4bracrfA2yzq8D303kqqBIEKlec5ILEGaAurnFj9fz6ZnTxrIiYYUTvI0M06gYmB
	 im46XpsEHCcwd35rSXRDGVxmiz5f9jBNP0f7TZuA=
Date: Wed, 24 Sep 2025 13:03:17 +0300
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
Subject: Re: [PATCH v2 14/16] leds: Use fwnode_get_next_child_node() instead
Message-ID: <20250924100317.GL28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-15-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-15-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:46:00AM +0300, Sakari Ailus wrote:
> fwnode_get_next_child_node() is now the same as
> fwnode_get_next_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants (device_get_next_child_node() in this case).
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/leds/flash/leds-rt4505.c   | 2 +-
>  drivers/leds/flash/leds-rt8515.c   | 2 +-
>  drivers/leds/flash/leds-sgm3140.c  | 3 +--
>  drivers/leds/flash/leds-tps6131x.c | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/leds/flash/leds-rt4505.c b/drivers/leds/flash/leds-rt4505.c
> index f16358b8dfc1..18fd5b7e528f 100644
> --- a/drivers/leds/flash/leds-rt4505.c
> +++ b/drivers/leds/flash/leds-rt4505.c
> @@ -365,7 +365,7 @@ static int rt4505_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	child = fwnode_get_next_available_child_node(client->dev.fwnode, NULL);
> +	child = device_get_next_child_node(&client->dev, NULL);
>  	if (!child) {
>  		dev_err(priv->dev, "Failed to get child node\n");
>  		return -EINVAL;
> diff --git a/drivers/leds/flash/leds-rt8515.c b/drivers/leds/flash/leds-rt8515.c
> index 6af0d2c7fc56..f6b439674c03 100644
> --- a/drivers/leds/flash/leds-rt8515.c
> +++ b/drivers/leds/flash/leds-rt8515.c
> @@ -304,7 +304,7 @@ static int rt8515_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(rt->enable_torch),
>  				     "cannot get ENT (enable torch) GPIO\n");
>  
> -	child = fwnode_get_next_available_child_node(dev->fwnode, NULL);
> +	child = device_get_next_child_node(dev, NULL);
>  	if (!child) {
>  		dev_err(dev,
>  			"No fwnode child node found for connected LED.\n");
> diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
> index 3e83200675f2..dc6840357370 100644
> --- a/drivers/leds/flash/leds-sgm3140.c
> +++ b/drivers/leds/flash/leds-sgm3140.c
> @@ -214,8 +214,7 @@ static int sgm3140_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "Failed to request regulator\n");
>  
> -	child_node = fwnode_get_next_available_child_node(pdev->dev.fwnode,
> -							  NULL);
> +	child_node = device_get_next_child_node(&pdev->dev, NULL);
>  	if (!child_node) {
>  		dev_err(&pdev->dev,
>  			"No fwnode child node found for connected LED.\n");
> diff --git a/drivers/leds/flash/leds-tps6131x.c b/drivers/leds/flash/leds-tps6131x.c
> index 6f4d4fd55361..f0f1f2b77d5a 100644
> --- a/drivers/leds/flash/leds-tps6131x.c
> +++ b/drivers/leds/flash/leds-tps6131x.c
> @@ -544,7 +544,7 @@ static int tps6131x_parse_node(struct tps6131x *tps6131x)
>  
>  	tps6131x->valley_current_limit = device_property_read_bool(dev, "ti,valley-current-limit");
>  
> -	tps6131x->led_node = fwnode_get_next_available_child_node(dev->fwnode, NULL);
> +	tps6131x->led_node = device_get_next_child_node(dev, NULL);
>  	if (!tps6131x->led_node) {
>  		dev_err(dev, "Missing LED node\n");
>  		return -EINVAL;

-- 
Regards,

Laurent Pinchart

