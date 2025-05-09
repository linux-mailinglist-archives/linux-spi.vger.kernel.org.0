Return-Path: <linux-spi+bounces-8010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B3AB0813
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 04:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4130B1BA3969
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 02:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39782309B6;
	Fri,  9 May 2025 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCQt4XHj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1E22FDFF;
	Fri,  9 May 2025 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759143; cv=none; b=P4ezAqBVB2YJGFoLPiDfRtF8EWgrBP4DSLVZRHPqwzbsWM7WejcRN9h5kD/jLf/xPsgy6wjY9wI5Bogaljuoxgbv4AyTCXLHNqp5ZtJXXjnfrBdRrQLyUl6ttM2ibX6/8SV91E0lQ2CkK9g2D/lrKvLMgpZ1OXE0Ee9ihDR+kZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759143; c=relaxed/simple;
	bh=6GJl5/03p4qtZ357VqegbeleeR8vc8nJug60jKGZQws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8wKB1kIv+Cy8jpmXuEUXqUxqUimZAd9kX2ibaoemtgqEBrGCNl9An2vs1LiCmaEoS+QVv2BZU4nIGBNDVAVLGzwmhDJ6XAXBTNQRwJ3qjOpOD87/wcRuqk1vavtezIjfMi8fllqGSUhsTRgtcHZigPHfbcTEGhO0935f3hQdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCQt4XHj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746759142; x=1778295142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6GJl5/03p4qtZ357VqegbeleeR8vc8nJug60jKGZQws=;
  b=ZCQt4XHjlNLsLN26Yy6Uj9zo6VzjyYe15TPp/B6Q9ajcvi1OXd5IDXAg
   Ms4piGdHGoomfmed1Hze04fNw1NY/DOOGYXB/Oqs4L0n0S4iVAxefzhtt
   aezT6cWakksk4ml0avSwyj72ssOm+rn7zXKjIyI8bU8fVYGiSJhr/hbq7
   yfuRbY9lJ6rMqXvJw7ZutVYlzSqGLtsKfxurxbbulJXaykXScl4gRUUed
   4NV5P8rL6SaQpa4y5iGir9XI9rm5viN39eCxsTIPoMBrYuWcVahxdEhs1
   5bfH1gEFlarDvfmqVgse1cgeeXZ7PYwo6PCBmud/ypHAUMh9tYGR+0APu
   Q==;
X-CSE-ConnectionGUID: TJpYdmIMTai529IxgWC6Zw==
X-CSE-MsgGUID: zl+DiOZaRbW9PcM3YU3Rzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59971005"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="59971005"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 19:52:21 -0700
X-CSE-ConnectionGUID: mzkDUzqyTteGozfkbYOQ0g==
X-CSE-MsgGUID: z1gCnSq0RGKtHzq0AizYig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136185823"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 19:52:18 -0700
Message-ID: <db0bf1b9-dd6c-4451-8eb9-ab789d732992@linux.intel.com>
Date: Fri, 9 May 2025 10:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: Robin Murphy <robin.murphy@arm.com>, Aditya Garg <gargaditya08@live.com>,
 =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>,
 linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
 <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 19:29, Robin Murphy wrote:
> On 2025-05-08 3:15 am, Baolu Lu wrote:
>> On 5/8/25 01:07, Aditya Garg wrote:
>>> Keyboard and touchpad stopped working on several Apple Macbooks from 
>>> the year 2017 using kernel 6.12.xx . Until now I could only find this 
>>> discussion affirming the bug on Debian and Fedora:https://github.com/ 
>>> Dunedan/mbp-2016-linux/issues/202
>>>
>>> On siduction I also tried the more recent kernels 6.14.5 and mainline 
>>> 6.15-rc4 (from Ubuntu) and the issue persisted with my testdevice 
>>> MacBookPro14,1 -- see the relevant output:
>>>
>>> kernel: platform pxa2xx-spi.3: Adding to iommu group 20
>>> kernel: input: Apple SPI Keyboard as /devices/ 
>>> pci0000:00/0000:00:1e.3/ pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/ 
>>> input/input0
>>> kernel: DMAR: DRHD: handling fault status reg 3
>>> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 
>>> 0xffffa000 [fault reason 0x06] PTE Read access is not set
>>> kernel: DMAR: DRHD: handling fault status reg 3
>>> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 
>>> 0xffffa000 [fault reason 0x06] PTE Read access is not set
>>> kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
>>> kernel: DMAR: DRHD: handling fault status reg 3
>>> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 
>>> 0xffffa000 [fault reason 0x06] PTE Read access is not set
>>> kernel: DMAR: DRHD: handling fault status reg 3
>>> kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
>>
>> It appears that all DMA faults are related to a fixed address,
>> 0xffffa000. Is this address something special?
> 
> Maybe it's retrying the same buffer a few times before finally giving 
> up? The address does look like a plausible iommu-dma IOVA, so I can 
> imagine at least two possibilities where a change in the IOMMU driver 
> might have an impact:
> 
> - It's the right address in the right context but incorrectly mapped as 
> DMA_FROM_DEVICE, where that previously had implicit read permission as 
> well but is now write-only (can the Intel 2nd-stage format do that like 
> Arm does? I forget...)

Intel 2nd-stage page table format allows write-only permission. But
commit eea53c581688 ("iommu/vt-d: Remove WO permissions on second-level
paging entries") has already removed it, and v6.12 kernel contains this
commit.

By the way, we are about to restore the write-only permission on 2nd-
stage page table,

https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com/

... if the device driver provides only DMA_FROM_DEVICE and the iommu
driver uses 2nd-stage page table for its dma translation.

The iommu driver currently treats DMA_FROM_DEVICE as a hint rather than
a mandatory requirement. If we want to enforce write-only permission in
the future, we should allocate a domain allocation flag so that the
iommu driver could have the opportunity to select the appropriate page
table format.

> 
> - It's the right address in the wrong context, because the DMA mapping 
> was done with the wrong device, which was previously in the same IOMMU 
> group as 00:1e.3, but now we assign groups differently. I don't know if 
> lpss_spi_setup() is relevant to this particular hardware setup, but 
> "dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));" 
> there certainly catches my attention, at least.
> 
> The DMA mapping tracepoints should be able to shed light on how that 
> address is mapped prior to the fault.

Yes. DMA mapping trace messages would shed more lights.

Thanks,
baolu

