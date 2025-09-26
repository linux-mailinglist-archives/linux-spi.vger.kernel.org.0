Return-Path: <linux-spi+bounces-10298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DDCBA283B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 08:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA93E4C6CD6
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE32322B8AB;
	Fri, 26 Sep 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WM7o08Oj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A63182D0;
	Fri, 26 Sep 2025 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867512; cv=none; b=jHgXK7/KI3rPARmMdUmNIaJnMA9xovGpDyDrULzo33al1m4RoHDXmIxl8dyXUlexLaBigdzh2LxlKHmu6jTmVvIQtsGbzjBMOT2GC1uJBcMnV8gOjjbb17YIiebXTGWasc7mWDlD2d6fYPGj2gxrO7+XIOPQvyd+mzPTxg2YmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867512; c=relaxed/simple;
	bh=8201WXrup8XvpSExFpkFq4mNS0iyckww5/D1SWX0+Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfCtr6JAxYEE55lwbgi5xHHoI3sHtB3SC5osLcXMZRZ/YeeSiy2aLtfNa9v1r9VHaHFx6XpzfNCFU2VsEsx0yfKj8lk1knRDC8JcmpBuCz4TO2bUcVhgPtcZ65H+wElaSyuMTPZAq2ulB+Dlf3of9pGIb83Om80cE0+x6SxAa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WM7o08Oj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758867511; x=1790403511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8201WXrup8XvpSExFpkFq4mNS0iyckww5/D1SWX0+Ug=;
  b=WM7o08OjWPq5669NpRLl8jaXL6nCl8BCnEC8mVEYS/qaSipEtyVikiaI
   rTWyRshNcaLHnheG0qRZgwzSDeeBU3/UmSH2ec4usm6g+6OzHe3pp4pjW
   DoOC0Mp26O3DMPOGnr0Q+MHbI5KpSkUscFzJxHemh8zhDC3QkPeR27wIF
   W9iAEPQ6zmNQjHWX9EkIGVmPk7WcABpMezMxafQmgT9v02PL6TLUjXDW6
   x5muwZgLMcXETAnN2FWEwxrfvo8V7cVl5oZIVSMNlh3oOseoJlKuacA6Z
   HBCKcD3Dhvc9HPwupqnRBEIXsQmthOKqT0wF+WYzUZvDWZVKO3NydjDaV
   A==;
X-CSE-ConnectionGUID: SPaslcM1S9iWqbS0FAmycw==
X-CSE-MsgGUID: IgjUj0y1R1yGtdOKnr9wSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65007907"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65007907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 23:18:30 -0700
X-CSE-ConnectionGUID: 3mfFTnffTbWRoLvJM5M84w==
X-CSE-MsgGUID: GifP7tIrSOKWwAhQm1LJog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="177094129"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.214])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 23:18:22 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B3D341201B4;
	Fri, 26 Sep 2025 09:18:18 +0300 (EEST)
Date: Fri, 26 Sep 2025 09:18:18 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
Subject: Re: [PATCH v2 02/16] ACPI: property: Use ACPI functions in
 acpi_graph_get_next_endpoint() only
Message-ID: <aNYwKkYW__0hRIQV@kekkonen.localdomain>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-3-sakari.ailus@linux.intel.com>
 <iqfarpvf72l7qbhfinopjb27qvfm7wg77d4yhuy5qyubcwtcd2@exmcuvgqr353>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iqfarpvf72l7qbhfinopjb27qvfm7wg77d4yhuy5qyubcwtcd2@exmcuvgqr353>

Hi Dmitry,

On Wed, Sep 24, 2025 at 11:32:56AM -0700, Dmitry Torokhov wrote:
> Hi Sakari,
> 
> On Wed, Sep 24, 2025 at 10:45:48AM +0300, Sakari Ailus wrote:
> > Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
> > property API is somewhat problematic as the latter is used in the
> 
> How exactly is this problematic?

In general, the fwnode property API is implemented by the (currently three)
backends so the backend calling fwnode property API to call itself without
knowing what exactly gets called may end up in an infinite recursion.
Keeping ACPI implementation separate from the fwnode property frontend
avoids even needing to think about this.

> 
> > impelementation of the former. Instead of using
> > fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
> > acpi_get_next_subnode() directly instead.
> 
> I think we are moving into the world of mixed fwnode types with software
> nodes/secondary fwnodes, so I do not think this is a step in right
> direction.

This is not how it works. If you have an ACPI node, it's and ACPI node, not
a software node or an OF node. A software node would be attached as
fwnode->secondary, it's not the same ACPI (device or data) node.

-- 
Regards,

Sakari Ailus

