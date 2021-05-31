Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7B3967B4
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhEaSUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:20:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59252 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhEaSUP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 May 2021 14:20:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VIILv5078859;
        Mon, 31 May 2021 13:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622485101;
        bh=Sl31BUmX3/FJulfUqY3PNC/Qjz+pJuWiNkIVYGd5qs0=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=NfuXKZimM57kbNyutIUTJM6AQmbAJeZSoNqqHrlLgWl4z9pvTMaJl3/+9eXFtRs3z
         g2Y+W0xB5DH8z4j+ETzjcWRrEMcLFd+xTtADNU10HcNjTnsLAf/xk/WE1OG3JJtRXL
         KdvAAs3J4ejOE+WFsF4pYzDBzu83kTs9mr1RiPEc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VIIL4i028558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 13:18:21 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 13:18:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 13:18:20 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VIHwdL118543;
        Mon, 31 May 2021 13:18:18 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode
Date:   Mon, 31 May 2021 23:47:57 +0530
Message-ID: <20210531181757.19458-7-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210531181757.19458-1-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Octal DTR capable flashes like Micron Xcella the writes cannot start
or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
appended or prepended to make sure the start address and end address are
even. 0xff is used because on NOR flashes a program operation can only
flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
happen via erases.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v2:
- Replace semicolon in subject with colon.
- Add a comment that ret < 0 after adjusting for extra bytes is not
  possible, and add a WARN_ON() on the condition to make sure it gets
  spotted quickly when some change triggers this bug.

 drivers/mtd/spi-nor/core.c | 73 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a696af6a1b71..d2a7e16e667d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2023,6 +2023,72 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	return ret;
 }
 
+/*
+ * On Octal DTR capable flashes like Micron Xcella the writes cannot start or
+ * end at an odd address in Octal DTR mode. Extra 0xff bytes need to be appended
+ * or prepended to make sure the start address and end address are even. 0xff is
+ * used because on NOR flashes a program operation can only flip bits from 1 to
+ * 0, not the other way round. 0 to 1 flip needs to happen via erases.
+ */
+static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
+				   const u8 *buf)
+{
+	u8 *tmp_buf;
+	size_t bytes_written;
+	loff_t start, end;
+	int ret;
+
+	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_write_data(nor, to, len, buf);
+
+	tmp_buf = kmalloc(nor->page_size, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	memset(tmp_buf, 0xff, nor->page_size);
+
+	start = round_down(to, 2);
+	end = round_up(to + len, 2);
+
+	memcpy(tmp_buf + (to - start), buf, len);
+
+	ret = spi_nor_write_data(nor, start, end - start, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are written than actually requested, but that number can't
+	 * be reported to the calling function or it will confuse its
+	 * calculations. Calculate how many of the _requested_ bytes were
+	 * written.
+	 */
+	bytes_written = ret;
+
+	if (to != start)
+		ret -= to - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually
+	 * written. For example, if for some reason the controller could only
+	 * complete a partial write then the adjustment for the extra bytes at
+	 * the end is not needed.
+	 */
+	if (start + bytes_written == end)
+		ret -= end - (to + len);
+
+	/* Should not be possible. */
+	if (WARN_ON(ret < 0))
+		ret = -EIO;
+
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -2067,7 +2133,12 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto write_err;
 
-		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
+		if (nor->write_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_write(nor, addr, page_remain,
+						      buf + i);
+		else
+			ret = spi_nor_write_data(nor, addr, page_remain,
+						 buf + i);
 		if (ret < 0)
 			goto write_err;
 		written = ret;
-- 
2.30.0

