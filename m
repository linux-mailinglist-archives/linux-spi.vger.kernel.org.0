Return-Path: <linux-spi+bounces-10874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C11C14B34
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680FA1B227F2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88D330B14;
	Tue, 28 Oct 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PREr+dBg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B932ED52;
	Tue, 28 Oct 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655713; cv=none; b=mrJ1tA64oCBi4nSyok00wfCkNbB3NaWfzm/efjRnEW7iZWq/qqfprBfBEhfF3oeEfTuN3aTYzeWKlL/iLiyVIMWUvruBvRbH1xUkbXClLqRsiWtD3A+rUGo7g/j7OX7ZtWxKq1V7D+OJVxvUAz3HmFyRRxVKq6ufnddv8skuBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655713; c=relaxed/simple;
	bh=IsSiLtjjKrn57XWnq/ZtclrFpBaVV4MFEOdQtDmlEKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WthOouQqzqXy7qBlTUz3GVRJjb0/tRqHFacQh65o1jzNuiDbQqWRdVXrhbDInFrzieLSJHSJe2gkJUp9Y8nR1lVMCRVEH00/VYPi6jWP+lsVzV0MGwfJcF9N0hC/vaQqRkDCnZ3dlCfcnlTYTzr12v7Bjyvs/qw8X5n7GHF+WRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PREr+dBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063A4C4CEE7;
	Tue, 28 Oct 2025 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761655711;
	bh=IsSiLtjjKrn57XWnq/ZtclrFpBaVV4MFEOdQtDmlEKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PREr+dBgL1t7+RMy/TivRYw9OL39nez4quLnCltbLPG01ozww8UZmKThJS8YPRkk/
	 wjubkkQycgg7VILM1kl9Dt0kx9SgcuZJ4J9giIoLTNxhxB4gWk1zpDyDGx0atnu9mp
	 QSBh4GNdNvHExTBatR+h/9B/4pKYPu+E1KzsLqjaz97zPzoyGpgF05N5FxQ65P63fJ
	 /1S/n6mAmmwffP3jqEN3YvQ04/hxdX36G8/S/TVSSoul+Oq7/W+99RA/lbzyMnacgr
	 ATHOCyn0k9Mu+WRY8AcTBj91y0qu4nfNh0RfZ/5pEQWtOdbZAa2J3giQuiUMk3ftID
	 IjRzww19Q3prw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
Date: Tue, 28 Oct 2025 08:48:08 -0400
Message-ID: <20251028124815.1058740-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028124815.1058740-1-sashal@kernel.org>
References: <20251028124815.1058740-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit bc25c6e0a4880b5ad70c31fe1466f30c9e4c8f52 ]

Add Intel Arrow Lake-H PCI ID to the driver list of supported devices.
This is the same controller found in previous generations.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/20251020145415.3377022-3-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of both the commit and the kernel
repository context, here is my assessment:

## **Backport Status: YES**

---

## **Analysis Details**

### **1. Code Changes Analysis**
The commit adds a single line to `drivers/spi/spi-intel-pci.c`:
```c
{ PCI_VDEVICE(INTEL, 0x7723), (unsigned long)&cnl_info },
```

This adds PCI device ID `0x7723` (Intel Arrow Lake-H SPI controller) to
the supported devices table, using the existing `cnl_info` board
configuration that's already proven and tested on numerous other Intel
platforms.

**Change statistics:** 1 file changed, 1 insertion (+)

### **2. Stable Kernel Rules Compliance**

I examined `/home/sasha/linux/Documentation/process/stable-kernel-
rules.rst` and found **explicit authorization** for this type of commit:

**Line 15 states:** *"It must either fix a real bug that bothers people
or just add a device ID."*

This commit satisfies the stable tree requirements:
- ✅ **Adds a device ID** (explicitly allowed per line 15)
- ✅ **Already in mainline** (commit bc25c6e0a4880)
- ✅ **Size: 1 line** (well under the 100-line limit)
- ✅ **Obviously correct** (simple table entry addition)
- ✅ **Enables hardware support** for Arrow Lake-H users

### **3. Historical Precedent - Similar Commits Backported**

I verified that similar PCI ID additions to this driver have been
**consistently backported** to stable trees:

**Evidence from repository analysis:**
```bash
# Lunar Lake-M commit (8f44e3808200c)
Backported to: stable/linux-6.8.y, 6.10.y, 6.11.y, 6.12.y, 6.13.y,
6.14.y, 6.15.y, 6.16.y, 6.17.y

# Arrow Lake non-H commit (8afe3c7fcaf72)
Backported to: stable/linux-6.8.y, 6.10.y, 6.11.y, 6.12.y, 6.13.y,
6.14.y, 6.15.y, 6.16.y, 6.17.y
```

**Pattern:** Device ID additions for Intel SPI controllers are routinely
backported, even without explicit "Cc: stable" tags, because they're
explicitly permitted by stable rules.

### **4. Cross-Subsystem Context**

Arrow Lake-H is a **real, shipping platform**. I found multiple Arrow
Lake-H device ID additions across the kernel, many already backported:

- `i2c: i801: Add support for Intel Arrow Lake-H` (f0eda4ddb2146) →
  **backported to 6.11.y - 6.14.y**
- `usb: dwc3: pci: add support for the Intel Arrow Lake-H`
  (2fff7bb8f1c26) → **backported to 6.7.y**
- `mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs` (1523d8ea99d28,
  6112597f5ba84)
- `pinctrl: meteorlake: Add Arrow Lake-H/U ACPI ID` (080c3068715df,
  a366e46da10d7)

This demonstrates that Arrow Lake-H support is being actively backported
across subsystems.

### **5. Risk Assessment**

**Risk: MINIMAL**

- **No code behavior changes** - only adds a PCI ID entry
- **Uses existing, proven code path** - references `cnl_info` used by
  20+ other device IDs
- **Isolated impact** - only affects systems with Arrow Lake-H hardware
  (PCI ID 0x7723)
- **No dependencies** - standalone change requiring no prerequisites
- **No architectural changes** - no API modifications, no data structure
  changes

### **6. User Impact**

**Without this patch:** Users with Arrow Lake-H systems cannot access
their SPI flash controller, preventing firmware access and critical
hardware functionality.

**With this patch:** Arrow Lake-H hardware works identically to other
supported Intel platforms (Lunar Lake, Meteor Lake, Granite Rapids,
etc.)

### **7. Author & Maintainer Context**

- **Author:** Mika Westerberg (original driver author and maintainer)
- **Commit history:** 16 out of 23 recent commits to this file are by
  Mika, primarily adding new Intel platform PCI IDs
- **Pattern:** Consistent, incremental hardware enablement for new Intel
  platforms

---

## **Conclusion**

This commit is a **textbook example** of what should be backported to
stable trees:
1. Explicitly permitted by stable kernel rules (device ID addition)
2. Minimal size (1 line) and zero risk
3. Consistent with historical backporting patterns
4. Enables real hardware that users have
5. No behavior changes to existing code
6. Part of broader Arrow Lake-H enablement across kernel subsystems

**Recommendation:** Backport to all active stable trees (6.12.y, 6.11.y,
6.10.y, etc.) following the same pattern as previous Intel SPI
controller device additions.

 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4bb158a23349e..7765fb27c37c3 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -80,6 +80,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7723), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
-- 
2.51.0


