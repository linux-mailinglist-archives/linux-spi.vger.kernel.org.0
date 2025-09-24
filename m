Return-Path: <linux-spi+bounces-10282-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E55FAB995BF
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F18D7A93D0
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B82DC783;
	Wed, 24 Sep 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MG9U504x"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B52BCF5;
	Wed, 24 Sep 2025 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708456; cv=none; b=DUmm4WqERDQ0SwhBOTD4SW9EN/OW+4oNnSNrF3llqayvR6h2tiU/IwRBbZ8O6ZegkVbqZtOA8gDaUJ90XpTrfqf0PIewyGhjpxlb1wX3MtO4ic5pwUWUtMmZkw1AglaBXkmspWi4A2Jb+Y9K9A9MFPMndri4+t+zuXObbCcmA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708456; c=relaxed/simple;
	bh=wYs42sFxB1z6qStU60RP+A1H9ebtQZzHVrEmZGgoccg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCmsk+CE83Uf/WBoBQNkQTF/pN8DyHGeYsj0xXEqyosgp+KVS2PeyVIAgh2DpW74LNkbJ2u1PDqgGYN34/ZSvuN3FxQEQ+4iKiEG0L9tWKB5BWqL3GoERQ8Pup9b9S537faMFlXuDOeaIE8a38IvIIcMeW3BpLp5WqNGH9zMtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MG9U504x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 37666169;
	Wed, 24 Sep 2025 12:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708363;
	bh=wYs42sFxB1z6qStU60RP+A1H9ebtQZzHVrEmZGgoccg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG9U504xXOiYhIvbDW9REDTOwCjd1Rjc3OlzBpQ0TbuiOaL7H8w/SIypUhTxNx6+o
	 OaQlncSq44/yQZqjh5QStUtWUFSBp4q2taKlfrxpThAXZCWz7NtQhYegKHG95MdtPQ
	 mYbjfEn2x2obfoJe4j8CwY4ieKsbVCP8NOHrQiK0=
Date: Wed, 24 Sep 2025 13:06:54 +0300
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
Subject: Re: [PATCH v2 08/16] property: Document that fwnode API returns
 available nodes
Message-ID: <20250924100654.GO28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-9-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-9-sakari.ailus@linux.intel.com>

Hi Sakari,

On Wed, Sep 24, 2025 at 10:45:54AM +0300, Sakari Ailus wrote:
> The fwnode API has historically provided two functions to iterate over a
> fwnode's child nodes, fwnode_get_next_child_node() and
> fwnode_get_next_available_child_node() whereas all of the fwnode API has
> always worked on available nodes, apart unavailable ACPI child device
> nodes could have been returned by fwnode_get_next_child_node().
> 
> Now that the availability check has been added to ACPI side as well,
> document that the functions in the fwnode API return available nodes.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 4bd64e729431..ff440456af7b 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -785,7 +785,7 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
>  EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
>  
>  /**
> - * fwnode_get_next_child_node - Return the next child node handle for a node
> + * fwnode_get_next_child_node - Return the next available child node handle
>   * @fwnode: Firmware node to find the next child node for.
>   * @child: Handle to one of the node's child nodes or a %NULL handle.
>   *
> @@ -830,7 +830,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
>  EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
>  
>  /**
> - * device_get_next_child_node - Return the next child node handle for a device
> + * device_get_next_child_node - Return the next available child node handle for a device

You may want to drop "for a device" at the end of the line, it seems
you've made that change in 15/16 instead of here.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>   * @dev: Device to find the next child node for.
>   * @child: Handle to one of the device's child nodes or a %NULL handle.
>   *
> @@ -858,7 +858,7 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);
>  
>  /**
> - * fwnode_get_named_child_node - Return first matching named child node handle
> + * fwnode_get_named_child_node - Return first available matching named child node handle
>   * @fwnode: Firmware node to find the named child node for.
>   * @childname: String to match child node name against.
>   *
> @@ -874,7 +874,7 @@ fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
>  
>  /**
> - * device_get_named_child_node - Return first matching named child node handle
> + * device_get_named_child_node - Return first available matching named child node handle for a device
>   * @dev: Device to find the named child node for.
>   * @childname: String to match child node name against.
>   *
> @@ -928,7 +928,7 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  EXPORT_SYMBOL_GPL(fwnode_device_is_available);
>  
>  /**
> - * fwnode_get_child_node_count - return the number of child nodes for a given firmware node
> + * fwnode_get_child_node_count - Return the number of available child nodes for a given firmware node
>   * @fwnode: Pointer to the parent firmware node
>   *
>   * Return: the number of child nodes for a given firmware node.
> @@ -946,7 +946,7 @@ unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode)
>  EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
>  
>  /**
> - * fwnode_get_named_child_node_count - number of child nodes with given name
> + * fwnode_get_named_child_node_count - Return the number of available child nodes with given name
>   * @fwnode: Node which child nodes are counted.
>   * @name: String to match child node name against.
>   *

-- 
Regards,

Laurent Pinchart

