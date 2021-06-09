Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3933A122B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhFILT1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 07:19:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54916 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhFILT0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 07:19:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159BHCiP108413;
        Wed, 9 Jun 2021 06:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623237432;
        bh=42fJCg/ThRtNdB6VcGZs5PPX2/UEAquNHV1MLw62RGA=;
        h=From:To:CC:Subject:Date;
        b=XEQ+oGo0ysY18uezmsqxgyaFR+L2jlQYvY0p1TQQ+OP4YfEbxV3x1Bjr3Ze1rda23
         68sL6S8tl4wKyG1iYsm149JPYLA+1YspsabFKRZv4D9yAux6CbTmHXYZ2h5axy/oGp
         eMeLqnEth/SJr/bRaguu/E3dSOme64hbExmKgeRQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159BHCkC085826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 06:17:12 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 06:17:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 06:17:12 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159BH7uF073420;
        Wed, 9 Jun 2021 06:17:08 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] Add bindings for slave-specific SPI controller properties
Date:   Wed, 9 Jun 2021 16:47:05 +0530
Message-ID: <20210609111707.9555-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds bindings for slave-specific SPI controller properties.
See patch 1 for more info on the motivations behind this.

This is the best approach that I came up with with my limited knowledge
of JSON schema. It has some limitations that are mentioned in patch 1. I
don't know of any better ways to model this. Suggestions are welcome!


Pratyush Yadav (2):
  spi: dt-bindings: add schema listing slave-specific properties
  dt-bindings: mtd: spi-nor: Add a reference to spi-slave-props.yaml

 .../bindings/mtd/jedec,spi-nor.yaml           |  3 +-
 .../bindings/spi/cdns,qspi-nor.yaml           | 33 ------------
 .../bindings/spi/spi-slave-props.yaml         | 52 +++++++++++++++++++
 3 files changed, 54 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml

-- 
2.30.0

