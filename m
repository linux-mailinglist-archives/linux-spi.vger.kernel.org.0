Return-Path: <linux-spi+bounces-12085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2BCD9137
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 12:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1A6300F326
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128F352929;
	Tue, 23 Dec 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKLFqC2U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487A3502B1;
	Tue, 23 Dec 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484324; cv=none; b=SohFHcy9h83tXCfFK6L70m4Vf8N9zha+c0gSN+iyInkVK0lJz7BkzKxCj+/P19txr1+DJANej+QJ4WtAhQdtMngXG5+2WyOlP2rezi1rRDe/+wLM3OR7TuDS5/nQRJB3FkLLzZWBnB3HAhE5qVKNa4JGmvhTtkqkkKWou/sLVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484324; c=relaxed/simple;
	bh=/zYcG2xYSdYnuLSHKUx/IzmXhDPgwtNTHCfAvrduQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcsQdNHKjoeMG2IS3TUxGLEzb1bdDASesp7MiQvrIIAEcOG1scjO2oEMOyZFkemtakvD0ZymNQ1cjNnoKUCaVkGVCdytRS5RGsNgezIFPhuCFtUayMsVMUPmGUU00JVh3vTOrDN8ZmjPC31C52RGPuGK0z1zuYIO/R4/Qu5tAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKLFqC2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDB3C19423;
	Tue, 23 Dec 2025 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766484322;
	bh=/zYcG2xYSdYnuLSHKUx/IzmXhDPgwtNTHCfAvrduQQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKLFqC2Uk/cCGXFRXMAn2Gzcw2zEpSryMzNseG+JvPxBF8EekqKOGdnG/KNk/s8/v
	 HV4Y4xH1RZuMNpSqWtzbp5D1p4NZ3HMtz8kl1dGnfqkMmzAsxo8bNnfTs3Q4Kb3YuQ
	 0fo0oiZxQGYse9MTDFSVEw6mrVUJg9J3MHYV2vOZ1Q+Ec7ixU5NGk4aJXwHAUsfOIS
	 6z3ba3eJ5QoEmSPBLC9MnCHHm1EJ1Rj1v2tAGt/WCVSykxcD2rZRCXTdxbVOXzFVSt
	 386BYtxKRVwG68h186xPxLf218r6+T+4G6tdkVYnTSXb9FG9Gdm4/N74J80viarGH5
	 jxpDYjn7Vwgdg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Fei Shao <fshao@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.18-6.12] spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ
Date: Tue, 23 Dec 2025 05:05:07 -0500
Message-ID: <20251223100518.2383364-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223100518.2383364-1-sashal@kernel.org>
References: <20251223100518.2383364-1-sashal@kernel.org>
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

From: Fei Shao <fshao@chromium.org>

[ Upstream commit 8c04b77f87e6e321ae6acd28ce1de5553916153f ]

This driver is migrated to use threaded IRQ since commit 5972eb05ca32
("spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer"), and
we almost always want to disable the interrupt line to avoid excess
interrupts while the threaded handler is processing SPI transfer.
Use IRQF_ONESHOT for that purpose.

In practice, we see MediaTek devices show SPI transfer timeout errors
when communicating with ChromeOS EC in certain scenarios, and with
IRQF_ONESHOT, the issue goes away.

Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://patch.msgid.link/20251217101131.1975131-1-fshao@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 1 line
- **Files touched:** 1 file
- **Complexity:** Trivially low - just a flag change
- **Risk:** Very low

The fix is:
- **Obviously correct**: IRQF_ONESHOT is the documented standard for
  threaded interrupts
- **Small and contained**: One flag change
- **Fixes a real bug**: Transfer timeout errors on real hardware

Looking at the interrupt handler code:
- `mtk_spi_interrupt` returns `IRQ_WAKE_THREAD` for non-SPIMEM transfers
- Without IRQF_ONESHOT, the IRQ line stays enabled, allowing repeated
  interrupts while the thread processes
- This causes race conditions on `mdata->state` and transfer handling,
  leading to timeouts

### 5. USER IMPACT

- **Who is affected:** Users of MediaTek SPI devices, particularly
  ChromeOS users with embedded controllers
- **Severity:** Medium-High - SPI transfer timeouts can cause
  significant functionality issues
- **Real-world impact:** Confirmed on MediaTek devices communicating
  with ChromeOS EC

### 6. DEPENDENCY CHECK

The prerequisite commit `5972eb05ca32` ("spi: spi-mt65xx: Use threaded
interrupt for non-SPIMEM transfer") was first included in **v6.12-rc1**.
This means:
- This fix is only applicable to 6.12.y stable trees and newer
- Older stable trees (6.6.y, 6.1.y, 5.15.y) don't have the threaded IRQ
  code, so this fix doesn't apply

### 7. SUMMARY

| Criterion | Assessment |
|-----------|------------|
| Fixes real bug | ✅ Yes - SPI transfer timeouts |
| Obviously correct | ✅ Yes - standard pattern |
| Small and contained | ✅ Yes - 1 line change |
| Tested | ✅ Yes - real hardware testing |
| Risk | ✅ Very low |
| Dependencies | ✅ Clear - requires 5972eb05ca32 (v6.12+) |

### Conclusion

This commit is an excellent candidate for stable backporting:

1. **Fixes a real, user-visible bug**: SPI transfer timeouts on MediaTek
   hardware
2. **Minimal change**: Single flag addition, no logic changes
3. **Obviously correct**: IRQF_ONESHOT is the proper pattern for
   threaded IRQs with hardirq handlers that return IRQ_WAKE_THREAD
4. **Low risk**: Well-understood kernel mechanism with no side effects
5. **Tested**: Confirmed to resolve the issue on real ChromeOS EC
   hardware

The only consideration is that this fix only applies to stable trees
with kernel 6.12 or later (which contain the prerequisite threaded IRQ
commit). For those trees, this is a straightforward, low-risk fix that
resolves real hardware issues.

**YES**

 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4b40985af1ea..90e5813cfdc3 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1320,7 +1320,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, mtk_spi_interrupt,
 					mtk_spi_interrupt_thread,
-					IRQF_TRIGGER_NONE, dev_name(dev), host);
+					IRQF_ONESHOT, dev_name(dev), host);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register irq\n");
 
-- 
2.51.0


