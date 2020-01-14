Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276C013B600
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 00:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgANXjM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 18:39:12 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51188 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgANXjM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 18:39:12 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 31006891AA;
        Wed, 15 Jan 2020 12:39:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579045150;
        bh=IeYUZ6EnMs2XBxd891SPVXMui9M9bja5/5RGY0S9fkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V61AWEYibvVCsvQju39chr+VZ3GqIFtUFc2nds6Ln/Mg/gZ27IaWrnomtMAxWzgIK
         vaGzlDTfZd2l46yOfl+NtvMTISomOmoa1r/yNiYZz/k0CLg+KznlnA9Z6yn6JjFQ8t
         63a8zOdGZ8jSNZzH8lzqZNZ8VTaSNNzwAH3WQh70eoT55UX+sl1HDKdZCEh7G6U26r
         zTiq1OdcEN6SAIUjPzx12++yi3A5qf/wW4LYNbQdA9r2eVSObteaGzOw/vFJJJSpBL
         MEqi0Bgtn9MtPdxhD0y4BKZvlyEeycc0FP4VbbZNo7fClLv4yRAblHORf7vci5zqMF
         jYC35LcCwFIVg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e1e511c0001>; Wed, 15 Jan 2020 12:39:08 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 36E0913EF0C;
        Wed, 15 Jan 2020 12:39:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 865AA280071; Wed, 15 Jan 2020 12:39:08 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anthony.derosa@syscall7.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
Date:   Wed, 15 Jan 2020 12:38:55 +1300
Message-Id: <20200114233857.25933-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200114233857.25933-1-chris.packham@alliedtelesis.co.nz>
References: <20200114233857.25933-1-chris.packham@alliedtelesis.co.nz>
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
 .../devicetree/bindings/spi/spi-mux.yaml      | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documen=
tation/devicetree/bindings/spi/spi-mux.yaml
new file mode 100644
index 000000000000..1026d03a69c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
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
+properties:
+  compatible:
+    const: spi-mux
+
+  mux-control:
+    $ref: "/schemas/mux/mux-controller.yaml#"
+
+required:
+   - compatible
+   - reg
+   - spi-max-frequency
+   - mux-control
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
+       spi-mux {
+         compatible =3D "spi-mux";
+         #address-cells =3D <1>;
+         #size-cells =3D <0>;
+         reg =3D <0>;
+         spi-max-frequency =3D <100000000>;
+
+         mux-control =3D <&mux>
+         mux-control-names =3D "spi";
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
+           compatible =3D "spidev";
+           reg =3D <1>;
+           spi-max-frequency =3D <10000000>;
+         };
+       };
+     };
--=20
2.25.0

