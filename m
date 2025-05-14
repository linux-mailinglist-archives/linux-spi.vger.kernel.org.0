Return-Path: <linux-spi+bounces-8114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D4AAB614D
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 05:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FA33B090A
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441C1E5B9C;
	Wed, 14 May 2025 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAgWLMh9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D01E5716;
	Wed, 14 May 2025 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747194262; cv=none; b=WRQcTi/ed9AO1hVY9jE0iqmptoErg5u9pD8/nhGMRuD35chtryK5ttb7LxS/M1UIiK+AiNpUtW7ai3Iw3JU87NfpMbH7l4j+hjKjF4yNPa4sbAjiDjUzI0m6u+4vRzCJZqemBGmhYq4XrT1FDCr77d+TpKfiYxlXQCsgOUNaGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747194262; c=relaxed/simple;
	bh=9pMoTXmFukaRAYw6b+fuA5BhdZG//oKKOf6c8Cvwb8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJeq6hSBvxi9rkXqQIgWQX9k/LnjVld+/I7bzomEmHZetqbSMk1t61bjB/tH+Bz19RtFXmK7pZGqPnCfjRzOLRcX2MHa8jSRIatRRou6TL2MzJuO1rms57pC/T24w8zeYKCIDghTtYP/18Gd48YMD0ILi79ExFymMx5ChyFIxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAgWLMh9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747194261; x=1778730261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9pMoTXmFukaRAYw6b+fuA5BhdZG//oKKOf6c8Cvwb8U=;
  b=IAgWLMh9IaMFCTGckaXb+BqAo2A+H/Q4elaiGwkTS1MLOG+8zHs6lJ0u
   iB/B1uI08XpFbk6XliEmvsPWe/Qtb5MT89Me1VN5FYpIJOXINTt1DuWJR
   MYYjC0gK2JFOcXJZjNvIVOB8DAIfK3fAUK1TMrxFIoGogVGyEGlijyesh
   U0ZM0c9wVv/7RkFLjpiVX7HVXsg6drtgXlVnTmhW+Sk8DLLDF8kd1QDMS
   bL0HIoy+WQh2GfWpXF5BRM5SJZLyjbQtToS+9Z627MrAefLPHlus8mIyi
   R4lM8fnUyzDqSt/uBpAvzlQf9ank4AmDdRPvznI5A0CcSC9FnMOMn4tkR
   w==;
X-CSE-ConnectionGUID: RZ6RVDBDTs2BrKsGBZrmBQ==
X-CSE-MsgGUID: UXU04rQiS/2SwA2eVNLuIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49234758"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49234758"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 20:44:20 -0700
X-CSE-ConnectionGUID: muIbOqbaRXmZ/mhVFl4nFA==
X-CSE-MsgGUID: cQDMq4JaQmS+JjO//4qkEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142852843"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 20:44:17 -0700
Message-ID: <d0e31e5e-3965-4f7d-8881-55e13dcabaaf@linux.intel.com>
Date: Wed, 14 May 2025 11:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] applespi from 6.12 onwards
To: kobarity <kobarity@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>, =?UTF-8?Q?Berkel_J=C3=B6rg?=
 <joerg.berkel@bfh.ch>, Robin Murphy <robin.murphy@arm.com>,
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
 <089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
 <eke7v7q6vxai.wl-kobarity@gmail.com>
 <5d760ba9-031f-469b-96e0-a171b7142f88@linux.intel.com>
 <eke7tt5oww4r.wl-kobarity@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <eke7tt5oww4r.wl-kobarity@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/25 20:08, kobarity wrote:
> Baolu Lu wrote:
>> On 5/12/25 20:16, kobarity wrote:
>>> Baolu Lu wrote:
>>>> On 5/11/25 21:31, kobarity wrote:
>>>>>
>>>>> Hi
>>>>>
>>>>> I'm also experiencing this problem on my MacBookPro14,3.
>>>>>
>>>>> Aditya Garg wrote:
>>>>>>
>>>>>> Hi Jörg
>>>>>>
>>>>>> Can you test the kernel here to see if this fixes your issue:
>>>>>>
>>>>>> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/14944200356
>>>>>>
>>>>>> Alternatively you can try compiling your own kernel with this patch:
>>>>>>
>>>>>> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com/
>>>>>
>>>>> As far as I have tried, this patch did not solve the problem.
>>>>>
>>>>> By bisecting, I found that this problem was introduced by commit
>>>>> 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
>>>>> In fact, since this commit, it will panic at startup.  This panic was
>>>>> fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
>>>>> pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
>>>>> 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
>>>>> and touchpad is not working.
>>>>
>>>> Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
>>>> comparison in context_setup_pass_through_cb")?
>>>
>>> Yes, I tried it on yesterday's master branch, including commit
>>> 64f792981e35.
>>>
>>> - Keyboard/Touchpad NOT working:
>>>     - No patches
>>>     - With patch in https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com/
>>> - Keyboard/Touchpad working:
>>>     - With my workaround patch
>>
>> Okay, thanks! Can you please try below change? I also attached a diff
>> file in the attachment for your convenience.
> 
> Thanks!  The keyboard and touchpad now work with this patch.  I tested
> it with the same master branch as before (commit 3ce9925823c7).
> 

Okay, thanks! Let me post a formal fix patch for this.

Thanks,
baolu

