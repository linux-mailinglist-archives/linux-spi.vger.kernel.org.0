Return-Path: <linux-spi+bounces-12414-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD24D24E6F
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 15:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C241D301A1B2
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB63A1E81;
	Thu, 15 Jan 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4bbQjQl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7136C598
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486577; cv=none; b=dScdlLoVVh2njSUNC7CmH0WzKDx2S3XdxAMEXYqNonbU7MtpY6Lk4MMJ3f11IimmAkgnKZJCl89SutwUqT0gDyyIesJZRYG45w0LQsT7S3ws2MFm6d5HcTzBPxB+9Qb5pgMDR15Azh6yrpnDrhZ5RBm5uCsAqkrtwfNvWF2aeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486577; c=relaxed/simple;
	bh=l/gxthEIRz3eU4IfqPyFZSaiAO97LgJ+vu7RHRX5Qy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxyPRfrGh3bwUFSOM/le49uTOnJR9ehGModrbvwzBvOpvGpPc4axjwPbgNN0HizwJN9w4z1G9DSwJJVvm+sEshFQJcto3anumxgREKuS1HXtT47NK1re8vSLgwwk6qyGcwd6+DpQPjkqB7omrMezVeRW07r/VysJ8aAEh5kqJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4bbQjQl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768486576; x=1800022576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/gxthEIRz3eU4IfqPyFZSaiAO97LgJ+vu7RHRX5Qy0=;
  b=S4bbQjQlZH31PfX5Y9W4tJZnR0onSQOM0HG94MXzqI6YOlAbiEPUtbAN
   /iJsTO1OLeqi0XllGr4i1j2eOW0P3Mzm4zta476Uehq40RFjkSpRPPnLq
   aMw9cVi4xXZrRd9zfA7cBkjyihQ5zx8pGIJOqYwN18NHGsXbKApaSnqJ0
   PzyudaxrucV/TD852+hrZfsUhzybQDyGDSNrsbq0KyNmi6SSyk3dkoeKL
   FP68BdcrrHUj5WrIHr62X6Ky0Qg1DO1lR46txKKAG9raZN1P4wSpT3xL3
   LF2cwzO8l6VoAx6HqyZOraCfTafFQb+CNuNoeBDTaeE24n5ylXVyn+2y7
   Q==;
X-CSE-ConnectionGUID: Aen+okYZSm2LVJ9rNLuDjQ==
X-CSE-MsgGUID: O5HDa/7/S12naMpmKXS6WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81156694"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="81156694"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 06:16:16 -0800
X-CSE-ConnectionGUID: IDo0CUaATLa6w+wp5FcMBQ==
X-CSE-MsgGUID: ftIyQlOLTNKXp0hpJ17ORA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209441246"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2026 06:16:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A1A9E98; Thu, 15 Jan 2026 15:16:13 +0100 (CET)
Date: Thu, 15 Jan 2026 15:16:13 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: intel-pci: Add support for Nova Lake SPI serial
 flash
Message-ID: <20260115141613.GF2275908@black.igk.intel.com>
References: <20260115120305.10080-1-alan.borzeszkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115120305.10080-1-alan.borzeszkowski@linux.intel.com>

On Thu, Jan 15, 2026 at 01:03:05PM +0100, Alan Borzeszkowski wrote:
> Add Intel Nova Lake PCH-S SPI serial flash PCI ID to the list of
> supported devices. This is the same controller found in previous
> generations.
> 
> Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

