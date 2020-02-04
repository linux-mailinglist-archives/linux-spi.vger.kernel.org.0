Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55138151493
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 04:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDD2y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 22:28:54 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54309 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDD2y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 22:28:54 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 35245886BF;
        Tue,  4 Feb 2020 16:28:47 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580786927;
        bh=S12NbNvzyitASYeuyiRTGlWzIthLnwLfrSqRKnQYHxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DYgC15CL/HBZUXollf40qLbO9WZA+CaaBboFwwZw2DCS0r3VDSzOtOH6lFCrc1Wxg
         cT8OBwCtXNrA/kRm7x48sZe8HOblOKv7lUh+AzjOyxujEY9Li/u6hXcWut5rpFQOVR
         lo1Adbc4VRF/t4/yHDz6gC1B033g4O6nw5Q9LbGSAw79OdfEeFJDkGZ00xPgAHhmJo
         JPG9u86Eb83Hfyyt9LgfevNmfBTzkLo6P2nR0gTrp6YHvUZyypyNeGbOZlg1eIY73F
         k4/YOXnmX8sc6QuNagQFoi/KPLYQoA/vIvGh4JbHjg9ngOYb4eGxyZj5xu9sV0a9fF
         Z1jyvF0UuncBw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e38e4e90001>; Tue, 04 Feb 2020 16:28:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 880DE13EEFA;
        Tue,  4 Feb 2020 16:28:41 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id B4513280071; Tue,  4 Feb 2020 16:28:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date:   Tue,  4 Feb 2020 16:28:37 +1300
Message-Id: <20200204032838.20739-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204032838.20739-1-chris.packham@alliedtelesis.co.nz>
References: <20200204032838.20739-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add binding documentation for the spi-mux driver. This allows a generic
multiplexer to be used to provide access to multiple SPI devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v5:
    - Add reviewed-by from Rob
   =20
    Changes in v3:
    - make dt_binding_check clean (properly this time)
   =20
    Changes in v2:
    - update license
    - make dt_binding_check clean

 .../devicetree/bindings/spi/spi-mux.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documen=
tation/devicetree/bindings/spi/spi-mux.yaml
new file mode 100644
index 000000000000..0ae692dc28b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SPI Multiplexer
+
+description: |
+  This binding describes a SPI bus multiplexer to route the SPI chip sel=
ect
+  signals. This can be used when you need more devices than the SPI cont=
roller
+  has chip selects available. An example setup is shown in ASCII art; th=
e actual
+  setting of the multiplexer to a channel needs to be done by a specific=
 SPI mux
+  driver.
+
+        MOSI /--------------------------------+--------+--------+-------=
-\
+        MISO |/------------------------------+|-------+|-------+|-------=
\|
+         SCL ||/----------------------------+||------+||------+||------\=
||
+             |||                            |||      |||      |||      |=
||
+      +------------+                        |||      |||      |||      |=
||
+      | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+=
++-+
+      |      |||   |                      | dev |  | dev |  | dev |  | d=
ev |
+      |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--=
+--+
+      |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        =
|
+      |   +------+ |       +--+---+\\\-------/   CS-1 |        |        =
|
+      |            |          |    \\\----------------/   CS-2 |        =
|
+      |   +------+ |          |     \\-------------------------/   CS-3 =
|
+      |   | ?    +-|----------/      \----------------------------------=
/
+      |   +------+ |
+      +------------+
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    const: spi-mux
+
+  mux-controls:
+    maxItems: 1
+
+required:
+   - compatible
+   - reg
+   - spi-max-frequency
+   - mux-controls
+
+examples:
+   - |
+     #include <dt-bindings/gpio/gpio.h>
+     mux: mux-controller {
+       compatible =3D "gpio-mux";
+       #mux-control-cells =3D <0>;
+
+       mux-gpios =3D <&gpio0 3 GPIO_ACTIVE_HIGH>;
+     };
+
+     spi {
+       #address-cells =3D <1>;
+       #size-cells =3D <0>;
+       spi@0 {
+         compatible =3D "spi-mux";
+         reg =3D <0>;
+         #address-cells =3D <1>;
+         #size-cells =3D <0>;
+         spi-max-frequency =3D <100000000>;
+
+         mux-controls =3D <&mux>;
+
+         spi-flash@0 {
+           compatible =3D "jedec,spi-nor";
+           reg =3D <0>;
+           #address-cells =3D <1>;
+           #size-cells =3D <0>;
+           spi-max-frequency =3D <40000000>;
+         };
+
+         spi-device@1 {
+           compatible =3D "lineartechnology,ltc2488";
+           reg =3D <1>;
+           #address-cells =3D <1>;
+           #size-cells =3D <0>;
+           spi-max-frequency =3D <10000000>;
+         };
+       };
+     };
--=20
2.25.0

