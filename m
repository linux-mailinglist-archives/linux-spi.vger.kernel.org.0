Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55D445F227
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378466AbhKZQkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 11:40:13 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34399 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378494AbhKZQiM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 11:38:12 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 13D80E000B;
        Fri, 26 Nov 2021 16:34:50 +0000 (UTC)
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
Subject: [PATCH v2 0/5] Stacked/parallel memories bindings
Date:   Fri, 26 Nov 2021 17:34:45 +0100
Message-Id: <20211126163450.394861-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Rob, Mark, Tudor & Pratyush,

Now that the discussion has move forward, let met propose a second
version for these bindings.

Cheers,
Miquèl

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

Miquel Raynal (5):
  spi: dt-bindings: Allow describing flashes with two CS
  dt-bindings: mtd: spi-nor: Allow external properties
  dt-bindings: mtd: spi-nor: Allow two CS per device
  spi: dt-bindings: Describe stacked/parallel memories modes
  spi: dt-bindings: Add an example with two stacked flashes

 .../bindings/mtd/jedec,spi-nor.yaml           |  5 ++--
 .../bindings/spi/spi-controller.yaml          | 30 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.27.0

