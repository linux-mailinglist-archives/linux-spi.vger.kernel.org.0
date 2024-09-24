Return-Path: <linux-spi+bounces-4944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402519846E4
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B831C225B5
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25061A7249;
	Tue, 24 Sep 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="dscdQn5n"
X-Original-To: linux-spi@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA21E505;
	Tue, 24 Sep 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185222; cv=none; b=SozSCzv/iUktLuF5oTSIxqtiP5NQoHYFT4+fDslLrPurK85fH2SAFkIZPqjYpnWv5YOIPtgb71gj/uLocv6nYXdPZ+BEoqjlnvN4AKg8bgrI/u+uaHG2zOFxWgJ1S/kyqQGeumNA8S4G7lTtUgy/UwfdUDdHm9PW1WHsZi2gB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185222; c=relaxed/simple;
	bh=1EN5pN+OaMzjvva2ElQGivllGskZlYeNnbvkbiNDCGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQnNpUZmtniE+hX0FcUR5GaKRQnBf5ccZ5ngp52NAASh/GWQi4Bogww+wQhBOlfqApv5AnmbI1GXrlbQaiI9HruRD8+5OE7Y8w436j3geQBCQmaVa9FcvgLHH8lJ2uptAK73taPz51NsMLqT4g2rKFvZZVG3qeDE4pqsSPCQWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=dscdQn5n; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RIEd/+3RUZ5FAc5/2lhcwWi5vz2ND8NO2C1zeGC37t8=; b=dscdQn5nW9VwStRMkAIgbD6ASW
	IRHhJctdQbv3K2aATWWIubCJ8QfPJFQDRrkM6dxmkYiaH1bZ3C/t81hZAaxx12FcLGJjERkNnArLZ
	k3PiciPhsX8UjxrRfocFnl+JfPk1NGbmYdafgSqi/nFAyc0thIzXFGabw/cwaAeVDdI6lu5bXhtDJ
	LrDCj6ctnnbVUIluPTRciUq/GZ50iAAhOQtNFFbrJFO9T9N+GQgrDqdjQCIW3UnJdnZOKVmiMCp7N
	1k0r5hVYgmi1plBFhKXbpnefAjDYLEm42an9dzQi9ZXZ5Tpi6oQ+Xi/fH9CxZztpebqJS5VDyC2N+
	ZHsmXAfA==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1st5ly-003YDw-Tj; Tue, 24 Sep 2024 14:40:11 +0100
Received: from ben by rainbowdash with local (Exim 4.98)
	(envelope-from <ben@rainbowdash>)
	id 1st5ly-00000000UFR-3j6O;
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
Subject: [PATCH 1/2] spi: s3c64xx: fix timeout counters in flush_fifo
Date: Tue, 24 Sep 2024 14:40:08 +0100
Message-Id: <20240924134009.116247-2-ben.dooks@codethink.co.uk>
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

In the s3c64xx_flush_fifo() code, the loops counter is post-decremented
in the do { } while(test && loops--) condition. This means the loops is
left at the unsigned equivalent of -1 if the loop times out. The test
after will never pass as if tests for loops == 0.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 833c58c88e40..6ab416a33966 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -245,7 +245,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-	} while (TX_FIFO_LVL(val, sdd) && loops--);
+	} while (TX_FIFO_LVL(val, sdd) && --loops);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
@@ -258,7 +258,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 			readl(regs + S3C64XX_SPI_RX_DATA);
 		else
 			break;
-	} while (loops--);
+	} while (--loops);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
-- 
2.37.2.352.g3c44437643


