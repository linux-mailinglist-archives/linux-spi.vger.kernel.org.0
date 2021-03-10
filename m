Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5373B3339E5
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhCJKYa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 05:24:30 -0500
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:59744
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhCJKYY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Mar 2021 05:24:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RynxEMM7CWTPaiNMTRKc8TnXCgMzrAPnUHe+J4eRsf3iwipxZxyQ08WJn30JYMhoRUmFf8dv9bMps3pqy3sFyAeeAPPbld5T4zHxQC08zv0yTpoJFuZ1LEB9j5CHmox8y4Os/F9SqwygWFqnN/wkKXgFqr4HMj+1+nWLCxxciaJyle5ZpQ9oNU6G6I32yFthD0U5wFrlU3oLT04MZEWmHoEjCdMey8jaeDeN+B5HTJFBi22PEkrCmuYYfzrk0ygoC8FhNt0uWV/unMs7UTI0/of3eQsEEb/xDPqeL0HbZT74muEXYpd/KQkEGXDUjDwumudcKufeK8XbAN3miXsyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l/HoP8sqwZ2TT3WHwCcaJf/4JUJW+6iLyGzBKzeyWg=;
 b=f7KfQtUfEHjg7kOgMdXoVfB7NztHEHnlRs9duVKqzTgmWjeEM4XIny2HwhZ37uUlS7GpV5hbcq919G5Ghq8fR5is37L4PD5j/oukdI5fnDyPdWfRy5SBExqZMMUodSYgZhzS9yTLjV42AJFLDR4/ReKBw4TzdENryA4SSpDuzF++l7DWOUah1blYjepRI8wlDagm887IKXOZ00uCufTpm+vJEfRmDhSoixjMSPMVFZcWljO11XgrMnFxf+Mc0Nyh3j4VxRIiJfMta0XYBnsffRBpFqBc1RhAyYdjV5IpB0NKMGWdLXwQk9TWVFxtYWmGj/dllfYYHSBoA3KOatZDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l/HoP8sqwZ2TT3WHwCcaJf/4JUJW+6iLyGzBKzeyWg=;
 b=JbQNZJN5OYwwFa3zKdOgatMCiZOpmo1YE+QEfFDv3PnCY5D4nxZazZLhe/cWAB9rZzPDGwrub+DBbym4OsEOdoTobYRDzKdhe7x9inhhJIhbDAhXteuOkk59oH9WVBpwLZQEW/tWBI0r6ejJJJpdj5nzOdmuH4BDDBb7GC1E17Y=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 10:24:22 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.040; Wed, 10 Mar 2021
 10:24:22 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Thread-Index: AQHXFM/6iIqk6EfgdU6QexJiEf5Gy6p7hhTAgAAR0oCAAE7kYIAAA7QAgAEZWuA=
Date:   Wed, 10 Mar 2021 10:24:21 +0000
Message-ID: <DB6PR0402MB27582479DBE5A2011ABB049FE0919@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
 <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210309123601.GA4878@sirena.org.uk>
 <DB6PR0402MB275840529A4F50EBFC723E1AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210309173138.GC4878@sirena.org.uk>
In-Reply-To: <20210309173138.GC4878@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [27.58.231.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87e5b7ba-a5ca-42a5-cb19-08d8e3aeabf8
x-ms-traffictypediagnostic: DBBPR04MB7515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB751522016A506B61082F6646E0919@DBBPR04MB7515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bb0vhMlOnSU5ks0190fSHnUlmxRrCVEwoSit4mCgIsDWAQHupU9a3HEemWxyXRxo+fnFSmBWZNmdr6ACN3F9jZqO5g/j69VWTL9si9Bq7ta+t5EAGJ6fy2o0s6v3hsILZy1OgmBlOlKm1ft/wUAiSJR7CGvVOPZORZj6UOD56ixHdEE5+FmZvhkNEJbx65/smost92/lMFAbHTLLDNiJy+wUdV1Blk/l7k/VJlZZPzR4VSMkuMnNZiu+J47yGAmaWYeiquh1s4/F67GRudzYVl2oufhWUcZUYeVYjig6QGf9Zz2eWzDWYdzWNlbQanJoodugs40cl/knySnfhQJC8ZE7TYw5CT3pU6zRq2jtkm+/RNscK9X5F3J0SBKBynoZ0e8EfizOo2slIXW+MvDvyAYLxJK+1prRH0eYDT0nrk9nXSMwTlEqOhIEzaSKnW8tSUiTenZTTUGsoPjmtLKVF0oQ2XUhKMO0YesW8ouWf3WtKe75/30YAeTezOOe4T8J7j5X2DFbJb99+X1OSSVim3ArDHgqggzKGi8iecJfqhQ9Ym4GhlLxmq192c1Lg1A8ZZ6Rck1q56nTrmv9Hn7MtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(83380400001)(26005)(66556008)(5660300002)(2906002)(9686003)(55016002)(33656002)(8676002)(8936002)(44832011)(86362001)(54906003)(316002)(76116006)(66476007)(71200400001)(4326008)(966005)(66446008)(52536014)(6506007)(478600001)(53546011)(186003)(7696005)(6916009)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8OmEBc0FyyI59ei0+XSLhMQ4c4P0XSK4rxDIEcDIPg3oatJU3NEk1g++QfkX?=
 =?us-ascii?Q?MzygRDE6/dE5XGMb1b6pcHVmdkUkWQpoomgX5BvWiBKPeeCIiNTnL1AmcH+U?=
 =?us-ascii?Q?g1TVP8pAiVorg8x+Br0rAU9vbCBqHKW2HkOmC0NF8yAqvBc+dMgONQzDnfW1?=
 =?us-ascii?Q?GVWVIq+YhQ8nbNilyh61R+gnJg4O3twuNuRAar63GQmy9YyNh+oJU/O+W85x?=
 =?us-ascii?Q?pWXyJF3AiYOfqCDt7p0vtInKxgRpv8/tAvddT+w5bRGgWivpIlxV0LTxruXW?=
 =?us-ascii?Q?AVoZyKCrgEk47hoeUg5RLZv0c6Mmt+5tYhrFkXHaIQWev5mVllwBYd8ZUcOy?=
 =?us-ascii?Q?Y5j1dIdqWXG9gdoqWbqRZCeMWpBO4KcVJ9Qzk9luaD60rxaBulvcKPjMJwE+?=
 =?us-ascii?Q?T1EE2L4XyDFMcomPhcTflMKnv9PpRsT/F1gUcBnc3POeuCAn4J/BfnXgwg1z?=
 =?us-ascii?Q?5lgbJ40Pemfg6Q1j1zm4eCxhv0L8KEGGLc4g/XACaT4kp/MeVDT82KLWDcSN?=
 =?us-ascii?Q?Ny6VcZ4D8GUlOMIB6KDvViipUS0J3QTkwFV93pqpHu++Ql872VZJ5pTdBBn5?=
 =?us-ascii?Q?8Z6m+funpAz9OGfYXp9dBb+gMaP6MeGraZ9AwY9FzrTY7aqllFFT9Jt18Daz?=
 =?us-ascii?Q?ZM9rNcEfms0LAr7U2gH4zu3kGaMOC1suM9jiDnrnrKMzHfsLXUmtzJKsdcTY?=
 =?us-ascii?Q?DjOdIO5ZTvEdCKfi1vcXn3P5G+0SHviNHit+7C1Eg2Lzp4bHRb2LXzJwsXxw?=
 =?us-ascii?Q?gkZl40dOBeex3iM0b0g6kkNyWjqkrde3J3r3toXtWsKxTVvXUk2flZiE9Dlg?=
 =?us-ascii?Q?AeqUdyQ/cIQFR/3upyAbRwhEGZIdK46yjDaos5sC2RRIWGF/G+VR9PhYqgcb?=
 =?us-ascii?Q?m+XEJlmOp105xHKXHX/l3Aym1ErAwuCjXisGpvOhuCyHDD5aumQbnRULhKHW?=
 =?us-ascii?Q?4dtSWJOYOHj3Ctu10pUdF+KiIkhtuQPETLnTH7QTejY5IuNXAb/In4EDhvVI?=
 =?us-ascii?Q?r94I8/JCp6PdVFxnEEIcnW2F6SfC6kS1uhX0sHm91832VuvYmFQS5Ecb3XFm?=
 =?us-ascii?Q?jkOP9uvLD5QGygCOjOqR7Yb70uM4kjsFBfmlzqpLaf3T3E/r6jlEB0w1x2nO?=
 =?us-ascii?Q?0/FOyDIkfhyXeMK7LxzE24cTBGfOuRFi8IswU1ex5fXjLiRNuQzZUK+xDVV9?=
 =?us-ascii?Q?plKQ4oZtXb4YO0OMO63//8QzNlqXZSWG0N6mUs0sg7tFNjBCVUOsDSkyROAR?=
 =?us-ascii?Q?csiTPx7o/ENPRXwoe+q5CY+axHSPTiY6F8052GSmgPcuKx1bLNdTwfBz2GxW?=
 =?us-ascii?Q?PoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e5b7ba-a5ca-42a5-cb19-08d8e3aeabf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 10:24:22.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCEjkEqLGCHqsPNYiMfNcmgw+Jgn7ftJ79tdHZK3+tISdlFmMFg0Cb/Bg7Q3GKGIWU/t5WO/yaaZGuobfyYlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, March 9, 2021 11:02 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>
> Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to j=
son schema
>=20
> On Tue, Mar 09, 2021 at 05:30:00PM +0000, Kuldeep Singh wrote:
>=20
> > > Binding patches generally go through the subsystem tree so please
> > > send the patch to me.
>=20
> > Thanks for letting me know.
> > I have developed the patch on top of your tree and also sent to spi-dev=
el
> mailing list.
> > Please see [1] for more details. Kindly let me know if I need to resubm=
it the
> patch.
>=20
> Like I said in the mail you're replying to please send me a copy of the p=
atch.

I hope this will suffice. Please let me know in case of any other requireme=
nt.

Regards
Kuldeep
[1]
Convert the NXP FlexSPI binding to DT schema format using json-schema.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 85 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 43 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 86 insertions(+), 44 deletions(-)  create mode 100644 Doc=
umentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml b/=
Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
new file mode 100644
index 000000000000..e3f2c5aae847
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,spi-nxp-fspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Flex Serial Peripheral Interface (FSPI)
+
+maintainers:
+  - Ashish Kumar <ashish.kumar@nxp.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nxp,lx2160a-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8dxl-fspi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  reg-names:
+    items:
+      - const: fspi_base
+      - const: fspi_mmap
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC SPI fspi_en clock
+      - description: SoC SPI fspi clock
+
+  clock-names:
+    items:
+      - const: fspi_en
+      - const: fspi
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
+
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        spi@20c0000 {
+            compatible =3D "nxp,lx2160a-fspi";
+            reg =3D <0x0 0x20c0000 0x0 0x100000>,
+                  <0x0 0x20000000 0x0 0x10000000>;
+            reg-names =3D "fspi_base", "fspi_mmap";
+            interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV=
(4)>,
+                     <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4=
)>;
+            clock-names =3D "fspi_en", "fspi";
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            flash@0 {
+                compatible =3D "jedec,spi-nor";
+                spi-max-frequency =3D <50000000>;
+                reg =3D <0>;
+                spi-rx-bus-width =3D <8>;
+                spi-tx-bus-width =3D <8>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Docum=
entation/devicetree/bindings/spi/spi-nxp-fspi.txt
deleted file mode 100644
index df178d1b62e6..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* NXP Flex Serial Peripheral Interface (FSPI)
-
-Required properties:
-  - compatible : Should be "nxp,lx2160a-fspi"
-			    "nxp,imx8qxp-fspi"
-			    "nxp,imx8mm-fspi"
-			    "nxp,imx8dxl-fspi"
-
-  - reg :        First contains the register location and length,
-                 Second contains the memory mapping address and length
-  - reg-names :  Should contain the resource reg names:
-	         - fspi_base: configuration register address space
-                 - fspi_mmap: memory mapped address space
-  - interrupts : Should contain the interrupt for the device
-
-Required SPI slave node properties:
-  - reg :        There are two buses (A and B) with two chip selects each.
-                 This encodes to which bus and CS the flash is connected:
-                 - <0>: Bus A, CS 0
-                 - <1>: Bus A, CS 1
-                 - <2>: Bus B, CS 0
-                 - <3>: Bus B, CS 1
-
-Example showing the usage of two SPI NOR slave devices on bus A:
-
-fspi0: spi@20c0000 {
-	compatible =3D "nxp,lx2160a-fspi";
-	reg =3D <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
-	reg-names =3D "fspi_base", "fspi_mmap";
-	interrupts =3D <0 25 0x4>; /* Level high type */
-	clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
-	clock-names =3D "fspi_en", "fspi";
-
-	mt35xu512aba0: flash@0 {
-		reg =3D <0>;
-		....
-	};
-
-	mt35xu512aba1: flash@1 {
-		reg =3D <1>;
-		....
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..8729f7b50945 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12832,7 +12832,7 @@ M:	Ashish Kumar <ashish.kumar@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+F:	Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
=20
 NXP FXAS21002C DRIVER
--
2.25.1

