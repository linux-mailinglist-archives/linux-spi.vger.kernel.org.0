Return-Path: <linux-spi+bounces-10495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864FBC9FAB
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D214259BA
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405452FB99C;
	Thu,  9 Oct 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzvkb0cb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171762FB99B;
	Thu,  9 Oct 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025604; cv=none; b=QqmXdgPOFqXYNKoyI2I8yA27iC4SGBCB5yKTDXEXdPPhXrnzeKcEGp2245pRv8vH2PlSMBPDc+mUw+fH8AXU4Fda3QIKO8p7d4KU3Ov0qz//r9CTq8IKq1tDkzjdi4o4YL6yVHNiJtHBuSnV6g2ofQ5RgGEdIuZyawOuT8dHl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025604; c=relaxed/simple;
	bh=iGPfhXstUEtIPxlrGq/8WGl8mFp+xaycxoQGPc3q3CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c82CcgO6E+TjW5lCJD1RUKDn1cSa+hsH+W4xRNjcTlTjzgaSmF/l070Mhp1ZH4moJKROGnzumrQbV+PuUD+f0JVICvGU+/t0L1ys8yddFRjZfNvMnab+SFyXJsy96GTTtIQIjNyUbnksVfHqQe1nZ0h93Vba0oa0wtNUtNrpm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzvkb0cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2122FC4CEE7;
	Thu,  9 Oct 2025 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025604;
	bh=iGPfhXstUEtIPxlrGq/8WGl8mFp+xaycxoQGPc3q3CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzvkb0cbZJ5m5WmeCn5YlzRxuDz4NAE81VPSKugzHBth1kBeqlIOtqf8gMSP8DnBA
	 Cerd1AvEbNbPEIRk8bE6ewFBUCy48vf00u9BAFPg1VopfMAxvPqF7aac0rB0TymuUY
	 jV5P6rbmsj/gOwA3GYZAneywRpereu+p+c3QncFE5lUKyl2/wkTposum09fEQZxMqO
	 MEZTCZHnnj5p60Rebw/9Io4SrImXUixh24N5fh/qZ9bXgA3ueobefjUY5wHQwLh1/T
	 BVcQ1xe+6GU7RcJieIQBdZ2w1qir/iQXMibvgIpani5H/7M83qsYdh4AHUlOMuaubY
	 N6ZLALdknmU3Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.16] spi: spi-qpic-snand: handle 'use_ecc' parameter of qcom_spi_config_cw_read()
Date: Thu,  9 Oct 2025 11:55:36 -0400
Message-ID: <20251009155752.773732-70-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit 9c45f95222beecd6a284fd1284d54dd7a772cf59 ]

During raw read, neither the status of the ECC correction nor the erased
state of the codeword gets checked by the qcom_spi_read_cw_raw() function,
so in case of raw access reading the corresponding registers via DMA is
superfluous.

Extend the qcom_spi_config_cw_read() function to evaluate the existing
(but actually unused) 'use_ecc' parameter, and configure reading only
the flash status register when ECC is not used.

With the change, the code gets in line with the corresponding part of
the config_nand_cw_read() function in the qcom_nandc driver.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit, here is my
assessment:

## Backport Recommendation: **YES**

### Analysis Summary:

**Context & History:**
This commit fixes a code correctness issue in the spi-qpic-snand driver
(added in v6.17, Feb 2025). The `qcom_spi_config_cw_read()` function had
a `use_ecc` parameter since the driver's inception, but it was
completely ignored - the function always read both ECC-related registers
regardless of whether ECC was being used.

**Technical Details:**
The change modifies lines 491-500 in `drivers/spi/spi-qpic-snand.c`:

**Before:** Always reads 3 registers via DMA:
- `NAND_FLASH_STATUS` + `NAND_BUFFER_STATUS` (2 registers)
- `NAND_ERASED_CW_DETECT_STATUS` (1 register)

**After:** Conditionally reads based on `use_ecc`:
- When `use_ecc=true`: Reads all 3 registers (normal ECC-enabled reads)
- When `use_ecc=false`: Reads only `NAND_FLASH_STATUS` (raw reads)

**Why This Matters:**
1. **Code Correctness:** During raw reads (`use_ecc=false`), the
   `qcom_spi_check_raw_flash_errors()` function (line 557-571) only
   checks the flash status register, never the ECC registers. Reading
   those ECC registers via DMA is "superfluous" as the commit message
   states.

2. **Established Pattern:** This aligns with the qcom_nandc driver's
   `config_nand_cw_read()` function, which has had this exact same
   conditional logic since 2018 (commit 5bc36b2bf6e2c8). That commit's
   message explained: "For raw reads, there won't be any ECC failure but
   the operational failures are possible, so schedule the
   NAND_FLASH_STATUS read."

3. **Already Backported:** The commit shows `[ Upstream commit
   9c45f95222bee ]` and `Signed-off-by: Sasha Levin
   <sashal@kernel.org>`, indicating it was already selected by AUTOSEL.

**Backport Justification:**

✅ **Pros:**
- Small, contained change (11 lines, 1 file)
- Fixes code correctness (parameter was being ignored)
- Removes unnecessary DMA operations (optimization)
- Aligns with well-established pattern from related driver
- Very low regression risk
- Already reviewed and approved by Konrad Dybcio and Mark Brown
- No follow-up fixes or reverts since Aug 8, 2025

❌ **Cons:**
- No explicit `Fixes:` tag
- No `Cc: stable@vger.kernel.org` tag
- Not fixing a critical user-visible bug
- More optimization/cleanup than bug fix
- Limited impact (Qualcomm-specific hardware only)

**Conclusion:**
While this doesn't fix a critical bug, it fixes a code correctness issue
where a function parameter was being completely ignored. The unnecessary
DMA operations during raw reads waste resources and could potentially
cause subtle timing or performance issues. The change is safe, well-
reviewed, and follows the established pattern from the mature qcom_nandc
driver. The fact that AUTOSEL has already selected it confirms its
suitability for stable backporting.

 drivers/spi/spi-qpic-snand.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 780abb967822a..5a247eebde4d9 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -494,9 +494,14 @@ qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int c
 	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
-	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-			  NAND_BAM_NEXT_SGL);
+	if (use_ecc) {
+		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
+		qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+				  NAND_BAM_NEXT_SGL);
+	} else {
+		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1,
+				  NAND_BAM_NEXT_SGL);
+	}
 }
 
 static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
-- 
2.51.0


