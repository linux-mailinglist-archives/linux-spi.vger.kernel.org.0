Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3EB43E126
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhJ1MsN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 08:48:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45444 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1MsM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 08:48:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19SCjOuE046426;
        Thu, 28 Oct 2021 07:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635425124;
        bh=NtVjaK3NVDc5/FgFPK++Bri10Kvkgs6XU03tEJ+YQ0c=;
        h=From:To:CC:Subject:Date;
        b=Vo0L4UGhARwXYeRKxOVVyJnLvlxMBykznrkdrPhOG8WrLDC9rDRpTiPQYo4/BtUCi
         VCX3Ma71P7Lfyl52NlD4SWrXCP+DohVdO4jihOzPjWA7TFFYVtQHPEEHpKT7LzHXxu
         wI1QczV5rlyWgjGB/ufySkewPQnlTYZcPsbZKr4s=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19SCjOD2119937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Oct 2021 07:45:24 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Oct 2021 07:45:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Oct 2021 07:45:23 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19SCjJbA115317;
        Thu, 28 Oct 2021 07:45:20 -0500
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
Subject: [PATCH v2 0/3] Add bindings for slave-specific SPI controller properties
Date:   Thu, 28 Oct 2021 18:15:15 +0530
Message-ID: <20211028124518.17370-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
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

Changes in v2:
- Move other subnode properties listed in spi-controller.yaml to
  spi-slave-props.yaml
- Move the Cadence controller-specific properties out of
  spi-slave-props.yaml. They will be added in a separate file.
- Add a reference to spi-slave-props.yaml in spi-controller.yaml.
- Update description.

Pratyush Yadav (3):
  spi: dt-bindings: add schema listing slave-specific properties
  spi: dt-bindings: cdns,qspi-nor: Move slave-specific properties out
  dt-bindings: mtd: spi-nor: Add a reference to spi-slave-props.yaml

 .../bindings/mtd/jedec,spi-nor.yaml           |  3 +-
 .../spi/cdns,qspi-nor-slave-props.yaml        | 42 +++++++++
 .../bindings/spi/cdns,qspi-nor.yaml           | 33 -------
 .../bindings/spi/spi-controller.yaml          | 69 +-------------
 .../bindings/spi/spi-slave-props.yaml         | 93 +++++++++++++++++++
 5 files changed, 139 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml

-- 
2.33.1.835.ge9e5ba39a7

