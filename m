Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250AD28EC5F
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 06:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgJOEqe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 00:46:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgJOEqe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 00:46:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCD3BC3150ACB8255FE8;
        Thu, 15 Oct 2020 12:46:28 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 15 Oct 2020 12:46:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] dt-bindings: misc: add support for both property names cmd-gpios and cmd-gpio
Date:   Thu, 15 Oct 2020 12:44:43 +0800
Message-ID: <20201015044443.1828-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201015044443.1828-1-thunder.leizhen@huawei.com>
References: <20201015044443.1828-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The definition "gpio_suffixes[] = { "gpios", "gpio" }" shows that both
property names "cmd-gpios" and "cmd-gpio" are supported. But currently
only "cmd-gpios" is allowed in this yaml, and the name used in
mmp2-olpc-xo-1-75.dts is cmd-gpio. As a result, the following errors is
reported.

slave: 'cmd-gpios' is a required property
slave: 'cmd-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
index b3c45c046ba5e37..dd549380a085709 100644
--- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
@@ -24,15 +24,21 @@ properties:
   compatible:
     const: olpc,xo1.75-ec
 
-  cmd-gpios:
+  spi-cpha: true
+
+patternProperties:
+  "^cmd-gpio[s]?$":
     description: GPIO uspecifier of the CMD pin
     maxItems: 1
 
-  spi-cpha: true
-
 required:
   - compatible
-  - cmd-gpios
+
+oneOf:
+  - required:
+      - cmd-gpio
+  - required:
+      - cmd-gpios
 
 additionalProperties: false
 
-- 
1.8.3


