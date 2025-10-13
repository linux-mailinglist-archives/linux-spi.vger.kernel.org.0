Return-Path: <linux-spi+bounces-10603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269BBD2D31
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 13:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBFEB344201
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635202638AF;
	Mon, 13 Oct 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+r1K2Rb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CD261B7F;
	Mon, 13 Oct 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355868; cv=none; b=KhBGZswCgROi18cutn5QMKpM5FXefZTEuHg2t31z9oHNKCpaP7HPVKfVsRkI+qkDnAa1TQXt7NjehZORVAZa0I+Ax86Apxz9s4kmlmGQfBoExoTSOSKna2SUpkhzfKx7com/dSvLV4Hj/17l7YheDgFolriS77CVJPd3CmFscvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355868; c=relaxed/simple;
	bh=DHOZJDu5kEvHcvJDToMbreMDRdWVKLGK1lK3EyD6Tj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=If1SOIlUKgAKafSppFYQSMXpj9u82aKSn0GoGR39xvygGfCPWf1xN99Dagwy5iwCF6Lf8Jwiv/DQMlbIRgGcqiDIqcXLd+tIv36tEOkQrkf+hAZeNjUIu/1mTWmwtnpqBEE1lVIm1FpeRHXU+LFYRcSafIuamfXOtoXzFS3veL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+r1K2Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AE7C4CEE7;
	Mon, 13 Oct 2025 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760355868;
	bh=DHOZJDu5kEvHcvJDToMbreMDRdWVKLGK1lK3EyD6Tj8=;
	h=From:Date:Subject:To:Cc:From;
	b=l+r1K2RbQ1OLk6srAKulKnuIxrz82MfDezjlZY2LajQFZrvRGZPxWqNaBNEooCV2k
	 +vHDq6e+GhaMt1TSWe3os6GFcWMH/octN8D9qaTibhpGfcHaoRamLAEVSnFuEEjOXh
	 flUX61o/YQIa1yTLHZk26eSOmUKV4p4hAx+Lgge27ixtLFZFZE+aMaJ5LzO6cA80QD
	 ghzCgwOXmD633MCiny6IfgXHVfG0LlKS8uXTNi88rFow6gGECvIaJWMWGyPRij19vK
	 xu/ju4SNBfkc83k8hVyv1t73CyUdqMwPWYSYV5oBbPc02xGddcJKpnZJ3Wrv2tKiar
	 a0FuMSuNhktZA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Mon, 13 Oct 2025 13:44:10 +0200
Subject: [PATCH v3] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-cadence-quadspi-fix-pm-runtime-v3-1-d65f18dade0d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAnm7GgC/43Nyw6CMBCF4VchXTumFwjgyvcwLnqZQqMUbIFoC
 O9uYaUrXf6TyXcWEjE4jOSULSTg7KLrfQpxyIhupW8QnElNOOUFo7QCLQ16jfCYpImDA+ueMHQ
 QJj+6DkHZytia0bwoS5KQIWD62Acu19Sti2MfXvvezLbr3/TMgIEQSqtcVUJyPN8weLwf+9CQz
 Z75p1f/9HjyKmUsWp2LmvIvb13XN4AVKVMdAQAA
X-Change-ID: 20251008-cadence-quadspi-fix-pm-runtime-bf8df9104577
To: Mark Brown <broonie@kernel.org>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=DHOZJDu5kEvHcvJDToMbreMDRdWVKLGK1lK3EyD6Tj8=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBo7OYZzj+pWZd1pa0cGSlHXc2Toq9udOaGNcHL3
 z6yujhQNDaJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaOzmGQAKCRAZDR20Zk4Z
 NYGTCACjCqU14WZrOCzPaTAByZmo4JIPFVOMxfyiB5XRf3lnSITJU97B9s/5T2G1EXaFaxAuM0U
 lNIbqngrQmUh6XAXvGKwPufWNEoHTFmv8e+Hp5Pddj5fGLcN0iN7Sg1r3bKNV8Ly/+CoAdpv5+S
 McsuImiwDeq66mBNANnQDV/YngK6OesIZnmE6BvF1gyMXNK2z8fZ0+2qLUR3uZOPuCPp0YiEY3G
 QeFSufzNrz+C3LwrTwQlRftXEawOuRUq/g44SrQhCkJndq67GFYhAS+OlRvKiW3pVyZnvcCVbJ3
 PWdI8jZJ1v/RimUIwPzQ0cFLGx9iR6FONpmyMSDajnjIQbsU
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
label to handle spi_register_controller() failures.

Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This has been tested on a AM69 SK board.
---
Changes in v3:
- Rebased on spi/for-6.18 (Dropped Dan's review since rebase was
  non-trivial)
- Link to v2: https://lore.kernel.org/r/20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org

Changes in v2:
- Updated message to use correct Fixes tag (Dan)
- Link to v1: https://lore.kernel.org/r/20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org
---
 drivers/spi/spi-cadence-quadspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ce4fc136a51ce3305e478c82da6b88ad542fc8c..4209578cb3426aad6707d0a46ddb78986c5eef7d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2002,15 +2002,17 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-		goto probe_setup_failed;
+		goto probe_ctrl_failed;
 	}
 
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
+
+probe_ctrl_failed:
+	pm_runtime_disable(dev);
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);

---
base-commit: 18a5f1af596e6ba22cd40ada449063041f3ce6d4
change-id: 20251008-cadence-quadspi-fix-pm-runtime-bf8df9104577

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>


