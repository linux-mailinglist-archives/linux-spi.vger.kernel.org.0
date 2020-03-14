Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D331858AD
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCOCSM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 22:18:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43383 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCOCSM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 22:18:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id dc19so17340864edb.10;
        Sat, 14 Mar 2020 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJ+RY29P5A3JmNUd+RYfkaMYIhrPtnZKpKcnzxMgng4=;
        b=AIQlqMfVJlN0HlyANWm0nSChXAKPt7/PzSrPhJsbEqjFRge+aDzgZhvs6Ien2kut/0
         0vUee8KBQHhcVRpoH1DhP2rZg1Yxpuf/DOs0aaj4payldQeDCyV/mUSjDDqcIGsYJrkh
         m/IqRrCyKU6iW4iyAdYlJ//gx+yM6znOMl1y9X3g63SGZQ+ZUUdfQoCbVShgUHf3NBRN
         UrO1B/gBqyYQUPFGMNXFEUw+qVqJP7zI1JheW4IgrZJKmvKLvRBYdM4fNNbWQMEDMar0
         gDSPyQyaKxJDT+ThhudfAWb5NIN7nyFD/DbzDrYteu77Xkl91n92sEkLHXRNk98hQ42w
         Wvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VJ+RY29P5A3JmNUd+RYfkaMYIhrPtnZKpKcnzxMgng4=;
        b=lVEP5gSbPymErp3VXp6MDUmpVqxZKH6gndjOoLzMM9XBvE/VSeYKN2gPVWx7OR6cE+
         bBzoJnav2hW0PCnYX+Eim0ddXB+0nzvwun0PxEv99ZIddVO7dBNVzQEDGg09nOmOh/jg
         czZj3h7/RuIwi06jglmFni0xJWEKEhKr2OYNpLwI8hpAkloWV2o46XZEOm0HSmdlTLgL
         JSb54jTkLF9nTZF1g9OWLSxfGxMdbb2KG+cTIshQh+1nDg26EIMLNR9EZP9bwiDsAFkr
         cXgwcPZK7QXiP4OEPtLap+WmkB8LY9QURs17WeZqRqmKKYYyd49s6Bi1lszTpmdB+Rt9
         dUEg==
X-Gm-Message-State: ANhLgQ1f/cj6kBRi6t1klSaopH/ielqvRAeViawaljZDEzpPxqBaQXNO
        MaK/954r0byMbYsjYUf5jS4zkNS7XCc=
X-Google-Smtp-Source: ADFU+vuj0pL5Ww/SuXqsYC+FIBzhjNsLjbKeBf77AQ5JP+yHyQGBqcpK7iOIx3za9aByLUgVWE1Aag==
X-Received: by 2002:a5d:5746:: with SMTP id q6mr584815wrw.83.1584225841940;
        Sat, 14 Mar 2020 15:44:01 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:01 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 04/12] spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
Date:   Sun, 15 Mar 2020 00:43:32 +0200
Message-Id: <20200314224340.1544-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

If dspi->words_in_flight is populated with the hardware FIFO size,
then in dspi_fifo_read it will attempt to read more data at the end of a
buffer that is not a multiple of 16 bytes in length. It will probably
time out attempting to do so.

So limit the num_fifo_entries variable to the actual number of FIFO
entries that is going to be used.

Fixes: d59c90a2400f ("spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8f2b73cc6ed7..51224b772680 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -739,13 +739,16 @@ static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
 	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	u16 xfer_cmd = dspi->tx_cmd;
 
+	if (num_fifo_entries * dspi->oper_word_size > dspi->len)
+		num_fifo_entries = dspi->len / dspi->oper_word_size;
+
 	dspi->words_in_flight = num_fifo_entries;
 
 	/* Fill TX FIFO with as many transfers as possible */
-	while (dspi->len && num_fifo_entries--) {
+	while (num_fifo_entries--) {
 		dspi->tx_cmd = xfer_cmd;
 		/* Request EOQF for last transfer in FIFO */
-		if (dspi->len == dspi->oper_word_size || num_fifo_entries == 0)
+		if (num_fifo_entries == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		dspi_pushr_write(dspi);
-- 
2.17.1

