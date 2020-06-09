Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594471F417B
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgFIQz6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 12:55:58 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:47362 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbgFIQz5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jun 2020 12:55:57 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49hGTk6GYmzKmhw;
        Tue,  9 Jun 2020 18:55:54 +0200 (CEST)
Authentication-Results: hefe.heinlein-support.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1591721753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j7Bl0e/NNgBksh6phq/ZeF/FFbH797+bKn2Kamf4oqw=;
        b=JJDTCht9yz33nts07y6Sn5sCv9jPSgwxEyVW8LooI1WFFxUrSymVvrihW3wPUIpwHFV724
        JpgZPYGrlyzRTjQF6DFwP8TAHu4p3d7fS98hczoEDPQo2ws2psrQSd6ZIZKaWvT1qwixoO
        akOBZtX5yoBIxY/8h/eaINUPJnJJPzynla8XGhS6CFJ31pXShZ+B+fjwKkxUfHYWKQRodQ
        31Kn4BhdqhYXfSOOu6t/elsAbSaeGSGWvwtcZ8SmTRtpqSNcFZz6jFqyk+gh1K1MZiSvWU
        26UfxhLn+ITqOAtcwgwRBFl5KcckmmhRz80TWBw8cG6OMEht4Wlqv6zrp24epQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received; s=mail20150812; t=
        1591721750; bh=+NSaqjpCbS41rHQqGIN0xjmkj6DIbcJlPX1xQbzYjGc=; b=l
        sYJ0+yH4epSS2hnDVbXx3ZI+wcHgyf24ERXrR2EjgjZfFUQncTj55uvK2rMheySb
        UYS0V/FoHAK4fY31SW4Wl6BPeEKdLXCpzw3AbHBiqE2uY8DCjLtbcVlMPan7qrkN
        zbP0TURvmld/GrerxafQt+BIM9KGM0dIqITAMJMaHgsxgVgrS9u5NaKKdJKgQCuX
        i8bs7cDy5Aiel/6CHq0yststTk16XKlx1JFr5yklIyyN9BiVRf1Oa879Gfo/iBO4
        VsitGoV7Vckg/HPLk2wPfYsqCWkFwYLQ6mrXTGulf0p87KGZcAyqRrOmiVydzJbn
        BZS4X2AQikwSoOLYHOjoA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id nGIsqmsi5gm7; Tue,  9 Jun 2020 18:55:50 +0200 (CEST)
From:   Alexander Stein <alexander.stein@mailbox.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Alexander Stein <alexander.stein@mailbox.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] spi: dt-bindings: amlogic, meson-gx-spicc: Fix schema for meson-g12a
Date:   Tue,  9 Jun 2020 18:55:27 +0200
Message-Id: <20200609165527.55183-1-alexander.stein@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C097A1761
X-Rspamd-Score: 0.89 / 15.00 / 15.00
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This fixes the following warning during dtbs_check:
---
spi@13000: clock-names: Additional items are not allowed ('pclk' was unexpected)
spi@13000: clock-names: ['core', 'pclk'] is too long
spi@13000: clocks: [[2, 23], [2, 258]] is too long
spi@15000: clock-names: Additional items are not allowed ('pclk' was unexpected)
spi@15000: clock-names: ['core', 'pclk'] is too long
spi@15000: clocks: [[2, 29], [2, 261]] is too long
---
Conditional schema properties don't overwrite others. Instead of
restrictions have to be validated. So general clock amount is 1-2 and
depending on the actual device type limit the mount to 1 or 2.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 9147df29022a..38efb50081e3 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -34,12 +34,15 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: controller register bus clock
+      - description: baud rate generator and delay control clock
 
   clock-names:
-    description: input clock for the baud rate generator
-    items:
-      - const: core
+    minItems: 1
+    maxItems: 2
 
 if:
   properties:
@@ -51,17 +54,22 @@ if:
 then:
   properties:
     clocks:
-      contains:
-        items:
-          - description: controller register bus clock
-          - description: baud rate generator and delay control clock
+      minItems: 2
 
     clock-names:
-      minItems: 2
       items:
         - const: core
         - const: pclk
 
+else:
+  properties:
+    clocks:
+      maxItems: 1
+
+    clock-names:
+      items:
+        - const: core
+
 required:
   - compatible
   - reg
-- 
2.27.0

