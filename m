Return-Path: <linux-spi+bounces-7991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1EAAF11A
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 04:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483D77B9C9E
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 02:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574C19CC02;
	Thu,  8 May 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDpgfJz/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12609145FE8;
	Thu,  8 May 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670804; cv=none; b=WBJgvcqOimAR3Y2Yj4W3zTLo7PocwoxzlvbpI6uPzrurmO3eHPK3Yel/9liTCn7z6QwpwcwVJGLdxEikZ0Dz/KtYFSXndX2O3Rx9Mdj1S1C8Mi+FfESc5OcOQeSeHOzIH/0MSwjCi00qkAUHne+9fMamVHI/w30opq77Iz9Y/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670804; c=relaxed/simple;
	bh=K9VvzZF7FrE8ISkenxe5c39/nohHVfBIj4VJaVLF+LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV1tm+hMAMz0tedH1EY0OcRNQXN1EXxtSj3el3PMYaCVEddkcSUUU8gVpOsrZ94c9m5ncrHKSGurdl6KJZNm+Jf5wbsmOrdGiVp1A9ZEy05Su6QSI4QgJqHOhEuQBR5PejFC6MjFHrWiqhuAkLiezsGI44fR8SsaaR4gwA0ETGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDpgfJz/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746670803; x=1778206803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K9VvzZF7FrE8ISkenxe5c39/nohHVfBIj4VJaVLF+LU=;
  b=gDpgfJz/NRxGT0Cfp861UuvhRUxkHbLY0hjSQGq2Fd6rseXFckQsGyNt
   kW9/6PN/mkRWpHhp22fGSn6nIMfxKUAcAlGXxeAl4DCyn/U3Jt+QYF9QQ
   z2Njh+8tpdfMrGZaVrnwOOE3xPmYOjVAEdXmQPqJvoiBNcTO0FIA1uIx1
   8SHyCCMCGsRtCRx4KqZjKa0wIhCJD6XNKKFF2DL0tav9bo/ZpkY+quhFj
   GkjJJB85fPBbTQBnJ4y5Nt0wTaRh2ZDse9eT6u78gU5dSQlvgEuvu5ttt
   5ykNZeW2NBVmrTiwPJBv9zpJBDTrOdVdM9DXgXRbl8V4lDxZrvNNjptXE
   w==;
X-CSE-ConnectionGUID: BJC/qMlRSOueQ9BPWrGfvg==
X-CSE-MsgGUID: LeJigqWlQg+EUsZcsOyZQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48595813"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48595813"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:20:02 -0700
X-CSE-ConnectionGUID: uSsh+Kr3TOykkChxmyuWfg==
X-CSE-MsgGUID: lD7yVttdQDu9Q5ECKqVsVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="159462536"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:19:59 -0700
Message-ID: <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
Date: Thu, 8 May 2025 10:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: Aditya Garg <gargaditya08@live.com>, =?UTF-8?Q?Berkel_J=C3=B6rg?=
 <joerg.berkel@bfh.ch>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 01:07, Aditya Garg wrote:
> Keyboard and touchpad stopped working on several Apple Macbooks from the year 2017 using kernel 6.12.xx . Until now I could only find this discussion affirming the bug on Debian and Fedora:https://github.com/Dunedan/mbp-2016-linux/issues/202
> 
> On siduction I also tried the more recent kernels 6.14.5 and mainline 6.15-rc4 (from Ubuntu) and the issue persisted with my testdevice MacBookPro14,1 -- see the relevant output:
> 
> kernel: platform pxa2xx-spi.3: Adding to iommu group 20
> kernel: input: Apple SPI Keyboard as /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/ 
> input/input0
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> kernel: DMAR: DRHD: handling fault status reg 3
> kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00

It appears that all DMA faults are related to a fixed address,
0xffffa000. Is this address something special?

Also what does below message mean from a SPI driver's perspective?

"applespispi-APP000D:00: Error writing to device: 01 0e 00 00"

I am asking this because the IOMMU fault messages are about DMA Reads
(device raised memory read), while above message complains failing to
write to device.

Thanks,
baolu

