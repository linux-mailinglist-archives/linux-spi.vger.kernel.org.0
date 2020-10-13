Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBD28D1C5
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbgJMQJV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 12:09:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731483AbgJMQJR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 12:09:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE4C2F614FBB78638DEE;
        Wed, 14 Oct 2020 00:09:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 00:09:03 +0800
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
Subject: [PATCH 6/6] dt-bindings: misc: correct the property name cmd-gpios to cmd-gpio
Date:   Wed, 14 Oct 2020 00:08:45 +0800
Message-ID: <20201013160845.1772-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201013160845.1772-1-thunder.leizhen@huawei.com>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
cmd-gpio.

arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
index b3c45c046ba5e37..c7a06a9650db2ed 100644
--- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
@@ -24,7 +24,7 @@ properties:
   compatible:
     const: olpc,xo1.75-ec
 
-  cmd-gpios:
+  cmd-gpio:
     description: GPIO uspecifier of the CMD pin
     maxItems: 1
 
@@ -32,7 +32,7 @@ properties:
 
 required:
   - compatible
-  - cmd-gpios
+  - cmd-gpio
 
 additionalProperties: false
 
@@ -49,7 +49,7 @@ examples:
       slave {
         compatible = "olpc,xo1.75-ec";
         spi-cpha;
-        cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
+        cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
       };
     };
 
-- 
1.8.3


