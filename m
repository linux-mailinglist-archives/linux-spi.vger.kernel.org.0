Return-Path: <linux-spi+bounces-10267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F0B9924E
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C02A5EBB
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377162D6639;
	Wed, 24 Sep 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JjccoRzk"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E428152A;
	Wed, 24 Sep 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706228; cv=none; b=sOoSOJ4rY7RtCypWPkPMcAwB3NPvVet0TS2ekR6yTQF96MaMPab7TmB7DYIMlJq8Yy2sX/N0fkULbOfOsLtdNAY1pnec5Z99k682d9zpL0ol6xH9Z2axtBAxr/RY5zqKbhXuBLU97YTjiOt/KUzfbUwpwXwUSuVjCyaZrMLJzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706228; c=relaxed/simple;
	bh=BA+KnrZJRJsQOIp0a6JJpaQIcE2G5Aj69pyLqeN/ic8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTivRjhmluYK68o/nd0q1tSKo0d0G5FqQKOq+VLDo6wweg3douReH+4SyXFaLep8iwx0Tk/vBYaYflKLglRKBBheJjnBvvTjr4Qfd7pT2FEOd0PwwmRaqp6Ejh+i2ZYQSokMpuAjE67W6E90NmR3zaJx8ggz5JnhiOjW0EwETLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JjccoRzk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 780AEC7B;
	Wed, 24 Sep 2025 11:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758706135;
	bh=BA+KnrZJRJsQOIp0a6JJpaQIcE2G5Aj69pyLqeN/ic8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjccoRzkNC/BAzyyVJHvyrSQsbZSgzwfyignd2TiwL/Ibr2YSO+dNsflVDyqPcI2J
	 UnsdGwcBcLZiy3JKXalaD27GHabf6yOYHQEt4tPlHidWuhkXDA5ojdCoFT63rVrehy
	 ritwk6j83RpmzW3nQFAAphaFpDxCS6RLrrqQ2/jk=
Date: Wed, 24 Sep 2025 12:29:45 +0300
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
Subject: Re: [PATCH v2 02/16] ACPI: property: Use ACPI functions in
 acpi_graph_get_next_endpoint() only
Message-ID: <20250924092945.GB28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-3-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:48AM +0300, Sakari Ailus wrote:
> Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
> property API is somewhat problematic as the latter is used in the
> impelementation of the former. Instead of using
> fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
> acpi_get_next_subnode() directly instead.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/acpi/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 5435628c67e7..3e85900080ac 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1381,7 +1381,7 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
>  
>  	if (!prev) {
>  		do {
> -			port = fwnode_get_next_child_node(fwnode, port);
> +			port = acpi_get_next_subnode(fwnode, port);
>  			/*
>  			 * The names of the port nodes begin with "port@"
>  			 * followed by the number of the port node and they also
> @@ -1399,13 +1399,13 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
>  	if (!port)
>  		return NULL;
>  
> -	endpoint = fwnode_get_next_child_node(port, prev);
> +	endpoint = acpi_get_next_subnode(port, prev);
>  	while (!endpoint) {
> -		port = fwnode_get_next_child_node(fwnode, port);
> +		port = acpi_get_next_subnode(fwnode, port);
>  		if (!port)
>  			break;
>  		if (is_acpi_graph_node(port, "port"))
> -			endpoint = fwnode_get_next_child_node(port, NULL);
> +			endpoint = acpi_get_next_subnode(port, NULL);
>  	}
>  
>  	/*

-- 
Regards,

Laurent Pinchart

