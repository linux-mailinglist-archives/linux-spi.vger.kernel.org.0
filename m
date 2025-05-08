Return-Path: <linux-spi+bounces-7998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B9AAF8BB
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0499C2592
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAE221F01;
	Thu,  8 May 2025 11:30:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A121D3E2;
	Thu,  8 May 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703801; cv=none; b=F3DXt0VhQHAD6oqr7RoJ5j4XxKco3JL974FllzRro9GyyhUjLqEc7D6ksDWni2JgYXcWV24ExIfQQX/F/bDZBBE/LfINh+KAgvLG7VV8f79gBdpdbOP+j9ndWC+GfhMC1KblVvgST+kGSuphfFTskBHL+rAOxJkkYm5o8Hwqv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703801; c=relaxed/simple;
	bh=kSaI/zdJnKbLO1hmFQjrwS7/k27n7lnFXTe6Z6uQ/60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN772EMscqJfJWLaDON/aQgige5+Z5HgwOzXkXNeB4b3u+bHkGyLD3f1LkNGyit7KlRycuMTJjkY0N6MHdHnDK2AmGMgfMifu8qXzIvtdXKWBr0tEaWNQvYLQrkibNdvZrojVhMH4GKyUlhTGycNfHcu3gB86g/Pcet1Ol/8xf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43B8D106F;
	Thu,  8 May 2025 04:29:48 -0700 (PDT)
Received: from [10.57.75.225] (unknown [10.57.75.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D097F3F673;
	Thu,  8 May 2025 04:29:56 -0700 (PDT)
Message-ID: <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
Date: Thu, 8 May 2025 12:29:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <gargaditya08@live.com>,
 =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>,
 linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-08 3:15 am, Baolu Lu wrote:
> On 5/8/25 01:07, Aditya Garg wrote:
>> Keyboard and touchpad stopped working on several Apple Macbooks from 
>> the year 2017 using kernel 6.12.xx . Until now I could only find this 
>> discussion affirming the bug on Debian and Fedora:https://github.com/ 
>> Dunedan/mbp-2016-linux/issues/202
>>
>> On siduction I also tried the more recent kernels 6.14.5 and mainline 
>> 6.15-rc4 (from Ubuntu) and the issue persisted with my testdevice 
>> MacBookPro14,1 -- see the relevant output:
>>
>> kernel: platform pxa2xx-spi.3: Adding to iommu group 20
>> kernel: input: Apple SPI Keyboard as /devices/pci0000:00/0000:00:1e.3/ 
>> pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/ input/input0
>> kernel: DMAR: DRHD: handling fault status reg 3
>> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 
>> 0xffffa000 [fault reason 0x06] PTE Read access is not set
>> kernel: DMAR: DRHD: handling fault status reg 3
>> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 
>> 0xffffa000 [fault reason 0x06] PTE Read access is not set
>> kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
>> kernel: DMAR: DRHD: handling fault status reg 3
>> kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 
>> 0xffffa000 [fault reason 0x06] PTE Read access is not set
>> kernel: DMAR: DRHD: handling fault status reg 3
>> kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
> 
> It appears that all DMA faults are related to a fixed address,
> 0xffffa000. Is this address something special?

Maybe it's retrying the same buffer a few times before finally giving 
up? The address does look like a plausible iommu-dma IOVA, so I can 
imagine at least two possibilities where a change in the IOMMU driver 
might have an impact:

- It's the right address in the right context but incorrectly mapped as 
DMA_FROM_DEVICE, where that previously had implicit read permission as 
well but is now write-only (can the Intel 2nd-stage format do that like 
Arm does? I forget...)

- It's the right address in the wrong context, because the DMA mapping 
was done with the wrong device, which was previously in the same IOMMU 
group as 00:1e.3, but now we assign groups differently. I don't know if 
lpss_spi_setup() is relevant to this particular hardware setup, but 
"dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));" 
there certainly catches my attention, at least.

The DMA mapping tracepoints should be able to shed light on how that 
address is mapped prior to the fault.

> Also what does below message mean from a SPI driver's perspective?
> 
> "applespispi-APP000D:00: Error writing to device: 01 0e 00 00"
> 
> I am asking this because the IOMMU fault messages are about DMA Reads
> (device raised memory read), while above message complains failing to
> write to device.

AFAICS it's a "write" at the SPI level, i.e. the SPI controller is 
sending data *to* the SPI device (the keyboard), so at the PCI/platform 
level the controller itself is fetching that data *from* memory.

Thanks,
Robin.

