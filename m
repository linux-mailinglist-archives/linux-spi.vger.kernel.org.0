Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A25175151
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 01:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCBAUM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 19:20:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41998 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCBAUM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 19:20:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id z11so1583000wro.9;
        Sun, 01 Mar 2020 16:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jwhY+knTdQifg64CQcyFlmXWmsjzGep6/zqhcI9bJvM=;
        b=UEYXrGzkRs5DtYBt/rn6AQsmMC/2Z9xKSVunv1RGBVw6cAikyysRPrb65690a71+bs
         kWztWGQTn33hcIcRINH81JDbnieZvQ0r4aUruqit/laHDkzI1G203Pf4RQBnTx6Jbihd
         musKu5Lq4Ur7mkf3+urjMjin/dxeqbd9SEfrNp4cSXV3YikI3jrQ7sR2dkw89TxZdo68
         o7wu2taZdQXEXPC1+QYjPKUkRMN03MCqWjcNW2UclCfnsQN8LX5139Eo9iALtz8IWeyl
         YKBNk4tinRBG3PTXOUDWSI9mIpqlmnBS7srQDebEfcZWG1xdaDwav3w2pVXt+9JQgrJZ
         xofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jwhY+knTdQifg64CQcyFlmXWmsjzGep6/zqhcI9bJvM=;
        b=bI3osHsFzwpRMSJCWDnKNz/26KLuBk2cghUbIKZljCYffhQzt19rW5xrBD13damtai
         44/3bUzgKAsIabo+5vL6adQ7w8Pvas1lGU75pKtN1Kvf0mvbi04FGoa68riCw8LDq8Bn
         hV/tM308gDCUjYT6dFmlNUcZR1+MLOOH9r8beGIwNyZ72Zeci0AVEfgmN81YN1jZIvv8
         lRyR7p6UxpBSciuavh9VjdqGni3u+LgfSavEZBylOiOovKmzC5b3gQnmtnH2oEO8NW9/
         3tv17qtdG6YKD2ksV/eckQ4/ckQF3DtEOY+eujnMjoyo0Z0DZPNpWz2W2CosceNz7lfx
         fb+A==
X-Gm-Message-State: APjAAAUvm47VvNZw1dKdZl7fODcurHI8uaCALAnavlHm25JM3VOBy/ME
        JhzuCmzD5pvpKNMNvCO/1BcF/2bM
X-Google-Smtp-Source: APXvYqxv7k5QTum7D+PAa3XIZQelSvxMB/afGjTLGnBe6kljV+v8gm3/OqrURI0kfLQ52cz1sJg4Zg==
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr17152540wrn.131.1583108410561;
        Sun, 01 Mar 2020 16:20:10 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:10 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] doc: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs
Date:   Mon,  2 Mar 2020 02:19:53 +0200
Message-Id: <20200302001958.11105-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Make the second compatible string optional for LS1012A, LS1088A and
LS2080A. Old versions of the spi-fsl-dspi.c driver still need to probe
on the old, generic compatible string for these controllers (such as
"fsl,ls1021a-v1.0-dspi") which provides less functionality.

Document the device tree bindings for LS1043A and LS1046A, whose
bindings are already in use in fsl-ls1043a.dtsi and fsl-ls1046a.dtsi.

Introduce new compatible strings for LS1028A and LX2160A. There will be
no second compatible string for these.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../devicetree/bindings/spi/spi-fsl-dspi.txt    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 162e024b95a0..99b94cfe1623 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -1,12 +1,17 @@
 ARM Freescale DSPI controller
 
 Required properties:
-- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
-		"fsl,ls2085a-dspi"
-		or
-		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
-		"fsl,ls1012a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
-		"fsl,ls1088a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
+- compatible : must be one of:
+	"fsl,vf610-dspi",
+	"fsl,ls1021a-v1.0-dspi",
+	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1028a-dspi",
+	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
+	"fsl,ls2085a-dspi",
+	"fsl,lx2160a-dspi",
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
 - clocks: from common clock binding: handle to dspi clock.
-- 
2.17.1

