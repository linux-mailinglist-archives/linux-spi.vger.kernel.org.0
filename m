Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B771F8CD7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 06:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgFOEGI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 00:06:08 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50529 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgFOEGG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 00:06:06 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9FE06891B1;
        Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592193957;
        bh=3cfAFYHU5BJxG56tepVZpAZxLjvCy9XsBWxa/cSrxSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a/U3scyjDp9kk7+DzU/JZRxhiSq5YSOtj5A+EUZB0hDoQp0v9IT01nMfXtxS1a8ry
         9q8NCDpRvkIQzZ71vOEFY9qrR97g5Iasx0geEk4V0c8xxgv/zX34sh3aTRLWe0mpzj
         X/AvcQ+y/nmKwc8fDAU5KsgYfMRKtE0gmZjxYQ1nUrBDO+lxXk4gZPTRoTAPRKjz9I
         9C2AxZjE6GTFIS7Q4QOQRIqC7V8w6xgqn4pk3k/dGUHHpWdrG3G7QfAYMAWgonLYM+
         QwQyQj0uSRmHXKLB9IIxIbm49khrAjB7GPnhM/G4Kv2cJTgkqGHPlQZ2oKksWsEBl5
         bsWLPtasJNTHg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee6f3a50002>; Mon, 15 Jun 2020 16:05:57 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 9EC4F13EDE4;
        Mon, 15 Jun 2020 16:05:56 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 50DA5341107; Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 2/5] spi: bcm-qspi: Improve debug reading SPI data
Date:   Mon, 15 Jun 2020 16:05:54 +1200
Message-Id: <20200615040557.2011-3-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch prevents device debug when data is not read from hardware
(i.e. when there is no receive buffer).

Reviewed-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 8fc5b9b3757b..92e04d24359f 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -749,21 +749,22 @@ static void read_from_hw(struct bcm_qspi *qspi, int=
 slots)
 	tp =3D qspi->trans_pos;
=20
 	for (slot =3D 0; slot < slots; slot++) {
-		if (tp.trans->bits_per_word <=3D 8) {
-			u8 *buf =3D tp.trans->rx_buf;
-
-			if (buf)
-				buf[tp.byte] =3D read_rxram_slot_u8(qspi, slot);
-			dev_dbg(&qspi->pdev->dev, "RD %02x\n",
-				buf ? buf[tp.byte] : 0x0);
-		} else {
-			u16 *buf =3D tp.trans->rx_buf;
-
-			if (buf)
-				buf[tp.byte / 2] =3D read_rxram_slot_u16(qspi,
-								      slot);
-			dev_dbg(&qspi->pdev->dev, "RD %04x\n",
-				buf ? buf[tp.byte / 2] : 0x0);
+		if (tp.trans->rx_buf) {
+			if (tp.trans->bits_per_word <=3D 8) {
+				u8 *buf =3D tp.trans->rx_buf;
+
+				buf[tp.byte] =3D
+					read_rxram_slot_u8(qspi, slot);
+				dev_dbg(&qspi->pdev->dev, "RD %02x\n",
+					buf[tp.byte]);
+			} else {
+				u16 *buf =3D tp.trans->rx_buf;
+
+				buf[tp.byte / 2] =3D
+					read_rxram_slot_u16(qspi, slot);
+				dev_dbg(&qspi->pdev->dev, "RD %04x\n",
+					buf[tp.byte / 2]);
+			}
 		}
=20
 		update_qspi_trans_byte_count(qspi, &tp,
--=20
2.27.0

