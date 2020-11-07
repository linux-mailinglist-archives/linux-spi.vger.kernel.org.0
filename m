Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC302AA35D
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKGIOn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgKGIOn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736882; x=1636272882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QoJVNai4z0WvL518+osR90NQ4x7vZ6Nl1KYmu+lCdTk=;
  b=qM1/olAY/9FN4fLvuK3yGW/2FOXHSDaFHBoiSljJPwgFrrG1aIpeXbdO
   BTz3v8NXV2G1Gx4gB9mV3sKEcZIycsr7JG3eS3Zd/dnIvmcQkTK4Q3rTu
   EBgejd1uk6xJ3WNIdouGKZLkR/dgZzmSn5DkENDpAqiB6fXITVxdle3Z4
   yfW9h1eWDKMkTuvGCtBLO/9ehOb1OVXCc+yPBXRKu+X/UPfwxnQY2elru
   /TAI3/+zMDpJJx7EWEvu5zeBr++w2EESfw1Gs08dmrNsQzIv+hu5YuxZN
   IEkP0J/u8It1tBUbwc+NLAI6ltsM9sJGVZJtr7p7/yVIA5FO50Io8GNs7
   g==;
IronPort-SDR: j2OvUFE5Z0wpQ3Ecr7ToMLxZ/YFNh7tZaQENlzPb5YQqvsm8/rdfVAN6vPo+r1X1EQQMns2ZYq
 Fj6Dx0gwO1x0TvR/V/SQgk2mcX/r/i85JO6FUqhNiqX113snlbdrsl/lekDnm4aBBhZMP9PfCm
 2LV4ve6nOKhlv3Kmj/jScdtzahoNZp+SQxv3gvK52MZE6xdFk04hx1+yDj4qUI8/792pYigM0u
 dSDRRai31veAAtSdnCJ8M+yqEva2CJrwFINe6GdVKpMPLCOlhp2wYmoNNPnyrNkVbVBpp9bKv/
 xow=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564373"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:42 +0800
IronPort-SDR: U14cN5sI3dOh6j4GbBjnECKgMQ9lHfkaDPsPU4Z5YTdjyBIonEIS8asaxVuX0eNW0DV7mcj54n
 B18is0BhihFJIQWfJvSYiTOPsThwm1WUgS6/MJskkIx1U+XFnea7DZIGNp23SofaGHU2b/j5ee
 hkkgwWyoOFGPUsFNhu0a8btUCHkqimX2e4vBxZJ4rKhfkhcPHFe1jVlc/xaYTvuK90ANK48BWF
 L/zJVH3yOLwQYj7hlicZzTDgcjy7IBkfDavfcyULsRugRgBEA8QTK/5l+yVYybqjtSyKctaJxl
 l13rQLPEj25WMrH3oF0lqlFX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:33 -0800
IronPort-SDR: l5NUdATJR2UmUDFMP2a7CPEW+CWgqJ5gegrk4pBecJjYdSp36XDdJ4PFTt1XYo3IquRXfcAPBK
 He10fkfu7C+nEDFDiZ0n7GlTGt9c3DiP3V5Yc5zbeN5VVKTFRhBcPnGqSrMeEyH3HZuEgSLCBO
 4y4m30TCEdJ8ssmXwDuYAmROYJZy4585Ods4E+50ZNoHGw7HXpIZdXqG9LZAqOuIFLxuIvAffj
 HQO2B+MtF0XFQw7uV1cwN56AJR2cKnX568HePrZH5CN1wYk2KKzuJFdWw2rjTSb4aQjgEyjUjF
 oAY=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:40 -0800
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
Subject: [PATCH 07/32] dt-bindings: Update DW SPI device tree bindings
Date:   Sat,  7 Nov 2020 17:13:55 +0900
Message-Id: <20201107081420.60325-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the polling propetry which is used to force the use of polled
transfers, ignoring the device interrupt property.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 99ed9b416e94..890a160a253f 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -120,6 +120,11 @@ properties:
       This value will be used if the property is not explicitly defined
       for a SPI slave device. See below.
 
+  polling:
+    default: false
+    description: Ignore the device interrupt and force the use of polled
+      transfers.
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.28.0

