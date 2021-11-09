Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7644B29B
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbhKISWX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 13:22:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55082 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbhKISWW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 13:22:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1A9IJH40094844;
        Tue, 9 Nov 2021 12:19:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636481957;
        bh=xsNrZAugT1a4ot1HJ3Nu/+NyUFJPJASfhJWC608znmA=;
        h=From:To:CC:Subject:Date;
        b=PYWfbWMgRF+mRZZTaJy/yImnZxTSDwfXFQPB2ZOgXzZqtd7wL/L5MVQlH0NFo7cMR
         CKc5Y+cWC9QVOEgCS956QhUHhAEGL+i73UMDtypbjKQhI5X+OKWvpwjflGRC0Clh77
         75FdPzZrPiIW4E26k6VDKMuQpkWVq6351swW9Iao=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1A9IJH0K080403
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 12:19:17 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 9
 Nov 2021 12:19:16 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 9 Nov 2021 12:19:16 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1A9IJC51017044;
        Tue, 9 Nov 2021 12:19:13 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 0/3] Add bindings for peripheral-specific SPI controller properties
Date:   Tue, 9 Nov 2021 23:49:08 +0530
Message-ID: <20211109181911.2251-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds bindings for peripheral-specific SPI controller properties.
See patch 1 for more info on the motivations behind this.

This is the best approach that I came up with with my limited knowledge
of JSON schema. It has some limitations that are mentioned in patch 1. I
don't know of any better ways to model this. Suggestions are welcome!

Changes in v3:
- s/slave/peripheral/g
- Drop the | on description.
- Drop the compatible property.

Changes in v2:
- Move other subnode properties listed in spi-controller.yaml to
  spi-slave-props.yaml
- Move the Cadence controller-specific properties out of
  spi-slave-props.yaml. They will be added in a separate file.
- Add a reference to spi-slave-props.yaml in spi-controller.yaml.
- Update description.

Pratyush Yadav (3):
  spi: dt-bindings: add schema listing peripheral-specific properties
  spi: dt-bindings: cdns,qspi-nor: Move peripheral-specific properties
    out
  dt-bindings: mtd: spi-nor: Add a reference to
    spi-peripheral-props.yaml

 .../bindings/mtd/jedec,spi-nor.yaml           |  3 +-
 .../spi/cdns,qspi-nor-peripheral-props.yaml   | 42 +++++++++
 .../bindings/spi/cdns,qspi-nor.yaml           | 33 -------
 .../bindings/spi/spi-controller.yaml          | 69 +-------------
 .../bindings/spi/spi-peripheral-props.yaml    | 89 +++++++++++++++++++
 5 files changed, 135 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml

--
2.33.1.835.ge9e5ba39a7

