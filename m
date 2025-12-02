Return-Path: <linux-spi+bounces-11731-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADDC9CF75
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 21:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02CE1342E4A
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2112DC79E;
	Tue,  2 Dec 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5nVIMy1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F121883E;
	Tue,  2 Dec 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708656; cv=none; b=ds8+7sxHs+BJF6K/aN5/2QdMswvnOXN4QTo4XxuiDRr7fCkPWa1KpEnWJcEbH9Ohkl5BNuC6E5xBxa0TnQOO/feImAkI6UHPKtw54JQnyQIc0HEHiEQ3i9LxVYoCjhtFEZwE6cCRzXIe8TBgOFHaYVFmzzDKP54gk8J90HGeqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708656; c=relaxed/simple;
	bh=dxSA9J1B+LhEYIizj0ghY8Q8WwzG//Lxeg+F/JtXs+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4jUiBP8LmW+ocV6C+pLOZEQZ9IF/8A140okuZ/U6xX3BnoMZxAHlVDvU2IcDBNb2v4DfpQKvOB6aLMtR/HyFdCDATo3Vn/JTDYSu0Y3FsALoorwOPfoxI4GbVKos4WNyCp9hhbNF8eqMe0YcPXXor8BtuE6DWsTqLiIF1T0uNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5nVIMy1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764708655; x=1796244655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dxSA9J1B+LhEYIizj0ghY8Q8WwzG//Lxeg+F/JtXs+Q=;
  b=e5nVIMy1VjRyx2L++zP2Gih4hggwGLeV4YnNs5CTr4Exo3ly5fKlwjmY
   JiboYQGglJ6nlBUFg7XW4pQkHzcVafDJ2TOBDEUfYfwtWMgwPZb0K9QdA
   ybwgzSexoUW3om3yj2ZYebmC1PbVa3CzDnr9zUc14qCwJzu6iKx9ML2wA
   Ti/UxNoMCDZKOPUEeHRF+ipt2v9LKE6wFJNk0xV+bC9Lc5kZs0TYIFH89
   Feuoo8CikYfvvr0yBzVkV4zrn2ixymrnIEI+RCvpmrbOuNcoRhqi+Ux/X
   h+GZa7vHcT007gD4iFjNRsCrf2tN/DOmAiVu4CuSIZLrZRuy6h2HbZjyi
   g==;
X-CSE-ConnectionGUID: 509EG2xLQOqh+aRm7LE7eg==
X-CSE-MsgGUID: ZXLh9/1ZQ1mNyRHlyLKhxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66410089"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66410089"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 12:50:54 -0800
X-CSE-ConnectionGUID: uUR95tQsRfmVjGh2iaDFfA==
X-CSE-MsgGUID: UzFGiWTMTpKwCYw8dL8MBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="225165070"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2025 12:50:52 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F329C93; Tue, 02 Dec 2025 21:50:50 +0100 (CET)
Date: Tue, 2 Dec 2025 21:50:50 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ali Tariq <alitariq45892@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, khairul.anuar.romli@altera.com,
	adrianhoyin.ng@altera.com, nirav.rabara@altera.com,
	matthew.gerlach@altera.com
Subject: Re: [PATCH] spi: cadence-qspi: Fix runtime PM imbalance in probe
Message-ID: <aS9RKnScH2DVXW-I@black.igk.intel.com>
References: <20251130091251.12120-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251130091251.12120-1-alitariq45892@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 30, 2025 at 09:12:51AM +0000, Ali Tariq wrote:
> The probe function incorrectly calls pm_runtime_put_autosuspend()
> twice in succession at the end of successful probe, dropping two
> runtime PM references while only one was acquired earlier with
> pm_runtime_get_sync(). This causes a usage count underflow:
> 
>     cadence-qspi 13010000.spi: Runtime PM usage count underflow!
> 
> Remove the first redundant pm_runtime_put_autosuspend() call to
> balance the reference count.
> 
> Tested on StarFive VisionFive 2 v1.2A board.

...

>  	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
> -		pm_runtime_put_autosuspend(dev);
>  		pm_runtime_mark_last_busy(dev);

This one — pm_runtime_mark_last_busy() — also may be removed as it's integrated
into the _put_auutosuspend().

>  		pm_runtime_put_autosuspend(dev);
>  	}

-- 
With Best Regards,
Andy Shevchenko



