Return-Path: <linux-spi+bounces-5102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E65990025
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C68E1F24765
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210914AD24;
	Fri,  4 Oct 2024 09:42:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAA1487DC
	for <linux-spi@vger.kernel.org>; Fri,  4 Oct 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034961; cv=none; b=XRU1Psa615ZaPNa2NgEN+w5R2juKAF0KNs/9rxaln2pRz0bWFv2bV5qYXKNm8QfllVa4p3P21/ka6po2s9Th6HAh4BLspKBMbOldBAVcMuWbb6/ImAj0fA9AeJ0tm1/KTkWDNp1Y2Am/n0NvLGI/VXudXQwgU337jlp8vwgfJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034961; c=relaxed/simple;
	bh=GBzeUiBGx7KJ9NM+p8zZ1XjuHJmQFkDnF1VvRJ6jilQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efLi5F4/7cfOXNGYzx4bDWYwwEkI3LiBn79BqpKqibBDIoR6R/l697bAIQZzw1XNYK3nmBq7apYc9oP+1THT08nSEbDfyPffo1SY/my0R8ge6kZf4Y4su8TPl3l3MYwgjM3InSokdua4drgVeHnocxcYV1tc0/EtBKpZkt0oclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D3C4CEC6;
	Fri,  4 Oct 2024 09:42:40 +0000 (UTC)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: Provide defer reason if getting irq during probe fails
Date: Fri,  4 Oct 2024 11:42:32 +0200
Message-ID: <20241004094234.268301-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=bJOy9M38cYOlsx3lbQlWA0TCmm8l335VaaEqAKZ24+M=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrT/O7q8ZzJtZg7Us9lSmu/xffPy2eZS8jY/FG5HTsgI4 SorO7Ctk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJfD/PwbAu62cKU27ztS7P BOkT+geYuD+9qhEPc+KL/PNwa9H27h9XHl5rZpnAMfUNB2vvieuL92dqtV6K33xxGkd86awOHWF be4Nper9eSK1P+XN6fXeJ26S1C3eteMz4rSjCmdNuq3E2fwY3+xbNkhkeonLHxNQbpvDW6ZQ+MZ WR+FPI6cUr4RR+d95N1+QPW0PP+cROfmoatd9VyiitdnmTfa5ZgeSbS+/el38PKG0MP8lR9Lbpk fODmJ7ZTVv+GalLvJcWqunbXpg++USEzvRbW19JOq/dvyN/SYdR4sK+X5cbgm/t0ma6kspR8PRz +He5u7K8nzk717o6LHCVUI5YK1OoFMQ9Zdm/GS0Tw9UVAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@kernel.org>

Using dev_err_probe() in spi_probe() improves the kernel output from

	spi spi0.0: deferred probe pending: (reason unknown)

to

	spi spi0.0: deferred probe pending: ad7124: Failed to get irq...

for my current quest to make a certain spi device work.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I didn't check how dev_pm_domain_attach() behaves. Depending on that replacing
its error path by

	return dev_err_probe(dev, ret, "Failed to attach PM domain\n");

might be beneficial in a similar situation.

Best regards
Uwe

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c1dad30a4528..dba202f8a525 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -419,7 +419,7 @@ static int spi_probe(struct device *dev)
 	if (dev->of_node) {
 		spi->irq = of_irq_get(dev->of_node, 0);
 		if (spi->irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+			return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get irq\n");
 		if (spi->irq < 0)
 			spi->irq = 0;
 	}

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.45.2


