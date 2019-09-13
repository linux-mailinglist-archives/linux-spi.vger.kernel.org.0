Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3119B1D21
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2019 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfIMMM2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Sep 2019 08:12:28 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:35203 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbfIMMM2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Sep 2019 08:12:28 -0400
X-IronPort-AV: E=Sophos;i="5.64,501,1559487600"; 
   d="scan'208";a="26313255"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2019 21:12:26 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AE9F24007F43;
        Fri, 13 Sep 2019 21:12:24 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: dw: Add basic runtime PM support
Date:   Fri, 13 Sep 2019 13:11:57 +0100
Message-Id: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI. This
series enables power mode in the driver so the clock domain will enable
the bus clock, adds the compatible string and updates the associated bindings
documentation.

Phil Edworthy (3):
  dt: spi: Add Renesas RZ/N1 binding documentation
  spi: dw: Add basic runtime PM support
  spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
 drivers/spi/spi-dw-mmio.c                                  |  1 +
 drivers/spi/spi-dw.c                                       |  4 ++++
 3 files changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

-- 
2.7.4

