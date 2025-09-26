Return-Path: <linux-spi+bounces-10300-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDABA38A1
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291F73BD6B4
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413E2D7DC2;
	Fri, 26 Sep 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hC/oOzx1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B32DC784;
	Fri, 26 Sep 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887320; cv=none; b=SX/Wkt+HSRHDkrE0ETefB8FRpQ3zeLOsffTCW8g9yCHYwxqw/w/Z2CH0cDwGkTD9RJdmV06WVgANzglv0zex2oHGM0IpLCU4A1ExVxidghwJVAXw7Z+n1/zsukeSsq90jqgcKm4nPHt3lL2TIg/XW6tldTUobvhvhyZ3+nO5ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887320; c=relaxed/simple;
	bh=E4e0aJYFgJz8G2kBy/37UxAGesQyoBDgqKIJdOVc8qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEoca4KEpRcyRL8jg/qR0jxX5lcYFemWaSRpA7LXSaBUqiAUYJNaT9dtIdZy0Znkw7GZuYcnoOG7ev9Lhti3PWdN/ax1M8nu7v1peGH19oCvsvjKZ4Y+leP1zsgshj3xxlfKRONTFbnqay+NmY7QyvnggRBXHgPwFjZw+a6t+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hC/oOzx1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758887318; x=1790423318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E4e0aJYFgJz8G2kBy/37UxAGesQyoBDgqKIJdOVc8qY=;
  b=hC/oOzx14+A1xenDHWUSarDBPZkI/b2R55DJ3g89KrRg+Do3qOPDcbvw
   6L0MUSS4yLkeptfLAPb5ZzCuz/kuP3lpLuBgQRhDD0+kpBm0Bw0Ndq1WR
   e+jj6fE05M36j5rKGcRSHyQ0nlCkZyC6lVJItPDP8RTeLaDDCOioUDEJG
   6o0moKZGpXcu7LdDTZpY/spK2+pceCCNHHtlmBcLsN5HZZPv9gdRPeNO8
   NYbCIxhQQi0DeJhr3mbvu94zzbJ+1Tank4ulbvu1pQsBIYHVTQg5H8AGB
   G3iA/CqnFXiYnUL+TI7OAUtU1DsTXYlgUu16h4RSlxSafHzalTBWL6glh
   w==;
X-CSE-ConnectionGUID: cuJQXdUCR0O2J2k0bm9new==
X-CSE-MsgGUID: FHBafSWKQx68qIkFArpfCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61387847"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61387847"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:48:36 -0700
X-CSE-ConnectionGUID: BK+axjuPStWsYBileeDUlA==
X-CSE-MsgGUID: oC0T6jquTx6oROopZJan1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="178351412"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.33])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:48:18 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E84671202BC;
	Fri, 26 Sep 2025 14:48:13 +0300 (EEST)
Date: Fri, 26 Sep 2025 14:48:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, Len Brown <lenb@kernel.org>,
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
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Subject: Re: [PATCH v2 00/16] Align availability checks on fwnode child node
 enumeration
Message-ID: <aNZ9fbh8eLiPAJzR@kekkonen.localdomain>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hSy9zQd6cP9B4QPSZi-6ughmkW=VoEBV-0MbUr2xcaAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hSy9zQd6cP9B4QPSZi-6ughmkW=VoEBV-0MbUr2xcaAQ@mail.gmail.com>

Hi Rafael,

On Wed, Sep 24, 2025 at 12:52:12PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Wed, Sep 24, 2025 at 9:46 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hello everyone,
> >
> > Historically the fwnode property API has enumerated only available device
> > nodes on OF whereas on ACPI, also nodes that haven't been present in the
> > system have been provided. Both OF and ACPI have similar concepts of node
> > availbility, on OF it's the "status" property present on device nodes and
> > on ACPI the _STA object evaluates to device present, enabled and
> > functional bits, of which the present and functional bits are currently
> > being used to determine whether to enumerate a device.
> >
> > Two additional functions, fwnode_get_next_available_child_node() and
> > fwnode_for_each_available_child_node(), have been provided to enumerate
> > the available nodes only on ACPI, whereas on OF the implementation has
> > been the same on the non-available variants. The motivation for providing
> > these has very likely been to provide fwnode variants of the similarly
> > named functions but the difference isn't justifiable from API consistency
> > viewpoint.
> >
> > This set switches the users away from the "available" fwnode API functions
> > and later on removes them, aligning the functionality on all fwnode
> > backends.
> >
> > since v1:
> >
> > - Move patch "ACPI: property: Make acpi_get_next_subnode() static" as
> >   first.
> >
> > - Add missing parentheses and kernel-doc Return: section in
> >   acpi_get_next_present_subnode() documentation and move the Return
> >   section: of fwnode_graph_get_endpoint_by_id() to the end of the
> >   documentation section (new patch for the latter).
> >
> > - Use device_get_next_child_node() instead of fwnode_get_next_child_node()
> >   in flash LED driver drivers.
> >
> > - Rework iterating port nodes in acpi_graph_get_next_endpoint() as
> >   suggested by Andy (new patch).
> 
> I think that you really have four series here, or rather two series, a
> collection of patches depending on them, and a follow-up cleanup.
> 
> > Sakari Ailus (16):
> >   ACPI: property: Make acpi_get_next_subnode() static
> >   ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint()
> >     only
> >   ACPI: property: Rework acpi_graph_get_next_endpoint()
> >   ACPI: property: Return present device nodes only on fwnode interface
> 
> So the above is one series, focused on ACPI property changes.
> 
> They can go in via ACPI as soon as everyone is happy with them.  I
> think I can push them for 6.18 if that helps to process the other
> patches.

If it's an option, that would be nice. But see below.

> 
> >   property: Move Return: section of fwnode_graph_get_endpoint_by_id()
> >     down
> >   property: Drop DEVICE_DISABLED flag in
> >     fwnode_graph_get_endpoint_by_id()
> >   property: Drop DEVICE_DISABLED flag in
> >     fwnode_graph_get_endpoint_count()
> 
> The above patches are another series that doesn't depend on the first
> one AFAICS and can go in via driver core.

Agreed.

> 
> >   property: Document that fwnode API returns available nodes
> >   driver core: Use fwnode_for_each_child_node() instead
> >   net: lan966x: Use fwnode_for_each_child_node() instead
> >   Input: touch-overlay - Use fwnode_for_each_child_node() instead
> >   media: thp7312: Use fwnode_for_each_child_node() instead
> >   leds: Use fwnode_for_each_child_node() instead
> >   leds: Use fwnode_get_next_child_node() instead
> 
> The above can go in via respective subsystem trees when the ACPI
> property series gets in (I'm not sure if/how they depend on the second
> series).
> 
> And the following one is a follow-up cleanup getting rid of code that
> would be redundant going forward.
> 
> >   property: Drop functions operating on "available" child nodes
> >   spi: cadence: Remove explicit device node availability check
> 
> Does the spi change depend on the previous patch?

There's really only one dependency, apart from the direct dependency of
fwnode_get_next_available_child_node() /
fwnode_for_each_available_child_node() definitions removed in the second
last patch: fwnode_get_next_child_node() and fwnode_for_each_child_node()
may still return non-available nodes before the last of the ACPI patches in
the set. So if the ACPI patches aren't merged but the rest are,
non-available nodes could be returned.

How about:

1. Merge the ACPI patches to 6.18.

2. Merge the rest, apart from the second last patch, for 6.19.

3. Once everything else is in, merge the last patch. Could wait for 6.20.

Perhaps I should split the series in three sets?

I'll send an update on the ACPI patches soon, to address a comment related
to them.

-- 
Kind regards,

Sakari Ailus

