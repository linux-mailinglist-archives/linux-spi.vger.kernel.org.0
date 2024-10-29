Return-Path: <linux-spi+bounces-5537-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1309B5545
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 22:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57451F23EA0
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F25209673;
	Tue, 29 Oct 2024 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bxpHBSam"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E2194AD6
	for <linux-spi@vger.kernel.org>; Tue, 29 Oct 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238729; cv=none; b=mn4pupTi2GjvQHDCehN3MGbFmmVfKz+NQHF8TQNKCDylmFsTbcSpAvZxMEgDziCZpPdzRjzs80kYW07W77BticvkCogOz16OXV7bYzgMfR3UAeeOeJ5Fs8xjwtkr+Ql7ytse7EanMKic+dXIHLQ/SBwV3LYe1ZdIEOeNvUut13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238729; c=relaxed/simple;
	bh=64P9JcC/UsbAQodko6h9O/sXWHArISyWmLSQS1bEXPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roWp4ONAhh9+1+aT/dTSN2COhZxJQOdrqWzPr1irvVMERvHquwWAsy8OcWYGgwVvarieF9YDG6yh/s7GxKitIFhT9VFmSlYsYnm9U4ViRXito7aHKNxFS7a71+b/BygKjJGaBqdmF4iiGVWewePdAIIEOLThtH8KR3W3rQaSzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=bxpHBSam; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 957FE2C0213;
	Wed, 30 Oct 2024 10:52:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730238723;
	bh=nDPsNw+YIj8Y1uuBIamZoWAOiwuD09KOm6uHsEnflCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxpHBSamVCHmxoD+QtuB0T5Y2ex2TRZhcYwbZ+GPlD/JSO6S37l6Bgu02WcNmWwwG
	 1e6DmLLI0NRith34zg+vkHlhFH0lKohPEyQJiDfXmEm/Gow/pJkln0OMu32dX4tpn6
	 +0kh7BRcO/jgRHKvzxsBeSfud+iUr7C5blNJ8heixO/UCXVL1yudGc50U1M6c3AQje
	 krsF+8mN512iiRVsU0j+Z3Yri8PW6fwch3l4clIDO5LvT2sPiq7zDdYgRApXfe5Mva
	 Syl92EZpYK9itumu42b+9vAkHpHCPadosL6z4i6FKbKP1C2/norK/Mgjv8QCDPfAJ3
	 sB1HRrY/AmAtw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672159030000>; Wed, 30 Oct 2024 10:52:03 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3E7C613ED6B;
	Wed, 30 Oct 2024 10:52:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 3546E28092F; Wed, 30 Oct 2024 10:52:03 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	miquel.raynal@bootlin.com
Cc: linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
Date: Wed, 30 Oct 2024 10:51:59 +1300
Message-ID: <20241029215159.1975844-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <94ffb58b-3242-4ab4-b09a-686116ced781@alliedtelesis.co.nz>
References: <94ffb58b-3242-4ab4-b09a-686116ced781@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67215903 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=e5I0b7u9wi4L-dRFP98A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The RTL9300 has some limitations on the maximum DMA transfers possible.
For reads this is 2080 bytes (520*4) for writes this is 520 bytes. Deal
with this by splitting transfers into appropriately sized parts. Also
ensure that we are using the correct buffer when doing DMA writes.

Fixes: 42d20a6a61b8 ("spi: spi-mem: Add Realtek SPI-NAND controller")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-realtek-rtl-snand.c | 51 +++++++++++++++++++----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl-snand.c b/drivers/spi/spi-realte=
k-rtl-snand.c
index 23c42c8469e4..50b3240641e8 100644
--- a/drivers/spi/spi-realtek-rtl-snand.c
+++ b/drivers/spi/spi-realtek-rtl-snand.c
@@ -231,19 +231,25 @@ static int rtl_snand_xfer(struct rtl_snand *snand, =
int cs, const struct spi_mem_
=20
 static int rtl_snand_dma_xfer(struct rtl_snand *snand, int cs, const str=
uct spi_mem_op *op)
 {
+	unsigned int pos, nbytes;
 	int ret;
 	dma_addr_t buf_dma;
 	enum dma_data_direction dir;
-	u32 trig;
+	u32 trig, len, maxlen;
+	void *buf;
=20
 	ret =3D rtl_snand_xfer_head(snand, cs, op);
 	if (ret)
 		goto out_deselect;
=20
 	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
+		maxlen =3D 2080;
+		buf =3D op->data.buf.in;
 		dir =3D DMA_FROM_DEVICE;
 		trig =3D 0;
 	} else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
+		maxlen =3D 520;
+		buf =3D op->data.buf.out;
 		dir =3D DMA_TO_DEVICE;
 		trig =3D 1;
 	} else {
@@ -251,7 +257,7 @@ static int rtl_snand_dma_xfer(struct rtl_snand *snand=
, int cs, const struct spi_
 		goto out_deselect;
 	}
=20
-	buf_dma =3D dma_map_single(snand->dev, op->data.buf.in, op->data.nbytes=
, dir);
+	buf_dma =3D dma_map_single(snand->dev, buf, op->data.nbytes, dir);
 	ret =3D dma_mapping_error(snand->dev, buf_dma);
 	if (ret)
 		goto out_deselect;
@@ -264,26 +270,37 @@ static int rtl_snand_dma_xfer(struct rtl_snand *sna=
nd, int cs, const struct spi_
 	if (ret)
 		goto out_unmap;
=20
-	reinit_completion(&snand->comp);
+	pos =3D 0;
+	len =3D op->data.nbytes;
=20
-	ret =3D regmap_write(snand->regmap, SNAFDRSAR, buf_dma);
-	if (ret)
-		goto out_disable_int;
+	while (pos < len) {
+		nbytes =3D len - pos;
+		if (nbytes > maxlen)
+			nbytes =3D maxlen;
=20
-	ret =3D regmap_write(snand->regmap, SNAFDLR,
-			   CMR_WID(op->data.buswidth) | (op->data.nbytes & 0xffff));
-	if (ret)
-		goto out_disable_int;
+		reinit_completion(&snand->comp);
=20
-	ret =3D regmap_write(snand->regmap, SNAFDTR, trig);
-	if (ret)
-		goto out_disable_int;
+		ret =3D regmap_write(snand->regmap, SNAFDRSAR, buf_dma + pos);
+		if (ret)
+			goto out_disable_int;
=20
-	if (!wait_for_completion_timeout(&snand->comp, usecs_to_jiffies(20000))=
)
-		ret =3D -ETIMEDOUT;
+		pos +=3D nbytes;
=20
-	if (ret)
-		goto out_disable_int;
+		ret =3D regmap_write(snand->regmap, SNAFDLR,
+				CMR_WID(op->data.buswidth) | nbytes);
+		if (ret)
+			goto out_disable_int;
+
+		ret =3D regmap_write(snand->regmap, SNAFDTR, trig);
+		if (ret)
+			goto out_disable_int;
+
+		if (!wait_for_completion_timeout(&snand->comp, usecs_to_jiffies(20000)=
))
+			ret =3D -ETIMEDOUT;
+
+		if (ret)
+			goto out_disable_int;
+	}
=20
 out_disable_int:
 	regmap_update_bits(snand->regmap, SNAFCFR, SNAFCFR_DMA_IE, 0);
--=20
2.47.0


