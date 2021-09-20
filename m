Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34E4116E3
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhITO3M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 10:29:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59928 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbhITO3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 10:29:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KERKTl105711;
        Mon, 20 Sep 2021 09:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632148040;
        bh=Y7l7RaNnp7XledpwNXnncmI84XTK+TQrRyIYiiow6jY=;
        h=From:To:CC:Subject:Date;
        b=iVj8t8mzZOzjB+LSPSNKaxSFv43hNK0hKIkYx4eGnA+GMm9cXZUYLhB+HMs29Bzvk
         C4abHK9XR5zIl4HYnH/N4/EwPYuLIipL3SsphEtVw/WchKhqUCwbR3uNwPH8ZS2qPj
         KcgzlyNXel64RMJ1OKIhmQixUUuw/pfyhS3c88Ks=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KERKjv044860
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 09:27:20 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 09:27:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 09:27:20 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KERE42100694;
        Mon, 20 Sep 2021 09:27:15 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <michael@walle.cc>
Subject: [PATCH v2 0/2] dt-bindings: mtd: spi-nand: Convert to DT schema
Date:   Mon, 20 Sep 2021 19:57:11 +0530
Message-ID: <20210920142713.129295-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Series to convert spi-nand.txt binding to YAML format and also fix up
snps-dw-apb-ssi for related dt_schema errors.

Changes in v2:
- Fixed dtschema erros in snps-dw-apb-ssi.
- Improved additionalProperties, reg, and compatible fields in
  spi-nand.yaml.

Apurva Nandan (2):
  dt-bindings: mtd: spi-nand: Convert to DT schema format
  dt-bindings: snps,dw-apb-ssi: Use 'flash' node name instead of
    'spi-flash' in example

 .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
 .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 +-
 3 files changed, 63 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml

-- 
2.25.1

