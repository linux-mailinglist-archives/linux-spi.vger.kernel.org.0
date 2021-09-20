Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8524116E6
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhITO3Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 10:29:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38144 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbhITO3O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 10:29:14 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KERW4a015725;
        Mon, 20 Sep 2021 09:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632148052;
        bh=5hWRp8SQ/F6dA2b0wXfuXXIFLTZSU7wZCK+QJTioq9U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OsMEr8gVfIuD5DEBJClcQxXNGhaZarK7/obCy+xm8ZIj5WS/R6TXqYcnsqNAEn1LP
         0TMaFu58z7V1dlNRKzCJDfrTkuxJbOA4PRy3GUtzs+V1p0T6psHcOsnlcy51AxZk06
         uTewsMvDULfiHTPZ7fCNefw3+oIr2fUj9jYwak90=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KERWBG026216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 09:27:32 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 09:27:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 09:27:31 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KERE44100694;
        Mon, 20 Sep 2021 09:27:27 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <michael@walle.cc>
Subject: [PATCH v2 2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node name instead of 'spi-flash' in example
Date:   Mon, 20 Sep 2021 19:57:13 +0530
Message-ID: <20210920142713.129295-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920142713.129295-1-a-nandan@ti.com>
References: <20210920142713.129295-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change the nodename in the example with spi-nand from 'spi-flash@1'
to 'flash@1' to make the schema uniform with both spi-nand and spi-nor
flashes. jedec,spi-nor.yaml uses 'flash@' nodename for spi-nor flashes,
so make the spi-nand examples in dt-bindings use it too for uniformity.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index ca91201a9926..d7e08b03e204 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -171,7 +171,7 @@ examples:
       cs-gpios = <&gpio0 13 0>,
                  <&gpio0 14 0>;
       rx-sample-delay-ns = <3>;
-      spi-flash@1 {
+      flash@1 {
         compatible = "spi-nand";
         reg = <1>;
         rx-sample-delay-ns = <7>;
-- 
2.25.1

