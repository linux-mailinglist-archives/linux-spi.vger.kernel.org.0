Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB562AA34B
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgKGIO1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:27 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgKGIO1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736866; x=1636272866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqUviBNZqhcYKVjLlBRgbOvJ4y6AYLOsGaaxkI1tHXE=;
  b=WbLmDeHMpyuMAj5o6aC3ehE826nSoTpBtKiuqxJrh9QieKpt5VVYIGEM
   P5BxAyT0VYjpY33M4I5MIqPeLlvVeswKj5ZZU/78m+elcsvEyLNWmS/Fg
   YeEgYsYj7wYE7+NqI5xY0QhIp0Qwgzrkl5UJ9eDGc413EMqkcMrpKt+U9
   Dl4smzilr+Oftroz10BHEE0mR/IEtO7YACeHKUyQBzQV6CPiLBHFpYly5
   SSnbNa33q7Cnk70/yLwva9DVbYB7AqsmZpcnMl7jViHjG8WztzR4tpGCB
   ANdHtans1lhNlmwZFFfRlxjoSIgDITVVYUWQMXKNXwb+Q4xp9LbZ1hMqt
   A==;
IronPort-SDR: n771JepbWCHDRkYyn8eHlO+UD9lV3sUgQrKoHBpkBj7/26yMD0PvmFHEJh7Fg1b3OZV5IZi+YM
 aLs3US7E1aU+D1JYFzLMYtkZVOt3O/P8z7PGAPQ6ZzKeuzBT+P9X2+FKFFj5YoJ8X+Gs4UchL1
 Lbokr311ZW3yP/SY/KWdYRsEHqqQ6SHkBpjmeZc5gmlCSW/FA/fa5cm6n8IbJlEVKyqYZgGwCS
 G38Ie2i8IPv6HuQtPABDm/3OXTfjHlXFn8xnyZGWg8UhnepZ+Io5Qh0GymXFqeUy499JgMebav
 f1k=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564357"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:26 +0800
IronPort-SDR: CViM24XLr0s7xjdVlrD3qV2x7d5ahqOLGtfj6NwpuToaZWpy/uS4bssZd4bEZH4Sw4QOHEW2QD
 TrToZ5NlkAX0ddU0K7J/VLq/MvsWO3HqJh+K91GoK4e8JtGdJyV39OtZxiCgHCsG8Z2ymEIioI
 No7d6V1X4d+d6ZHLx6uHdUcZ6unfMXJSyraKM3HE+i3E8W1hfph+3je7D9Ug5mBOg9CJW1z06x
 bQSephzJS3Y3ps7ruC1E2m3+03z05EkU6/zKAnQCbc6VN8UsXTtSlOqCMBr6ECkd8uEvZRthwz
 X4CIW2tNehmo14F7SN+Xdov2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:17 -0800
IronPort-SDR: TmBsa7t3u9A7oOAAJ6Q9xlQB6YGNq7OndCgwgljnfYFrMAktTQLVE89+b449fpt9Mw7Xr+O3BY
 U9zIY390So2hnkbpscRoeheh9r+XlcJwEykzBi55qYwq0hTm5aoaNFV3b2Bc2yubJYy5jJJpZp
 jjMxRqB1Bc9lZQysDb6Pcr+5RH/AgWpwmT3QihEA/AcCs4BgEg5egeDogJqj32RBmxwcAmcke+
 le/0xfq+Zm5V7QU1z0BA81wKCy48rumCkg4lGF2bMCmkGnS9pARlhm+ISDPatWjLyhaaTddJm4
 7Y8=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:24 -0800
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
Subject: [PATCH 01/32] of: Fix property supplier parsing
Date:   Sat,  7 Nov 2020 17:13:49 +0900
Message-Id: <20201107081420.60325-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The DesignWare GPIO driver gpio-dwapb ("snps,dw-apb-gpio" or
"apm,xgene-gpio-v2" compatible string) defines the property
"snps,nr-gpios" for the user to specify the number of GPIOs available
on a port. The "-gpios" suffix of this property name ends up being
interpreted as a cell reference when properties are parsed in
of_link_to_suppliers(), leading to error messages such as:

OF: /soc/bus@50200000/gpio-controller@50200000/gpio-port@0: could not
find phandle

Fix this by manually defining a parse_gpios() function which ignores
this property, skipping the search for the supplier and thus avoiding
the device tree parsing error.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/of/property.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 408a7b5f06a9..d16111c0d6da 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1308,7 +1308,6 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
 DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
-DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
 
 static struct device_node *parse_iommu_maps(struct device_node *np,
 					    const char *prop_name, int index)
@@ -1319,6 +1318,22 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
 	return of_parse_phandle(np, prop_name, (index * 4) + 1);
 }
 
+static struct device_node *parse_gpios(struct device_node *np,
+				       const char *prop_name, int index)
+{
+	/*
+	 * Quirck for the DesignWare gpio-dwapb GPIO driver which defines
+	 * the "snps,nr-gpios" property to indicate the total number of GPIOs
+	 * available. As this conflict with "xx-gpios" reference properties,
+	 * ignore it.
+	 */
+	if (strcmp(prop_name, "snps,nr-gpios") == 0)
+		return NULL;
+
+	return parse_suffix_prop_cells(np, prop_name, index,
+				       "-gpios", "#gpio-cells");
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
-- 
2.28.0

