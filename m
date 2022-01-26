Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2749C895
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 12:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiAZL0L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 06:26:11 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52123 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiAZL0L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 06:26:11 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7938960002;
        Wed, 26 Jan 2022 11:26:08 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 0/3] Stacked/parallel memories bindings
Date:   Wed, 26 Jan 2022 12:26:04 +0100
Message-Id: <20220126112608.955728-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Rob, Mark, Tudor & Pratyush,

Here is a sixth versions for these bindings, which applies on top of
the v5.17-rc1 now that Pratyush's work as been merged.
(https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/)

Cheers,
Miquèl

Changes in v6:
* Added Pratyush's acks.
* The tooling now validates the binding (updating dt-schema is
  necesary).
* Updated the maxItems field to 4 as a "big enough value" as discussed.

Changes in v5:
* Used the uint64-array instead of the matrix type.
* Updated the example as well to use a single "/bits/ 64" cast because
  doing it twice, despite being supported by the language itself, is not
  yet something that we can use for describing bindings.

Changes in v4:
* Changed the type of properties to uint64-arrays in order to be able to
  describe the size of each element in the array.
* Updated the example accordingly.

Changes in v3:
* Rebased on top of Pratyush's recent changes.
* Dropped the commit allowing to provide two reg entries on the node
  name.
* Dropped the commit referencing spi-controller.yaml from
  jedec,spi-nor.yaml, now replaced by spi-peripheral-props.yaml and
  already done in Pratyush's series.
* Added Rob's Ack.
* Enhanced a commit message.
* Moved the new properties to the new SPI peripheral binding file.

Changes in v2:
* Dropped the dtc changes for now.
* Moved the properties in the device's nodes, not the controller's.
* Dropped the useless #address-cells change.
* Added a missing "minItems".
* Moved the new properties in the spi-controller.yaml file.
* Added an example using two stacked memories in the
  spi-controller.yaml file.
* Renamed the properties to drop the Xilinx prefix.
* Added a patch to fix the spi-nor jedec yaml file.

Miquel Raynal (3):
  dt-bindings: mtd: spi-nor: Allow two CS per device
  spi: dt-bindings: Describe stacked/parallel memories modes
  spi: dt-bindings: Add an example with two stacked flashes

 .../bindings/mtd/jedec,spi-nor.yaml           |  3 ++-
 .../bindings/spi/spi-controller.yaml          |  7 ++++++
 .../bindings/spi/spi-peripheral-props.yaml    | 25 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.27.0

