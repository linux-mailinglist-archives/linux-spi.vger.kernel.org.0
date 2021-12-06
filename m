Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6013C469318
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 10:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbhLFKC5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 05:02:57 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43631 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbhLFKC4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 05:02:56 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 54C5C24000A;
        Mon,  6 Dec 2021 09:59:22 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/3] Stacked/parallel memories bindings
Date:   Mon,  6 Dec 2021 10:59:18 +0100
Message-Id: <20211206095921.33302-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Rob, Mark, Tudor & Pratyush,

Here is a third versions for these bindings, which applies on top of
Pratyush's work:
https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/

Cheers,
Miquèl

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
 .../bindings/spi/spi-controller.yaml          |  7 +++++++
 .../bindings/spi/spi-peripheral-props.yaml    | 21 +++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.27.0

