Return-Path: <linux-spi+bounces-5164-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD1995F96
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 08:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B986E1F221D9
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8040849;
	Wed,  9 Oct 2024 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLuOZ2aE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0028EF
	for <linux-spi@vger.kernel.org>; Wed,  9 Oct 2024 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454661; cv=none; b=T0FGNze+Lv7cZ0CEWTrqQnv6YhjZtun/+eeG3EtbUzOQuBmO54wNuzUpaY68cJzL9bsQ6i0CX3pFAG+zTT7iZm0LxyY3u7dDoPUIoEbfmvRDUx2dRW1hQhTjMadBgKiRmbZixHLN3P4uHZ88zsmrRHCY1beePhRDJ9Mchkthqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454661; c=relaxed/simple;
	bh=zOxXllkQLBAZD2RYnv1nrG2HJR9Xxdx1TVxxZcej4W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS4ImqdXW00/WSaiRt2rKm3BcumU9ZZNA97o0sRBjCsAx152XEAnrcGz0JcaIt4uUhixXwKOkxw+sOgDd/Fv3Xvx24rm1DJlKyU/U/SbGgSEn1FGX+HXt9qoM+6zWCJRm5NsQqJb7Dz84njPlBxEOE7Z5a0nODrB99RQKrZkeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLuOZ2aE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728454661; x=1759990661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zOxXllkQLBAZD2RYnv1nrG2HJR9Xxdx1TVxxZcej4W0=;
  b=MLuOZ2aEklSFDVnz8MXLY3mAxHN4UPhTaj2iOxykSaw+l25lqN2AFVr2
   XiogaLLQLxlH4JJDz+4kLkLflVaVYZTQ9NNqUem3Gd6D7wRwjRLjEtqum
   BZKtE5Jasct8Sz10wutCyLOBfwwb+HFENpzRtnVambtWviOLfkIyd0s/8
   Y8ETAl+2jN19He586ztxN0ZbQkbrpFzkGigqECWSkKOtR1AYJh0TkbF6y
   sfB+yYdEjNpl3LE257fCrf6zCTNeuGEc7yXBfyEvOZhhzPHcsZm1GO8i+
   6KlBMFglnjGN2D1QBS86YW/THEwTycyJ8ZS1orPIjOELBxHUxMCHmUQoJ
   Q==;
X-CSE-ConnectionGUID: QuDB33p+Tj2r4vmCZN45BQ==
X-CSE-MsgGUID: D27d5TSATYGXmpDsXzI6rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38295042"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38295042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:17:40 -0700
X-CSE-ConnectionGUID: gc62OBJ6SvK8T8BQTCye3g==
X-CSE-MsgGUID: q+ivKvnvT7Kwy/KJMD+9KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80935887"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2024 23:17:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D0F6828E; Wed, 09 Oct 2024 09:17:36 +0300 (EEST)
Date: Wed, 9 Oct 2024 09:17:36 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: intel: Add protected and locked attributes
Message-ID: <20241009061736.GY275077@black.fi.intel.com>
References: <20241009061202.2436300-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009061202.2436300-1-mika.westerberg@linux.intel.com>

On Wed, Oct 09, 2024 at 09:12:02AM +0300, Mika Westerberg wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> The manufacturing access to the PCH/SoC SPI device is traditionally
> performed via userspace driver accessing registers via /dev/mem but due
> to security concerns /dev/mem access is being much restricted, hence the
> reason for utilizing dedicated Intel PCH/SoC SPI controller driver,
> which is already implemented in the Linux kernel.
> 
> Intel PCH/SoC SPI controller protects the flash storage via two
> mechanisms one is the via region protection registers and second via
> BIOS lock. The BIOS locks only the BIOS regions usually 0 and/or 6.
> 
> The device always boots with BIOS lock set, but during manufacturing the
> BIOS lock has to be lifted in order to enable the write access. This can
> be done by passing "writeable=1" in the command line when the driver is
> loaded. This "locked" state is exposed through new sysfs attributes
> (intel_spi_locked, intel_spi_bios_locked).
> 
> Second, also the region protection status is exposed via sysfs attribute
> (intel_spi_protected) as the manufacturing will need the both files in
> order to validate that the device is properly sealed.
> 
> Includes code written by Tamar Mashiah.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Just learned that Tomas just left Intel so this address is not working
anymore, I'll resend with that updated.

