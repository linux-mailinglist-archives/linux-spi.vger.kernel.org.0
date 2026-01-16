Return-Path: <linux-spi+bounces-12444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB5D31C2D
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 14:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 748D130069B0
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A882652B6;
	Fri, 16 Jan 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR9VgakF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1123C512;
	Fri, 16 Jan 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569852; cv=none; b=AUdi5DLeKbfURpol6qQhHnYPQIktD4SIjB/J37NyOp3udKEhl4iFslkjxf4BtbtzixEirsILtOVFqNKUs07a6RmSvAQ8MusR5j9cEiwW1p61bIIRrLl5Y2IykH3pvUluINtqzVRZHQeKIe95/zY1K9gRrOpYCvcZ2s30k9EXPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569852; c=relaxed/simple;
	bh=n3iW2Tj+vCxQwVgYlwOE8woENlPxrgCzFts6M+ARsAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WoldAbqitMYeBIoZ6ecCis5rhyn6/5mxLF30BsSSOhOGxsXgSQSbt0Q9miapantLYzNmkNb8lLjCBEgKQUN0LmSQ9N45oxpVrAzFJiis5hOwjY9i7BJXUBPfg31f1qEJTu63CVOnxA0e22TXg6zqrzSuWL+E/2IZaztSEpnlihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR9VgakF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C34C116C6;
	Fri, 16 Jan 2026 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768569851;
	bh=n3iW2Tj+vCxQwVgYlwOE8woENlPxrgCzFts6M+ARsAM=;
	h=From:Date:Subject:To:Cc:From;
	b=CR9VgakFnZ32Tn4Bud5kKBJQ4vKOrem9l4rK6FPaU8V4Z/nrOVK+SyU62j9RBSSLq
	 GnkLaJQC+VXQCK9ZLvUv8ic1ogM8vWNei4y1rGj6ZPHKOQklJulLkeUww+xRkKxJyh
	 nAa34r76fRvltLMUZ3PBZVd4zIYkvH3JPwkLufsNiSnDxTO1LjBKTufVqH88qI/Epq
	 bZuFfrAVmRXeBw0VrWSm/VSiDhl9zxN81B2Ntixuck/XcbyK7B7q6gtmFqewykIgmH
	 Jo70tdHJSEYM6RgSSuPvCcbfERAbqDhA4NpcpHHcPbqykzKo4aieT2fwDtV6g72FhO
	 afUONp8i4GoYQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 16 Jan 2026 13:23:40 +0000
Subject: [PATCH] spi: rockchip: Use plain request_irq()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
X-B4-Tracking: v=1; b=H4sIANs7amkC/yXMQQ6CQAxA0auQrm0yRSXBqxgXMK1ONYGxBUNCu
 DujLt/i/xVcTMXhUq1g8lHXcSigQwUxdcNDULkY6lA3geiMnhVtjK+YNOOUTDoWRrU39tSciAM
 fW2qh9Nnkrsvvfb397XP/lDh9h7BtO5/Jyf99AAAA
X-Change-ID: 20260115-spi-rockchip-threaded-irq-b1641d0d3919
To: Heiko Stuebner <heiko@sntech.de>
Cc: Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n3iW2Tj+vCxQwVgYlwOE8woENlPxrgCzFts6M+ARsAM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpajv5U/lesGnmB76mqSKLV43KjffKXBwaNmwv+
 NzWMRlI02iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaWo7+QAKCRAk1otyXVSH
 0CwGB/9/rGyUTjSO6Hyo6yX5Kteocrj34723rjZQgoAAfZzMecwg9BstwYHILNZ7ja/h3JtyN8L
 rmY7/4Vb4FuZPJGYS/62FJxRHpWHEP0GSfZTE+fr1D5RC49x8VkVWetwcgVz2sKJDv1tJJpKmL1
 LSMk3LpP5fhkww3jsZC0STIpIcmqqnJbUKMQPesuXDb5uCiRP3njbLr3MZSr6LwbULqSVh98HVN
 tOxbppgq9jJmXlUb+eB8h1tciMBgcri3899j2dqooCD4fd/kiGOSzmWAbsAKS6OJhdxNwYGtvlR
 uJ7JKz6GHSiCFNH7gQ2z7qjOIR0DjxXBGz+7Wzo+bqrGCwlT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The Rockchip driver has since interrupt support was added used
request_threaded_irq() but not actually supplied a threaded handler,
handling everything in the primary handler.  This is equivalent to just
using a plain request_irq(), and since aef30c8d569c (genirq: Warn about
using IRQF_ONESHOT without a threaded handler) the current behaviour has
triggered a WARN_ON().  Convert to use request_irq().

Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a6381de6f33..62e1bc08c940 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -805,8 +805,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_put_ctlr;
 
-	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
-					IRQF_ONESHOT, dev_name(&pdev->dev), ctlr);
+	ret = devm_request_irq(&pdev->dev, ret, rockchip_spi_isr, 0,
+			       dev_name(&pdev->dev), ctlr);
 	if (ret)
 		goto err_put_ctlr;
 

---
base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
change-id: 20260115-spi-rockchip-threaded-irq-b1641d0d3919

Best regards,
--  
Mark Brown <broonie@kernel.org>


