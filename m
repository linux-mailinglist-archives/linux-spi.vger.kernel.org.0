Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB8470B8B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 21:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbhLJUOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Dec 2021 15:14:19 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49421 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhLJUOS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 15:14:18 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D297B240002;
        Fri, 10 Dec 2021 20:10:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 0/3] Stacked/parallel memories bindings
Date:   Fri, 10 Dec 2021 21:10:36 +0100
Message-Id: <20211210201039.729961-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Rob, Mark, Tudor & Pratyush,

Here is a fourth versions for these bindings, which applies on top of
Pratyush's work:
https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/

Cheers,
Miquèl

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

 .../bindings/mtd/jedec,spi-nor.yaml           |  3 +-
 .../bindings/spi/spi-controller.yaml          |  7 +++++
 .../bindings/spi/spi-peripheral-props.yaml    | 29 +++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.27.0

