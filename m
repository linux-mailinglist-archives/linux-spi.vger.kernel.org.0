Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2714AB6A
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2020 22:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgA0VEa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jan 2020 16:04:30 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:41966 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA0VEa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jan 2020 16:04:30 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 74080886BF;
        Tue, 28 Jan 2020 10:04:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580159067;
        bh=6tDJYJw6qyBxE5gbUdGqb3erz1PiKAMuHxH5IXgdldk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xvqz3GAKf/YE1UGg4bgNHUGbWhGNNw2d4sbHc7k52JBfoW1yxSAMU/byQ2FRjW7D+
         kYYUSOZR8ZAyqMiiO3b4mbB6Tk7nX57fn4s8z1pnTuPIKoxlEVtLQ90thl7tpaQEfh
         sE9PXmCHC42ak3VXOZwiHh7MjjMZuKgTglcHdujHI3Cfn2eQFfVvHNOLgg4myb08ze
         +vFjzaTfQOC+UqlLieyxuk+fjVpGMMrFIfBATJ9iVulFmNov2t7zWE8XGBXnZeEGf4
         vWy36zR2SWpyhvAwS/7NtLpxnSDREag1ummTfpTKbwhYk8hnSVlQTINhOdqfPdHXCl
         V2OrlB3ob3yWg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e2f50560001>; Tue, 28 Jan 2020 10:04:27 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id D88AC13EFAE;
        Tue, 28 Jan 2020 10:04:21 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 12E3A280071; Tue, 28 Jan 2020 10:04:22 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date:   Tue, 28 Jan 2020 10:04:14 +1300
Message-Id: <20200127210415.5708-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200127210415.5708-1-chris.packham@alliedtelesis.co.nz>
References: <20200127210415.5708-1-chris.packham@alliedtelesis.co.nz>
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
---

Notes:
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

