Return-Path: <linux-spi+bounces-8067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC1AB2EC6
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 07:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7323AF865
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 05:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A241EE03B;
	Mon, 12 May 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqhJnXS3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26503383;
	Mon, 12 May 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027039; cv=none; b=kx7Z+/OyK2/bDXo7bT9jJAkjn2prMQjHvq/GD8g6cSgDAmTxdXiduZ6an5cnLH/eA1aH2X5ELgQ8aF7OvYOaOXkijvuqamaE6VbmeVKZwyzxKKqgTvQTGZ68rTNgTtlrqO4+eQC2e/ZntcKoWZINLR9jb9OMhSex4oHl68OlZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027039; c=relaxed/simple;
	bh=d1DbIspaborzszuaHHfNpLuHTD+O86chj15Atki5stY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbeP/PiHIEsC4nVaZ4IIVN+Kp/D9gZqTYmXaw8ia3c1uM/+PDtkRNb2ijpVMA0a3e/hqliEC2HaK2mr4+MIBpiqyJ+jffYe8Hy8/3dpUKBbIBUnqxBRBGLdbx0pJrEE4r5bqeTzRUjbVhsvaHr0Ye1LsbX7LN/QwWY1IK1fytUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqhJnXS3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747027037; x=1778563037;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d1DbIspaborzszuaHHfNpLuHTD+O86chj15Atki5stY=;
  b=JqhJnXS33bAQuu2iFS9HIQOGo6asxNKp9tnmNnAf4eGeOdEmEPkFby8h
   Z0G14xkqffB5T21b3bQRcj0UyIhqklnZ6dLN55Zb0DIjwBt+aVayf2bZN
   ikXUY17GDlg1dB5r6W8RKEvBhai0ST9SFCQehoK58fZh64SBp4AtYO87X
   AXDouqFEwkg8RgpydJO67jlVV+tUz3SjIeYLE0XCDMMV6f9YpJHfCRoqZ
   sWBSY54MJtj21x3fo3mqimKWe9e13p5HL7jUtgAB5v8AVNvGoqumI68Sh
   sRH4sFqBGrmHf/xlZe4NXBBVk5UstNuIRqZ9xxpBbZZY2aqu6wFtz8HA0
   g==;
X-CSE-ConnectionGUID: Pu1zHaLqQdCXFGfvRCfzJw==
X-CSE-MsgGUID: 9IRFA7yZQ++p/4kymyjSyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52620523"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="52620523"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 22:17:16 -0700
X-CSE-ConnectionGUID: XGBJ7UCTRGqvUpUbTFCatQ==
X-CSE-MsgGUID: dISN6hk3Qz213K05sVGIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137119974"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 22:17:13 -0700
Message-ID: <089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
Date: Mon, 12 May 2025 13:12:38 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: kobarity <kobarity@gmail.com>, Aditya Garg <gargaditya08@live.com>
Cc: =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "lukas@wunner.de" <lukas@wunner.de>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
 <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
 <PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
 <PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <eke7wmanw9xq.wl-kobarity@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <eke7wmanw9xq.wl-kobarity@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/11/25 21:31, kobarity wrote:
> 
> Hi
> 
> I'm also experiencing this problem on my MacBookPro14,3.
> 
> Aditya Garg wrote:
>>
>> Hi Jörg
>>
>> Can you test the kernel here to see if this fixes your issue:
>>
>> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/14944200356
>>
>> Alternatively you can try compiling your own kernel with this patch:
>>
>> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com/
> 
> As far as I have tried, this patch did not solve the problem.
> 
> By bisecting, I found that this problem was introduced by commit
> 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
> In fact, since this commit, it will panic at startup.  This panic was
> fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
> pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
> 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
> and touchpad is not working.

Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
comparison in context_setup_pass_through_cb")?

> 
> I also found that I can workaround this problem by reverting only the
> intel_iommu_attach_device() change in commit 2031c469f816 as in the
> attached patch, but I'm not sure if this is a reasonable fix.
> 

Thanks,
baolu

