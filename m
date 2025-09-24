Return-Path: <linux-spi+bounces-10274-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90EEB994E7
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F6C7B49B7
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574662DC770;
	Wed, 24 Sep 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d+yuqGct"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49A2DBF4B;
	Wed, 24 Sep 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708149; cv=none; b=ED7MGxE92+sKI5h/R9F8GtK7vPSLktAi8dQw6PWk5MwEukkGGjwnA6tXSNwkg36nJQ8dIUVQh7SnD9aPCxLwit7VH7BaW5Jy94722NWU7weAChgF7w8BZTFrk6CJfJGAn8UTbo69tiqrG1TG0THZAAq6oCdBtvJI5yBu79NaE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708149; c=relaxed/simple;
	bh=ZVkoSQMr1f/bgfl2m/mI9fBcWPCJ33j/JRFQcTIkeQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7houdtS3ZF+UGRY/OY8xfnqGezAUy1XgS0ApILggL0aZEgfT53tMtw+jNCXypo4CGP8U6J3kLmvQo1nlBmbvyXQUVh9EdydacCNXFP+3DpS2/LeH6tgfSNZ/csh3SoDzDFZjEwxZufqkOGmEJ2mxwRU3ybsyXhRoN4DZ3Vh14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d+yuqGct; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 13C721E31;
	Wed, 24 Sep 2025 12:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708057;
	bh=ZVkoSQMr1f/bgfl2m/mI9fBcWPCJ33j/JRFQcTIkeQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+yuqGctkZ5gPhYUHmmoExk0s7MpOEPVPCpYRABhENbZmy3vOTOtkdbtQUom5kGYr
	 tm1dekQtN9ktoAiye3fop++yEjsLky91hM5hQ1HAr5lV7FU3Z75+NRO5RMQkIUN3Mt
	 AwDML7jE3JlLdomgA5NEWDcowkCGJrOeWxDax2EA=
Date: Wed, 24 Sep 2025 13:01:47 +0300
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
Subject: Re: [PATCH v2 09/16] driver core: Use fwnode_for_each_child_node()
 instead
Message-ID: <20250924100147.GG28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-10-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-10-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:55AM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/base/core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..4bffd347e2f9 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -185,7 +185,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
>  	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
>  	fwnode_links_purge_consumers(fwnode);
>  
> -	fwnode_for_each_available_child_node(fwnode, child)
> +	fwnode_for_each_child_node(fwnode, child)
>  		fw_devlink_purge_absent_suppliers(child);
>  }
>  EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
> @@ -231,7 +231,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
>  	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
>  	__fwnode_links_move_consumers(fwnode, new_sup);
>  
> -	fwnode_for_each_available_child_node(fwnode, child)
> +	fwnode_for_each_child_node(fwnode, child)
>  		__fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>  
> @@ -1318,7 +1318,7 @@ void device_links_driver_bound(struct device *dev)
>  
>  		guard(mutex)(&fwnode_link_lock);
>  
> -		fwnode_for_each_available_child_node(dev->fwnode, child)
> +		fwnode_for_each_child_node(dev->fwnode, child)
>  			__fw_devlink_pickup_dangling_consumers(child,
>  							       dev->fwnode);
>  		__fw_devlink_link_to_consumers(dev);
> @@ -1736,7 +1736,7 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
>  
>  	fw_devlink_parse_fwnode(fwnode);
>  
> -	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
> +	while ((child = fwnode_get_next_child_node(fwnode, child)))
>  		fw_devlink_parse_fwtree(child);
>  }
>  
> @@ -2309,7 +2309,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
>  	 * case where the supplier is added before the consumer's parent device
>  	 * (@dev).
>  	 */
> -	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
> +	while ((child = fwnode_get_next_child_node(fwnode, child)))
>  		__fw_devlink_link_to_suppliers(dev, child);
>  }
>  

-- 
Regards,

Laurent Pinchart

