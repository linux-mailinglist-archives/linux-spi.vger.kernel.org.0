Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEE2154A7
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGFJXe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgGFJXe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 05:23:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF54C061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 02:23:34 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so41615864ejc.8
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2020 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6fo77lXw3Wa9Ww9ysq9BOqYKJ0fNyxAE2eRhCOsSNc=;
        b=YSXvQNgxeN2qzLB+St45pcHZ/m81Pnb4zyDkQ6gegeYhVS1FY7bXxEqEocf0voPJJU
         HKbqdCgjSddYDNZftx5Un7qw+elwZ3E/9wFERFyGKgxYtvL/QeAbUXnaPMSSjUEKKSRJ
         HqT+QsznvXgR15DfoNIvc3SClvGwGQuyZ3bWPD1o4r31Lv7hvUCd9UClHA0NgMz/O/VQ
         WJ8ukwPCwe6sn0vYfvKiIEYbr1B9mOYJCZSbnBIudMeL+lABv8K3O4E6YTLeJwBn4ZM7
         2oisQMY8CXbrLw6VA96xX+P8O9XZk2fSJ3UWaMLalEY0QbKifD7Y8RdZ86AsSynSuqE0
         hhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6fo77lXw3Wa9Ww9ysq9BOqYKJ0fNyxAE2eRhCOsSNc=;
        b=ip4s/1mz3k0H/sgUhO4rKVyrrxTlI4MrDkZR/oeskSgIeVmyIspvH9DdzZ0Z8hWmzn
         T56ulU8RDsYUIrSpmcAYCb0wGiIrPLGxuieaStxEqsQXhkksymrGuXfPCITYYoYZAXPO
         peagQjcbTTIxNyTVGrLLArWDMZKBpEMIB0Tu8ONjRkMbCa4y0Ho/49OZDMtpiMH6L5Rc
         xt/ADTrgqc1Sbzx5p8q3eBhTbv2uc+uQ1LizjS6koN+IU+Ld86l8GfkeZEZdBheYqPwN
         GyxOPDy3hSANRbh4qZIVwqVO8zcjfieZptSWvB9W3ycdzLibL6NzM/I7fBLPSOsqwrF+
         qfEg==
X-Gm-Message-State: AOAM533RhdtAF3c7G4PBCV4Ix/XAhGpUBeCo3Nra2vC0664sg4vfllYC
        9PjpuPmOJjOE4inRfPSHcVAM
X-Google-Smtp-Source: ABdhPJwpyAHaCGzluPP24M/BnJk1LROk9XKUZIbY7we5jc8pngCTX3YsRtf++tZzjXF0rmbzFu2NIg==
X-Received: by 2002:a17:906:dbcf:: with SMTP id yc15mr32612198ejb.222.1594027412796;
        Mon, 06 Jul 2020 02:23:32 -0700 (PDT)
Received: from localhost.localdomain (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id bm21sm15895244ejb.13.2020.07.06.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:23:32 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de,
        Adrian Fiergolski <adrian.fiergolski@fastree3d.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy chain driver.
Date:   Mon,  6 Jul 2020 11:22:44 +0200
Message-Id: <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add documentation for SPI daisy chain driver.

Signed-off-by: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
---
 .../bindings/spi/spi-daisy_chain.txt          | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-daisy_chain.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
new file mode 100644
index 000000000000..1e5b046dda83
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
@@ -0,0 +1,56 @@
+spi-daisy_chain : The driver handling SPI daisy chains.
+-----------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "spi,daisy_chain"
+- reg			: Chip select assigned to the chain
+
+  For the SPI devices on a common SPI chain - nodes of daisy_chain):
+- spi-daisy-chain-len  : Length (in bytes) of the SPI transfer,
+		         when the SPI device is part of a device chain.
+- spi-daisy-chain-noop : Byte string of no-operation command which should
+		         be send when device is not addressed during the
+			 given SPI transfer
+
+Optional properties:
+  (for the SPI devices on a common SPI chain (nodes of daisy_chain):
+- spi-daisy-chain-bits_per_word : no-operation transfers involve
+                                  one or more words; word sizes like
+				  eight or 12 bits are common.
+				  In-memory wordsizes are powers of two
+				  bytes (e.g. 20 bit samples use 32 bits).
+				  If not defined, it is assumed to be 8.
+
+The daisy chain is a virtual device represented as a regular SPI device. Its
+nodes define physical devices available on the chain. The order of the nodes
+defines the order of the physical devices on the chain: MOSI pin of a device
+represented by the first node is the last one on the MOSI daisy chain. The
+daisy-chain functionality is transparent to the drivers of the physical devices
+on the chain. All nodes share SPI mode, chip select and a max speed of the
+virtual daisy chain device. Once one of the physical devices is being accessed,
+the spi-daisy_chain driver combines this data with no-operation commands of all
+other devices on the chain.
+
+Example:
+
+	daisy_chain0: daisy_chain@0 {
+	        compatible = "spi,daisy_chain";
+		spi-max-frequency = <10000000>;
+		reg = <0>;
+
+		dac0: ltc2632@0 {
+	              compatible = "lltc,ltc2634-l12";
+		      spi-daisy-chain-len = <4>;
+		      spi-daisy-chain-noop = [00 F0 00 00];
+		};
+		dac1: ltc2632@1 {
+	              compatible = "lltc,ltc2634-l12";
+		      spi-daisy-chain-len = <4>;
+		      spi-daisy-chain-noop = [00 F0 00 00];
+		};
+		dac2: ltc2632@2 {
+	              compatible = "lltc,ltc2634-l12";
+		      spi-daisy-chain-len = <4>;
+		      spi-daisy-chain-noop = [00 F0 00 00];
+		};
+	};
-- 
2.27.0

