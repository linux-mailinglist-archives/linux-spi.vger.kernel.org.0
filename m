Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87EB3AF305
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 19:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhFUR6c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 13:58:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhFUR4S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 13:56:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C1A471F42689
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0CEA24800C8; Mon, 21 Jun 2021 19:54:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv5 2/5] spi: dt-bindings: support devices with multiple chipselects
Date:   Mon, 21 Jun 2021 19:53:56 +0200
Message-Id: <20210621175359.126729-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621175359.126729-1-sebastian.reichel@collabora.com>
References: <20210621175359.126729-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add binding support for devices, that have more than one
chip select. A typical example are SPI connected microcontroller,
that can also be programmed over SPI like NXP Kinetis or
chips with a configuration and a data chip select, such as
Microchip's MRF89XA transceiver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 0477396e4945..faef4f6f55b8 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -114,8 +114,11 @@ patternProperties:
           Compatible of the SPI device.
 
       reg:
-        minimum: 0
-        maximum: 256
+        minItems: 1
+        maxItems: 256
+        items:
+          minimum: 0
+          maximum: 256
         description:
           Chip select used by the device.
 
-- 
2.30.2

