Return-Path: <linux-spi+bounces-11414-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C410DC74AE3
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD4414E26BD
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B82F7AB0;
	Thu, 20 Nov 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJPvnljz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C02D660D;
	Thu, 20 Nov 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650118; cv=none; b=Bj/VvkGLeOak044OdaITnX098TKnSv4U5cjF5whobeL06JCClC+WcJ9Qp+pA8MS8L2mmbrTOAdDUqpcQ9CRG9nRk5DgPCNZA63eTX/SM7pYMPzsDqlU+n9Y48usB0+/7DGwqTxPW0gv3XwI3vL3zT3z3MD51MbKv9V0zVDefj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650118; c=relaxed/simple;
	bh=lTFfvrpRZXxRFzE7mbtSZXzaOPD4RhsN1+X43z7bVJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR2GSXP+hkyPEwKi1400o0PfCRBmF/JWKNRvOJRuN7Ud0KRsYPfHIR84XlTqMfA9JBUtOLeMNQB3CTBgDlay0MVsm2QhOLGqGEcoikfvrCY1RlsNaRUzMlqQLPvSwRiJAQuHl8xg9BO/OmSLmLgTYRJ6PHIAZYm5YIi0aVUJKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJPvnljz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763650117; x=1795186117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lTFfvrpRZXxRFzE7mbtSZXzaOPD4RhsN1+X43z7bVJQ=;
  b=SJPvnljzcuH34qEO2cko3Kry/QO6LeAcLffOMJbLgGRrljqZut8CqG5I
   LdMVKWErCIxUvutfql668Ra+78TahjihL5OMrjY0zqYbcn93OxrrIrYfL
   nWRzDVJGWuAxQcVldkYSKhyAwhpE1M+ae8SzuvPJ+28MNqvV1oPwxnZQm
   tqOZSKVOU9RIBLelfFlogRF2TQUukP2fqJTk8d/DFrp5HzALuJABCEazk
   vHbh+rahfF+md+dNuPm12zrp5xCB9zOZRh93EggdWuh+utWjKJKO3xkuf
   uy2RzbQLk0O5lkO/PpHJ1mHEA/XfUTqcYtMhJay+1TUVzvCNfx1PhNRFZ
   A==;
X-CSE-ConnectionGUID: b0yjArhFQueF/kKhNhWUvw==
X-CSE-MsgGUID: 34K/zhZsRCaLgiHJ9rk7nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65652288"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65652288"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:48:36 -0800
X-CSE-ConnectionGUID: 5I8aOsmMRF+FhXNUMqMtmw==
X-CSE-MsgGUID: LyTIPn1uQpeVueOPSrGFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="190669239"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:48:32 -0800
Date: Thu, 20 Nov 2025 16:48:29 +0200
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
Subject: Re: [PATCH v7 2/9] software node: increase the reference of the
 swnode by its fwnode
Message-ID: <aR8qPYm9GFgPQedJ@smile.fi.intel.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-2-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-2-a100493a0f4b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 02:23:57PM +0100, Bartosz Golaszewski wrote:

> Once we allow software nodes to reference other kinds of firmware nodes,
> the node in args will no longer necessarily be a software node so bump
> its reference count using its fwnode interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



