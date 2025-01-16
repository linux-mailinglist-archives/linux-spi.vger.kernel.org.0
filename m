Return-Path: <linux-spi+bounces-6378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD1A144DF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F90188A2CE
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A26241A02;
	Thu, 16 Jan 2025 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SlvTl+QM"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAE236A79;
	Thu, 16 Jan 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068143; cv=none; b=uIMiKcA0IQc6/2Ma1UiOpj78AaZLfrqQxbnoEXvliltHjqbfUerN8kHul4SJgyKRVokDZdH20XKdlCDyehVeGz5GtEIamd5c6RURyguOj9/K+aK4SLDrInElVX8FIgc4gjBTi7yESkLgbzTPTEV8At49B3gepjafpbZTKFY29L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068143; c=relaxed/simple;
	bh=KIT1n1bX3eDng3r+qwid11vHDsNx3quVnbQL3jXaPqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMEBkMeOzbvfNyzhBJSho++M9k+scopgXNwhKE8XDhXuYNnKiU5LNqbYMRlkze1gG0JiK6f0p5S3+d5mg+LvfWQ+C+VT2KkQG+gZVfV//Fhti8Zi7XFlHTT4rS0zeGMoj76d42AOIIZ+1yNMwpcfztm5YyyrY1MkCWh1IP8/fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SlvTl+QM; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737068140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgUvBMBWULyeQIjVoTQGL6xz3yswwmfd8gZCRxzSVkk=;
	b=SlvTl+QMSw+AfBh7e1XBZA4UxJHyUmFO8w2J1UXKRGYXgzqh7DxdSvpIefbU2o0HgWxnVH
	zSDfhzQLfQ9E3Dg3v4Bn2cAIb6mIYUkuhoy6n1CzGv2IeDbMoPnFx4myOKalEVB8jHNYUx
	hd1VnehJRgf3YYy92tJ94N6OxYXbXB4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/5] spi: zynqmp-gqspi: Abort operations on timeout
Date: Thu, 16 Jan 2025 17:55:19 -0500
Message-Id: <20250116225521.2688224-4-sean.anderson@linux.dev>
In-Reply-To: <20250116225521.2688224-1-sean.anderson@linux.dev>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When an operation times out, we leave the device (and driver) in an
inconsistent state. This generally results in all subsequent operations
timing out. Attempt to address this by resetting/reinitializing the
device when we have a timeout. This tends to be fairly robust.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 7d138f45b692..cf47466ec982 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1057,6 +1057,21 @@ static unsigned long zynqmp_qspi_timeout(struct zynqmp_qspi *xqspi, u8 bits,
 	return msecs_to_jiffies(timeout + 100);
 }
 
+
+static int zynqmp_qspi_wait(struct zynqmp_qspi *xqspi, unsigned long timeout)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(&xqspi->data_completion, timeout);
+	if (ret)
+		return 0;
+	dev_err(xqspi->dev, "Operation timed out\n");
+
+	/* Attempt to recover as best we can */
+	zynqmp_qspi_init_hw(xqspi);
+	return -ETIMEDOUT;
+}
+
 /**
  * zynqmp_qspi_exec_op() - Initiates the QSPI transfer
  * @mem: The SPI memory
@@ -1104,11 +1119,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 				   GQSPI_IER_TXNOT_FULL_MASK);
 		timeout = zynqmp_qspi_timeout(xqspi, op->cmd.buswidth,
 					      op->cmd.nbytes);
-		if (!wait_for_completion_timeout(&xqspi->data_completion,
-						 timeout)) {
-			err = -ETIMEDOUT;
+		err = zynqmp_qspi_wait(xqspi, timeout);
+		if (err)
 			goto return_err;
-		}
 	}
 
 	if (op->addr.nbytes) {
@@ -1133,11 +1146,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 				   GQSPI_IER_TXNOT_FULL_MASK);
 		timeout = zynqmp_qspi_timeout(xqspi, op->addr.buswidth,
 					      op->addr.nbytes);
-		if (!wait_for_completion_timeout(&xqspi->data_completion,
-						 timeout)) {
-			err = -ETIMEDOUT;
+		err = zynqmp_qspi_wait(xqspi, timeout);
+		if (err)
 			goto return_err;
-		}
 	}
 
 	if (op->dummy.nbytes) {
@@ -1204,8 +1215,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		}
 		timeout = zynqmp_qspi_timeout(xqspi, op->data.buswidth,
 					      op->data.nbytes);
-		if (!wait_for_completion_timeout(&xqspi->data_completion, timeout))
-			err = -ETIMEDOUT;
+		err = zynqmp_qspi_wait(xqspi, timeout);
 	}
 
 return_err:
-- 
2.35.1.1320.gc452695387.dirty


