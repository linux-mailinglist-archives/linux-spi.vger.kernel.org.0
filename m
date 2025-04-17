Return-Path: <linux-spi+bounces-7633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE9BA91699
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6631E3B77B2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0A2253B5;
	Thu, 17 Apr 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TliwaA5y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AE22422F;
	Thu, 17 Apr 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879194; cv=none; b=FknV/vRYcLanGpEmUKEeZIhXQTGE1bUe8vGM88XYaP94k/73YBJ1wEuwZowDbXUKLzs0vKmse9RxHlPMMFrHHCrPJ3FEbzfVJ3D2j7RJyN0ebiDewHJcFBFKkBAVadUKoliY1ZJbtjRt+/vBstTYSbohUmx2f3zSBnS/AeVxXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879194; c=relaxed/simple;
	bh=/re34Jijx67qh7ep0kYMZSfCwz9MDqjL7GzZBKLxH7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smU3dyEt98mSWvast9oU1W2Kvk4fnrhs7pgZaom9XVWNcKh1hDTKcVPIh5kqu6gczwg1elIBPPZFmUlJkx6xDg7E4Olr1i/eHXf288NPFWQqw7KQ3JpKehNSXj0qT0JYNbKkHPkJWSMkm3ZlrTxVPGtlH9lQbU4oaVc7HTWZHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TliwaA5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7278C4CEE7;
	Thu, 17 Apr 2025 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744879194;
	bh=/re34Jijx67qh7ep0kYMZSfCwz9MDqjL7GzZBKLxH7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TliwaA5y2u57bdhOZ7iJAFcvhsQX9BAu1zkOyCqNXe4ZleisgVo3sdrH+c6Gqeb/s
	 9LS6vEjClRpGM1pyGdP/J+bZ64CHyVa6dH41Sc3B+8+3eT6+Go65GDjgYRc0g1xtK4
	 NKG3cJFGQ5NRiJ1d4K5n6twG7tT2HxeGqujDM903vc8B/mUgIjTVc0ovrCo2G5sDXQ
	 6KWHFh4TLwfhpGB+pEOWZuy/btomDE9i6Mci9FVYO7CAkzdxwKAwj8QYs7MG/hZfL1
	 z6CO/uGaA+5fR+of8zvu4i1Upkqdhw/cs+Db+IQctnBq0I21Y1oUwXjUZgx966u9HG
	 XrrQMFe2zEjOQ==
From: Philipp Stanner <phasta@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/2] spi: pci1xxxx: Use non-hybrid PCI devres API
Date: Thu, 17 Apr 2025 10:39:04 +0200
Message-ID: <20250417083902.23483-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417083902.23483-2-phasta@kernel.org>
References: <20250417083902.23483-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci1xxxx enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_regions() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Moreover, since both functions are already managed in this driver, the
call to pci_release_regions() is unnecessary.

Remove the call to pci_release_regions().

Replace the call to sometimes-managed pci_request_regions() with one to
the always-managed pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/spi/spi-pci1xxxx.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index fc98979eba48..330078b1d50f 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -741,21 +741,19 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			if (ret)
 				return -ENOMEM;
 
-			ret = pci_request_regions(pdev, DRV_NAME);
+			ret = pcim_request_all_regions(pdev, DRV_NAME);
 			if (ret)
 				return -ENOMEM;
 
 			spi_bus->reg_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
-			if (!spi_bus->reg_base) {
-				ret = -EINVAL;
-				goto error;
-			}
+			if (!spi_bus->reg_base)
+				return -EINVAL;
 
 			ret = pci_alloc_irq_vectors(pdev, hw_inst_cnt, hw_inst_cnt,
 						    PCI_IRQ_ALL_TYPES);
 			if (ret < 0) {
 				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
-				goto error;
+				return ret;
 			}
 
 			init_completion(&spi_sub_ptr->spi_xfer_done);
@@ -773,13 +771,12 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			if (ret < 0) {
 				dev_err(&pdev->dev, "Unable to request irq : %d",
 					spi_sub_ptr->irq);
-				ret = -ENODEV;
-				goto error;
+				return -ENODEV;
 			}
 
 			ret = pci1xxxx_spi_dma_init(spi_bus, spi_sub_ptr->irq);
 			if (ret && ret != -EOPNOTSUPP)
-				goto error;
+				return ret;
 
 			/* This register is only applicable for 1st instance */
 			regval = readl(spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
@@ -808,8 +805,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			if (ret < 0) {
 				dev_err(&pdev->dev, "Unable to request irq : %d",
 					spi_sub_ptr->irq);
-				ret = -ENODEV;
-				goto error;
+				return -ENODEV;
 			}
 		}
 
@@ -828,15 +824,11 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 		spi_controller_set_devdata(spi_host, spi_sub_ptr);
 		ret = devm_spi_register_controller(dev, spi_host);
 		if (ret)
-			goto error;
+			return ret;
 	}
 	pci_set_drvdata(pdev, spi_bus);
 
 	return 0;
-
-error:
-	pci_release_regions(pdev);
-	return ret;
 }
 
 static void store_restore_config(struct pci1xxxx_spi *spi_ptr,
-- 
2.48.1


