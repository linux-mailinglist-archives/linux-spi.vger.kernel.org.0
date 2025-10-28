Return-Path: <linux-spi+bounces-10873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80010C14AF5
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEDC1B22480
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BE32E125;
	Tue, 28 Oct 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ8tKUBl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD51EE033;
	Tue, 28 Oct 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655698; cv=none; b=DBaslh1ZlBnR/tqK3OsEeHlBy0fzQXyYh07koEU8T8FejRisWu+TJp8aCXRpQdKzgZk1a9yfp1QB7DhRAHaQxiwMnMp/y+uDa6jR/GChUX7ORu0m0r1d/lzDoGSoKgmSLGX83y82xXXScQWx/UWbBidljzfdrfxVfesM2Rsege8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655698; c=relaxed/simple;
	bh=XDxjdZZlBIzdN570pWYWjXgJISALZu5t3ofQ1UfnZnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmYN7KS1AHp1Kkk+NKvUDC5D+tgh9e8gbeds2fkQPbEHKQ/wHActSeHf/nMsb6GWb36HDzpY5+1kInUGWfJDV42DrTKJxu4HIsxQtoa0zakVMontD3oX2cfXy1ixhmMjeUjAboxlbwjVEbnJ53pILM9E1Fc0HzR9p56Ib3COSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ8tKUBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41C2C4CEE7;
	Tue, 28 Oct 2025 12:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761655697;
	bh=XDxjdZZlBIzdN570pWYWjXgJISALZu5t3ofQ1UfnZnc=;
	h=From:To:Cc:Subject:Date:From;
	b=sJ8tKUBlUjTCHwmSDfr14wDxQ1cCAoTiphEZBAO9DY2k814B8bM/Wd3Z2QOYCBsTg
	 zsUiVkbiTP+ApidSoVSJLJijXPa0CTDZ8w1+5YjkwOQT55ICqsz6dmZfhpmX8lSCoe
	 j+w/qfOcqNMWMhebzkie90kdsN/zAb45rBZWoyiuq4jMptGY/Nkjg8tC9krbghc4wd
	 c8GgOmnG9LmgnSN4LnChLGZny44TFjHHHsWMdKS3+rW4F0QALXlkC7mKEU/H2LTDgI
	 mdva1QkN565i0qDkQn83Q4tYQ7qHEQV070CLP+ed69Mv+GPctm9leAOaXijRzqH+i7
	 /bD0YQgdQb9YQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash
Date: Tue, 28 Oct 2025 08:48:01 -0400
Message-ID: <20251028124815.1058740-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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

[ Upstream commit f7e37affbc9085f2b77ccb6596521a44eabf7505 ]

Add Intel Wildcat Lake SPI serial flash PCI ID to the list of supported
devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/20251020145415.3377022-4-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT ANALYSIS COMPLETE

**Backport Status: YES**

---

## DETAILED ANALYSIS

### 1. COMMIT CHARACTERIZATION

**Type**: Hardware enablement (PCI device ID addition)

**Code Changes**:
- Single line addition to `drivers/spi/spi-intel-pci.c`
- Adds PCI device ID `0x4d23` (Intel Wildcat Lake SPI serial flash)
- Maps to existing `cnl_info` configuration structure
- No behavioral changes to existing code paths

### 2. SEMANTIC CODE ANALYSIS FINDINGS

#### Tools Used:
- **Read**: Examined the complete file structure (drivers/spi/spi-intel-
  pci.c:68-99)
- **Grep**: Located PCI device table usage and MODULE_DEVICE_TABLE macro
- **Git analysis**: Reviewed commit history and backport precedents

#### Impact Scope Analysis:
- **Direct impact**: Only affects systems with PCI ID 0x4d23 (Wildcat
  Lake hardware)
- **Caller analysis**: The PCI device table is used by the kernel's PCI
  subsystem for automatic device-driver matching
- **Dependency analysis**: Uses `cnl_info` structure (drivers/spi/spi-
  intel-pci.c:38-41), which has existed since 2022
- **Risk assessment**: Zero risk to existing hardware - new entry only
  triggers on matching PCI ID

### 3. BACKPORT PRECEDENT (Strong Evidence)

I found multiple similar commits that **WERE backported** to stable
trees:

**Example 1 - Lunar Lake-M** (commit ec33549be99fe):
```
commit ec33549be99fe25c6927c8b3d6ed13918b27656e
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Commit: Sasha Levin <sashal@kernel.org> [STABLE MAINTAINER]

spi: intel-pci: Add support for Lunar Lake-M SPI serial flash

[ Upstream commit 8f44e3808200c1434c26ef459722f88f48b306df ]
```

**Example 2 - Granite Rapids** (commit 60446b5e74865):
```
commit 60446b5e74865acff1af5f2d89d99551c8e6e2c1
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Commit: Greg Kroah-Hartman <gregkh@linuxfoundation.org> [STABLE
MAINTAINER]

spi: intel-pci: Add support for Granite Rapids SPI serial flash

[ Upstream commit 9855d60cfc720ff32355484c119acafd3c4dc806 ]
```

**Key Finding**: Both commits were backported to stable trees by stable
maintainers (Sasha Levin, Greg Kroah-Hartman) **despite having NO
explicit stable tags** in the original commits.

### 4. STABLE TREE COMPLIANCE

**Positive Factors**:
- ✅ Fixes a real user problem (Wildcat Lake users cannot access SPI
  flash on stable kernels)
- ✅ Extremely low risk (single line, static table entry)
- ✅ No architectural changes
- ✅ No dependencies on unreleased features
- ✅ Follows established backporting pattern for PCI ID additions
- ✅ "Obviously correct" - uses tested configuration from 20+ other Intel
  platforms

**Considerations**:
- ⚠️ Technically a "new feature" (new hardware support)
- ✅ However, PCI ID additions are a **special exception** routinely
  accepted by stable maintainers
- ✅ Hardware enablement is considered "fixing" missing support for
  existing hardware

### 5. DEPENDENCY VERIFICATION

- **cnl_info structure**: Present since 2022, exists in all stable
  kernels that would receive this backport
- **PCI_VDEVICE macro**: Standard kernel infrastructure
- **intel_spi_probe()**: Core function, no recent changes that would
  conflict
- **Clean backport**: No conflicts expected with any stable kernel
  version

### 6. RISK ANALYSIS

**Regression Risk**: **MINIMAL**
- Only triggered when PCI ID 0x4d23 is detected
- No effect on systems without Wildcat Lake hardware
- Uses well-tested code path (cnl_info shared with 20+ other platforms)
- No user-space API changes

**Testing Coverage**:
- Same code path used by numerous Intel platforms (Ice Lake, Tiger Lake,
  Alder Lake, etc.)
- Configuration structure (cnl_info) battle-tested across multiple
  generations

### 7. COMMIT MESSAGE ANALYSIS

The commit message is:
- ✅ Clear and descriptive
- ✅ Identifies specific hardware (Intel Wildcat Lake)
- ✅ Consistent with previous similar commits
- ❌ No "Fixes:" tag (not applicable - this is new hardware support)
- ❌ No "Cc: stable@vger.kernel.org" tag (but precedent shows this
  doesn't prevent backporting)

---

## RECOMMENDATION

**YES - This commit SHOULD be backported to stable kernel trees**

### Rationale:

1. **Strong precedent**: Multiple similar PCI ID additions for Intel
   platforms (Lunar Lake, Granite Rapids, Arrow Lake) have been
   backported to stable trees by stable maintainers

2. **User benefit**: Enables critical SPI flash functionality for
   Wildcat Lake hardware owners running stable kernels

3. **Minimal risk**: Single-line change to static table with no impact
   on existing hardware

4. **Well-established pattern**: PCI ID additions for hardware
   enablement are routinely accepted for stable backports as they "fix"
   missing hardware support

5. **Clean backport**: No dependencies or conflicts expected

### Target Stable Trees:
- All currently maintained stable kernels (6.17.x, 6.16.x, 6.15.x, etc.)
- The commit is from v6.18-rc3, so it would benefit users on any stable
  kernel before 6.18

 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4b63cb98df9cc..4bb158a23349e 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -75,6 +75,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x38a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x43a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x4d23), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
-- 
2.51.0


