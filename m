Return-Path: <linux-spi+bounces-10270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8ECB99446
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 11:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EE3B6BCB
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E392D9EFC;
	Wed, 24 Sep 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UBfJOepM"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01815624D;
	Wed, 24 Sep 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707884; cv=none; b=hrlj2GMY0OzOUpuxFFsYa5AOY74FUX7wGfjssBcLF9wwiZKqNkIodH7Oxa+z7gSjWxS4wVGqfXhwVYF0ueT5DenDVRfU6YeJnsASBC2/sEtiQ/6lYw7HKEWkKYibG4ximem6lnXJMRNHXrxHdYx/cIIv7gGKv9gTZoVpMSj4uWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707884; c=relaxed/simple;
	bh=z216LoX9X55cYuHe5JrSL3qC2h8WWC3NHYL+anfwmow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl/SCAf1GjrQlT1o9psmRwJImJZwHdiyXgJUYys+YbZxiPxAZUoHSfLl2lg68s6bZK86syVgTy8tVX1c1KFuChKeYfpHSguE4bc/mlYCBnACu9fgnk1fulM9d23HiP2+0IH7KkDVMxRthN/39WMW5iw+kAKP/RD/oIEAU1Bivq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UBfJOepM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id C0633BE4;
	Wed, 24 Sep 2025 11:56:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758707795;
	bh=z216LoX9X55cYuHe5JrSL3qC2h8WWC3NHYL+anfwmow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBfJOepMoryVjYzbfqQZ3rKpNtk0sGgpt3iToI5SeEfuGK2TQRFZWl++SRuM/Gk4n
	 8yRs/97KSQusrq7c8KduUSXfx6RjBgcGuC7yGysWPG0diWKduqaLCybVdKaIANtxwL
	 gzOrROWPwkMES4R/MP+FYR32e5nR9iID/viqIrA0=
Date: Wed, 24 Sep 2025 12:57:25 +0300
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
Subject: Re: [PATCH v2 04/16] ACPI: property: Return present device nodes
 only on fwnode interface
Message-ID: <20250924095725.GD28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-5-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-5-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:50AM +0300, Sakari Ailus wrote:
> fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
> nodes and there has been no check these devices are present in the system,
> unlike there has been on fwnode OF backend. In order to provide consistent
> behaviour towards callers, add a check for device presence by introducing
> a new function acpi_get_next_present_subnode(), used as the
> get_next_child_node() fwnode operation that also checks device node
> presence.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 5438592dc136..01f3880ffcce 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1319,6 +1319,26 @@ acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  	return NULL;
>  }
>  
> +/**

/*

as the function is static ?

> + * acpi_get_next_present_subnode - Return the next present child node handle for a fwnode
> + * @fwnode: Firmware node to find the next child node for.
> + * @child: Handle to one of the device's child nodes or a null handle.

A blank line here would be nice.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> + * Like acpi_get_next_subnode(), but the device nodes returned by
> + * acpi_get_next_present_subnode() are guaranteed to be present.
> + * Returns: The next sub-node fwnode handle.
> + */
> +static struct fwnode_handle *
> +acpi_get_next_present_subnode(const struct fwnode_handle *fwnode,
> +			      struct fwnode_handle *child)
> +{
> +	do {
> +		child = acpi_get_next_subnode(fwnode, child);
> +	} while (is_acpi_device_node(child) &&
> +		 !acpi_device_is_present(to_acpi_device_node(child)));
> +
> +	return child;
> +}
> +
>  /**
>   * acpi_node_get_parent - Return parent fwnode of this fwnode
>   * @fwnode: Firmware node whose parent to get
> @@ -1664,7 +1684,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
>  		.property_read_string_array =				\
>  			acpi_fwnode_property_read_string_array,		\
>  		.get_parent = acpi_node_get_parent,			\
> -		.get_next_child_node = acpi_get_next_subnode,		\
> +		.get_next_child_node = acpi_get_next_present_subnode,	\
>  		.get_named_child_node = acpi_fwnode_get_named_child_node, \
>  		.get_name = acpi_fwnode_get_name,			\
>  		.get_name_prefix = acpi_fwnode_get_name_prefix,		\

-- 
Regards,

Laurent Pinchart

