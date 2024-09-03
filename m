Return-Path: <linux-spi+bounces-4520-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1376F9690B7
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 02:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E01C218B7
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 00:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC51A4E75;
	Tue,  3 Sep 2024 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6wPJg3x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D5A32;
	Tue,  3 Sep 2024 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725324193; cv=none; b=LZXoOVUUGicm8TAxsNAy9Lvy/yNU1ti/WRcrNepKfMOElooun7hr29ekG6M+WmW+M8p4j/xOokwGuxx0knl1Q0Jjc6iTmtl4/NeqQgVDILH/jzB0G402vwIExJnK8mHCmMiHlrdLquCb+u+ZF4TsZ0I6T+C+avg6SmspD7hCax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725324193; c=relaxed/simple;
	bh=2LcdvhbJjQlCVDeUbqNLSdBIUIGgAwUZWz+vOG/kTjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fAALrXHDnKo+eQP3JSUQbcSfDqZDQmLPeZndPZW7XDLE31MNuqfBzT3vwSFY9DNuflYmkjlRZmc3DqWaNZBcrnYZgrEyaaO3C1mWZunHmEM1kIoNge4PPJHEn7jya0Ixewwldua7OsSlS0wHMUXsAaq/rPMcR604wtCy1osxzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6wPJg3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14990C4CEC2;
	Tue,  3 Sep 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725324192;
	bh=2LcdvhbJjQlCVDeUbqNLSdBIUIGgAwUZWz+vOG/kTjQ=;
	h=From:Date:Subject:To:Cc:From;
	b=e6wPJg3xMVqbo5LlbQsz6rOERdc7Bqnhb4N8juGbStcMjl97GbLTHb/KZ3Pe9LzV+
	 pMybvQC1DamS0bQ+Yc1KDY2gOUfMtF/wCya+YbNbp37SliZMLe22nM+SBEZI6cOsXk
	 pPAo21WL3tA1acniXxkT43/ISsuwAt9QCIIfePqdoo8xHZ2g2XnNsyZFeKZ5rqPrfj
	 2fXkffKRk8XBjpydGxDB8oUVNZSXVHDXgvYsGe/+OUnBJ/wtd1EC9rRHa1L9F3yqc6
	 80MM9qJNVr0MYmsixcDHhZbIZ7sxnuLP2RkttlY/J2mTGgvdlXMBs5zSEdJH+QpQE6
	 V381O69FHASIQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 02 Sep 2024 17:43:06 -0700
Subject: [PATCH] spi: Revert "spi: Insert the missing pci_dev_put()before
 return"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-spi-revert-8a0ec8c2d736-v1-1-928b829fed2b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJlb1mYC/x2MywqAIBAAfyX23MJmL+tXooPpWnup0IhA+vek4
 8DMJIgchCOMRYLAt0Q59gxVWYDdzL4yissMilRDAymMp2AWOVyoDbHVVrm+7lAPrTFEi/PWQ67
 PwF6e/zzN7/sBgmO9a2kAAAA=
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, 
 Yang Ruibin <11162571@vivo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=nathan@kernel.org;
 h=from:subject:message-id; bh=2LcdvhbJjQlCVDeUbqNLSdBIUIGgAwUZWz+vOG/kTjQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGnXoud/v6co/Oz+68yXt7PSWHY/2t33yklsn/5RySVc2
 2cc6dw9q6OUhUGMi0FWTJGl+rHqcUPDOWcZb5yaBDOHlQlkCAMXpwBcJI+R4cef7yxFWpvvGLT/
 ObRTpedjjLnMJh+t8sMLlrR89b/zWI6RYd4VSd90+aAd6z8+Ohk07Zp0wdpGpYn33yut2CU67b/
 NaV4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 8a0ec8c2d736 ("spi: Insert the missing pci_dev_put()before
return") added two uses of pci_dev_put() with an uninitialized dma_dev,
resulting in the following compiler warnings (or errors with
CONFIG_WERROR) when building with clang:

  drivers/spi/spi-pxa2xx-pci.c:150:15: error: variable 'dma_dev' is uninitialized when used here [-Werror,-Wuninitialized]
    150 |                 pci_dev_put(dma_dev);
        |                             ^~~~~~~
  drivers/spi/spi-pxa2xx-pci.c:228:15: error: variable 'dma_dev' is uninitialized when used here [-Werror,-Wuninitialized]
    228 |                 pci_dev_put(dma_dev);
        |                             ^~~~~~~

Commit 609d7ffdc421 ("spi: pxa2xx-pci: Balance reference count for PCI
DMA device") added a call to pci_dev_put() via
devm_add_action_or_reset() in case of failures, so the recent change was
incorrect for multiple reasons. Revert it altogether.

Fixes: 8a0ec8c2d736 ("spi: Insert the missing pci_dev_put()before return")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index a7bf4568f9ec..cc8dcf782399 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -146,10 +146,8 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	c->num_chipselect = 1;
 
 	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
-	if (ret) {
-		pci_dev_put(dma_dev);
+	if (ret)
 		return ret;
-	}
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
@@ -224,10 +222,8 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	}
 
 	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
-	if (ret) {
-		pci_dev_put(dma_dev);
+	if (ret)
 		return ret;
-	}
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);

---
base-commit: 42afa0cec405abcaf9263378496a51ba16895252
change-id: 20240902-spi-revert-8a0ec8c2d736-895aa00bdfcf

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


