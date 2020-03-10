Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9248417FD24
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgCJM4A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 08:56:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52110 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgCJM4A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:56:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so1283995wme.1;
        Tue, 10 Mar 2020 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+42PHEu2nzu+7aU3KuglcC8e8R1+npX/kGMj4laVVPo=;
        b=ievYGuImn8W/Xz5H1brEG0ti8LVpmS9U0yDebUXjEh7ZBc6K8XrJXNucFPjaXzYjAs
         cnNCgPG/O+8sReBqqWY7v8lZs4PsYiiegeKvwL8H3T7OR5xWm8bqPBla5anQe9azOqjN
         wCyMwEoMx/Es/1JUIpiikPkA8SXMshl93gR998hyp25C39Pr1EnU8PRmiX6STuMztMb9
         tXMsTOJAOCM1xIWBXOuX4X1MnrfrLjbrOnscA09ETbjF0fWPZMvCWxDf/sJsm0xqe/I1
         CzeOI5Vu2T3GC4kiyoEs9uv3lU5LZtZ/TjF4nylr6jcJstWcFKaEw00J5UpbLTr0erql
         e9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+42PHEu2nzu+7aU3KuglcC8e8R1+npX/kGMj4laVVPo=;
        b=jXl3p95LqX7JKH0CIzIqQi/Z2zIXBr+xJ/6m9eVvsQAAFO5cF4jd5uKJn4nBl32zen
         etYvAXr3l8ueaNDYXJGo6v5K/KHJNx7v99HvaUehaq99LshkNwKJKWtC/MPgWV93xqbI
         U+SYdr2Tb8VhN+hcUMCloEvfYV5hZFWnTJtvD0Pn4b2Qz/E4nirOfFWHEssFpKUNwcLM
         e32TqeAuGuXO9Fe3FQykjI/voYBzL92r4JA/kMKtYpybLcv7k4vuSNEviGU+sMD4pbBq
         c7xUoqiyA32fa3EmyoGUMo0LopkYVZa9tfp1d4YE4EbR1aS5xEQR3SSzBFbhieTZr8Tg
         HeSg==
X-Gm-Message-State: ANhLgQ37PF9C4Joyyiaq/MF3KfZz+tnwT9zEV+wmNPmqaoFK9R1XDg8G
        HgTmv3rp7zojzcx4d8lmhRU=
X-Google-Smtp-Source: ADFU+vssI3snvYLDt64fQ12Iv00nSeq9e551GRAKRZ0Pjqb0f/yUw5mTVLEhaeiJiniGO6MErnpaow==
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr2038917wmn.31.1583844957697;
        Tue, 10 Mar 2020 05:55:57 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 5/7] spi: spi-fsl-dspi: Add support for LS1028A
Date:   Tue, 10 Mar 2020 14:55:40 +0200
Message-Id: <20200310125542.5939-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is similar to the DSPI instantiation on LS1028A, except that:
 - The A-011218 erratum has been fixed, so DMA works
 - The endianness is different, which has implications on XSPI mode

Some benchmarking with the following command:

spidev_test --device /dev/spidev2.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 20000000

shows that in DMA mode, it can achieve around 2400 kbps, and in XSPI
mode, the same command goes up to 4700 kbps. This is somewhat to be
expected, since the DMA buffer size is extremely small at 8 bytes, the
winner becomes whomever can prepare the buffers for transmission
quicker, and DMA mode has higher overhead there. So XSPI FIFO mode has
been chosen as the operating mode for this chip.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v3:
Removed the dma_bufsize variable (obsoleted by 4/7).

Changes in v2:
Switch to DSPI_XSPI_MODE.

 drivers/spi/spi-fsl-dspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8f5d18dc78d5..fd1f04b996f7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -124,6 +124,7 @@ struct fsl_dspi_devtype_data {
 enum {
 	LS1021A,
 	LS1012A,
+	LS1028A,
 	LS1043A,
 	LS1046A,
 	LS2080A,
@@ -151,6 +152,11 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
+	[LS1028A] = {
+		.trans_mode		= DSPI_XSPI_MODE,
+		.max_clock_factor	= 8,
+		.fifo_size		= 4,
+	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
@@ -1112,6 +1118,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 	}, {
 		.compatible = "fsl,ls1012a-dspi",
 		.data = &devtype_data[LS1012A],
+	}, {
+		.compatible = "fsl,ls1028a-dspi",
+		.data = &devtype_data[LS1028A],
 	}, {
 		.compatible = "fsl,ls1043a-dspi",
 		.data = &devtype_data[LS1043A],
-- 
2.17.1

