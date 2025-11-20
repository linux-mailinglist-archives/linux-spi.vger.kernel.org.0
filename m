Return-Path: <linux-spi+bounces-11416-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2802C74D84
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8960E4E2B57
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226734F248;
	Thu, 20 Nov 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC5s1zJH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301C34CFDD;
	Thu, 20 Nov 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651203; cv=none; b=ASONwcocfE9KzylFzN2fYs9SaL8NtGmtOeGhxD/P0iGHj/1dZnrOEzc9gpWdVjptKGMxEvOOi+oARvYP72hGvupE7crlqxnmZcCjwMtVCdjvq4hImgicYcdTkM2D17czHmDTymZGgQBIU/7YuAgIwNy0JUrAEJIhIRRfb9VZsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651203; c=relaxed/simple;
	bh=MvYzU5CYUx+NkTDResHrhZoeTT+LBYxva1yQm7eALJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOqz+uL1+m8rCp8nlvMfhgzYZkTpUVKmV/IDOeWVAUIULNdRRkLKIHZZfk8ZloOY2YTKly1CLf3wCSr/Jlm3Rp2Oluo0dw/TTYkIzYbsvUTQ5Yi4zhcs2H7eapkj1EJHIdHjc4XGcyGuft+3G4KSCDoAjCVFnCovBY7/MN5no7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC5s1zJH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763651199; x=1795187199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MvYzU5CYUx+NkTDResHrhZoeTT+LBYxva1yQm7eALJs=;
  b=eC5s1zJHcmYnogfyFkJE2EHzGQJCKgNUfVdVLZZ6igUAyrCugeHlsqIW
   CnK2QYxCCLmSOWw8grhaN+yDG2ZmxqQmBJgNbglg6Gn42B6jhONvdwNEk
   q2Dj/d5I154mVcAvJmmqaaUTTUnggIs0F5Dr8ORpsLXMqkp/RlUziBosD
   PLec9GR3ibfij/U5CUZedTrmSJiyjAf7tbmjj9x3GnptNf54u05chhvcd
   WD1g2+vdO73jPrSsjXS4t8jCb1spgeWMVcW1MWjo5hcv2lVONWozVv6kZ
   Tj3PyAWEo15E48c2Us1+oFFg7Y/hWZyGAX/m6UnayBT2HQHicaUcdMY5g
   A==;
X-CSE-ConnectionGUID: tIvs5SgERv2fYtMdSQdFMw==
X-CSE-MsgGUID: J+S3BxPlR4uAfSNk84Iwlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="68328925"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="68328925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:06:33 -0800
X-CSE-ConnectionGUID: s/zaIC1FQbe9TkjeIDSdow==
X-CSE-MsgGUID: dMKOj6TeS3O9fQyCnHOl7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="195530098"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:06:24 -0800
Date: Thu, 20 Nov 2025 17:06:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH v7 0/9] reset: rework reset-gpios handling
Message-ID: <aR8ubexLrTgmxtpv@smile.fi.intel.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 02:23:55PM +0100, Bartosz Golaszewski wrote:
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
> 
> In this case using fwnode lookup makes more sense. However, since the
> reset provider is created dynamically, it doesn't have a corresponding
> firmware node (in this case: an OF-node). That leaves us with software
> nodes which currently cannot reference other implementations of the
> fwnode API, only other struct software_node objects. This is a needless
> limitation as it's imaginable that a dynamic auxiliary device (with a
> software node attached) would want to reference a real device with an OF
> node.
> 
> This series does three things: extends the software node implementation,
> allowing its properties to reference not only static software nodes but
> also existing firmware nodes, updates the GPIO property interface to use
> the reworked swnode macros and finally makes the reset-gpio code the
> first user by converting the GPIO lookup from machine to swnode.
> 
> Another user of the software node changes in the future could become the
> shared GPIO modules that's in the works in parallel[1].
> 
> Merging strategy: the series is logically split into four parts: driver
> core, SPI, GPIO and reset respectively. However there are build-time
> dependencies between all three parts so I suggest the reset tree as the
> right one to take it upstream with an immutable branch provided to
> driver core, SPI and GPIO.

Solution seems still OF-centric (some of_* is in reset-gpio are left),
but the series in the right direction, thanks for doing this!

-- 
With Best Regards,
Andy Shevchenko



