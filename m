Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B0213B9E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jul 2020 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGCONt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jul 2020 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGCONt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Jul 2020 10:13:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41DC08C5DE
        for <linux-spi@vger.kernel.org>; Fri,  3 Jul 2020 07:13:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lx13so15735963ejb.4
        for <linux-spi@vger.kernel.org>; Fri, 03 Jul 2020 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6fo77lXw3Wa9Ww9ysq9BOqYKJ0fNyxAE2eRhCOsSNc=;
        b=OKtenahX3RzeHz8eqckt2hJeEJqyL5k8hpCH678eVcRrOhnqdlWxyAFhKYATSOB0rr
         nhVamSj3cgGMg4RJv9DhwGt7cjQB2phviZd5uqkRj4Dy1BUk2XdRjeoKeB1ICh8X7vG+
         vnd124ixlUqSg+RA9zuSbVE6eFj6ecr/sn0goROKMW3+ZqPBD1Q3SC1kXpAMXkd3kMxZ
         IKwP4dK3QHm+fv+XSt/nV4k8YLE36B0T08GfrAWjZOoKSaRDpwAo8JSm+iBJNkgbe5yg
         Y87QyianoelCcWVqFPg6RR/LhupB3jF2BGq4iMY50B/FGptRa5yZWsqEaub5kIFh9q4A
         DX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6fo77lXw3Wa9Ww9ysq9BOqYKJ0fNyxAE2eRhCOsSNc=;
        b=ljZbRdGVyHWPe1YJQvWQDdeow5N55E694UO1ppxdvf+rDl5fXBfeUiv/NjfYUH4anJ
         aB1PXpuTepihalpl1e47bSdZj7kYZwzbxy97MHreZTHK10dC+Y9F1FRObCBPRSzqfS9L
         2ZooA5H3ELz49ARhoXFDZmj6GS6rgz+dJLj/IlijSsJPBUlDx2s7knbGXK6uaVEK6Gbc
         WVIzwZhYA+7hvanmIRSHa+A9DoDUJZdbdFnfB5883+cAjgUHJRNTvhUb+895WB7rMCp6
         NDoEYPBsLlZTWVZmTj7jStqopxDLfnxEYU4KxWS+fHWiytWD09iaSB1bwik7uq4SV2Mz
         EvwA==
X-Gm-Message-State: AOAM533NCfrmUHts1HmkOEoywBoD4Q3fX38yY4a17kQdZglIpp/brfhc
        hi/USVCmWpt/oomjWsXwnvxFJVQbvQ==
X-Google-Smtp-Source: ABdhPJyRbLYq9MEV45zJu8f3bC63LdbzZNthVYMD8yE5KmqCDZGYe0DAPkSM9ywGumepqy5UggEOCQ==
X-Received: by 2002:a17:907:1059:: with SMTP id oy25mr34700449ejb.90.1593785627461;
        Fri, 03 Jul 2020 07:13:47 -0700 (PDT)
Received: from localhost.localdomain (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id be2sm12745741edb.92.2020.07.03.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 07:13:47 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de,
        Adrian Fiergolski <adrian.fiergolski@fastree3d.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: Add documentation for SPI daisy chain driver.
Date:   Fri,  3 Jul 2020 16:12:44 +0200
Message-Id: <20200703141246.17281-2-adrian.fiergolski@fastree3d.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703141246.17281-1-adrian.fiergolski@fastree3d.com>
References: <20200703141246.17281-1-adrian.fiergolski@fastree3d.com>
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

