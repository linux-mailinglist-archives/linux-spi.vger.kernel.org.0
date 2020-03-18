Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1179F1892AC
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCRARY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43521 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgCRARW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id b2so21867548wrj.10;
        Tue, 17 Mar 2020 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8zpgtiG0w2opJ4PQ2uuwoYe8iOMFJzU+1DygKuJLws=;
        b=rvaJFHhGMAYFRsIhjMw3stPetGwHRLpuYoUup/pPcFMokhLv76eYrYuwsxXW82AThE
         Le7LTysiWqmJV5kGluDvnnSKUBhd3sUtY+sPsJKA/paMBl6Z/JhCqmG9gxcr5xVBe+QD
         OuqkjG9wCwe1YP9C0mpklSkUqMCmrIfDI33QF4wpadkrSveq/vZ8e8bSIFdIXQt7/dGZ
         ne5GEPP+l5lDukbrA6KAf++aoZFflGFAiyFa+j4wBHjaTcYxBUf8x+UbEJuHxET2UPSS
         awFjJXp1+075Xfx+l9T782jG0ZqrvDwIY1q65EnYEHYLau6P2gKXS00H/sWCTF3Vk9YE
         q9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e8zpgtiG0w2opJ4PQ2uuwoYe8iOMFJzU+1DygKuJLws=;
        b=P99Kb+MwHzB5xbH3ZA8rFUWkV+mWORLSmemHJtpMHZOFRHzhO6HL/T1lybbsHp1fdB
         WPjhdt7Re0bIAhQyaYpsL8BFATx9DiWul5WbwWxJZAmZM20lgVRwuRNyx2CfcyblTijo
         OMA5HCgQzw30y1Ytzd6w5a7Us4aFgTe657QeBzeIEGaHiCsXpTPF1/fVTAtLSn6oQUM7
         dV3GTkcTYIw6DAKsKQOSfCLYgJ6z2wJ0Fm+4gL8BCbNSGlTBBYrZx4w1o6A+9DRHzjbU
         0f3jSO9HyCFli7HE/3RTaP2Q8P/FDwiwbAQNuiZWgBrayTbtRZsOSgRl7CaPDeP1759v
         XMFA==
X-Gm-Message-State: ANhLgQ1JrOEum8KPoCEGhZ2W4ADXKlGQEonReVpteRSZFiLd1L4Oc+XJ
        8cIII/w68No1BhmTEmVxDAQ=
X-Google-Smtp-Source: ADFU+vsM/azJbIuB3F79HdGdu7i/oU05oFfDvB6gssRHXn6C51cOxUsILqywLikbctYCfzlYFZjxhQ==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr1508818wrn.375.1584490640603;
        Tue, 17 Mar 2020 17:17:20 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:19 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 10/12] spi: spi-fsl-dspi: Add support for LS1028A
Date:   Wed, 18 Mar 2020 02:16:01 +0200
Message-Id: <20200318001603.9650-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
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
Changes in v5:
None.

Changes in v4:
None.

Changes in v3:
Removed the dma_bufsize variable (obsoleted by 03/12).

Changes in v2:
Switch to DSPI_XSPI_MODE.

 drivers/spi/spi-fsl-dspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5873752a091e..50e41f66a2d7 100644
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
@@ -1050,6 +1056,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
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

