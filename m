Return-Path: <linux-spi+bounces-10273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC3B994CC
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B9A4A5A5B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E12DA76B;
	Wed, 24 Sep 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B1enMBCA"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC992D879C;
	Wed, 24 Sep 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708081; cv=none; b=dwHhuk+SFL8OpQeuAmuC5qTW6AXSfV0UnFdPeHbpGdmzDXX9CKLdNg6+qohsA1wfxWY33Xv16aeHNXDZOG0+kZBjTdFp+oVuyDImAnxsTz6x8KmmYKVUbYKRivqDa+/TrsMjrwDn9olXWDXfInTWyHQbUe2+M6DbDXXTOCgdHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708081; c=relaxed/simple;
	bh=L9rXAO4TRnu0P7LaCvfTltUKK+P3dX9M0cRaUN0Iwdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCXD60xII3+e6yEqXkMOObArjvodv4N6eSu9n1gFYez5HsDOiPqyckuD57+6oGsD98S+UYs11teXK6vwnOKqqG2BorupXax5d0jj9r+nIONYVnn9BrOqJWkIIpTIkRV+WO+DYejCIK3JCue7ek8DGKQKk2SDo9xWwrpS76wlAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B1enMBCA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 441F31E30;
	Wed, 24 Sep 2025 11:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758707990;
	bh=L9rXAO4TRnu0P7LaCvfTltUKK+P3dX9M0cRaUN0Iwdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1enMBCAJTNPmqlep7QPL1M88eaOslsfCubzJXVt1jFe2bNqpYXIFknc1vrkemusH
	 W3NU0ZYxMqErtoTcmr5AWb3ocnTot8PQqwUsoQey4HoqbXpka4iZwClSdeMrL/q81n
	 RqH2JCgcfOkiCmrHiC2w9WN+KuC3VyQIVufdVslo=
Date: Wed, 24 Sep 2025 13:00:40 +0300
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
Subject: Re: [PATCH v2 07/16] property: Drop DEVICE_DISABLED flag in
 fwnode_graph_get_endpoint_count()
Message-ID: <20250924100040.GA9827@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-8-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-8-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:53AM +0300, Sakari Ailus wrote:
> FWNODE_GRAPH_DEVICE_DISABLED flag isn't used anywhere, drop the flag and
> support for it in fwnode_graph_get_endpoint_count().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

With 06/16 squashed into this,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/base/property.c  | 10 ++--------
>  include/linux/property.h |  8 +-------
>  2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 7fc3257f223d..4bd64e729431 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1291,21 +1291,15 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
>  /**
>   * fwnode_graph_get_endpoint_count - Count endpoints on a device node
>   * @fwnode: The node related to a device
> - * @flags: fwnode lookup flags
>   * Count endpoints in a device node.
> - *
> - * If FWNODE_GRAPH_DEVICE_DISABLED flag is specified, also unconnected endpoints
> - * and endpoints connected to disabled devices are counted.
>   */
> -unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
> -					     unsigned long flags)
> +unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode)
>  {
>  	struct fwnode_handle *ep;
>  	unsigned int count = 0;
>  
>  	fwnode_graph_for_each_endpoint(fwnode, ep) {
> -		if (flags & FWNODE_GRAPH_DEVICE_DISABLED ||
> -		    fwnode_graph_remote_available(ep))
> +		if (fwnode_graph_remote_available(ep))
>  			count++;
>  	}
>  
> diff --git a/include/linux/property.h b/include/linux/property.h
> index d1e80b3c9918..8b8bbbe6b5b7 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -503,19 +503,13 @@ static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
>   * @FWNODE_GRAPH_ENDPOINT_NEXT: In the case of no exact match, look for the
>   *				closest endpoint ID greater than the specified
>   *				one.
> - * @FWNODE_GRAPH_DEVICE_DISABLED: That the device to which the remote
> - *				  endpoint of the given endpoint belongs to,
> - *				  may be disabled, or that the endpoint is not
> - *				  connected.
>   */
>  #define FWNODE_GRAPH_ENDPOINT_NEXT	BIT(0)
> -#define FWNODE_GRAPH_DEVICE_DISABLED	BIT(1)
>  
>  struct fwnode_handle *
>  fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
>  				u32 port, u32 endpoint, unsigned long flags);
> -unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
> -					     unsigned long flags);
> +unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode);
>  
>  #define fwnode_graph_for_each_endpoint(fwnode, child)				\
>  	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\

-- 
Regards,

Laurent Pinchart

