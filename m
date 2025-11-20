Return-Path: <linux-spi+bounces-11415-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F1C74B81
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 476204E95E4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2334AAE8;
	Thu, 20 Nov 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPvYjfpH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726132C933;
	Thu, 20 Nov 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650395; cv=none; b=a3909lD7/FIRDYVrqUef80yQe0dRW2LJLxJoHA/gfHlrZ4Rfm65kw45CQfi4AU0Nv5cJkBWjvGXpd/H/ZBHqOKVD0jm6iVZ9GrY5gXyT1sm0kuUZ06p3vo26en4VZQJhtu5a/L6fzuqrqRsIMzRq7nXPM0DuAye8Vdy6USMew34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650395; c=relaxed/simple;
	bh=FOiGqkM13wCQMhUWojZNwiMjhBlfxERbLsSU4OXdTRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFvLhh9kN73vSdcqJVF6MV2ZKitlfWNkD/CnJtqfViSbh3gbj4P4C18gNzyYIftdZPVCOAP1O6VLsDOEuTBfm/eM/JNXszt/Im+gl0Md/N7Y2ls5YY1bgZ6E7rQaGd3091dH7KM3g/7WKzuSnufeStVLoYz/7sfCXF2bAY3p2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPvYjfpH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763650394; x=1795186394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FOiGqkM13wCQMhUWojZNwiMjhBlfxERbLsSU4OXdTRU=;
  b=HPvYjfpHAHFGw37IH48frOSqPqf53TOcQGFw29Q+d/pHvrs6BOZ60YK9
   UBgcD15erRwZxsvEFpWX/oZ2xCbVSM7sOqZ56pOV6uiq+bak0t/UFZLmC
   UPaqkVa+NdyNqyjbkTh4lN7jwtugT2IRTG+P4ZN/ZOro0vYTnAWuAWo+V
   26hPMKoBcs41ibF8WN/1hKso3eEYGxMXwdHXb/0hFywry3pdmC8dSb0mm
   P7wd0sPNZd9+wSNzaMkTHEsjUKpKQyjpjCRNzOjUzacM72V2b5M1jN8CP
   NOU7A/QZKWIJi5CzWUqoiIySei0shLly+FE27JW6HLYLnNO6pt8TnBhgm
   A==;
X-CSE-ConnectionGUID: 0BegWDndRt6QWaVZxDwKbw==
X-CSE-MsgGUID: n7tnmA3QQ7GY/GGQRLFLfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="83343384"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="83343384"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:53:13 -0800
X-CSE-ConnectionGUID: l30GPsCbRQaLLmArLdMxeg==
X-CSE-MsgGUID: EeWyz0ePQxqBTJBGWgI6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="192187607"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:53:07 -0800
Date: Thu, 20 Nov 2025 16:53:05 +0200
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
Subject: Re: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
Message-ID: <aR8rUVyeAJzIFtAp@smile.fi.intel.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 02:23:59PM +0100, Bartosz Golaszewski wrote:

> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently
> software nodes are added to support this case, however, the chip
> selects for these devices are specified using a hack. A software
> node is added with the same name as the pinctrl driver, as the
> look up was name based, this allowed the GPIO look up to return
> the pinctrl driver even though the swnode was not owned by it.
> This was necessary as the swnodes did not support directly
> linking to real firmware nodes.
> 
> Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
> name as the key for GPIO lookup") changed the lookup to be
> fwnode based this hack will no longer find the pinctrl driver,
> resulting in the driver not probing. There is no pinctrl driver
> attached to the swnode itself. But other patches did add support
> for linking a swnode to a real fwnode node [1]. As such the hack
> is no longer needed, so switch over to just passing the real
> fwnode for the pinctrl property to avoid any issues.

I very much like this solution.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



