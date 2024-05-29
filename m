Return-Path: <linux-spi+bounces-3128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430018D3B40
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DB41C22E0C
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B3181BB3;
	Wed, 29 May 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hfwNwGIY"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA921181334;
	Wed, 29 May 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997377; cv=none; b=TViY4kA/gAuu2e1fAgS8IjHnwit61p0A4qqmB/yQp9UeprMj5RBpR23MbcOLNpYRm4nncYsXSMAkDWBWveEqcR2PFYxQSws7cCQaPMYI3G7DXoTeRGW47GKVY/EEvw6tIGQ7v5Ha9ud0DFO286nkYW7NHIm8xYiyEkixbbNqtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997377; c=relaxed/simple;
	bh=YVjAOvgGqxa6Vv/TVvkaro0LhBO+CsQZ4z3wd5iHsLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=buX/F87tu0FZGyIZdMbibTuYfPmzD8aSp2oRY4yCV90Ybo5WyhQgiXaVx0cTnTaHcJ90wyuygYRBUfnUtPSmrMUiM+Je/G65oBLIVXFSEn+UPOXpFa+g2L+i7jC2OpNEVt9Qk/4siYyvjpu6/+f05CUA8GskWcc4/zlrYKFesu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hfwNwGIY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716997374;
	bh=YVjAOvgGqxa6Vv/TVvkaro0LhBO+CsQZ4z3wd5iHsLg=;
	h=From:Date:Subject:To:Cc:From;
	b=hfwNwGIY8NAShnPZRRmwAnq0tiGmG7BIbkCrQ394odi1UX8zymn7IeLBDVsAHo8UR
	 4l83tLHA6UJviARTFOr9NqR/DgfN/ubVY5JQt01F1xCVJjv03iiojbobipRs2E5SNd
	 3/MZZVQ9KMwUTRMoxSwd64/7R4paljxS4KLrgtQVWdQbmBY2iPHjio1LYpvO1+kfiY
	 0KKTHDoND1Xa0mswZ7A+V4BN46JVJdfKckDgMPVOQyHdjSwQMYGQ3QjqN7M02NQ7c3
	 /+agy0HrTpn+u0VtDxlxAJTaLvjrjlw0jRmHjk25+VG5DSjXBIP0QDLJ5LOumbYhtF
	 ZwxMm4+hzYSRA==
Received: from [192.168.1.221] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B32EF378218C;
	Wed, 29 May 2024 15:42:52 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 29 May 2024 11:42:35 -0400
Subject: [PATCH] spi: Assign dummy scatterlist to unidirectional transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAOpMV2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNL3ZTcRN38/IJi3ZTS3NxKXaPkpDSL5KTE1GRTEyWgpoKi1LTMCrC
 B0bG1tQD/kAWZYAAAAA==
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, kernel@collabora.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Commit 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
introduced a regression: unmapped data could now be passed to the DMA
APIs, resulting in null pointer dereferences. Commit 9f788ba457b4 ("spi:
Don't mark message DMA mapped when no transfer in it is") and commit
da560097c056 ("spi: Check if transfer is mapped before calling DMA sync
APIs") addressed the problem, but only partially. Unidirectional
transactions will still result in null pointer dereference. To prevent
that from happening, assign a dummy scatterlist when no data is mapped,
so that the DMA API can be called and not result in a null pointer
dereference.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Closes: https://lore.kernel.org/r/8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Closes: https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
Closes: https://lore.kernel.org/all/4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano
Fixes: 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[nfraprado: wrote the commit message]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f94420858c22..9bc9fd10d538 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,6 +1220,11 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
+/* Dummy SG for unidirect transfers */
+static struct scatterlist dummy_sg = {
+	.page_link = SG_END,
+};
+
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1258,6 +1263,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						attrs);
 			if (ret != 0)
 				return ret;
+		} else {
+			xfer->tx_sg.sgl = &dummy_sg;
 		}
 
 		if (xfer->rx_buf != NULL) {
@@ -1271,6 +1278,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 				return ret;
 			}
+		} else {
+			xfer->rx_sg.sgl = &dummy_sg;
 		}
 	}
 	/* No transfer has been mapped, bail out with success */

---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240529-dma-oops-dummy-2cbf8cbaec54

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


