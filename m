Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C524E2C1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 23:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHUViV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 17:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHUViT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 17:38:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D7C061573;
        Fri, 21 Aug 2020 14:38:19 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id df16so2734982edb.9;
        Fri, 21 Aug 2020 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gfug6M3OOZNJ6q8sApGDCaMBquL65QMuLFdwuuumNZA=;
        b=jJ6eae3Ww+WWoXwtlu8P2VejAtCwIbkp1hM5FMDc4Zr/kaCcCRojMR7zI4Nhg7+yZW
         ZBUofAil656eC9j0w0jL4lQVktpXNTm05+a2ZfkTTtBRkzXILrphQ69mH2Y28fQaMKU7
         XRkWX/qyM33hcafGbIWzqz/FLGx5uvF64S5hv+B8feCw/QnKRBm9XsVSv/lAF1HqAoPx
         Nh8SsXOgRvY+bGlhLpVMb3UuEhSy6pe1wYrVDTTqQPn1w6xxDLEsPSECpGSIukXGZYy0
         D16/cbrmQ1yMi3uHC/qqCp0MchMfEEp6GCnqYmGe3tyQedwhCyCamdjMhAwMm2gxSHU8
         dDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gfug6M3OOZNJ6q8sApGDCaMBquL65QMuLFdwuuumNZA=;
        b=iZlnEgO9Nc+bhNpX6kuoPeGrP/1TlVqDPlEi5IMm+QEMavk8/TZpXOZ86X9syJKJmF
         pKmTO9GInRB/tlAN/Q/lwqSbbSZF8VbtVKm/val5z1V68SukWwFDmyy/5Fl+uEO25qam
         4mXi2aNB2219cA91fgHUBadZYlZyK+YBzSwR8PHvX+0Rolazd1AsA8F+MPIZZ1KO6F26
         8pGU5NwfxQ5v/bYpclV11QWGbLocGVUtiImwOLQaQqZhXlVLvEOv4OPzZBVH7aWFtX2o
         4RqnjTwxLGykBQtE0vv5xAZXY2N6ExCxZ27MqExmHyWrHOJ7SkOFR5PZ1zXoQ0UVFUGn
         a+MQ==
X-Gm-Message-State: AOAM530eor/mAKMkFp2QNDB1mdHUx31pCL7I3tgXUVBIkIqzAnLNDr3P
        PPC62UcZ/B/8xHmtDPfyLzw=
X-Google-Smtp-Source: ABdhPJx9SolUSPU3K4hQ7fAGjLqRUXTKmcwsXFEYs/qMrfvB/XNPni7gUXanVwnJeBE6tcmYRQWomg==
X-Received: by 2002:a50:935a:: with SMTP id n26mr4858258eda.107.1598045896089;
        Fri, 21 Aug 2020 14:38:16 -0700 (PDT)
Received: from localhost.localdomain ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id cq1sm1775762edb.95.2020.08.21.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:38:15 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself as maintainer for spi-fsl-dspi driver
Date:   Sat, 22 Aug 2020 00:37:53 +0300
Message-Id: <20200821213753.3143632-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since I've introduced a fairly large diff to this driver since tag v5.4,
I would like to avoid breakage for my use cases by getting a chance to
be copied on newly submitted patches.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..d29fa11d7742 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6884,6 +6884,14 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/dma/fsldma.*
 
+FREESCALE DSPI DRIVER
+M:	Vladimir Oltean <olteanv@gmail.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+F:	drivers/spi/spi-fsl-dspi.c
+F:	include/linux/spi/spi-fsl-dspi.h
+
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 L:	netdev@vger.kernel.org
-- 
2.25.1

