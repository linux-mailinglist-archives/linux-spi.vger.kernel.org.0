Return-Path: <linux-spi+bounces-3169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24E8D5EBE
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 11:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579D52846D9
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0381213F44F;
	Fri, 31 May 2024 09:47:10 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0078C69
	for <linux-spi@vger.kernel.org>; Fri, 31 May 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148829; cv=none; b=Z2rL7dyE4ufQ2XqIhJgmKZ9pJPUF5BCpz7BqZpYbmbsVLVbSbC22k20rQwxuwYUM0ckvU+SD3MdRtJkhG0Rk/DEbN0dZ8O7BGJN2y85EhO8hmPUyRxOjFcOPZUddxCK/gd8f4Y36c+dhqo2nIuBnbcMCM7EvLnX+7vDQEySnWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148829; c=relaxed/simple;
	bh=SC275hQjH9VkQy1y5Rrs3/LU4ycdUMdkK1Iho1g3uNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp9KBShqczUhT3PTlNOUftIuIGQSwg1ZO9DnqeCoO1cpnREMj5pi5WJ9rAlUJHXZ8KxR/gYtSaiZ41hTYhH8sk7J/vwQCcerBIFzsQqcgNG61CsVnc0A030xqZdECvmOQaTtd4pb4tcoThSZU+2e9kNER6vB6+MRk7PqzRBz4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id ba956cf2-1f32-11ef-aafc-005056bdd08f;
	Fri, 31 May 2024 12:47:01 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/2] spi: Do not rely on the SG table and respective API implementations
Date: Fri, 31 May 2024 12:44:33 +0300
Message-ID: <20240531094658.1598969-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we use global non-constant SG list to cover DMA unmmaped
part of unidirection transfer. This is heavily relies on the internal
implementation of the SG table and respective APIs. Instead, and
to be pair with the DMA mapped part of the transfer, use SG table
allocation for a single entry without any mapping done on top. This
also will be symmetrical to the respective sg_free_table() call.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 43cd3e5bccbe..da978ee262d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,11 +1220,6 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
-/* Dummy SG for unidirect transfers */
-static struct scatterlist dummy_sg = {
-	.page_link = SG_END,
-};
-
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1261,25 +1256,26 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						(void *)xfer->tx_buf,
 						xfer->len, DMA_TO_DEVICE,
 						attrs);
-			if (ret != 0)
-				return ret;
 		} else {
-			xfer->tx_sg.sgl = &dummy_sg;
+			/* Allocate dummy SG table for unidirect transfers */
+			ret = sg_alloc_table(&xfer->tx_sg, 1, GFP_KERNEL);
 		}
+		if (ret)
+			return ret;
 
 		if (xfer->rx_buf != NULL) {
 			ret = spi_map_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
 						xfer->rx_buf, xfer->len,
 						DMA_FROM_DEVICE, attrs);
-			if (ret != 0) {
-				spi_unmap_buf_attrs(ctlr, tx_dev,
-						&xfer->tx_sg, DMA_TO_DEVICE,
-						attrs);
-
-				return ret;
-			}
 		} else {
-			xfer->rx_sg.sgl = &dummy_sg;
+			/* Allocate dummy SG table for unidirect transfers */
+			ret = sg_alloc_table(&xfer->rx_sg, 1, GFP_KERNEL);
+		}
+		if (ret) {
+			spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
+					    DMA_TO_DEVICE, attrs);
+
+			return ret;
 		}
 	}
 	/* No transfer has been mapped, bail out with success */
-- 
2.45.1


