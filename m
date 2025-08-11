Return-Path: <linux-spi+bounces-9340-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C9B20AAA
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2953B2A5849
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099217A309;
	Mon, 11 Aug 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYyqaWVZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D5192D8A;
	Mon, 11 Aug 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920150; cv=none; b=POA0thuBm5Z40GzOdLO8vYxlGLuqr3PO2XxP64V6A1idzQi0aNaGApDLzyc/5syCM7jPjRVBoiD65Ts1IY5aG2HHVX+hqrfClTlC05oagh6Pf7sJ/kTWox13XcBcVttc7XBc6pUVlY3j4zrLYRWFVIAm4vy/Az7LK5Ao3CQ4EjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920150; c=relaxed/simple;
	bh=hgje/5m7tCFZnecaHF4btLlr7z9uMoHAO2b2GE35ZTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGtA/cGVe6WA9wkd2E3ttA19Yjq1zk4uLYU5Yn7kkhp8cRWaMGIwcGpG1+4A191GarCSfKqb5mOSJ6EAPLfonChAaHdurneRwqCZdTIZr9qd6IywiBUQF0D+ulyky39pK0PStlJYVP6j8OIiYHgzy/BluIgDMP7zCU5aQsKr4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYyqaWVZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754920148; x=1786456148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgje/5m7tCFZnecaHF4btLlr7z9uMoHAO2b2GE35ZTw=;
  b=bYyqaWVZKyV08jqJAYcjFPBNxqQOj/uQCoLVUdq5HzuYxGVK3PPPQAK/
   +0dqzm+hLg395ntQT3z/HS1uihTJjPZ8lQ84gNLK4W4+0fwonHEPos+LB
   dnhkBM48UZDh2Z0rlFpFg/dVL1mE7R/jMJEosor+hpDUIUfB9gofp3tEX
   WaPhqWovLNqPVIWauVr8fx0YcVKCfOPk6fmMZ06fIKeNkRCovpjuPKVnR
   q3ojJkJd/eNCpl77CfKT2vSMXAoGaM1za5bXeEWefZZ5V/Ul11/P1umtJ
   SOLNmPEZ2S1PusAKXS0+Nx7jpsiB/zrPRJvANN16kyoUm3NZi6MXC1O5n
   Q==;
X-CSE-ConnectionGUID: lUsJ8lIrTqWI1S4bijjspA==
X-CSE-MsgGUID: X5BfU9VXQn+YWFw1OqZRwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57314368"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57314368"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:49:08 -0700
X-CSE-ConnectionGUID: CFAAlM5rSaC7yxk5Q2a6Ww==
X-CSE-MsgGUID: 3PZEryUDQ560ZACN95uUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166226665"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 11 Aug 2025 06:49:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A112B94; Mon, 11 Aug 2025 15:49:04 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:49:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Haixu Cui <quic_haixcui@quicinc.com>, broonie@kernel.org,
	virtio-dev@lists.oasis-open.org, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [RFC PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <aJn00MKH5lK6Zwsa@black.igk.intel.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-3-quic_haixcui@quicinc.com>
 <f6f087f9-83c9-452e-9a0f-f8743b8c71c2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f087f9-83c9-452e-9a0f-f8743b8c71c2@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 11:33:42AM +0530, Mukesh Kumar Savaliya wrote:
> On 4/1/2025 9:06 AM, Haixu Cui wrote:

[...]

> > +struct virtio_spi_config {
> > +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> > +	__u8 cs_max_number;
> > +	__u8 cs_change_supported;
> > +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL (1 << 0)
> > +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD (1 << 1)
> > +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL (1 << 2)
> Can use BIT(x) ?

No.

> > +	__u8 tx_nbits_supported;
> > +	__u8 rx_nbits_supported;
> > +	__le32 bits_per_word_mask;
> > +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0 (1 << 0)
> > +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1 (1 << 1)
> > +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0 (1 << 2)
> > +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1 (1 << 3)
> > +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH (1 << 4)
> > +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST (1 << 5)
> > +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK (1 << 6)
> All with BIT(x) ?

No. There is no such macro in UAPI. There is another one available, though.
Check the spi.h UAPI header for the details.

> > +	__le32 mode_func_supported;
> > +	__le32 max_freq_hz;
> > +	__le32 max_word_delay_ns;
> > +	__le32 max_cs_setup_ns;
> > +	__le32 max_cs_hold_ns;
> > +	__le32 max_cs_inactive_ns;
> > +};

-- 
With Best Regards,
Andy Shevchenko



