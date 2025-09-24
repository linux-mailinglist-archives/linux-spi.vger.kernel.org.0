Return-Path: <linux-spi+bounces-10266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871DBB99227
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AA219C6791
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBE2D7DD2;
	Wed, 24 Sep 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gF52eEVl"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCD27A47F;
	Wed, 24 Sep 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706120; cv=none; b=RPomV/sHOeSwI/GjgKTG3jzIa7HZyT1lQZSd4tuT4Yufz0QhB0KTPUkZtg5SSsnx7uIWiyBylnwPWh+vetgykzgp8gNjiqB4yh9iHzYUOQ6Fkqf0PlPU7hII4DWsOqDR+QlHPWNckwlnH54rbW+I8k3ExyFE6tCTZNgqkqi6hlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706120; c=relaxed/simple;
	bh=Mvtpnlgmu4fkZBD1ciM4YyQufHOelWXpMzob6t85g5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl6Xxfx6wE1UXdCYDzsucpwrvofo1QN0hd/iFFQuX5ZkrRiYItCoZGIfVb1/LvbITBf6TdPTLreUJeTH/iRr5IUbY6/KJIfPiQ1dvUU6L2ttOmOBNXTTt7jcqb5K2Q6OjQn7EtKf3leQu6Ceq/CupUfG6+jSZcI4A0YYX6yhGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gF52eEVl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 5FC95BE4;
	Wed, 24 Sep 2025 11:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758706020;
	bh=Mvtpnlgmu4fkZBD1ciM4YyQufHOelWXpMzob6t85g5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF52eEVlwp4aTR924B7Rti2uGM0f7hC4JEmyvLceIpfAyzAXSzwJmFqmg2TzuILyB
	 0xrF+Du8u+XMGdfhm1v8nCT1eLkoWjc0k5GPAVWlThxKSZ4S2bd6Fy+9fbGA5/JmAM
	 gfftysU8zP/q92FlJRRS+ZFBDDJlvD/cdFEKRG7I=
Date: Wed, 24 Sep 2025 12:27:50 +0300
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
Subject: Re: [PATCH v2 01/16] ACPI: property: Make acpi_get_next_subnode()
 static
Message-ID: <20250924092750.GA28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-2-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Wed, Sep 24, 2025 at 10:45:47AM +0300, Sakari Ailus wrote:
> acpi_get_next_subnode() is only used in drivers/acpi/property.c. Remove
> its prototype from include/linux/acpi.h and make it static.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/acpi/property.c |  5 +++--
>  include/linux/acpi.h    | 10 ----------
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 436019d96027..5435628c67e7 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1264,8 +1264,9 @@ static int stop_on_next(struct acpi_device *adev, void *data)
>   * @fwnode: Firmware node to find the next child node for.
>   * @child: Handle to one of the device's child nodes or a null handle.
>   */
> -struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
> -					    struct fwnode_handle *child)
> +static struct fwnode_handle *
> +acpi_get_next_subnode(const struct fwnode_handle *fwnode,
> +		      struct fwnode_handle *child)
>  {
>  	struct acpi_device *adev = to_acpi_device_node(fwnode);
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5ff5d99f6ead..703323b9fe0c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1349,9 +1349,6 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
>  int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
>  		       void **valptr);
>  
> -struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
> -					    struct fwnode_handle *child);
> -
>  struct acpi_probe_entry;
>  typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
>  						 struct acpi_probe_entry *);
> @@ -1450,13 +1447,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
>  	return -ENXIO;
>  }
>  
> -static inline struct fwnode_handle *
> -acpi_get_next_subnode(const struct fwnode_handle *fwnode,
> -		      struct fwnode_handle *child)
> -{
> -	return NULL;
> -}
> -
>  static inline struct fwnode_handle *
>  acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>  			     struct fwnode_handle *prev)

-- 
Regards,

Laurent Pinchart

