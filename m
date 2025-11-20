Return-Path: <linux-spi+bounces-11413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A63C74A69
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6459C358B96
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9592FDC4C;
	Thu, 20 Nov 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCfzvjLv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C62F1FCB;
	Thu, 20 Nov 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650081; cv=none; b=nTPXlyoutNLLthMXf27gLlig+PNT24Qgludk3Mo971PSD5Gxwc6KZy5phz+ZaxA0sUya3H3KNyrSZW2sQ3NkkZig7dssNnwasu9b4sesrayy22tqyF6HR9dP9Kpk3mfbOAgsn2rRZOa84Raqf8cyhaZyg5SuxjCt1gp+5ln1vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650081; c=relaxed/simple;
	bh=0xnaEtuEXez2x7reJKOJu+bm8QH1nnLf7VB8abmxOeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW5x4J3xVES1JjAjkbgUPvwtWYdmDENEzODoZI0DFLeKGU8W+nHyXg8S4HACGQcDnSEUwGApCCw1mqBn1GpfvEf0lsPfgHAPWhmJMPT5p2o4s8yPhmgtmp7UiomWqQ/KIbDyE4Uib9XtARAWtoK+sCaIiOxJabcgUgFmg59pews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCfzvjLv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763650077; x=1795186077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0xnaEtuEXez2x7reJKOJu+bm8QH1nnLf7VB8abmxOeA=;
  b=FCfzvjLvpGrtfBN6Az8VWHtApSkHCjKxAm5aFm4m1SewPCewtjv9uiuj
   Sxq62y33TsPQVWmXjX5ogaWsjMTr4Ajegf0L5Iz3k67kJ5vPEWBGNhqLi
   BMxCWACslARI8rWsep4DuPASGGzyLji7Rrrc2ivYC9vSmNOhoTS7++nok
   kS7yGGVyXJMZq7GEMTJb5e2LaR2qVtifoVnvdvpTChdQfoO5wgtxz/GF1
   iAwH1SXhrY9u8SJvG5QX4tZ6JNeI1oKHHFFH3zFEOdsyYD6AdV7VhY9Dd
   gufRyFYku0SAZTiF2Sp9tx0itQlB0NW8hfXs+TbJ+ZZHQfJCqqcrlQZz+
   Q==;
X-CSE-ConnectionGUID: 29WLHnwrTC6dzWBrgG2YRQ==
X-CSE-MsgGUID: x320KevuSQCeUaQNKIyQfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69577858"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69577858"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:47:53 -0800
X-CSE-ConnectionGUID: /zvKHaciSsmg7MVQOdHFlA==
X-CSE-MsgGUID: QSBGddDVTa+Q26+F4OWcdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="195525640"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:47:48 -0800
Date: Thu, 20 Nov 2025 16:47:45 +0200
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 1/9] software node: read the reference args via the
 fwnode API
Message-ID: <aR8qEVgkYr3veDqu@smile.fi.intel.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 02:23:56PM +0100, Bartosz Golaszewski wrote:

> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



