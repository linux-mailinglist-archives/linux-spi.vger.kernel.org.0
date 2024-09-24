Return-Path: <linux-spi+bounces-4946-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543E9846E8
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBC11F23557
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36D145B00;
	Tue, 24 Sep 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="tHbXMtq9"
X-Original-To: linux-spi@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3241A3AA6;
	Tue, 24 Sep 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185224; cv=none; b=h20torfvMtPcWLJaGlv1/gFDR3E0jhKVH6jlNaBiGze4SbPuuEPItQ4M3PzAsFlH44xlTfteWWsHY/2SBOFHlzto1JvzBOJPEIInxSFUETelae2jb4jKlt2l4lCT0V2I5C2K0IXDKFQyoSww4o5f/9qAI3VVbgXKeSkyOT2z7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185224; c=relaxed/simple;
	bh=ut3JW1nD5GFSZqnAX5kOPVq6yHEIvRG6A59oqmHyGFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r41Dv5+zKeAkwuC9S33qfPett1sr2Ps1XVGi8lfutKKziXoyhqi4muBtI5P2bF3eEE7faqe/epgxFGnp7UHy5o8F7fDdMSuDt4wKhEc6N6SZCah8nsYB+0gbY+CjLwAJevJhbDD+exraYkP4ryskEJHvuLVj9JzK+EMvAN3ORzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=tHbXMtq9; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x8vVJjhSJf8ntKWMHQeF38IG4mIwV3gbUUfBMyXl/pI=; b=tHbXMtq9ZXYeL0mc3IEogvuEFI
	M4oX9PTvyYhYU6vehYpoAMG5gCefE3LP/hUVcY66ac2gX7dSvmpO6UO0/iaK6ZZwCBYWNDz+DHzKp
	poFEPArAYPnDCosgO86Urq0EZkNq1RphsIoZSh48flJJXNW4GARYUareKZxL5HGQZwa3/ymeD1QIK
	GvAXpX4xJgw7w5YMLi2F/0o0WRvKyGp97Pvsv25TTmx7vqpvtWJLkor7lXTLC/kPDVLMV8Yu9wpxv
	FBiZuTJiaOg2fQX4VioRQwdPfvtrliaLOBctDpCHu2OJevgsrqIiZSV5eF3/G3tCJUPgbrZWWKVG4
	7s01OWJA==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1st5ly-002wbh-PE; Tue, 24 Sep 2024 14:40:11 +0100
Received: from ben by rainbowdash with local (Exim 4.98)
	(envelope-from <ben@rainbowdash>)
	id 1st5ly-00000000UFV-3uFk;
	Tue, 24 Sep 2024 14:40:10 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-spi@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] spi: s3c64xx: update flush_fifo timeout code
Date: Tue, 24 Sep 2024 14:40:09 +0100
Message-Id: <20240924134009.116247-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The code that checks for loops in the s3c6xx_flush_fifo() checks
for loops being non-zero as a timeout, however the code /could/
finish with loops being zero and the fifo being flushed...

Also, it would be useful to know what is left in the fifo for this
error case, so update the checks to see what is left, and then also
print the number of entries.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6ab416a33966..7b244e1fd58a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -247,8 +247,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 		val = readl(regs + S3C64XX_SPI_STATUS);
 	} while (TX_FIFO_LVL(val, sdd) && --loops);
 
-	if (loops == 0)
-		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
+	if (TX_FIFO_LVL(val, sdd))
+		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO (%d left)\n", TX_FIFO_LVL(val, sdd));
 
 	/* Flush RxFIFO*/
 	loops = msecs_to_loops(1);
@@ -260,8 +260,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 			break;
 	} while (--loops);
 
-	if (loops == 0)
-		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
+	if (RX_FIFO_LVL(val, sdd))
+		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO (%d left)\n", RX_FIFO_LVL(val, sdd));
 
 	val = readl(regs + S3C64XX_SPI_CH_CFG);
 	val &= ~S3C64XX_SPI_CH_SW_RST;
-- 
2.37.2.352.g3c44437643


