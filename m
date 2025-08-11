Return-Path: <linux-spi+bounces-9341-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D1B20AB3
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673AB18C27FD
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF941DFDAB;
	Mon, 11 Aug 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK6E7X7x"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D51A5B8F;
	Mon, 11 Aug 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920207; cv=none; b=FTNJYQNwM4iK42P0rAd4e+/Eoj5YcEavdjmrsbk5InkUCMQMlzE+CpRq8DIXMXRDG2zXLBp05irUT7U7tt6d5dKaqoyGpqEeJ5mIA9twkF4o4zgkXPaJD07bNPP6skgPgHFe7X+ZlWM5wWfhMyG7wA6CTQcdF+UJhV6GZU0+y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920207; c=relaxed/simple;
	bh=7sNojz96BQK667pfkgnkWwBeqI7F9VBaOh5poBi84jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlziOQlWFMNCa/r5AfEGeFMIzeHMjqrxD5T2GnqPMo/wV6SG1Pt9uVrtUcsHN+YDAvpaDUnaBQ7tFshNSN6fpEBQv34q5hvzCxV96kbdaDgNSO9EyW50ScJxzqI4D5y2JQEGqnyX1K1AQBWJq4niRiueUrFEBsUwSQne5Vh9euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK6E7X7x; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754920207; x=1786456207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7sNojz96BQK667pfkgnkWwBeqI7F9VBaOh5poBi84jw=;
  b=iK6E7X7xIc09hSU5EMIRANBdwtqKnhgjy3e/jv4f8/i1MMLdJq2xbKCm
   G2Xs5Cj+0QaYNHt5/zSb1xY5/AQvoGyWzGZJdJ5gg7NGhna2nayQVWvE4
   mSLTV9DaOoZMIVcCPE3OHtw6rnK7kfE5UEat9QdQ9XIUGcSoI8WUWGiAX
   4tBW32TkrmajQ9f9jaNWd+y+Oqz1ME36H0ab8F26hA0pOFc/GyKmgU4C0
   //+OTJA4k6LetboF9/DsDnewdQ4XtoNdjEDoCTrbLlBAtsyp0uakRMU23
   KtKE4AIjveJsuszkvqF5YHE6u1J+hM5GRnwop3aDeKbWKi2lt03AprMEh
   Q==;
X-CSE-ConnectionGUID: BLOSg1q9RS2qJ+VntxYP+w==
X-CSE-MsgGUID: t3grEuGdSIyY13U/CjqbsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="74758639"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="74758639"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:50:06 -0700
X-CSE-ConnectionGUID: 0BfnAal2RNqKremhBa1ajQ==
X-CSE-MsgGUID: nM83XovzTAWEo/MeUOyXCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165919451"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2025 06:50:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4A80B94; Mon, 11 Aug 2025 15:50:02 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:50:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, broonie@kernel.org,
	virtio-dev@lists.oasis-open.org, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [RFC PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <aJn1Chsfe5297OTa@black.igk.intel.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-3-quic_haixcui@quicinc.com>
 <f6f087f9-83c9-452e-9a0f-f8743b8c71c2@quicinc.com>
 <ea936063-2a24-406d-a7c6-f832a72d5da5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea936063-2a24-406d-a7c6-f832a72d5da5@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 25, 2025 at 04:24:25PM +0800, Haixu Cui wrote:

...
1
> > > +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL (1 << 0)
> > > +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD (1 << 1)
> > > +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL (1 << 2)
> > Can use BIT(x) ?
> Will update the code accordingly:
> #define VIRTIO_SPI_RX_TX_SUPPORT_DUAL    BIT(0)
> #define VIRTIO_SPI_RX_TX_SUPPORT_QUAD    BIT(1)

Please, do not do this.
I explained more in the previous reply why.

-- 
With Best Regards,
Andy Shevchenko



