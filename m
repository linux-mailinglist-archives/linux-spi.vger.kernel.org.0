Return-Path: <linux-spi+bounces-9196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25954B1355E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 09:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04209178FED
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF3223335;
	Mon, 28 Jul 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dkfb0xjX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFE223301;
	Mon, 28 Jul 2025 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686605; cv=none; b=K4hnJ3n726JjZ/gYxcibNbpOdPkNVHp5j2eCeWjHdB7UJH8Ja+dVdliZ49LkNe+g7Zd53RLnLnc5xxBXkGPKM3s6Uld61HvhonkJ2bO1V9k6hFDK6e+6oj2EL4qH/tf6uWAzOpBZ7JymQYElj6fXJ4P5QKAlmRGkOPPWHNgahsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686605; c=relaxed/simple;
	bh=fELmI1I7WwxoqLk6NoJJj3JbPs2L4fWVDFlsNfL0Py4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx9E5qpZ1Ykhyyzj9gTsbnAJKTkp946KyPsSEleI59fbcUOvOVxA7jATsDI/SriveoOkVdvlTkDLZmB+X9Md62QCq/fsy5R7xnROB+k8O/U8HgeGQ4JOPmh1vtmQ3UvXLR/pnZ/4pXzGrw30qBy4FE4vw6stJTxIV+jQms/Pnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dkfb0xjX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753686604; x=1785222604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fELmI1I7WwxoqLk6NoJJj3JbPs2L4fWVDFlsNfL0Py4=;
  b=Dkfb0xjX69nDO7pXot34jXca5xlZUiwZdH8S1VUfyvWhScC7+Qa2Bx3n
   XBpXJdHNZu1aBsNJLoVNoGo5mOBUJkAcG2LSePGzwwasi5vEWpA+kz7Qz
   T/feAB0eys3SkG8MKjKGGT8NYLQdwPcU5XUVvEragLD647OPdGD8dXYWw
   ddRPtLJfv2u/JwgiC1YuP4VcXd+KgHsE1f+ZmNiBOZ1TftanwK5ozXva8
   Cs9zboavIP8CZ770qnyC1lhr4d56elRgZzQKuHh0jh/Tv0S165GwIJwgv
   BD/g4kptmdRcEV2ocySc+yyxgmXlgKIae21jaKFWy3HCfddsU6fgs29SS
   A==;
X-CSE-ConnectionGUID: 7mIbDmQCREiWvdQINKaMyg==
X-CSE-MsgGUID: CoGl8GkASrKQkMNmowPG7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="56018455"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56018455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 00:10:03 -0700
X-CSE-ConnectionGUID: 1b5uAKZ1R2WvX6VPVI7RUQ==
X-CSE-MsgGUID: jWFNKIIRRFOiYMr0h12pjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162792296"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 28 Jul 2025 00:09:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7A1A615B; Mon, 28 Jul 2025 10:09:57 +0300 (EEST)
Date: Mon, 28 Jul 2025 10:09:57 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexey Charkov <alchark@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
Message-ID: <20250728070957.GT2824380@black.fi.intel.com>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
 <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
 <mafs01psu89sx.fsf@kernel.org>
 <CABjd4YyRScBgDbi8Sk0D3vxcmLF8+YBetUdkfhrS_4Y7M+gS1g@mail.gmail.com>
 <mafs0h5z1snn7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mafs0h5z1snn7.fsf@kernel.org>

Hi,

On Thu, Jul 24, 2025 at 03:51:08PM +0200, Pratyush Yadav wrote:
> > From what I understood, spi-mem primarily expects to be talking SPI
> > opcodes to the controller, and for the controller/driver to bring
> > their own chip probing routines. This controller on the other hand
> > abstracts the opcodes away, and wants someone to tell it what its
> > flash chip can do (the controller itself can only get a chip ID in
> > "normal" mode, and it needs to somehow know the chip size and
> > standard/fast read capability of the chip). So pretty much the
> > opposite, huh.
> 
> Does it use SFDP to figure out which opcodes to use? Then it feels very
> similar to intel-spi. See [0] for example. I know this is fitting a
> square peg in a round hole, but if it isn't too painful then it would
> make maintenance on SPI NOR end a bit easier.
> 
> Mika (+Cc), you did the conversion of intel-spi to SPI MEM. Maybe you
> can share how painful/easy the conversion was, and if it ended up being
> maintainable?

Well it is kind of "maintainable" but the driver needs to do whole lot of
translation to get the SPI opcodes translated into the commands the
controller can actually execute. This means that if we get new opcodes for
new chips the driver needs to be updated too. I feel the SPI MEM is not
really good fit for "higher level" controllers like this.

