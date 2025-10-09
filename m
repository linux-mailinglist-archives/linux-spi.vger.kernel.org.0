Return-Path: <linux-spi+bounces-10486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68011BC79E0
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 09:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 586254E9567
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81472D0610;
	Thu,  9 Oct 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZPSZk6z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0272D0601;
	Thu,  9 Oct 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993841; cv=none; b=izfmWi5MONpWFNXgngnORe1qr0GcmLA4pOFMmUr4U+FJAGlLifelcbWA8wH7sOKLrxWOwUMwztj+Tod2YdHmP1L1Xa0DDagt2e5Cvc7FEbIroGtTvZvTSNQBwc09Q+KSgloJIL/j7tpITH2lCTYapxBkyEk8jprTdGMGAI6U8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993841; c=relaxed/simple;
	bh=BTUcMOYzHrskys6WkMBozEYOqAx0t7L2rCB81+2XQ9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kcu06KzowRfs0S7xb01jWwjQbAdaHTVAP/Osc4PCzI3lp+Bp1zGe4Ik056Dl8pHGhXLlMYxUDZac6c0IFwpaJ6NC1QeuBvnJW/Qx3vsARin6EvR69xPkxPXu5Wv+afCyX8WTHU185HnzV3db5FH0UYy9rADLvIyZkWdbDyK+MI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZPSZk6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF23FC4CEFE;
	Thu,  9 Oct 2025 07:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759993841;
	bh=BTUcMOYzHrskys6WkMBozEYOqAx0t7L2rCB81+2XQ9c=;
	h=From:Date:Subject:To:Cc:From;
	b=DZPSZk6zz3eGN9DMiQQLAACix7zG/HWBOwRxpafnMQTIQviEzEHOrLenZPbpOSYZG
	 k8NM7sibydpvYfYTK1WigIHjPEndrjv8PjpzE9VtdZ9wwzat+qnj/BA+QCaRNGsyw5
	 JSt6TjCo5mpMVopQyYMUPTxbgYFNXmnKmdN3cFgbsl/7pfBXK+jZFWvOY2OYGnTtKK
	 1tCjXP6yLLSufF8mySU9C25auQwKJ9nMogXRE+lWYmyMmGiX7ArmZ/I9W0KykJJrKx
	 pfJ40pHdimn9kaK/pONJPCYOxKx/SEzZOa8NRx9Vv6hWnORiD4XYJaFeuctqi0vUOh
	 Ncg96e3xsyXDQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 09 Oct 2025 09:10:38 +0200
Subject: [PATCH v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
X-B4-Tracking: v=1; b=H4sIAO1f52gC/42NTQ6CMBBGr0K6dkxbIKAr72FY9GeAiVJwCkRDu
 LuVE7h8X768t4mITBjFNdsE40qRxpBAnzLhehM6BPKJhZa6VFLW4IzH4BBei/FxImjpDdMAvIS
 ZBgTb1r69KFmUVSWSZGJMjyNwbxL3FOeRP0dvVb/1b/WqQEGeW2cLW+dG4+2BHPB5HrkTzb7vX
 wM+/rPNAAAA
X-Change-ID: 20251008-cadence-quadspi-fix-pm-runtime-bf8df9104577
To: Mark Brown <broonie@kernel.org>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=BTUcMOYzHrskys6WkMBozEYOqAx0t7L2rCB81+2XQ9c=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBo51/uSWgLkzY5WC1l85rzsWm4O/KpSRl0yzRqa
 royAHEsY++JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaOdf7gAKCRAZDR20Zk4Z
 NbONB/wLJ3cQPlTeUzvGhHKe3x0QtldYuO3YRGlD/M8fuX7lh57/P+m/L5l1WRYvwY12e4n4y8f
 H9TAzwCjyTRli8XStkRTgHueHL7CRX/nWO5Qva2QiVBlk9K24BmlzDSZWB91ZQ4kQYby8RaZt8Y
 +ShP3QyVpsiLU1cO8iqZNfIgU8EIIe5+YULq1515W4QRyhVxzg7upcY5lhLR4EOe36F8OjON/5G
 a7oIPv8y1PVv905x3e2iBXCEYdIeWYl9OB4LzvAHdWqoiIITyIcUAyniqlUb63uPW1kpUPSxG5b
 l4HepOA1Ft7/l7mpRXk33t0OzH6Ysmyz4k0b52k0KfU6SpXM
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
we handle the error by jumping to probe_setup_failed.
In that label, we call pm_runtime_disable(), even if we never called
pm_runtime_enable() before.

Because of this, the driver cannot probe:

[    2.690018] cadence-qspi 47040000.spi: No Rx DMA available
[    2.699735] spi-nor spi0.0: resume failed with -13
[    2.699741] spi-nor: probe of spi0.0 failed with error -13

Only call pm_runtime_disable() if it was enabled by adding a new
label to handle cqspi_request_mmap_dma() failures.

Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This has been tested on a AM69 SK board.
---
Changes in v2:
- Updated message to use correct Fixes tag (Dan)
- Link to v1: https://lore.kernel.org/r/20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8fb13df8ff8714d2ad5a019f0ae0ec3ee38833bb..81017402bc5661d08ff4e75017db954fda19ba2a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1995,7 +1995,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_setup_failed;
+			goto probe_dma_failed;
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
@@ -2019,9 +2019,10 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	return 0;
 probe_setup_failed:
-	cqspi_controller_enable(cqspi, 0);
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
+probe_dma_failed:
+	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);

---
base-commit: 0d97f2067c166eb495771fede9f7b73999c67f66
change-id: 20251008-cadence-quadspi-fix-pm-runtime-bf8df9104577

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>


