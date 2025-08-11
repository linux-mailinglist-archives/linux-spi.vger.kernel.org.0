Return-Path: <linux-spi+bounces-9342-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A6B20ACF
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 15:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D63A9DAB
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0111F1507;
	Mon, 11 Aug 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbapUF9i"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB81E3DFE;
	Mon, 11 Aug 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920362; cv=none; b=vDQjdwl8ZpTCuQBpo2ARyy/6gkrAhtS5y9OxktSVyxx7frcsG8+CJbyyxZgJpFlpJ13gP4VaTm69j8Mt9Kgjl6TmJXAAbwAFw+ntfLsarhB/bLPc/4i7UPjBU/rD+VHKUY3xoVrHgP4vPpvpUIrpZl/wcQ2afA/UHDaQC5QLhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920362; c=relaxed/simple;
	bh=Aql2THQceJ4GffDpFhDq2nHqAMJ2K2EU3ur3gU8xV3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVf96tpB2vrcK9p7pGaUCE4jK3qJs9DllbTYTndEeMECEUExR2DJsZcupaa4NPTPvbX8iEkVIVe8ND9mWVj7bzvRqOw7UVAo7KlNuDdJTWcHsRpor7P2rZfUZPBC/UqgWQmFV8s4Ouib9NbNIpD29lbE5rX+yUqdjgvTYMZ4Wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbapUF9i; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754920360; x=1786456360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aql2THQceJ4GffDpFhDq2nHqAMJ2K2EU3ur3gU8xV3w=;
  b=EbapUF9iwnpQfYkqXSqQtL59x4RpWMPActd+zyIC2vSu/wgrJCkLkqiE
   5TZpiNBKS0vF5AXX/eSH2lOnWw5Vj2/dOLci2s43k97KwiwGdTvPbtQ6F
   nkOk/VwZXHa3AR92HgjlCu7olVIFU4T4PYW89S3+i8TUKJ0zeIIXAWIoC
   ufvm69svBQPxxvKbOruCYMd/0GvfEVzz7NoN7eNi3YNSpQz9TY4T1pElc
   fxkPjKLk2Ldo2hrORGv0ajox2Upcy22EHWi7dga2RVVp0bHo8R8X2ElhL
   Ved39Jm7NYhc+8FUvNbSj2AxZhV2nIb0uFPdVzHLS75xT0XQ0u8yMmtGv
   Q==;
X-CSE-ConnectionGUID: nbNvMxiDSbats0duocoGnQ==
X-CSE-MsgGUID: 9RbbGuTmSLmiavXqoF0YLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="74758824"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="74758824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:52:39 -0700
X-CSE-ConnectionGUID: dQzUXkjBT7i6kX3xocf3lg==
X-CSE-MsgGUID: Xk0+KFR0TSaKGMP0S6SJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165129404"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 06:52:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4654194; Mon, 11 Aug 2025 15:52:36 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:52:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: broonie@kernel.org, virtio-dev@lists.oasis-open.org,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com
Subject: Re: [RFC PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <aJn1pNxapW09BYpu@black.igk.intel.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-3-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401033621.1614194-3-quic_haixcui@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 01, 2025 at 11:36:20AM +0800, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.

...

> +/*

All comments look like kernel-doc, but miss the proper annotation. Why?

> + * All config fields are read-only for the Virtio SPI driver
> + *
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports to toggle
> + * chipselect after each transfer in one message:
> + *   0: unsupported, chipselect will be kept in active state throughout the
> + *      message transaction;
> + *   1: supported.
> + *   Note: Message here contains a sequence of SPI transfers.
> + * @tx_nbits_supported: indicates the supported number of bit for writing:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @rx_nbits_supported: indicates the supported number of bit for reading:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @bits_per_word_mask: mask indicating which values of bits_per_word are
> + *   supported. If not set, no limitation for bits_per_word.
> + * @mode_func_supported: indicates the following features are supported or not:
> + *   bit 0-1: CPHA feature
> + *     0b00: invalid, should support as least one CPHA setting
> + *     0b01: supports CPHA=0 only
> + *     0b10: supports CPHA=1 only
> + *     0b11: supports CPHA=0 and CPHA=1.
> + *   bit 2-3: CPOL feature
> + *     0b00: invalid, should support as least one CPOL setting
> + *     0b01: supports CPOL=0 only
> + *     0b10: supports CPOL=1 only
> + *     0b11: supports CPOL=0 and CPOL=1.
> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
> + *     supported, chipselect active low should always be supported.
> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first should always be supported.
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
> + *     normal mode should always be supported.
> + * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
> + *   limitation for transfer speed.
> + * @max_word_delay_ns: the maximum word delay supported in ns unit,
> + *   0 means word delay feature is unsupported.
> + *   Note: Just as one message contains a sequence of transfers,
> + *         one transfer may contain a sequence of words.
> + * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chipselect
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   deasserted.
> + */

...

> +	u8 result;

Shouldn't all types in UAPI be double underscored?

-- 
With Best Regards,
Andy Shevchenko



