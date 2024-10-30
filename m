Return-Path: <linux-spi+bounces-5567-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637139B6D16
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 20:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94A52820AC
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5EC1D0E00;
	Wed, 30 Oct 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jMxgmYMu"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C21BD9F0
	for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317774; cv=none; b=MGKgcUN3iQHIV/4bNZg2+D6MM3Toj/B0FU18nJn1HcsweS1JiwMhMJPdTTVl6WgdQ/F/onjDP0aMyyG/KoCAE+TR2wcUVzkl4PN0dFV220DsKYc2831mvVA+l5Me2RFH4mfElkZd/0PMuqlsfnpoDGdzuiz7Xl9QRCyki4i8ERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317774; c=relaxed/simple;
	bh=BUPtAdY12R8GPkh7i+9161i5emCrqvdz2dxRJlcXPL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufk9voJOp2EAOEc/h0H66jvOQOkFKhQFPvvdoLcZxH+Vz/4bikgrYXibOCwfLIVB3gtbRY2zvnAtKKNUTA7vG5OapO6OXTWRF5aYcvaCbmx3mPoUeqB+4E8WfSCsOoOBWC8lcZ3EKHs9wss3NNchgT3veXeAB9a0ZKBpcmmLujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=jMxgmYMu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 293B42C028E;
	Thu, 31 Oct 2024 08:49:23 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730317763;
	bh=7MJwVJ1p1VHy6G2vJ9Kg5R9A/A6D8emFGXE0Dw5d1cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMxgmYMuTMfEiBbIIK/TrqFdlphXDGEy1pl1HVv/pVAmurNlIj2zNtaCCFi9/vDNk
	 n25VKOHi8YnV2C2WEQDCOuBaGpUOORltOM6R0+3PNgb+xJZ9YUkeF+BOjHTagzn8JD
	 cZdBWYMdEt5nZu9rJtCTWowHMVtct3KMhzvBdDXyXO9XgeN9bOFu6aLZU/io/bQ4+r
	 SN0D//5NynjIqtndTQdj2erlPdhLErSp594nfROYu3Uvz/PhWan3b5bYiohBsGei9i
	 qsaYGljEHTYZ3nw5hG8UFp+tVZVK2QZNg/Nr4GwXp4dPGBWt3iqFDesJWvvTs+blpO
	 VUdrUWE1AGOtQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67228dc20000>; Thu, 31 Oct 2024 08:49:22 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id A86CE13ED7B;
	Thu, 31 Oct 2024 08:49:22 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A224A280456; Thu, 31 Oct 2024 08:49:22 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	miquel.raynal@bootlin.com
Cc: linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
Date: Thu, 31 Oct 2024 08:49:20 +1300
Message-ID: <20241030194920.3202282-1-chris.packham@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67228dc2 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=lLVWK1Xwrs9e9ZnuNuoA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The RTL9300 has some limitations on the maximum DMA transfers possible.
For reads this is 2080 bytes (520*4) for writes this is 520 bytes. Deal
with this by splitting transfers into appropriately sized parts.

Fixes: 42d20a6a61b8 ("spi: spi-mem: Add Realtek SPI-NAND controller")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Drop unecessary "also" change. data.in and data.out point to the sa=
me
      memory but the latter is marked as const which causes some compiler
      warnings when we're trying to get a dma mapping for it.

 drivers/spi/spi-realtek-rtl-snand.c | 46 +++++++++++++++++++----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl-snand.c b/drivers/spi/spi-realte=
k-rtl-snand.c
index 23c42c8469e4..cd0484041147 100644
--- a/drivers/spi/spi-realtek-rtl-snand.c
+++ b/drivers/spi/spi-realtek-rtl-snand.c
@@ -231,19 +231,22 @@ static int rtl_snand_xfer(struct rtl_snand *snand, =
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
=20
 	ret =3D rtl_snand_xfer_head(snand, cs, op);
 	if (ret)
 		goto out_deselect;
=20
 	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
+		maxlen =3D 2080;
 		dir =3D DMA_FROM_DEVICE;
 		trig =3D 0;
 	} else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
+		maxlen =3D 520;
 		dir =3D DMA_TO_DEVICE;
 		trig =3D 1;
 	} else {
@@ -264,26 +267,37 @@ static int rtl_snand_dma_xfer(struct rtl_snand *sna=
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


