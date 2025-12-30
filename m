Return-Path: <linux-spi+bounces-12169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA2CE9C55
	for <lists+linux-spi@lfdr.de>; Tue, 30 Dec 2025 14:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E80C30161E7
	for <lists+linux-spi@lfdr.de>; Tue, 30 Dec 2025 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA322B8B6;
	Tue, 30 Dec 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XikhIr/T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383C2222B7;
	Tue, 30 Dec 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100987; cv=none; b=EmHovyxKygts2r2CzPVNJMLp54sDOr5Sh5GVdGa3A3I/zsUDIYA2A5WrXKXwzX2BpuQZlXZ3+KB52kREEnWSk8rJ9z7UxeEt/nOxYSW1zpaw9aW4gHU1+zjizj9xeG+irK2BnsutCA4wjAsnyaZLFRZFIQ/cLzmhGz7NbKsirjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100987; c=relaxed/simple;
	bh=fQ6bL8jYrSxzdgJbfHwUYCbaXfudgMkK9XnQe/sw4ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgiHWnxkxdDw7NyOe0HaYKF6ufvqYJRyNAPHRpgHlyrfGISITVX5UU3O8V8ViKtGLtlbSWt8pxdbQC1HGXj9RrSwFkYvlpFLzO6A0zTAEj7l1wXNwu6mZZWHDIYQv9yvveqROKe2E952R5e+793pkypZWoUSygdmOo5YvujTGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XikhIr/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87D5C4CEFB;
	Tue, 30 Dec 2025 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767100985;
	bh=fQ6bL8jYrSxzdgJbfHwUYCbaXfudgMkK9XnQe/sw4ug=;
	h=From:To:Cc:Subject:Date:From;
	b=XikhIr/TZWfHaFNTggm8HY358cE/w+oIwKd/t/7PKyuw4//nvlrHVD98NklTd1FTc
	 Mdi4MXMEVuWiqfHdW/1A8mAxttLTvwQrmNfCYMSZWX3p2aGXU9SsaoaF/GZnICCGJo
	 yh5D/m05z/BNqiQXxIn7bpZ/Krs+myrRSY4Lp72422c81K7wX+9Z8oJHwYpP/OtMUo
	 pyIU8AiZBbZajdhOGMyBuNyRw5Q9H6jjOxRlfKCWCQhIYoXECK51y7yaAYCZSGfSGM
	 +IgFKksqFKLR43FPRw+542ng3eLjcodwpF05+hy1Il1xWhMyigRassxXB4MnXSpzp+
	 PwFF23rVvn0cA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mateusz Litwin <mateusz.litwin@nokia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] spi: cadence-quadspi: Prevent lost complete() call during indirect read
Date: Tue, 30 Dec 2025 08:22:54 -0500
Message-ID: <20251230132303.2194838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mateusz Litwin <mateusz.litwin@nokia.com>

[ Upstream commit d67396c9d697041b385d70ff2fd59cb07ae167e8 ]

A race condition exists between the read loop and IRQ `complete()` call.
An interrupt could call the complete() between the inner loop and
reinit_completion(), potentially losing the completion event and causing
an unnecessary timeout. Moving reinit_completion() before the loop
prevents this. A premature signal will only result in a spurious wakeup
and another wait cycle, which is preferable to waiting for a timeout.

Signed-off-by: Mateusz Litwin <mateusz.litwin@nokia.com>
Link: https://patch.msgid.link/20251218-cqspi_indirect_read_improve-v2-1-396079972f2a@nokia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### Summary

**Pros for backporting:**
1. ✅ Fixes a genuine race condition causing timeouts
2. ✅ Small, surgical fix (< 10 lines changed)
3. ✅ Logic is obviously correct and well-explained
4. ✅ Low risk - worst case is benign spurious wakeup
5. ✅ Reviewed by subsystem maintainer (Mark Brown)
6. ✅ No dependencies on other commits
7. ✅ Driver has been in the kernel since 2020, exists in all active
   stable trees
8. ✅ From a reputable source (Nokia) dealing with real hardware

**Cons:**
- None significant. The absence of explicit Fixes:/Cc: stable tags is
  expected for commits under manual review.

### Risk vs Benefit

- **Risk**: Very low - the change is simple, localized, and
  mathematically correct
- **Benefit**: Prevents user-visible timeouts during SPI read operations
  on affected hardware

This commit is an excellent candidate for stable backporting. It fixes a
real race condition bug with a small, obvious, and low-risk change. The
fix has been reviewed by the SPI maintainer and addresses real hardware
issues without introducing new features or significant complexity.

**YES**

 drivers/spi/spi-cadence-quadspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..695dbf7142d1 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -769,6 +769,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	readl(reg_base + CQSPI_REG_INDIRECTRD); /* Flush posted write. */
 
 	while (remaining > 0) {
+		ret = 0;
 		if (use_irq &&
 		    !wait_for_completion_timeout(&cqspi->transfer_complete,
 						 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
@@ -781,6 +782,14 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 		if (cqspi->slow_sram)
 			writel(0x0, reg_base + CQSPI_REG_IRQMASK);
 
+		/*
+		 * Prevent lost interrupt and race condition by reinitializing early.
+		 * A spurious wakeup and another wait cycle can occur here,
+		 * which is preferable to waiting until timeout if interrupt is lost.
+		 */
+		if (use_irq)
+			reinit_completion(&cqspi->transfer_complete);
+
 		bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 
 		if (ret && bytes_to_read == 0) {
@@ -813,7 +822,6 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 		}
 
 		if (use_irq && remaining > 0) {
-			reinit_completion(&cqspi->transfer_complete);
 			if (cqspi->slow_sram)
 				writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
 		}
-- 
2.51.0


