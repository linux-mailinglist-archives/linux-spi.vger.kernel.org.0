Return-Path: <linux-spi+bounces-10301-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1ABBA38C2
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3086E7A6A0D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90C2E5404;
	Fri, 26 Sep 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ull+ZgZJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A02D0601;
	Fri, 26 Sep 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887397; cv=none; b=V5QG7ek+7iQFzLQ+1zgERl6+fC5zyWI/O6XYtqxRtsgqf2jhS5sdUn4luEMhMNmy6ZXngEagovgPBgLSHi9YQfGkN2SCuEAetxzlZ9dBQIfsHvkapYdf60Fpr5h7Snf4RjC1mwLO/6tCUiIvIG32LanH//WQd1xjRGHqlkB2Nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887397; c=relaxed/simple;
	bh=F6vkmwXAj5jiqHJtsFmVLViWZqoBinpqAhY458odFy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY+ji8OfifwuxSboY+oT57fP5BEwl+b6El4lMbif2kQtmjRuBajjIGLfeBkWH4dkA6YoQwKvTT94P7P7IH0FpeSIY6uCjtqaAyb6zYwCcFs0LJtJbhz38lzsbQ/l2hyRZz7edMDa9KjxeH08rmIFwfl6v3dgw8VrAc7tfW6OtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ull+ZgZJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758887396; x=1790423396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F6vkmwXAj5jiqHJtsFmVLViWZqoBinpqAhY458odFy0=;
  b=Ull+ZgZJcuwRRPTn/k58iCU/XmJZo1UofknAxDiprd4U3wYsNvOy7Jm0
   FM0lv3E/tmah1dByMe31IPGSWvplGi0mvodqj4g+R9qfa7XBaqqUvsafP
   5ymbsdeVQKzq1Z01kRKCW6e6egZjIj7ifgJQTQU3BGJtj70QFs8mGsTz0
   dXxu8zxzgkzY2DIlwDQAy+ACDR3o4y7+LWybGa3Cou+yt/+UcotsVdbnt
   FJawC8z6u4zjHlE10nbUxE0+TddC73TsFp7Os0ArpzwLseZQN03TNiUwf
   f5WnPwJ3B7qIYKBrwxEa5XUSlkJi/sPMCMJ8qjpfsF8B6+2iyunSuGyeS
   A==;
X-CSE-ConnectionGUID: 9En9tj9+QaG0E8Jwen+qZg==
X-CSE-MsgGUID: e4gqiS9uTs6Tff5O9ESFxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61132636"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61132636"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:49:55 -0700
X-CSE-ConnectionGUID: qm83rxGFQeq0pPV3J5K8sQ==
X-CSE-MsgGUID: MnAYXKGgRJCuKU2ewW28mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="214727852"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:49:47 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id ADDAD1202BC;
	Fri, 26 Sep 2025 14:49:42 +0300 (EEST)
Date: Fri, 26 Sep 2025 14:49:42 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <aNZ91lK7RvDku6li@kekkonen.localdomain>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-4-sakari.ailus@linux.intel.com>
 <20250924093934.GC28073@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924093934.GC28073@pendragon.ideasonboard.com>

Hi Laurent,

Thank you for the review.

On Wed, Sep 24, 2025 at 12:39:34PM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> On Wed, Sep 24, 2025 at 10:45:49AM +0300, Sakari Ailus wrote:
> > Rework the code obtaining the next endpoint in
> > acpi_graph_get_next_endpoint(). The resulting code removes unnecessary
> > contitionals and should be easier to follow.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 3e85900080ac..5438592dc136 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1399,14 +1399,15 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
> >  	if (!port)
> >  		return NULL;
> >  
> > -	endpoint = acpi_get_next_subnode(port, prev);
> > -	while (!endpoint) {
> > -		port = acpi_get_next_subnode(fwnode, port);
> > -		if (!port)
> > +	do {
> > +		endpoint = acpi_get_next_subnode(port, prev);
> > +		if (endpoint)
> >  			break;
> > +
> > +		port = acpi_get_next_subnode(fwnode, port);
> >  		if (is_acpi_graph_node(port, "port"))
> > -			endpoint = acpi_get_next_subnode(port, NULL);
> > -	}
> > +			prev = NULL;
> 
> Isn't there an issue here ? If the next subnode of fwnode is not a port,
> the next iteration of the do loop will attempt to get an endpoint from
> that non-port node. Maybe the acpi_get_next_subnode() that will try to
> get the endpoint from the non-port port will return NULL because prev
> won't be a child of port, but that seems fragile.
> 
> I think the following would be easier to understand:
> 
> 	do {
> 		endpoint = acpi_get_next_subnode(port, prev);
> 		if (endpoint)
> 			break;
> 
> 		prev = NULL;
> 
> 		do {
> 			port = acpi_get_next_subnode(fwnode, port);
> 		} while (port && !is_acpi_graph_node(port, "port"));
> 	} while (port);

Yes, this indeed ensures port will be a port node. I'll use this in the
next version.

> 
> > +	} while (port);
> >  
> >  	/*
> >  	 * The names of the endpoint nodes begin with "endpoint@" followed by
> > 
> 

-- 
Regards,

Sakari Ailus

