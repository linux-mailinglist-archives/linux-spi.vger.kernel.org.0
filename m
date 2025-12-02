Return-Path: <linux-spi+bounces-11732-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E386CC9D4DE
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 00:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21C544E59EE
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503F2FB0AE;
	Tue,  2 Dec 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMbVQzm7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D02F1FFE;
	Tue,  2 Dec 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716713; cv=none; b=JvD3OKnlYBT8zUEXiEyxs6oS9oNOy4CspVhuOSMrcIFbaaixX6T7pAR7+QRQZLTsufkuyxikyUkyDQkgdnVxj0e7mwD3Od2C0N60YsW6HZWTd1VgmK3ZRrZ+XEgvV5XyqgnF8fXIRVS0lVujZk1k44mOtYBy24JWcrjJeNti+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716713; c=relaxed/simple;
	bh=sXGJFPecuGDhj7hiVvBRtRIF2Bg/VeaQrC0i27OaD68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t1hFJqW/YEMS9zLWFugSqmhirZRfG/ekGFa8mnV4nUmCpDl31T7Kf4rdFJEwVOdEF//2GQxDBQUR47iCkotbeUqD2DknHbDtSSW2bKzzpYXgbq+/ts3v6u0PHi9mnikVzGBg1xrACiEeL8GFusCYWj720P3aSmBCnzXS2qw5xfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMbVQzm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF45C4CEF1;
	Tue,  2 Dec 2025 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764716712;
	bh=sXGJFPecuGDhj7hiVvBRtRIF2Bg/VeaQrC0i27OaD68=;
	h=From:Date:Subject:To:Cc:From;
	b=dMbVQzm7l9kksjqSAJ34pE7HbYodq5ONOFzmyrhBquwDx2xz0ZsVBGuAGcQuJqOio
	 NaSkVMGRTOZ+K0ajk/9HyUpHsRXk6GUYDUInIbCnIaIVNBu8y+87x2jX1rzoL6VmNp
	 YuzdJrHJz+F6rpD8EDFj25k49jgq0PGkVV+cYuoDtinFjcqUqaubVjOrVXlIYjuho1
	 t1aLg9DlAaBdhBM7rzya79HJefpapXCmsXSbiueESrBq8JhNJCOsXuOhgHZEbg6TQq
	 fJaqzRmrC1wQBxgFiHGPmkfp5f/EBhUiX4UyFaXbNfj5QzreSXgPDZNT2v2Lb8CnBK
	 VktIE/E01xWXw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Dec 2025 22:53:44 +0000
Subject: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPdtL2kC/x3NwQqDMBAE0F+RPXdBRQ34K6WHNY52oYlpoiKI/
 97Yy8BjYOakhKhI1BcnReyadPEZ1aMg+xY/g3XMprqs2yoHp6BsZYS34O+NuPlVHTg4VjfIR+6
 ma41pSjsZCChvhYhJj//P83VdPzbNt4t3AAAA
X-Change-ID: 20251202-spi-cadence-qspi-runtime-pm-imbalance-657740cf7eae
To: Francesco Dolcini <francesco@dolcini.it>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sXGJFPecuGDhj7hiVvBRtRIF2Bg/VeaQrC0i27OaD68=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpL3Cm5CJl5jjvUJAHekdzbU2IMj4IyIBN2H6yF
 sM/y5HaGauJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaS9wpgAKCRAk1otyXVSH
 0KpIB/48WNjTLaX30mMnoGCj9QB/FKrv5PsRWt9Isqf9IEM5NKA5C+cL3l4VWc7z1UD12qARfZL
 Jh0GkP9o+69xpxpEj2HJd41/VF9edA/9xx+uO1ycW4soLkA1gz9aFWDc6AopMCaZyoC4F66dU7X
 J+AOC2PwTgSAn2SR02n7Bns0PM/PdOVDU9oN+iIt146SeQpOHQkRhdgMeceToMyBuz8y7/9eqyX
 f5MRNt9zpDfUZiRJSpWvlHMml+YBD2rxU0xiGIgZKYirqD7H1R+WVEZkqruqvuanDr7qaqVqdlT
 YiTzCgJnFzdJTK7vIMxJ0ZnwqSgaNCUctobstcWo+BRCdn5C
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The recent refactoring of where runtime PM is enabled done in commit
f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
avoid imbalance") made the fact that when we do a pm_runtime_disable()
in the error paths of probe() we can trigger a runtime disable which in
turn results in duplicate clock disables. Early on in the probe function
we do a pm_runtime_get_noresume() since the probe function leaves the
device in a powered up state but in the error path we can't assume that PM
is enabled so we also manually disable everything, including clocks. This
means that when runtime PM is active both it and the probe function release
the same reference to the main clock for the IP, triggering warnings from
the clock subsystem:

[    8.693719] clk:75:7 already disabled
[    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb
...
[    8.694261]  clk_core_disable+0xa0/0xb4 (P)
[    8.694272]  clk_disable+0x38/0x60
[    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
[    8.694309]  platform_probe+0x5c/0xa4

Avoid this confused ownership by moving the pm_runtime_get_noresume() to
after the last point at which the probe() function can fail.

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/r/20251201072844.GA6785@francesco-nb
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..0833b6f666d0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1985,7 +1985,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 		pm_runtime_use_autosuspend(dev);
-		pm_runtime_get_noresume(dev);
 	}
 
 	ret = cqspi_setup_flash(cqspi);
@@ -2012,6 +2011,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_get_noresume(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20251202-spi-cadence-qspi-runtime-pm-imbalance-657740cf7eae

Best regards,
--  
Mark Brown <broonie@kernel.org>


