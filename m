Return-Path: <linux-spi+bounces-11769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5ECA51B0
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 20:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42EAF303463B
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF22348866;
	Thu,  4 Dec 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEzYn7gt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410EC2FFDF2;
	Thu,  4 Dec 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875744; cv=none; b=hKmpFvZJ9d+LXoDPz1pKz43H3tYHy4IJZYLIMb2HiMGt+oLvS+QcIxA0bfRpeCbzggA6+gJfnXUQcNuTvM3gSLQYnIe2cILBvGPr5ejOFXOhFJH/pFptlT5BKTHjNBjQupcOaa3dxC3btkddq1Odeq3wH74jE3qgiTRu9HansFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875744; c=relaxed/simple;
	bh=2RwiJMfqNlj5nwIslWeNCxbIgrqAREPL34rxBwbWCWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ii3FQb8c4rzjtqIvW/ikp+smflIM+IJq/Zq1GhbHwXTxJ7411Z5oIlYnK4uEMExjA4LcNpcOubSXbGZT9QLvO22YH++GhM+Er+s6i85oJn1vpfihSnmmGP5llGFTcmRD4I9yi01LwolIJx5wcQcoacpXza079C/iYE3iqSrd9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEzYn7gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE7C4CEFB;
	Thu,  4 Dec 2025 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875743;
	bh=2RwiJMfqNlj5nwIslWeNCxbIgrqAREPL34rxBwbWCWA=;
	h=From:Date:Subject:To:Cc:From;
	b=DEzYn7gtyEhUIVnjh8alAmsPSzlwB9b6+b/W/R1GFk689/MrWJov3q1p4Uw1lJ0l0
	 AukmnMwrXwzPpsFN/o/2JYJwiE4ADtIZN87l3OfGlhS7n2afqtD/3cilhfvyf5Vamk
	 g0NZG6SWcZJ1N5KAgEt7jL8JSF5UEAmqyOOJVtXYx/BiG0cJ9k24JvC3O8MJ5iv0gP
	 XiDG6lGb/+xNmqYfymALZMOtxof98+VLMBgFeC67PhY2W327DVP49h/Y5/JT2drAaT
	 ghKOZUvVfpYy//P+xTFhs5GhRZm1RfZB+TGJkNX9ql1Qe0dtj7vexNiK7ajm4RmNuf
	 bZrWhbSY8Kiiw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 04 Dec 2025 19:13:35 +0000
Subject: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF7dMWkC/5WNQQ6CMBBFr0K6dgxtxBpX3sOwGMsUJkKpUyQaw
 t0t3MDNT97/yX+LSiRMSV2LRQnNnHgMGcyhUK7D0BJwk1mZ0lQ6B6TI4LCh4AheG8g7TDwQxAF
 4eGCP23KurD2VzltCUvkrCnn+7J57nbnjNI3y3bWz3tp/DbMGDUh0cdaj0d7cniSB+uMorarXd
 f0BQfdBxdsAAAA=
X-Change-ID: 20251202-spi-cadence-qspi-runtime-pm-imbalance-657740cf7eae
To: Francesco Dolcini <francesco@dolcini.it>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2RwiJMfqNlj5nwIslWeNCxbIgrqAREPL34rxBwbWCWA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpMd3datQZ5E6cjataEpVJwd19E05V3YGu0jVZN
 +BDYovmMTqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaTHd3QAKCRAk1otyXVSH
 0Am7B/9h54IfiO/+IKN6zeDGfdqDdoDd0RAdQInB9fqsC1VA1f3YThRVXFsKnxHYnglyEYie20D
 B2DjxOWOIUBRH8wS3rxMsJQx4iwL+0FrO0g0M5VtSAHI8DwYNzpyFMR8IjF6eTpc624HJnM5lvH
 Sot+zUpWQlhQC8DgFrN7iWJK6ttvFlsaRGnZIjik2YZ9wyLrDsK5UCfDGECzjxDVvGCCehzktYV
 6daZPpIlkD48/isIvxls2HHpJqEkarlH5QbaewYzCyrTOZuEvY/GgBNE/cKfx/KeRe47rV7VL0y
 09YysACSIbTuF3UYiSuWheibdFHEWfZ69Yt73N5Wglsi/dGn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The recent refactoring of where runtime PM is enabled done in commit
f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
avoid imbalance") made the fact that when we do a pm_runtime_disable()
in the error paths of probe() we can trigger a runtime disable which in
turn results in duplicate clock disables.  This is particularly likely
to happen when there is missing or broken DT description for the flashes
attached to the controller.

Early on in the probe function we do a pm_runtime_get_noresume() since
the probe function leaves the device in a powered up state but in the
error path we can't assume that PM is enabled so we also manually
disable everything, including clocks. This means that when runtime PM is
active both it and the probe function release the same reference to the
main clock for the IP, triggering warnings from the clock subsystem:

[    8.693719] clk:75:7 already disabled
[    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb
...
[    8.694261]  clk_core_disable+0xa0/0xb4 (P)
[    8.694272]  clk_disable+0x38/0x60
[    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
[    8.694309]  platform_probe+0x5c/0xa4

Dealing with this issue properly is complicated by the fact that we
don't know if runtime PM is active so can't tell if it will disable the
clocks or not.  We can, however, sidestep the issue for the flash
descriptions by moving their parsing to when we parse the controller
properties which also save us doing a bunch of setup which can never be
used so let's do that.

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/r/20251201072844.GA6785@francesco-nb
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Switch to moving the DT parsing earlier so we avoid triggering the
  clock referencing problems.
- Link to v1: https://patch.msgid.link/20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org
---
 drivers/spi/spi-cadence-quadspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..bdbeef05cd72 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1845,6 +1845,12 @@ static int cqspi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = cqspi_setup_flash(cqspi);
+	if (ret) {
+		dev_err(dev, "failed to setup flash parameters %d\n", ret);
+		return ret;
+	}
+
 	/* Obtain QSPI clock. */
 	cqspi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(cqspi->clk)) {
@@ -1988,12 +1994,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_get_noresume(dev);
 	}
 
-	ret = cqspi_setup_flash(cqspi);
-	if (ret) {
-		dev_err(dev, "failed to setup flash parameters %d\n", ret);
-		goto probe_setup_failed;
-	}
-
 	host->num_chipselect = cqspi->num_chipselect;
 
 	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))

---
base-commit: cebdea5fc60642a39a76c237257a7e6662336006
change-id: 20251202-spi-cadence-qspi-runtime-pm-imbalance-657740cf7eae

Best regards,
--  
Mark Brown <broonie@kernel.org>


