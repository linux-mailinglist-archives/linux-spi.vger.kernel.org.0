Return-Path: <linux-spi+bounces-7364-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A2A76450
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A271883653
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7FD1D79BE;
	Mon, 31 Mar 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wh+mYJR8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E21DE4EA;
	Mon, 31 Mar 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417292; cv=none; b=socGjLU22I2j8EQeiWPevtpvoUkJagNfzwGI2hVJrvJfgSGB8d5nv6tBwnab7TM9yK6C5uoK4Fxoissqa1mPUFMDuAFDby7E0YiChaClRdKo1MGLSI2QvBgWrdrL2/SbYzXaVf5Ty28877W6H7hKEMjaSPaiirZ4VIzVQu/6v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417292; c=relaxed/simple;
	bh=i6OESr7sqBnutkJwUtXDPCFB3tJMF1nGPzTGzdq4Gao=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhtWpZ9x4rurofye7HluPbyjBqTkOrIgaMDXN2akbpffLGBXSagoLRmYu3MgquuklN8Zx+66cOtVE7Ob4GR/ew8qK+X2OIXTuH+5hVM9irLPiNIhQUPBH4im+JJtTYlWOz8MfNidsvTPNuoaUrIM4RP098LMH/VcWEqbSQjYDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wh+mYJR8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743417291; x=1774953291;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=i6OESr7sqBnutkJwUtXDPCFB3tJMF1nGPzTGzdq4Gao=;
  b=Wh+mYJR8yuKjdomdSDORtygzywXToJxCoweNX82zRnPId3UuKQ9oCxle
   J0gNRmHhrvzDOVaXk2FROFNJlp6swYzlB60tJwBF09sEN2Yi5OWtoUcgR
   HzmEVpFXgo4CyOcsDCGNiug/rZooRTs+jQIzrha44ifPXimFG9adxl3Iz
   B7UKJlPVjZo4GTLfXmp9u/X38j1GKQ/68G7/IXjjEsGZNYKFaQJQRzn96
   vaOWuMQ7AqSn/sFeDwWr4QjgXoOAGXSWTaS80X9XcF18Fbn6sqALljepS
   ugljNKerqpwzDxI6pvw5llSLbOxVd3G6TS2GrsTbHgiMS+IKCmY1LN2Ys
   Q==;
X-CSE-ConnectionGUID: 7HZOWv6fTWmZsaH0dWkxUw==
X-CSE-MsgGUID: BaHoeJH4RlCjpPayKA1t4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44875991"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44875991"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:34:50 -0700
X-CSE-ConnectionGUID: plA3MP+PQCq43616VN7cMw==
X-CSE-MsgGUID: o4fhvhSSRK2q3232/aA3HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131065407"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:34:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tzCTe-00000007ddT-34e6;
	Mon, 31 Mar 2025 13:34:46 +0300
Date: Mon, 31 Mar 2025 13:34:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Group CS related fields in struct spi_device
Message-ID: <Z-pvxknKkP85nmhu@smile.fi.intel.com>
References: <20250331101649.4054627-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331101649.4054627-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 31, 2025 at 01:16:48PM +0300, Andy Shevchenko wrote:
> The CS related fields are sparse in the struct spi_device. Group them.
> While at it, fix the comment style of cs_index_mask.

Scratch this, it was based on a wrong branch. I will issue a v2.

-- 
With Best Regards,
Andy Shevchenko



