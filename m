Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EED18317C
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCLNbq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:31:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46431 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLNbq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 09:31:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so7446547wrw.13
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLQxofLrrQufYfCzcz5A2fXA3LA5FXwNOEDuv3qZeb4=;
        b=L58sEGr8l+astd+Uyrn2GV7dFQ2zh9/AkvdoHOz5Dvh56QoyE33GsFMwfgPGxtgeVy
         rUyclAX12ZUzQamElKe3/1hQpBGyLKkSTotT4kN91veEu3xyTpu7bz/Ivb7ciVxgyXor
         AvjCWflJHeenQ0mdJNTTNrYGZGMIJGxo8nFsWkQFRJ9A4UD+/1ZZril2UyFUFCI5OZfJ
         8Aw8K23ii6LD2AS+X53x8DNvGfoEgBVjS9c0aR443i2O2+4CNzdxF/MgElCgG6H8BZ/2
         fW1/+HadDzP8Jebsefl3mJSxf0SQpVcTwkB1kqu0oOfN2U5ZqnAKhoBgaROGpwrIOgHM
         34BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLQxofLrrQufYfCzcz5A2fXA3LA5FXwNOEDuv3qZeb4=;
        b=TlzE+6oQLqGaCJtEm5qgfIpM6qEOzPh28bYqTy7DDIoxQOgMwgs7tjUkW2/XeV4JAF
         jTRzzu31DFtk6FmgP5hmlNfd/akS121ofeLcKDV2MMtHE2DtD5/bhCY3XpNYh/eY4HYg
         bPwyI1vt+NS0iYtN+cHuyUKbcal0XsLtLuwL40VgMwkOaWq7kIBAO55gKzMZMkcHZaBj
         PFJ1Sk0YRvJS7c2dzqc+sfRuY/+I5SaF/Jmb0muJF5o2kYlgOZUX8g0hlVICwc8tAGXi
         XcQxXo88g5wHnB3lKWQSWEp8Yj680nvQyXixvpFtZLk9e04DLusAtr5DVrWxqVc0Mwte
         5rTQ==
X-Gm-Message-State: ANhLgQ3YBEyuKLRaSuiPosHC5Y2kjkTLNLoL8zRJp8mNQbWDTjzq6pnG
        xZ96G17mULHWPUSQBN5iEEpKtQ==
X-Google-Smtp-Source: ADFU+vuvZ8Xr2ZYxfBXSZYjeBVUgJ6OKzbEwTh8X/QVkj+5XIR8vD4XV0pHiP+EDUSxcI//XSme66g==
X-Received: by 2002:adf:8182:: with SMTP id 2mr10608373wra.37.1584019902623;
        Thu, 12 Mar 2020 06:31:42 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] dt-bindings: spi: amlogic,meson-gx-spicc: add Amlogic G12A compatible
Date:   Thu, 12 Mar 2020 14:31:30 +0100
Message-Id: <20200312133131.26430-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Amlogic G12A SPICC controllers uses a secondary clock used to feed the
baud rate generator and the delay control logic.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 49b617c98ae7..9147df29022a 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -22,6 +22,7 @@ properties:
     enum:
       - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
       - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
+      - amlogic,meson-g12a-spicc # SPICC controller on Amlogic G12A and compatible SoCs
 
   interrupts:
     maxItems: 1
@@ -40,6 +41,27 @@ properties:
     items:
       - const: core
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,meson-g12a-spicc
+
+then:
+  properties:
+    clocks:
+      contains:
+        items:
+          - description: controller register bus clock
+          - description: baud rate generator and delay control clock
+
+    clock-names:
+      minItems: 2
+      items:
+        - const: core
+        - const: pclk
+
 required:
   - compatible
   - reg
-- 
2.22.0

