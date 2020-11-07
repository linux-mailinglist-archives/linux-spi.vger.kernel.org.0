Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75F62AA39D
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgKGIPV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:21 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgKGIPU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736919; x=1636272919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mT3pTXQexT9Dgnt/dopD8ONmHSaoe0HrxwBKmVk9pvo=;
  b=WPXbg8VNLNvhK8/mhDMCUfDRpdGMs1O9HJ8JVTGDH/suF0H37N3OsZjA
   GOegH2MBUAAnvxlAYo0dqLj5l3xtXiF8zfBix/4PnXB0lWOMvWq7eCja+
   rnNzs9/m5+5EgI7v5V8j3eRYkLkYvLIXWGbEJqSeAwjl8eEjiD0e1Mm7f
   Ifg1YNAh8zpM5kfBaK8zcwg9hRhoEyOcaBsJJQfuYI9+LGKsQJjitiQFS
   1rUbZit2S0Y5rxHVPVzXiaoWvBwJWUKSkIGa2auR4uc3I7eNlDBknkpEs
   eA0RS8lIZfMtqNskeyq+YHw84Z1OZpPUF+fGo112aYxDUYB4GlndagxvX
   g==;
IronPort-SDR: PvujEE7T4qzq3tSLmeHgOy0920IpY8ah539avwPTG/d3P8jL+HRdUiJCAvO4qP8WR7aGtbIq6N
 Mp2eY6MH3JthWlQsK5qmK9Kl19Nf5/QeP3xMvGnh8VfKUHodj4fjrnk88TWU6Lu4k6Ot9WPNKa
 OjC+L0ihBn9wqh6lcYUC3Hfz0wQeszdLReRsthl13qk76JOOVsp6ggaSTr61MvXqhCmEzknR3X
 HIYv0djrm2BoUlvw/vr6dW/ddVk48sYdUikV5JoMW6af/ZTVFRjF6OGci1ampy2mbARnbSFtzd
 j6M=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564412"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:19 +0800
IronPort-SDR: pWfFSy3MMowsC+GyZzx1sOTDYXGThvXr9H1EbHwR1dwxQ7ZZ6rNamyz3fUonZ6HrYzslw+ELF1
 Im1K1h8ylZDFpDCdvxsD8mc/QpilDgvHYdIzjcKBr9e4vN7/pyWeIRdWuSqqFEQ76/QG1ZoIgN
 O0S+T1XGJuG8W1DY7H9wLeySg3GtydH7Ql9Ch5gp9AbDsEbUgIijiHx9jH9fJ+WwFiuhSxCZtV
 /xfb+cE/XeoX8Cu511083sNzKjf9ti7EWjwW4q6nDXRcHH2U7GKSDgXD4iTPs2jCMM5TVe129q
 NFl7lvzKwachoX8jOmzMHkCu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:10 -0800
IronPort-SDR: nsSrpRMvEDvSs1TeA0fMTqHiFneFxHjZmLfdiZ87YpKj8Av1NoJkpTT29IXc4QkCHCdg6d+K/y
 zVGcDYrgUlDAfCTc+znMu3URNsQ3kk3ic6fmy40H5NFAj8SQwDDMBehX3TbPn8UYRGm+mzfuhQ
 DJC3TOp0zMejeMzCFqodVr59FKdboNmBIlVIJflbfggqVHWF6ocv7cwqJTb4YP+Ci2XKOErP8e
 NIeljGbMnfObFqEuZg9gln+SgXE+TnW8kID6vacvc37Da0BkapPZ9YbWTCsul4IYeM6yuSlmTt
 lAk=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:18 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
Date:   Sat,  7 Nov 2020 17:14:09 +0900
Message-Id: <20201107081420.60325-22-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
"Kendryte" and "canaan" as a vendor prefix for "Canaan Inc."

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..f53d4d8e7f2a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -179,6 +179,8 @@ patternProperties:
     description: CALAO Systems SAS
   "^calxeda,.*":
     description: Calxeda
+  "^canaan,.*":
+    description: Canaan, Inc.
   "^caninos,.*":
     description: Caninos Loucos Program
   "^capella,.*":
@@ -537,6 +539,8 @@ patternProperties:
     description: Ka-Ro electronics GmbH
   "^keithkoep,.*":
     description: Keith & Koep GmbH
+  "^kendryte,.*":
+    description: Canaan, Inc.
   "^keymile,.*":
     description: Keymile GmbH
   "^khadas,.*":
-- 
2.28.0

