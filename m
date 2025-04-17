Return-Path: <linux-spi+bounces-7632-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5AA91697
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9DA19E14AE
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC07222590;
	Thu, 17 Apr 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrF02IEJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E321B9E5;
	Thu, 17 Apr 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879177; cv=none; b=JEn2A02D986iywhHEc+h1BBlx5bh1BewW/XlEU4pMI3+UD1LywjVW/5q95sOpgiapfinEXMv+ApHux8aLx29ImVx9A7KgsxRWIa+4wiysFkFfWm1do4sOUhk+iXQx28HcOZE5cb3I+RXoTLFwNa8ms0A3pixtgbrJNrOv1ELprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879177; c=relaxed/simple;
	bh=K0f+JOXWGi4vrHLeSyyv7b7BSq3YVVIQ43kBiZpnSSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKBVGNPQWR+ycU3VQtL+ri46B5lvMEvRixg6S8qOwYvT8k0EH6ce6I6h6SojMGLhQB5Ry0IWIKnZnjKgLtJ+emgpEGV3ojjH65ABTvfhY0Hf/pfXZxBW6OH+0Gaego9uqRNdUsIBHgqPFg6FKCnwJVH5rmN6sntiqwVpJSm81r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrF02IEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF6FC4CEE4;
	Thu, 17 Apr 2025 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744879176;
	bh=K0f+JOXWGi4vrHLeSyyv7b7BSq3YVVIQ43kBiZpnSSM=;
	h=From:To:Cc:Subject:Date:From;
	b=LrF02IEJjTTBTcx/O1v8IT11OBNP/xXZFOQJtRypB9LIp9x7URQcwFWRzvm+MGD4E
	 CIMEyGo+F6W0qw7HkfFaG2dQeEYfuHqAbPTPhP7x5iRWfsjeNgAjaDwCWLM8xzTFCl
	 7tW1dEPiUtI7KY0jLxfLYBmjr7UfBYrHxokKtzsVKmojwlk0iXiXUEnouX6b3NzSZ1
	 2oFWiavlwB2uBwXqZ6U063Shc/ifXNIgkm2MIUomd3g4PJc1FtILTlnrxc1a6dg31B
	 ETu/Qhl6wTEAoZdDnYdU5Whp1/bw3nfJhaB7t16k+YJjDq8Gj3dBSBlqywVyapitNc
	 FnkPqgxs0O49w==
From: Philipp Stanner <phasta@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/2] spi: spi-cavium-thunderx: Use non-hybrid PCI devres API
Date: Thu, 17 Apr 2025 10:39:02 +0200
Message-ID: <20250417083902.23483-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cavium-thunderx enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_regions() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Moreover, since both functions are already managed in this driver, the
calls to pci_release_regions() are unnecessary.

Remove the calls to pci_release_regions().

Replace the call to sometimes-managed pci_request_regions() with one to
the always-managed pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/spi/spi-cavium-thunderx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 337aef12abcc..367ae7120bb3 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -34,7 +34,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 	if (ret)
 		goto error;
 
-	ret = pci_request_regions(pdev, DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret)
 		goto error;
 
@@ -78,7 +78,6 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 	return 0;
 
 error:
-	pci_release_regions(pdev);
 	spi_controller_put(host);
 	return ret;
 }
@@ -92,7 +91,6 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 	if (!p)
 		return;
 
-	pci_release_regions(pdev);
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
 }
-- 
2.48.1


