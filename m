Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE432D0010
	for <lists+linux-spi@lfdr.de>; Sun,  6 Dec 2020 02:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLFBUI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 20:20:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLFBUI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Dec 2020 20:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607218758; x=1638754758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0I4QzQzOsChmNRmAhZHgMo7j8PJFacdYYrWcPxv0oYw=;
  b=jKlEXqx4NHOBFY78DmCZV2/zgxZBykzLA6dx4L7iY4e4KXu+Dv4gXJDS
   Js7xw6o9PHhCnB4dJaizvP/nidZFsOqBogQxvQfrRvqrn2B7nkto4BhW3
   U3wZMhDtgrU+uMrg9M1m2ziHxnV1JqC/ULjAh0ZcB8mUB5JIcehJMx/ML
   JeT5aMlvohWET2AawUoYnh6mfWDvNhrJb32frW/kATG6P2sQZ00YonQN1
   OQRDCkGObGz2/UsjTacI/MNFEGxg4UXK0avDSsxtCNd8/Oa17GvxXfv5W
   MD8kgQNH6sv8D36szPcwiEm0f95zKrVSHddg5J+M7aGfmhbv3icL24J0F
   Q==;
IronPort-SDR: mQ5zs72xzp4425URVPxu22ND647gae3RXyz44nEpWpVLB58FZKIBaPAcHY1lUwkcJbFp/sG7nV
 e4eAY2WrLohW4Cb0rePTssKsvV5rGRFDAM8VCxOI3T7psecxB+JefzgfHRawl/Rla7NT4tsEEt
 0ljpsqw0lCmR1i4PGw+1d0hI8LGcDfwIcTFkKmplm56/kjb/vzrDF4ILEX5ajZHphJbUVBZmpa
 UWSAzS3WDC5AtpnqZ7KiD8fY+Lz877JMkpZdZDP/PaVFhbdyrdU/aQz5bEeSetJZFV1qtGvaHC
 uuA=
X-IronPort-AV: E=Sophos;i="5.78,396,1599494400"; 
   d="scan'208";a="258231902"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2020 09:36:39 +0800
IronPort-SDR: 6oZHDvrAWUvTTjRdCSE4gNlnZWzVHDBfqi78acexTMKmdYHuXEiNZbywZz3Y/EblpvJ5Oh2/33
 2/Nr/xKlXuIRTW7HjgwomNjuaFiPk2Bc0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 17:02:26 -0800
IronPort-SDR: fuEYEf2IlrLD5G/bOGkuGCDZkpkN4CKsRXw+g+I+0EwzZ2N1ZRJqQpP7XZooPxjlYDu3eDscW7
 hakcDMFmSKrQ==
WDCIronportException: Internal
Received: from cnf005296.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Dec 2020 17:18:21 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller
Date:   Sun,  6 Dec 2020 10:18:15 +0900
Message-Id: <20201206011817.11700-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201206011817.11700-1-damien.lemoal@wdc.com>
References: <20201206011817.11700-1-damien.lemoal@wdc.com>
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

