Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2074E185765
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCOBhe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:37:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCOBhe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:37:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id y2so1391535wrn.11;
        Sat, 14 Mar 2020 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8rTQ0IClwX4HmkVqkn09uapHZa8iKCCdQ/w5jqdWFX0=;
        b=Ae2m+G1zbkPgLhiIQB4NGYgZsJZarLZSK/uYW5+MT3aw0hkpd6LUusnh+5TBzdhnEb
         1BGBJTIYAj5XsaSnv3JyDDjWpuAKr50mJegwAxVF6gVHedBNPQETb8TYjHJTTqDWBaqV
         k3QV896rVQPXnBeQr6m/mnX4llceLfvrU/L2K2DYYVwfBWRKbVcqI0ktBWH3OQayVctd
         WS1a6OMGj75MZkjlMxS5va7YCDIOVnOrOs9maWPQz6b+3Hwni/tf4XU6yJh+G0YG800S
         N6rUivb5YNN5MtSg4jRYsRdSLQvtxXno807RBQN7JbEZ2XnDDXVbGcRPbVtUfz2u69g7
         FHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8rTQ0IClwX4HmkVqkn09uapHZa8iKCCdQ/w5jqdWFX0=;
        b=DbGeD91oSlOlGvJtJ5apeCPjGyzDK1WNTQ8FqQ9hZp66Ds1EenA1U8Dzog+taSljdU
         QvTigfalruzOpLpP/VwW0e5IHzLGnUT60Itb/QJKzVRQ5jad7mC9QtoWrXlREsOzSD7H
         3f65l5DzfKwhmM3QjS5f/3B1WRxNrJ/Cinpl4tIq7LN+Y7Sm6m32bzx5EUlHASXwZUW8
         DKlWr3CdChs/cTURSHrSLGj2Q4V7ofjgW3nbq/h3X3FirxF7xJ3JGH7CBLpBYtgavBxh
         ADa/g5BCS2tZAbA1EKZc7xFUibHpekyzQjpGT2eZ+oHK/mNiYxmorvae8RMRUXqNcHpQ
         lqIg==
X-Gm-Message-State: ANhLgQ0tRYcmZyS7jDEnxzQYVe8btlTJvBt/UH1xgXB0Tg7qtewhN8AZ
        emckHyXsuIgp/2Gw0U6yjLZi6OkrvGc=
X-Google-Smtp-Source: ADFU+vsOPU5iXtGc4c5vLHVbG26F/KzISRMwd6S+1Pl4xvCyIqJRvAy6s6KTEGb7+32TGGMa0e8vFQ==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr26365240wrv.308.1584225843285;
        Sat, 14 Mar 2020 15:44:03 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:02 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 05/12] spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
Date:   Sun, 15 Mar 2020 00:43:33 +0200
Message-Id: <20200314224340.1544-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

dspi->words_in_flight is a variable populated in the *_write functions
and used in the dspi_fifo_read function. It is also used in
dspi_fifo_write, immediately after transmission, to update the
message->actual_length variable used by higher layers such as spi-mem
for integrity checking.

But it may happen that the IRQ which calls dspi_fifo_read to be
triggered before the updating of message->actual_length takes place. In
that case, dspi_fifo_read will decrement dspi->words_in_flight to -1,
and that will cause an invalid modification of message->actual_length.

Make the simplest fix possible: don't decrement the actual shared
variable in dspi->words_in_flight from dspi_fifo_read, but actually a
copy of it which is on stack.

Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 51224b772680..3ac004aa2abd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -765,8 +765,10 @@ static u32 dspi_popr_read(struct fsl_dspi *dspi)
 
 static void dspi_fifo_read(struct fsl_dspi *dspi)
 {
+	int num_fifo_entries = dspi->words_in_flight;
+
 	/* Read one FIFO entry and push to rx buffer */
-	while (dspi->words_in_flight--)
+	while (num_fifo_entries--)
 		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
-- 
2.17.1

