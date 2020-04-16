Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCED1ACEF1
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbgDPRnn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732560AbgDPRnj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C50C061A0C;
        Thu, 16 Apr 2020 10:43:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so5841522wmf.5;
        Thu, 16 Apr 2020 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VT7oTdX/J4WibqlSitG5Ze8BtxKf5ofSQPDu5bFcIAY=;
        b=fOgmbt24Fa/xv7ATQ9dhmpOd0y0QXDQQh0W/4CQEzpA6Pe01uxOJS1/7KvrkB9pkEa
         DzgqgT5+FzmdjalJIo8lJ1zyMBHp57w2ncsVIcBWDzgAulgIzDCKx8cr2ux1KpIx8xSD
         j7QujYdFFWMkrcYIxbLD2LOZIdw49nNw/L7FPGUDF8H2Cwyb6ANASGA3Har1oNw6T988
         hK1fh6IQKIb7KFKLPE8Rkf7uz/iSfMrX3VFIK3WiJfPNjPBBfg7ZBA6BmG5xCp5YW83C
         XkPlyjXd/dixiGWdo/5BgTjRPTSkBtFWQ84wTpGbuD9wCwIoBEB/siOPcMz7yrkxBXg6
         r50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VT7oTdX/J4WibqlSitG5Ze8BtxKf5ofSQPDu5bFcIAY=;
        b=PpJEJN/5wVUGIkL8972EPD5f+TMr4e/kwUChk4qqCv6yI+lR8xA4NWOpAiPXc8xEcS
         VQ8XeeU/W7/1CZ2fbPJc122xSg3u7Pe6+FDEAC+ue8jw47ckHTSNkTkearscskw0NKcy
         Tv2SfeYYSt6+9Xkd0G1QMZ2+KvuBjOc4FdLLDb4tsr4N6Ea1I9+j5kkvTsx74k/rf1WP
         Dt3QIcb0srkr8z41TM/iWzgPxqMSws9hHetWJJQS7EfoJs9WR82aDnBiPfWpq1EJCgjW
         lG0//b3viDWhdVm5TLd4I53Nzkx5efIFV+GY9JIK0t67Lf6+uErlP4tsD4vBFhlkfl98
         LCfA==
X-Gm-Message-State: AGi0PuZbVma6XxksOAOmWplwp9g6haTUrU+BkfE+KoilVeNk+IBH8RlH
        7/2cVH+QhgMeDB7lyZfWUzo=
X-Google-Smtp-Source: APiQypLo4NDGXDAu77RQZ+RaXOO40hdqk4TsG4dKky3/yxjnH0amcSxZ1bCC89R+4pQq1Iprl7f+7g==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr5651209wmj.125.1587059018163;
        Thu, 16 Apr 2020 10:43:38 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:37 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch 5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
Date:   Thu, 16 Apr 2020 13:43:05 -0400
Message-Id: <20200416174309.34044-5-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently we set the tx/rx buffer to 0xff when NULL. This causes
problems with some spi slaves where 0xff is a valid command. Looking
at other drivers, the tx/rx buffer is usually set to 0x00 when NULL.
Following this convention solves the issue.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c48c399dce53..e00208801c8b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -669,7 +669,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 			if (buf)
 				buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
 			dev_dbg(&qspi->pdev->dev, "RD %02x\n",
-				buf ? buf[tp.byte] : 0xff);
+				buf ? buf[tp.byte] : 0x0);
 		} else {
 			u16 *buf = tp.trans->rx_buf;
 
@@ -677,7 +677,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 				buf[tp.byte / 2] = read_rxram_slot_u16(qspi,
 								      slot);
 			dev_dbg(&qspi->pdev->dev, "RD %04x\n",
-				buf ? buf[tp.byte] : 0xffff);
+				buf ? buf[tp.byte / 2] : 0x0);
 		}
 
 		update_qspi_trans_byte_count(qspi, &tp,
@@ -732,13 +732,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 	while (!tstatus && slot < MSPI_NUM_CDRAM) {
 		if (tp.trans->bits_per_word <= 8) {
 			const u8 *buf = tp.trans->tx_buf;
-			u8 val = buf ? buf[tp.byte] : 0xff;
+			u8 val = buf ? buf[tp.byte] : 0x00;
 
 			write_txram_slot_u8(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
 		} else {
 			const u16 *buf = tp.trans->tx_buf;
-			u16 val = buf ? buf[tp.byte / 2] : 0xffff;
+			u16 val = buf ? buf[tp.byte / 2] : 0x0000;
 
 			write_txram_slot_u16(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
-- 
2.17.1

