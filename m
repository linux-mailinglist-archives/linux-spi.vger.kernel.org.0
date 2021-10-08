Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A784A427262
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJHUiO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbhJHUiH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 16:38:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CAC061570;
        Fri,  8 Oct 2021 13:36:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q19so8648748pfl.4;
        Fri, 08 Oct 2021 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+tKSUZZoLdxj9O5dUKeqvhvfpyZlmeunOzo/f0PScmU=;
        b=aKlDAQ78J+yHK+Oxud1fXYJvK7stD95LZ/Zsiw+4ra9tU3x7L1NHpx1HYb+tCzCf5s
         yFN8RPWBBjVHGKXfTVay+ZOjbW192/IXX7QbeqWAW7Mn9s4pzUfCOnUWc4V5rNLnUu0F
         09Vv2nRiBY12igMCOWPSngs/ZN81PzcpyTKYLH6di3SvUl+7g4W5M01hQ/La1vHcilS4
         unu4pho6MgwSwdWnycNa+aHqjUUUjkbb5Yi2QdmLWG2LgscGA02hO3Lt/D8LlfQTPG9c
         1VhUIPiWJ+zaM2ZJdbxkTgWe9c0jwXVGOP32U0HupJpyuUBiq2VQIwsffEfXu4jXdBDI
         4PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+tKSUZZoLdxj9O5dUKeqvhvfpyZlmeunOzo/f0PScmU=;
        b=VZYpP0FR+INZmWtH84wkiBWG2QL6cSILoByxfZAv94fzSXIgnS9JzL9EuBs+WYMLYM
         5lnr/033IacB1syNrIsXsuNB/SrCRX/k+Jg08JUoX10iJ2i6c9OA8aXVMnduOyafe/5l
         Ca/oGtx6VHWCByG1xMn7YlgzA8K3OB3n1mh/FUOxGgYg5VQKaEC1BdozhTiVf1HxFstn
         FlpfyKdUqQ9CiBcZe1uQKHFSMQzmpBZ9LzZqB0P2hDqyod88RQAksYlODRV7zf8hEmql
         EVaufOFBXp+Ckn2mdyrjWALbKaMrHABjOQSPXs9s1GFU7mnWugmHgKP/33eyGd005fbY
         4hqw==
X-Gm-Message-State: AOAM533iAaJzcRRE7nNmiJb2SVfSJDP2Evuj3iLnYFpOtpNK03nRvpRV
        GK7xf1tsOJ8Xrj7PyFUDs8Y=
X-Google-Smtp-Source: ABdhPJy8GUK5saMHqWzDj+wrcjinSKSoPeoquNRIITmjkCXk1iPTOrpi5BpCrbDMIgWWkoTLaKIzgQ==
X-Received: by 2002:aa7:914d:0:b0:44c:61e3:99b9 with SMTP id 13-20020aa7914d000000b0044c61e399b9mr12359099pfi.65.1633725371734;
        Fri, 08 Oct 2021 13:36:11 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q6sm117615pjd.26.2021.10.08.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:36:11 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 1/3] spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
Date:   Fri,  8 Oct 2021 16:36:01 -0400
Message-Id: <20211008203603.40915-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008203603.40915-1-kdasu.kdev@gmail.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Kamal Dasu <kdasu@broadcom.com>

Adding 32-bits and 64-bits per transfer modes using the SPCR3
register settings provided in MSPI controller ver >= 1.5

Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 172 ++++++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a78e56f566dd..9a2d12e7650c 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -83,6 +83,9 @@
 /* MSPI register offsets */
 #define MSPI_SPCR0_LSB				0x000
 #define MSPI_SPCR0_MSB				0x004
+#define MSPI_SPCR0_MSB_CPHA			BIT(0)
+#define MSPI_SPCR0_MSB_CPOL			BIT(1)
+#define MSPI_SPCR0_MSB_BITS_SHIFT		0x2
 #define MSPI_SPCR1_LSB				0x008
 #define MSPI_SPCR1_MSB				0x00c
 #define MSPI_NEWQP				0x010
@@ -102,6 +105,7 @@
 #define MSPI_NUM_CDRAM				16
 #define MSPI_CDRAM_CONT_BIT			BIT(7)
 #define MSPI_CDRAM_BITSE_BIT			BIT(6)
+#define MSPI_CDRAM_DT_BIT			BIT(5)
 #define MSPI_CDRAM_PCS				0xf
 
 #define MSPI_SPCR2_SPE				BIT(6)
@@ -114,6 +118,12 @@
 						 ~(BIT(10) | BIT(11)))
 #define MSPI_SPCR3_SYSCLKSEL_108		(MSPI_SPCR3_SYSCLKSEL_MASK & \
 						 BIT(11))
+#define MSPI_SPCR3_TXRXDAM_MASK			GENMASK(4, 2)
+#define MSPI_SPCR3_DAM_8BYTE			0
+#define MSPI_SPCR3_DAM_16BYTE			(BIT(2) | BIT(4))
+#define MSPI_SPCR3_DAM_32BYTE			(BIT(3) | BIT(5))
+#define MSPI_SPCR3_DATA_REG_SZ			BIT(8)
+#define MSPI_SPCR3_CPHARX			BIT(9)
 
 #define MSPI_MSPI_STATUS_SPIF			BIT(0)
 
@@ -153,6 +163,14 @@
 #define TRANS_STATUS_BREAK_DESELECT (TRANS_STATUS_BREAK_EOM |		\
 				     TRANS_STATUS_BREAK_CS_CHANGE)
 
+/*
+ * Used for writing and reading data in the right order
+ * to TXRAM and RXRAM when used as 32-bit registers respectively
+ */
+#define swap4bytes(__val) \
+	((((__val) >> 24) & 0x000000FF) | (((__val) >>  8) & 0x0000FF00) | \
+	 (((__val) <<  8) & 0x00FF0000) | (((__val) << 24) & 0xFF000000))
+
 struct bcm_qspi_parms {
 	u32 speed_hz;
 	u8 mode;
@@ -261,7 +279,7 @@ static inline bool bcm_qspi_has_sysclk_108(struct bcm_qspi *qspi)
 static inline int bcm_qspi_spbr_min(struct bcm_qspi *qspi)
 {
 	if (bcm_qspi_has_fastbr(qspi))
-		return 1;
+		return (bcm_qspi_has_sysclk_108(qspi) ? 4 : 1);
 	else
 		return 8;
 }
@@ -570,23 +588,23 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 {
 	u32 spcr, spbr = 0;
 
-	if (xp->speed_hz)
-		spbr = qspi->base_clk / (2 * xp->speed_hz);
-
-	spcr = clamp_val(spbr, bcm_qspi_spbr_min(qspi), QSPI_SPBR_MAX);
-	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spcr);
-
 	if (!qspi->mspi_maj_rev)
 		/* legacy controller */
 		spcr = MSPI_MASTER_BIT;
 	else
 		spcr = 0;
 
-	/* for 16 bit the data should be zero */
-	if (xp->bits_per_word != 16)
-		spcr |= xp->bits_per_word << 2;
-	spcr |= xp->mode & 3;
+	/*
+	 * Bits per transfer.  BITS determines the number of data bits
+	 * transferred if the command control bit (BITSE of a
+	 * CDRAM Register) is equal to 1.
+	 * If CDRAM BITSE is equal to 0, 8 data bits are transferred
+	 * regardless
+	 */
+	if (xp->bits_per_word != 16 && xp->bits_per_word != 64)
+		spcr |= xp->bits_per_word << MSPI_SPCR0_MSB_BITS_SHIFT;
 
+	spcr |= xp->mode & (MSPI_SPCR0_MSB_CPHA | MSPI_SPCR0_MSB_CPOL);
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_MSB, spcr);
 
 	if (bcm_qspi_has_fastbr(qspi)) {
@@ -599,13 +617,37 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 			/* SYSCLK_108 */
 			spcr |= MSPI_SPCR3_SYSCLKSEL_108;
 			qspi->base_clk = MSPI_BASE_FREQ * 4;
-			/* Change spbr as we changed sysclk */
-			bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, 4);
 		}
 
+		if (xp->bits_per_word > 16) {
+			/* data_reg_size 1 (64bit) */
+			spcr |=	MSPI_SPCR3_DATA_REG_SZ;
+			/* TxRx RAM data access mode 2 for 32B and set fastdt */
+			spcr |=	MSPI_SPCR3_DAM_32BYTE  | MSPI_SPCR3_FASTDT;
+			/*
+			 *  Set length of delay after transfer
+			 *  DTL from 0(256) to 1
+			 */
+			bcm_qspi_write(qspi, MSPI, MSPI_SPCR1_LSB, 1);
+		} else {
+			/* data_reg_size[8] = 0 */
+			spcr &=	~(MSPI_SPCR3_DATA_REG_SZ);
+
+			/*
+			 * TxRx RAM access mode 8B
+			 * and disable fastdt
+			 */
+			spcr &= ~(MSPI_SPCR3_DAM_32BYTE);
+		}
 		bcm_qspi_write(qspi, MSPI, MSPI_SPCR3, spcr);
 	}
 
+	if (xp->speed_hz)
+		spbr = qspi->base_clk / (2 * xp->speed_hz);
+
+	spbr = clamp_val(spbr, bcm_qspi_spbr_min(qspi), QSPI_SPBR_MAX);
+	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spbr);
+
 	qspi->last_parms = *xp;
 }
 
@@ -626,7 +668,7 @@ static int bcm_qspi_setup(struct spi_device *spi)
 {
 	struct bcm_qspi_parms *xp;
 
-	if (spi->bits_per_word > 16)
+	if (spi->bits_per_word > 64)
 		return -EINVAL;
 
 	xp = spi_get_ctldata(spi);
@@ -665,8 +707,12 @@ static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 	/* count the last transferred bytes */
 	if (qt->trans->bits_per_word <= 8)
 		qt->byte++;
-	else
+	else if (qt->trans->bits_per_word <= 16)
 		qt->byte += 2;
+	else if (qt->trans->bits_per_word <= 32)
+		qt->byte += 4;
+	else if (qt->trans->bits_per_word <= 64)
+		qt->byte += 8;
 
 	if (qt->byte >= qt->trans->len) {
 		/* we're at the end of the spi_transfer */
@@ -709,6 +755,33 @@ static inline u16 read_rxram_slot_u16(struct bcm_qspi *qspi, int slot)
 		((bcm_qspi_read(qspi, MSPI, msb_offset) & 0xff) << 8);
 }
 
+static inline u32 read_rxram_slot_u32(struct bcm_qspi *qspi, int slot)
+{
+	u32 reg_offset = MSPI_RXRAM;
+	u32 offset = reg_offset + (slot << 3);
+	u32 val;
+
+	val = bcm_qspi_read(qspi, MSPI, offset);
+	val = swap4bytes(val);
+
+	return val;
+}
+
+static inline u64 read_rxram_slot_u64(struct bcm_qspi *qspi, int slot)
+{
+	u32 reg_offset = MSPI_RXRAM;
+	u32 lsb_offset = reg_offset + (slot << 3) + 0x4;
+	u32 msb_offset = reg_offset + (slot << 3);
+	u32 msb, lsb;
+
+	msb = bcm_qspi_read(qspi, MSPI, msb_offset);
+	msb = swap4bytes(msb);
+	lsb = bcm_qspi_read(qspi, MSPI, lsb_offset);
+	lsb = swap4bytes(lsb);
+
+	return ((u64)msb << 32 | lsb);
+}
+
 static void read_from_hw(struct bcm_qspi *qspi, int slots)
 {
 	struct qspi_trans tp;
@@ -732,7 +805,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 				buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
 			dev_dbg(&qspi->pdev->dev, "RD %02x\n",
 				buf ? buf[tp.byte] : 0x0);
-		} else {
+		} else if (tp.trans->bits_per_word <= 16) {
 			u16 *buf = tp.trans->rx_buf;
 
 			if (buf)
@@ -740,6 +813,25 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 								      slot);
 			dev_dbg(&qspi->pdev->dev, "RD %04x\n",
 				buf ? buf[tp.byte / 2] : 0x0);
+		} else if (tp.trans->bits_per_word <= 32) {
+			u32 *buf = tp.trans->rx_buf;
+
+			if (buf)
+				buf[tp.byte / 4] = read_rxram_slot_u32(qspi,
+								      slot);
+			dev_dbg(&qspi->pdev->dev, "RD %08x\n",
+				buf ? buf[tp.byte / 4] : 0x0);
+
+		} else if (tp.trans->bits_per_word <= 64) {
+			u64 *buf = tp.trans->rx_buf;
+
+			if (buf)
+				buf[tp.byte / 8] = read_rxram_slot_u64(qspi,
+								      slot);
+			dev_dbg(&qspi->pdev->dev, "RD %llx\n",
+				buf ? buf[tp.byte / 8] : 0x0);
+
+
 		}
 
 		update_qspi_trans_byte_count(qspi, &tp,
@@ -769,6 +861,28 @@ static inline void write_txram_slot_u16(struct bcm_qspi *qspi, int slot,
 	bcm_qspi_write(qspi, MSPI, lsb_offset, (val & 0xff));
 }
 
+static inline void write_txram_slot_u32(struct bcm_qspi *qspi, int slot,
+					u32 val)
+{
+	u32 reg_offset = MSPI_TXRAM;
+	u32 msb_offset = reg_offset + (slot << 3);
+
+	bcm_qspi_write(qspi, MSPI, msb_offset, swap4bytes(val));
+}
+
+static inline void write_txram_slot_u64(struct bcm_qspi *qspi, int slot,
+					u64 val)
+{
+	u32 reg_offset = MSPI_TXRAM;
+	u32 msb_offset = reg_offset + (slot << 3);
+	u32 lsb_offset = reg_offset + (slot << 3) + 0x4;
+	u32 msb = upper_32_bits(val);
+	u32 lsb = lower_32_bits(val);
+
+	bcm_qspi_write(qspi, MSPI, msb_offset, swap4bytes(msb));
+	bcm_qspi_write(qspi, MSPI, lsb_offset, swap4bytes(lsb));
+}
+
 static inline u32 read_cdram_slot(struct bcm_qspi *qspi, int slot)
 {
 	return bcm_qspi_read(qspi, MSPI, MSPI_CDRAM + (slot << 2));
@@ -792,20 +906,39 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 
 	/* Run until end of transfer or reached the max data */
 	while (!tstatus && slot < MSPI_NUM_CDRAM) {
+		mspi_cdram = MSPI_CDRAM_CONT_BIT;
 		if (tp.trans->bits_per_word <= 8) {
 			const u8 *buf = tp.trans->tx_buf;
 			u8 val = buf ? buf[tp.byte] : 0x00;
 
 			write_txram_slot_u8(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
-		} else {
+		} else if (tp.trans->bits_per_word <= 16) {
 			const u16 *buf = tp.trans->tx_buf;
 			u16 val = buf ? buf[tp.byte / 2] : 0x0000;
 
 			write_txram_slot_u16(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
+		} else if (tp.trans->bits_per_word <= 32) {
+			const u32 *buf = tp.trans->tx_buf;
+			u32 val = buf ? buf[tp.byte/4] : 0x0;
+
+			write_txram_slot_u32(qspi, slot, val);
+			dev_dbg(&qspi->pdev->dev, "WR %08x\n", val);
+		} else if (tp.trans->bits_per_word <= 64) {
+			const u64 *buf = tp.trans->tx_buf;
+			u64 val = (buf ? buf[tp.byte/8] : 0x0);
+
+			/* use the length of delay from SPCR1_LSB */
+			if (bcm_qspi_has_fastbr(qspi))
+				mspi_cdram |= MSPI_CDRAM_DT_BIT;
+
+			write_txram_slot_u64(qspi, slot, val);
+			dev_dbg(&qspi->pdev->dev, "WR %llx\n", val);
 		}
-		mspi_cdram = MSPI_CDRAM_CONT_BIT;
+
+		mspi_cdram |= ((tp.trans->bits_per_word <= 8) ? 0 :
+			       MSPI_CDRAM_BITSE_BIT);
 
 		if (has_bspi(qspi))
 			mspi_cdram &= ~1;
@@ -813,9 +946,6 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 			mspi_cdram |= (~(1 << spi->chip_select) &
 				       MSPI_CDRAM_PCS);
 
-		mspi_cdram |= ((tp.trans->bits_per_word <= 8) ? 0 :
-				MSPI_CDRAM_BITSE_BIT);
-
 		write_cdram_slot(qspi, slot, mspi_cdram);
 
 		tstatus = update_qspi_trans_byte_count(qspi, &tp,
-- 
2.17.1

