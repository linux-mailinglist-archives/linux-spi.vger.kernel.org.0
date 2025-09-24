Return-Path: <linux-spi+bounces-10280-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B772B99559
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B91919C239B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E42DC77D;
	Wed, 24 Sep 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X+xPz5ip"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC62BCF5;
	Wed, 24 Sep 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708310; cv=none; b=cEuJoNWxFTs6XjwK4sRjME8Dc/7cgFOrgFiHd2Vh7oyx8ZRd6oGYlrVIlDyGvB+mJazjQt89lN1Cd81efppFTJFdUhMwv6adXzpkTngNzY2mNwHE2HEwXhD87099Pttb/eukKtXHEvDxzbfObNJ7IEA0Wqi+HKnNTNYhvKt/vDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708310; c=relaxed/simple;
	bh=GFvcInq1IOuXE1vhB63t9/fSWu4hTelI/2URgyAn79g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjV/kAXTTrv6Z4w7+8/qU74Ma1ZeU7SyVvpyGDQcyKPKAMGaezzvmHwCh+XCwOPdAl6izqRajl/tzVckBAudjzgnOvJ/eNFUCBmAayX5zVuNQ3i08IBwNFkfb0pk79LBX3k3mTjMHHSA+Ikde6tMhBsP7FkTkx4R4Hcanv+Vybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=X+xPz5ip; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 5CD9E169;
	Wed, 24 Sep 2025 12:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708219;
	bh=GFvcInq1IOuXE1vhB63t9/fSWu4hTelI/2URgyAn79g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+xPz5ipCEtVXMBRJ1jvZe1NVoqmlyMiZQhoNJeMTbfWJ2fPhduU3zQx4OnS6Iv9M
	 owEQ5L8D3MxHWCaguicATmhcu628vb5cYQh0BzvQm6wAbybtKQqA3S1YtngHbrVdDl
	 ABfCVHXroXYOUx6UynplDNpflCJ6BcgOe2hvsWt4=
Date: Wed, 24 Sep 2025 13:04:29 +0300
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
Subject: Re: [PATCH v2 15/16] property: Drop functions operating on
 "available" child nodes
Message-ID: <20250924100429.GM28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-16-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-16-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Wed, Sep 24, 2025 at 10:46:01AM +0300, Sakari Ailus wrote:
> fwnode_get_next_available_child_node() and later
> fwnode_for_each_available_child_node() were introduced to mirror the OF
> interface operating on OF nodes. Now that these two are functionally the
> same as the variants without "_available" part, drop the "_available"
> variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c  | 30 +-----------------------------
>  include/linux/property.h |  6 ------
>  2 files changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index ff440456af7b..75c3283fb5ca 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -802,35 +802,7 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
>  
>  /**
> - * fwnode_get_next_available_child_node - Return the next available child node handle for a node
> - * @fwnode: Firmware node to find the next child node for.
> - * @child: Handle to one of the node's child nodes or a %NULL handle.
> - *
> - * The caller is responsible for calling fwnode_handle_put() on the returned
> - * fwnode pointer. Note that this function also puts a reference to @child
> - * unconditionally.
> - */
> -struct fwnode_handle *
> -fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
> -				     struct fwnode_handle *child)
> -{
> -	struct fwnode_handle *next_child = child;
> -
> -	if (IS_ERR_OR_NULL(fwnode))
> -		return NULL;
> -
> -	do {
> -		next_child = fwnode_get_next_child_node(fwnode, next_child);
> -		if (!next_child)
> -			return NULL;
> -	} while (!fwnode_device_is_available(next_child));
> -
> -	return next_child;
> -}
> -EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
> -
> -/**
> - * device_get_next_child_node - Return the next available child node handle for a device
> + * device_get_next_child_node - Return the next available child node handle

This last line is an unrelated change. With that fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>   * @dev: Device to find the next child node for.
>   * @child: Handle to one of the device's child nodes or a %NULL handle.
>   *
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 8b8bbbe6b5b7..da6202053862 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -161,8 +161,6 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
>  					    unsigned int depth);
>  struct fwnode_handle *fwnode_get_next_child_node(
>  	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
> -struct fwnode_handle *fwnode_get_next_available_child_node(
> -	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
>  
>  #define fwnode_for_each_child_node(fwnode, child)			\
>  	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
> @@ -172,10 +170,6 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  	fwnode_for_each_child_node(fwnode, child)			\
>  		for_each_if(fwnode_name_eq(child, name))
>  
> -#define fwnode_for_each_available_child_node(fwnode, child)		       \
> -	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
> -	     child = fwnode_get_next_available_child_node(fwnode, child))
> -
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);
>  

-- 
Regards,

Laurent Pinchart

