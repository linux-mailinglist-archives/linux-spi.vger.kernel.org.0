Return-Path: <linux-spi+bounces-10493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC2BC9F35
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D3354556
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5F2F999E;
	Thu,  9 Oct 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFx6YcvD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606422ECE82;
	Thu,  9 Oct 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025526; cv=none; b=i/kxULov4/0S5/kP0fLYHPr+uWSPThVop99DQCvJKcM4lg5GY3DTQzTX81AyO8iPyLX8U3KKjBK/KgVN+QdafRcTNW7OfR7AjXWPJD3tJ5uwIKrUoZRHQUnYnf/0X37+l+lKrSxCbiTDGfAPVPjnaqsf0CxROmlzYz5ZtCIZmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025526; c=relaxed/simple;
	bh=QCsXN+2MwVIE/kMj/+64HJt1HbB8Ev1JwllW9t42zFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkAbpSHa0Noa7uzTDFEiWr3jS4Kg3NV8b8KDJwYttdmZROp2e2juQCzd8NcSy50tPfMggibq/j6ew0dYdCqA2hRj5tVmqRB+84k9qCe9HdhNrg4O+TdpcSNd1GxIc6v9KWp2IzEHloNyKNEaIFkwwp2djiMcBJ+Nzj+/HDtjYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFx6YcvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A142C4CEE7;
	Thu,  9 Oct 2025 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025526;
	bh=QCsXN+2MwVIE/kMj/+64HJt1HbB8Ev1JwllW9t42zFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFx6YcvD05RvMT6iqZMZuT+mU6tJG2R31+04hEnSTIiZkTBU2aJqAWJYtuK9stqO+
	 8QqX0bsBvqjWeBE5BOxwtejWWkSZ51YlaK7dmyPF3IcsI+OCj2FyK7wyNdsqFNTYXY
	 2i7AzErcrb2lStLKyUGq4YyrLJfh4/UM7mjQ/k4beK54i2pPLmZ5eLaaTJODIzt4Gi
	 2h4ncyHW4pyG+tl7sn6jNNZSV2b3vxOHGn0OWVzt0XvNha64HQ2q6iV5tZlFZTg1UH
	 4KtDMnra4D+EQBoAifdx8VnbllXiX7pVhPiqyug2k67KbexyPWpRV8EtrjjaEwsN8G
	 3WcsO8fLKjb4g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] spi: rpc-if: Add resume support for RZ/G3E
Date: Thu,  9 Oct 2025 11:54:56 -0400
Message-ID: <20251009155752.773732-30-sashal@kernel.org>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ad4728740bd68d74365a43acc25a65339a9b2173 ]

On RZ/G3E using PSCI, s2ram powers down the SoC. After resume,
reinitialize the hardware for SPI operations.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250921112649.104516-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changed: The resume callback now reinitializes the underlying
  RPC-IF hardware by calling `rpcif_hw_init(dev, false)` before resuming
  the SPI controller queue. See drivers/spi/spi-rpc-if.c:210. The rest
  of the resume path remains unchanged and returns
  `spi_controller_resume(ctlr)` (drivers/spi/spi-rpc-if.c:212). The
  patch is a small, contained 2-line addition in a single driver file.

- Why it’s needed: On RZ/G3E systems using PSCI, s2ram powers the SoC
  off, so the RPC-IF/xSPI controller loses register state. The SPI
  core’s `spi_controller_resume()` does not reconfigure hardware
  (drivers/spi/spi.c:3519), it only restarts the message queue. Without
  reinitialization, resumed SPI operations can fail or misbehave. The
  added `rpcif_hw_init()` reprograms controller registers and ensures
  the hardware is ready post-resume.

- Correctness of the reinit: `rpcif_hw_init()` is the standard hardware
  bring-up routine used in probe; it resumes runtime PM, reconfigures
  the controller for the appropriate mode, and then drops the PM
  reference. See drivers/memory/renesas-rpc-if.c:315. It’s already
  invoked during probe for the SPI path (drivers/spi/spi-rpc-if.c:173),
  so reusing it on resume is appropriate and consistent.

- Scope and risk: The change is isolated to RPC-IF SPI driver resume. It
  does not alter normal operation, only system-suspend resume behavior.
  The call is idempotent and guarded by runtime PM
  (pm_runtime_resume_and_get/put inside rpcif_hw_init), minimizing risk.
  It doesn’t introduce features or architectural changes.

- Impacted platforms: Although the commit message highlights RZ/G3E
  (xSPI), the reinit is generally safe for other RPC-IF variants too and
  can only improve robustness after system suspend.

- Stable-tree suitability:
  - Fixes a real user-visible bug (SPI transactions can fail after S2RAM
    on RZ/G3E).
  - Minimal change (two added lines), fully contained in the driver.
  - Low regression risk and no API or architectural churn.
  - Touches a specific subsystem driver (SPI/Renesas RPC-IF), not core
    kernel paths.

- Backport notes (API/context):
  - `rpcif_hw_init()` currently takes a `struct device *`
    (drivers/memory/renesas-rpc-if.c:315; include/memory/renesas-rpc-
    if.h:75). On older stable trees that predate commit a198fcd1d53cb
    (which changed RPC-IF APIs to pass a device instead of an internal
    handle), the signature may differ. In such trees, adapt the call
    accordingly (e.g., pass `rpc->dev` or the older handle type).
  - Ensure the device passed to `rpcif_hw_init()` is the one holding
    `rpcif_priv` (in probe we pass `rpc->dev`, which is the parent RPC-
    IF device). If the stable branch still uses the older arrangement,
    the backport should call `rpcif_hw_init(rpc->dev, false)` after
    obtaining `struct rpcif *rpc = spi_controller_get_devdata(ctlr)` in
    resume.
  - Macro context (SIMPLE_DEV_PM_OPS vs DEFINE_SIMPLE_DEV_PM_OPS) may
    differ between branches; this is mechanical and does not affect the
    substance of the fix.

In summary, this is a classic, low-risk, correctness fix for resume on
RZ/G3E that should be backported to stable kernels that include the RPC-
IF xSPI support, with trivial API/context adjustments as needed.

 drivers/spi/spi-rpc-if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 627cffea5d5c7..300a7c10b3d40 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -207,6 +207,8 @@ static int __maybe_unused rpcif_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
+	rpcif_hw_init(dev, false);
+
 	return spi_controller_resume(ctlr);
 }
 
-- 
2.51.0


