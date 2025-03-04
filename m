Return-Path: <linux-spi+bounces-7031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C1A4E40E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 16:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17964424094
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EA290BB4;
	Tue,  4 Mar 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1G6t6PA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99837290BB0;
	Tue,  4 Mar 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101907; cv=none; b=Jm9vKz1y/HEebPYrJAjoteMNW3FSNh2GSBunhkxzzZnZh1X3Zbszz+r5c9KET00Dr8TR8RTPLrlXk9QFX/T1UV8JD1EeOoEah9i+Mccp6uPlkhIrG6hvkCkOIIwfmukQHe5Bo9uVngkqoJrcd/oiUriN+fso2xYPBylww5fz8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101907; c=relaxed/simple;
	bh=6ZMR3JRh3hbKzX58+/zvS7DWCMOYY0gMB6+P65b4ncA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZfa+QrwQFlEkcDuwgZf+9kgz+Ipjf5MCY0Qw8TtdMqn2MhPuWjrcJ0VLe/6ZgvRAjGilJwzpBb2bFvHVKrlAndjhjwFUtjJjRsqt0FV71a1CS6d6zzuHb6PqhKp/yRIYB1wMlH6gG0U7RYQqmTcF3HgdA1bFfVUI+SKNsh0HbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1G6t6PA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101906; x=1772637906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZMR3JRh3hbKzX58+/zvS7DWCMOYY0gMB6+P65b4ncA=;
  b=S1G6t6PAYiQMhjG4BMXurHDSRVu5+A1yz/JHfZNHMTNuyjpfquN6ABH3
   49DKF/rNKftKdSDLG52vzdqvTMuaLLzLzGNIxVxqsSOhm3NPiOsZ8rtET
   dhuJnD/3TPFtaefWmDBOF7NA1WbbHwVb+GMn8O6rtncXEMwf3doaReUFW
   XjfdB2bcOFxwckTOmxdKOB6NwyWnL4rt9mfg5WHxUHj0R4fUJU5vAA1dp
   CvvNeaSLYaMefy4nX1O6rj5TOj97PVyCCC6yuCes1dsfNkzP9fwfQciUL
   5FsHE971mt9XJtV+EwJRjKZCQ9Vk3n+SBKRcm+vxlKAemzDiKPiOD8KvF
   g==;
X-CSE-ConnectionGUID: LNnQwVSCT/22MTLFI5nkvg==
X-CSE-MsgGUID: S12lcTcOT36QoCL/i34Mpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53419958"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53419958"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:25:05 -0800
X-CSE-ConnectionGUID: 5LUeupubTcym07sCUcY9Gg==
X-CSE-MsgGUID: UeGbvbhSRGaCqLepIhePSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155600115"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2025 07:25:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0103818F; Tue, 04 Mar 2025 17:25:01 +0200 (EET)
Date: Tue, 4 Mar 2025 17:25:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-spi@vger.kernel.org, stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: microchip-core: prevent RX overflows when
 transmit size > FIFO size
Message-ID: <Z8cbTc7zdT58J4Br@black.fi.intel.com>
References: <20250303-veal-snooper-712c1dfad336@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-veal-snooper-712c1dfad336@wendy>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 10:47:40AM +0000, Conor Dooley wrote:
> When the size of a transfer exceeds the size of the FIFO (32 bytes), RX
> overflows will be generated and receive data will be corrupted and
> warnings will be produced. For example, here's an error generated by a
> transfer of 36 bytes:
> 
>   spi_master spi0: mchp_corespi_interrupt: RX OVERFLOW: rxlen: 4, txlen: 0
> 
> The driver is currently split between handling receiving in the
> interrupt handler, and sending outside of it. Move all handling out of
> the interrupt handling, and explicitly link the number of bytes read of
> of the RX FIFO to the number written into the TX one. This both resolves
> the overflow problems as well as simplifying the flow of the driver.

...

> +static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, int fifo_max)
>  {
> +	for (int i = 0; i < fifo_max; i++) {
> +		u32 data;

> +		while (mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)
> +			;

What may go wrong with this code? :-)
I think limiting the infinite loop by a timeout is a good thing to have.

> +		data = mchp_corespi_read(spi, REG_RX_DATA);
>  
>  		spi->rx_len -= spi->n_bytes;
>  

>  	mchp_corespi_write(spi, REG_FRAMESUP, len);
>  }

-- 
With Best Regards,
Andy Shevchenko



