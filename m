Return-Path: <linux-spi+bounces-8101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A8FAB48E4
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 03:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF57B10F6
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE9195B37;
	Tue, 13 May 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Chy+YN34"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5517583;
	Tue, 13 May 2025 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100534; cv=none; b=MdzSf3q/AH5N3SX/zRHvbDTZ5J/GvqX+EYNINU1zz5rDyBx728ywOmXjS3F10r242H5lYtGd7WuWQKGDcVngu0Y1ipRrn9FafeUTCKPxLHs3aH4lkg3VKHN/xHTk/GqvXknQEgA4DXnNozdO6w8uopZ+i9WUwRm/SQwHm8ONtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100534; c=relaxed/simple;
	bh=tqfQS6oxsFjhPs/Z50e9x6aN2DzbxyZhm92wCnbhKDU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=WDZMH0TU8JnhYd/5KIISUp8SKg/2IDzpAq7MyySEJtsl/dybSewwLAK9AoXpsOaveH7BzMvd3UX4AhOA68qBasZHO9zxlXR8S2q0H+EmdGr69DwX3QsJp0lcMTQD+xeskqoqMkdvrVSrsGBNrGsPDtI+Y/SvGkpxfdE6j198dmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Chy+YN34; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747100533; x=1778636533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=tqfQS6oxsFjhPs/Z50e9x6aN2DzbxyZhm92wCnbhKDU=;
  b=Chy+YN34mY22ZozBYtd+UuJLKPU0k1atSJLJxHgE8OJYrSbYWNknitm5
   k0TfKjYt+u41Mz/zSwY9mLVkeRgULYZnKU1GNIFoHoD6qFXKRY1WvD3Dp
   rj6NhzSn3eLvElDobR72/6AfD4ZVwIcVlaeBOLroLmPklJ29LTpWXe1wZ
   wLY+SBpwtqvhpkyOfxgV6NqMLM1MTvPRjIlnnbNnMVhWcHbzfXT+2wPgn
   wSI/W0voq/szmnEtNneRVoMhwzhS2vRzHcoRKTVh+END9bNNAaUm0BKHT
   LvAlCtatqTCpJwW1GbM3aQdrvSB/KYPV6mXSZqQwYWCnoBQaYWzH6h+r+
   g==;
X-CSE-ConnectionGUID: HwHAbeAYRFCWAZp1ygjLoQ==
X-CSE-MsgGUID: B2tVQlv9Qn6R8btHW58VWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66332200"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66332200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 18:42:13 -0700
X-CSE-ConnectionGUID: gs+bo9UCRS6oUiHvHgEzow==
X-CSE-MsgGUID: 98vXkWv8RyW7ZTZtktSHOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142497925"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 18:42:10 -0700
Content-Type: multipart/mixed; boundary="------------Pmc9TytVRXbvZn0nfSt18r6r"
Message-ID: <5d760ba9-031f-469b-96e0-a171b7142f88@linux.intel.com>
Date: Tue, 13 May 2025 09:37:33 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <eke7v7q6vxai.wl-kobarity@gmail.com>

This is a multi-part message in MIME format.
--------------Pmc9TytVRXbvZn0nfSt18r6r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/25 20:16, kobarity wrote:
> Baolu Lu wrote:
>> On 5/11/25 21:31, kobarity wrote:
>>>
>>> Hi
>>>
>>> I'm also experiencing this problem on my MacBookPro14,3.
>>>
>>> Aditya Garg wrote:
>>>>
>>>> Hi Jörg
>>>>
>>>> Can you test the kernel here to see if this fixes your issue:
>>>>
>>>> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/14944200356
>>>>
>>>> Alternatively you can try compiling your own kernel with this patch:
>>>>
>>>> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com/
>>>
>>> As far as I have tried, this patch did not solve the problem.
>>>
>>> By bisecting, I found that this problem was introduced by commit
>>> 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
>>> In fact, since this commit, it will panic at startup.  This panic was
>>> fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
>>> pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
>>> 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
>>> and touchpad is not working.
>>
>> Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
>> comparison in context_setup_pass_through_cb")?
> 
> Yes, I tried it on yesterday's master branch, including commit
> 64f792981e35.
> 
> - Keyboard/Touchpad NOT working:
>    - No patches
>    - With patch in https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvidia.com/
> - Keyboard/Touchpad working:
>    - With my workaround patch

Okay, thanks! Can you please try below change? I also attached a diff
file in the attachment for your convenience.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 49530d5d8c85..9a86ead8377d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1832,6 +1832,8 @@ static int dmar_domain_attach_device(struct 
dmar_domain *domain,
         if (ret)
                 goto out_block_translation;

+       info->domain_attached = true;
+
         return 0;

  out_block_translation:
@@ -3206,6 +3208,10 @@ void device_block_translation(struct device *dev)
         struct intel_iommu *iommu = info->iommu;
         unsigned long flags;

+       /* Device in DMA blocking state. Noting to do. */
+       if (!info->domain_attached)
+               return;
+
         if (info->domain)
                 cache_tag_unassign_domain(info->domain, dev, 
IOMMU_NO_PASID);

@@ -4302,6 +4308,9 @@ static int identity_domain_attach_dev(struct 
iommu_domain *domain, struct device
         else
                 ret = device_setup_pass_through(dev);

+       if (!ret)
+               info->domain_attached = true;
+
         return ret;
  }

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cbfb8bb4c94a..3ddbcc603de2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -774,6 +774,7 @@ struct device_domain_info {
         u8 ats_supported:1;
         u8 ats_enabled:1;
         u8 dtlb_extra_inval:1;  /* Quirk for devices need extra flush */
+       u8 domain_attached:1;   /* Device has domain attached */
         u8 ats_qdep;
         unsigned int iopf_refcount;
         struct device *dev; /* it's NULL for PCIe-to-PCI bridge */

Thanks,
baolu
--------------Pmc9TytVRXbvZn0nfSt18r6r
Content-Type: text/x-patch; charset=UTF-8; name="diff.patch"
Content-Disposition: attachment; filename="diff.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYwppbmRleCA0OTUzMGQ1ZDhjODUuLjlhODZlYWQ4Mzc3ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCisrKyBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYwpAQCAtMTgzMiw2ICsxODMyLDggQEAgc3RhdGljIGludCBkbWFy
X2RvbWFpbl9hdHRhY2hfZGV2aWNlKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluLAogCWlm
IChyZXQpCiAJCWdvdG8gb3V0X2Jsb2NrX3RyYW5zbGF0aW9uOwogCisJaW5mby0+ZG9tYWlu
X2F0dGFjaGVkID0gdHJ1ZTsKKwogCXJldHVybiAwOwogCiBvdXRfYmxvY2tfdHJhbnNsYXRp
b246CkBAIC0zMjA2LDYgKzMyMDgsMTAgQEAgdm9pZCBkZXZpY2VfYmxvY2tfdHJhbnNsYXRp
b24oc3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUgPSBp
bmZvLT5pb21tdTsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCisJLyogRGV2aWNlIGluIERN
QSBibG9ja2luZyBzdGF0ZS4gTm90aW5nIHRvIGRvLiAqLworCWlmICghaW5mby0+ZG9tYWlu
X2F0dGFjaGVkKQorCQlyZXR1cm47CisKIAlpZiAoaW5mby0+ZG9tYWluKQogCQljYWNoZV90
YWdfdW5hc3NpZ25fZG9tYWluKGluZm8tPmRvbWFpbiwgZGV2LCBJT01NVV9OT19QQVNJRCk7
CiAKQEAgLTQzMDIsNiArNDMwOCw5IEBAIHN0YXRpYyBpbnQgaWRlbnRpdHlfZG9tYWluX2F0
dGFjaF9kZXYoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgZGV2aWNlCiAJ
ZWxzZQogCQlyZXQgPSBkZXZpY2Vfc2V0dXBfcGFzc190aHJvdWdoKGRldik7CiAKKwlpZiAo
IXJldCkKKwkJaW5mby0+ZG9tYWluX2F0dGFjaGVkID0gdHJ1ZTsKKwogCXJldHVybiByZXQ7
CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuaAppbmRleCBjYmZiOGJiNGM5NGEuLjNkZGJjYzYwM2Rl
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oCisrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuaApAQCAtNzc0LDYgKzc3NCw3IEBAIHN0cnVjdCBkZXZp
Y2VfZG9tYWluX2luZm8gewogCXU4IGF0c19zdXBwb3J0ZWQ6MTsKIAl1OCBhdHNfZW5hYmxl
ZDoxOwogCXU4IGR0bGJfZXh0cmFfaW52YWw6MTsJLyogUXVpcmsgZm9yIGRldmljZXMgbmVl
ZCBleHRyYSBmbHVzaCAqLworCXU4IGRvbWFpbl9hdHRhY2hlZDoxOwkvKiBEZXZpY2UgaGFz
IGRvbWFpbiBhdHRhY2hlZCAqLwogCXU4IGF0c19xZGVwOwogCXVuc2lnbmVkIGludCBpb3Bm
X3JlZmNvdW50OwogCXN0cnVjdCBkZXZpY2UgKmRldjsgLyogaXQncyBOVUxMIGZvciBQQ0ll
LXRvLVBDSSBicmlkZ2UgKi8K

--------------Pmc9TytVRXbvZn0nfSt18r6r--

