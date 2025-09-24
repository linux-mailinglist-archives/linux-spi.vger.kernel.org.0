Return-Path: <linux-spi+bounces-10268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52FB99308
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50A33A45B3
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E22D8DB9;
	Wed, 24 Sep 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LdvcwGPJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1618280018;
	Wed, 24 Sep 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706816; cv=none; b=TXxU2LwU/fvQQNIxJgC3EAMgGRG/ymeUdnJP53z1HnV4gGbUy5LtT8766txfCosl4mJNfU0i81wXTBMptCTszPFEpLfegUaRXB9FTcOWJHiqZnuwC99gwk+TRgTJiDNYHDhmsTpCX8K5whHIrJ5BAfc5JoTg2Hg43u2BzoTWGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706816; c=relaxed/simple;
	bh=cVFpRLHlsKFQcKYfT9okznz5+JYZuj0FczFbY1rq0OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWBcn6gbQYyZ40t2kJPThQv8/zUQ/TmF48cRqflUgHWU890KhNoD/IY9nX5cgHtwpvi/VhK5NkeoSikVtRwPWsDeoulvIOGXUh0B88tXK4IdC4EAgm0WwS4tFgipdV8rMMEyOC2Fc3ya+ETe5uTRhKirQv6ZOc+UMcM8OJ6aOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LdvcwGPJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 8D818BE4;
	Wed, 24 Sep 2025 11:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758706723;
	bh=cVFpRLHlsKFQcKYfT9okznz5+JYZuj0FczFbY1rq0OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdvcwGPJ+gKPP8uQa/ZfiecxPP+vzZwoStHeEkH07Vdi8o5ECa/kbtjLwkS34hQ1s
	 B/DjqIRtC2yrIH+3+nNHfWe8zt9f3AFIqaqkEtYZp8aGyTIgsVjEW91HwkYc1BEB9n
	 nOohutmwBlC7cT6q17iwNw/s7hFsf2Zhe4/9qZ2M=
Date: Wed, 24 Sep 2025 12:39:34 +0300
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
Subject: Re: [PATCH v2 03/16] ACPI: property: Rework
 acpi_graph_get_next_endpoint()
Message-ID: <20250924093934.GC28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-4-sakari.ailus@linux.intel.com>

Hi Sakari,

On Wed, Sep 24, 2025 at 10:45:49AM +0300, Sakari Ailus wrote:
> Rework the code obtaining the next endpoint in
> acpi_graph_get_next_endpoint(). The resulting code removes unnecessary
> contitionals and should be easier to follow.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 3e85900080ac..5438592dc136 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1399,14 +1399,15 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
>  	if (!port)
>  		return NULL;
>  
> -	endpoint = acpi_get_next_subnode(port, prev);
> -	while (!endpoint) {
> -		port = acpi_get_next_subnode(fwnode, port);
> -		if (!port)
> +	do {
> +		endpoint = acpi_get_next_subnode(port, prev);
> +		if (endpoint)
>  			break;
> +
> +		port = acpi_get_next_subnode(fwnode, port);
>  		if (is_acpi_graph_node(port, "port"))
> -			endpoint = acpi_get_next_subnode(port, NULL);
> -	}
> +			prev = NULL;

Isn't there an issue here ? If the next subnode of fwnode is not a port,
the next iteration of the do loop will attempt to get an endpoint from
that non-port node. Maybe the acpi_get_next_subnode() that will try to
get the endpoint from the non-port port will return NULL because prev
won't be a child of port, but that seems fragile.

I think the following would be easier to understand:

	do {
		endpoint = acpi_get_next_subnode(port, prev);
		if (endpoint)
			break;

		prev = NULL;

		do {
			port = acpi_get_next_subnode(fwnode, port);
		} while (port && !is_acpi_graph_node(port, "port"));
	} while (port);

> +	} while (port);
>  
>  	/*
>  	 * The names of the endpoint nodes begin with "endpoint@" followed by
> 

-- 
Regards,

Laurent Pinchart

