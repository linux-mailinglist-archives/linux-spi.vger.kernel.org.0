Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD00146046
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAWBY1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 20:24:27 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36155 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAWBY1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jan 2020 20:24:27 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 25550886BF;
        Thu, 23 Jan 2020 14:24:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579742665;
        bh=kmiDiaKiwZNr3ZUWD2bOHX6HuBV/rQF0LIqOia8udp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aDDTHRR4URHuZS3fjfF7HTgM8A8ts02wm/nzU8sO2/1+9l2wzyZafWNTT3a68ONbl
         ZHa4qo/B9UCiNLMSWvNiv0PrgN7vcugYrMPk7Lc8YF6w2sK8nSk4XmgzgDGOoYbMKV
         r+0zGkJEPTPYJoNA62iOBwT/NM/lz8tObaebPoiEmZ4l3akgWLL+S9lVAH7FivX3Uu
         tlgqRHeI/iR8ObyELObQKYXSYwmJ+AgDXsAfotgMPG3I+DxbO5cUTgl5qwQdYIo59i
         KvRnFk9FQutyDZRzPt8FF+ToKSIUAEfrznyzFSBK7HPGImm1dFgj6wEHBpDB529yiz
         sQ9pc3N4gm8Tw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e28f58c0001>; Thu, 23 Jan 2020 14:23:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 42B3213EF28;
        Thu, 23 Jan 2020 14:23:23 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A1F9E280071; Thu, 23 Jan 2020 14:23:24 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date:   Thu, 23 Jan 2020 14:23:16 +1300
Message-Id: <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz>
References: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz>
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
    Changes in v2:
    - update license
    - make dt_binding_check clean

 .../devicetree/bindings/spi/spi-mux.yaml      | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documen=
tation/devicetree/bindings/spi/spi-mux.yaml
new file mode 100644
index 000000000000..4bdb31e2257e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -0,0 +1,84 @@
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
+     mux: mux-controller {
+       compatible =3D "gpio-mux";
+       #mux-control-cells =3D <0>;
+
+       mux-gpios =3D <&gpio0 3 GPIO_ACTIVE_HIGH>;
+     };
+
+     spi {
+       spi-mux@0 {
+         compatible =3D "spi-mux";
+         #address-cells =3D <1>;
+         #size-cells =3D <0>;
+         reg =3D <0>;
+         spi-max-frequency =3D <100000000>;
+
+         mux-controls =3D <&mux>
+
+         spi-flash@0 {
+           compatible =3D "jedec,spi-nor";
+           #address-cells =3D <1>;
+           #size-cells =3D <1>;
+           reg =3D <0>;
+           spi-max-frequency =3D <40000000>;
+         };
+
+         spi-device@1 {
+           compatible =3D "lineartechnology,ltc2488";
+           reg =3D <1>;
+           spi-max-frequency =3D <10000000>;
+         };
+       };
+     };
--=20
2.25.0

