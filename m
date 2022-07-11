Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B255D46F
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiF0Tlq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiF0Tlb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 15:41:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7F1705A
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i25so8975202wrc.13
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CI3fJo8A+eaieUlzNYpta6LCY7AsQa7tJxY+upYt5DU=;
        b=NCjs560wHII6fVECQB9/GdNlhvJNFE4pkOGLs8jP+UxuRPiuWEHK2RAq+jRyb7l21B
         lfShg0ET3/X/0mjEMGlwSBSEdfkuN/jOG4+hLlup2Q1NEGgyw8TvLXt6Sh1ng8wnUUF6
         ACyhrCvbH8GLUqGorfK03QyZ/EOUgFIIkp9U/rze0vaIL0pGtOjj0l2WGg8p0UVFtKdE
         2GtvloqzOeXu8KfiG3wMjVq/vAsjfcHvwx3Fvw+Z7IhEjjmeAf2mLbSlaMXjwCsQ5NF8
         F9+tVjwoFB7PMmDlGl56M6lK2Iw5z3M3LCYB6VBFZ/Gv2C7k/N+jEVee+9P4Wub30j/G
         soHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CI3fJo8A+eaieUlzNYpta6LCY7AsQa7tJxY+upYt5DU=;
        b=I/iR88Ufldpgrx0ueEsaqDWaBFqWZwGtbIpPf26FcC8v3keU+aaylkK/bGOOj3E0SA
         pkL4WY9iFMOYHP54Ea1CfZat97NAj0kqtgTnx5Sn+054QdF4OXB8Nqd+ZNZse2VcIuof
         f9lfdG4NcZIgzU67DPlzNNmbjZN2Iybqtk345WJpB6OC0sCAX8KE/B9hDYCDA3ktbeqG
         2A4WtUEc7AzM7wvW+fQ0DnMiPrEvq1e9sNUrf6aDqd6UiCwLcHnMejE2SwI5Oqv+koAx
         Gq4c+gcr5cp5eETWJXBP1dkr+CMwkqvO67l7GuCzsqEVbi/e/dLrbXh1+8Fh3YPHZd59
         +t4g==
X-Gm-Message-State: AJIora9QGNEXWVJTI093Eu7xmqLk1wGWiei8CDDq/hX2V3RB+tp1IvSV
        qPlUjxv4ngKmF+ncjIXqB1hBag==
X-Google-Smtp-Source: AGRyM1vB7FfkKSm2wSwW9aXIKCoZFOmSwRYKxi54RsU01e+Y3cIcwbXfb6XLRuYxVHKTOGWa9mvMRw==
X-Received: by 2002:a05:6000:18d:b0:21b:901e:9b27 with SMTP id p13-20020a056000018d00b0021b901e9b27mr14202414wrx.389.1656358887406;
        Mon, 27 Jun 2022 12:41:27 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:26 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 07/16] dt-bindings: memory-controllers: add canaan k210 sram controller
Date:   Mon, 27 Jun 2022 20:39:55 +0100
Message-Id: <20220627194003.2395484-8-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The k210 U-Boot port has been using the clocks defined in the
devicetree to bring up the board's SRAM, but this violates the
dt-schema. As such, move the clocks to a dedicated node with
the same compatible string & document it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I made myself maintainer since I didn't have anywhere else
to point a finger, but I am happy to let someone else take
that on!

The corresponding U-Boot code seems to be:
static int sram_init(void)
{
	int ret, i;
	const char * const banks[] = { "sram0", "sram1", "aisram" };
	ofnode memory;
	struct clk clk;

	/* Enable RAM clocks */
	memory = ofnode_by_compatible(ofnode_null(), "canaan,k210-sram");
	if (ofnode_equal(memory, ofnode_null()))
		return -ENOENT;

	for (i = 0; i < ARRAY_SIZE(banks); i++) {
		ret = clk_get_by_name_nodev(memory, banks[i], &clk);
		if (ret)
			continue;

		ret = clk_enable(&clk);
		clk_free(&clk);
		if (ret)
			return ret;
	}

	return 0;
}

Which, without having the hardware etc, I suspect is likely to keep
working after the move.
---
 .../memory-controllers/canaan,k210-sram.yaml  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
new file mode 100644
index 000000000000..837eb65854fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/canaan,k210-sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Canaan K210 SRAM memory controller
+
+description: |
+  The Canaan K210 SRAM memory controller is initialised and programmed by
+  firmware, but an OS might want to read its registers for error reporting
+  purposes and to learn about the DRAM topology.
+
+maintainers:
+  - Conor Dooley <conor@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - canaan,k210-sram
+
+  clocks:
+    minItems: 1
+    items:
+      - description: sram0 clock
+      - description: sram1 clock
+      - description: aisram clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: sram0
+      - const: sram1
+      - const: aisram
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/k210-clk.h>
+    memory-controller {
+        compatible = "canaan,k210-sram";
+        clocks = <&sysclk K210_CLK_SRAM0>,
+                 <&sysclk K210_CLK_SRAM1>,
+                 <&sysclk K210_CLK_AI>;
+        clock-names = "sram0", "sram1", "aisram";
+    };
+
-- 
2.36.1

