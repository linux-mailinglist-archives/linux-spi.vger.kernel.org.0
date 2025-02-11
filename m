Return-Path: <linux-spi+bounces-6754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775BA30737
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 10:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF2D3A1830
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35081C1F02;
	Tue, 11 Feb 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwUTjXzg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB81BD9D2;
	Tue, 11 Feb 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266450; cv=none; b=XL2jxhbp7IUhHcyfP1rr9/I/KuwIIb5OqinCi3PJ8LFnCsnQmdB7mI2kNmuIDa74EQwa/yRMPsVtpVNh+LoquSYd1blqnmYf2bQGQDkIk/q4n7sTk3SDZrkxNJRXrMzPx8Dn+5HKa9AxbWU/aaOJTS1kmQWk2wkSTtTgs8MbiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266450; c=relaxed/simple;
	bh=Y7+oO2OZP1DNk/8EYMtFBmFLiKua9Hyu//B5IPMfpbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxZkTRczraQgq4VbZEsl5hrYM+DhRW4Vg7E8fauuXDQlr1EP+2DgPEynuvZA7p9/4S8iswQ5ZmhWR7OEkK/dQxEK2usk7cR/uqSVicw6VCIU4eqaMUsLzmKCvGVqho/3OgFLfYsIsXRyHe4ylAz52HgxU2spr2Ie2zOcoggt6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwUTjXzg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739266449; x=1770802449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7+oO2OZP1DNk/8EYMtFBmFLiKua9Hyu//B5IPMfpbo=;
  b=fwUTjXzggmLZvh/r1q8OajFsHBNM6QDluVJ4TNlPX2pOs8HtYbHTzJq6
   kSLAL0vu/te5RoJQ8IoHuGPqKFYSBo2F7i0Xn4K74/jOPbn1WaIrBukJM
   dY6AjxflIXI4en/KJ7oCnukkSnydpr3C6A6i0LUzVbnaMuA2T/GX+Iy31
   AJ2dzZFSVM0KUZA0ULjttOJ0gXiNeGId3Qk/2xbjkL2L+8CUJzunC0z1r
   3/uMWKOtfLaZEUqhZgZHsjZXdTu2kOKLmfjbt6pzBLLm2nZXA8PBI9O2z
   p7Agwk83VpjltY3bjEww8Xhs3ZXp2MIIuO/QAF0W/m5//HyMHpDEu4R+o
   g==;
X-CSE-ConnectionGUID: bq94FiAmSt6UaGz9qmp9/Q==
X-CSE-MsgGUID: L5JcBbc1TGSjMoPW57hxSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57414326"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="57414326"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:34:09 -0800
X-CSE-ConnectionGUID: Jr3zBeuAT/2OPMZVIMCU9g==
X-CSE-MsgGUID: hmYDjOzVSlqgiJ9DPBJ8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112925516"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:34:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thmea-0000000AST8-2rmQ;
	Tue, 11 Feb 2025 11:34:04 +0200
Date: Tue, 11 Feb 2025 11:34:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: offload: extra headers
Message-ID: <Z6sZjPj-izl_-cRc@smile.fi.intel.com>
References: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 10, 2025 at 05:16:13PM -0600, David Lechner wrote:
> Following up from some late feedback, a couple patches adding extra
> headers to a few SPI offload files.

For both,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



