Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86EE2C4D0A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Nov 2020 03:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgKZCA4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 21:00:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17444 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbgKZCA4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 21:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606356056; x=1637892056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0I4QzQzOsChmNRmAhZHgMo7j8PJFacdYYrWcPxv0oYw=;
  b=CZhWAP4WvClIvV9MpKWmDikx3ADIGC/CAZ+lI0SnWg4jy9r3gxnEMVOC
   6/F5mWM6LaC3ZXFtCwQh0vqqwSjpyTSNnfeUEhwXqYskAJmTOI+1/iUwf
   lpsKYuGm4MqsoYQpzwBxIx8ADrXYbVbmKAgC1MgkDtnAr+1OWsq9LfPxl
   TY3WBZFagyOKpYr/3Li2ipngEX2cBsiLjBT6VM/kvBswU0i9sIODsCMO2
   KrR7L8P+WgLH63QdsoaLh4kQyRZSnut4xqhGEb2Mul8NFU8qNzxW3beUk
   /8zo/PWjndQENFe5IACh1uFYRvkKLZJQ5OPt/UFJiEpL+5x7Q/4S662rI
   Q==;
IronPort-SDR: Zra4TB4kwAFiKQlyGZc+geNHXxSuKzAYu16lg3PkuelNkn9FRgEQPNk53JyNufxId34fpbAxOb
 fYpk/mObZKbCW2dtnXIUDaF0SZwElzqWWfisZOGk6xSze+yqfPFsdfzfcBS6tMGVM677fIqvvp
 fm3EzQxyE/azET2kGfTVS48vnMU1C0PQ5zN04s6Rwtf+U0eArj1QyOSQ4PGC8vGE0HRiKfSZjp
 IbEGrMb744/Ctv92Tu2X4dPpem1+c8wl7d6CjRF/rVtmwfIuzfD4DJOdQAex9Lg043v8sGMLR6
 leI=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157980299"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:00:56 +0800
IronPort-SDR: OMmfMDzjI3YdsFqNclBF89Bou6vz7qzwRU44QXqEa8aIjFcdHHCfOuGYhhjfSyLHJiwAk0NNhk
 SbkedJuDnXF4gwl2CIr/06dHeYP/deztY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:46:38 -0800
IronPort-SDR: uIFwRCk56/LGewbvwstkHBqzPw0LzYf83eyP7hN9je3HYh96QHD7O3TUqcDZFuyyXNG2jg0mf+
 y/AOy5nPUnwA==
WDCIronportException: Internal
Received: from 57m2vf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Nov 2020 18:00:54 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller
Date:   Thu, 26 Nov 2020 11:00:49 +0900
Message-Id: <20201126020049.35712-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126020049.35712-1-damien.lemoal@wdc.com>
References: <20201126020049.35712-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update the snps,dw-apb-ssi.yaml document to include the compatibility
string "canaan,k210-spi" compatible string for the Canaan Kendryte K210
RISC-V SoC DW apb_ssi V4 SPI controller.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 99ed9b416e94..4825157cd92e 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -65,6 +65,8 @@ properties:
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
         const: baikal,bt1-sys-ssi
+      - description: Canaan Kendryte K210 SoS SPI Controller
+        const: canaan,k210-spi
 
   reg:
     minItems: 1
-- 
2.28.0

