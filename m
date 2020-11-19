Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3A2B9204
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKSMDB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 07:03:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54227 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKSMDB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 07:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605788069; x=1637324069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXJrIaVsxDsMBU5I3i9cV2ZN+GdyANZ3n8iU5PEg9Og=;
  b=B/P787JA6UaWBlMarSIpiBk636XJigyvj3HDI6YeNIsdL/39VmG5vJuS
   7ztTuL1Ma3mW3w4C64PD4yDyteHNxNEoxqROCeNqG3P9mjyhfos84vobs
   n0EucYIGwus+MHwfLwOAoPjqaQnu8cI2iKX2JN8oshgmPyemcApscoXs0
   53deQKH5ScZbuQqXiL69YwrV4cl256INyEUF2+0qbnNekK4knk7UXDUvQ
   RUfiaN9lDJwBJ7vtkJDxWWjrY+k+B2Y93gkbYppi6zsDy0Vu+RAQhx7AE
   NX1uXhwXD0d5MVkpUu/0xPkHsDqCiGDXF3ge5akUVjGvINMNRtFKCKgWY
   g==;
IronPort-SDR: pUQT1uPssGmyH6KBcyjKE7eeUoI+ckRecTA+RLVvzebLNW2KwIOU+u6Wt/VaeIseEi3l4PdlkR
 l1eSXsTDIJcrLbnwxiR80IwXx7mreSgr/kxSXQ3EdFYjGUKPDUlPDZxK0s16edxtVS926YO+H9
 8twjT1dRiDlzYI4qkBrVdIbogaZC3dqN+LOrx5O1lQd2F73kW1woz5pV6AOk+S4Gi/vwAF940a
 0ChNtsc2dZM8eMV22gYrJSsBQMVjxj6r3tZlZfEnZ+vW98gQ9u7mc/wPUCA2r8v/HnN9/HVLk0
 E6s=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="256574394"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 20:14:28 +0800
IronPort-SDR: 9hJYIZXHErHtMBCSt2Ca9jtvNLDu7wS5GZu+4IX1W3Qs+wYzorcME3uvJYZIOqnmgTtVNpoZ5X
 2RQWnRyh4lrbcm0pzRBWOUZGDPt66b9DEghljiFjxIW72V0LM4f8lYcyTRq6Nyr1ZHSxxda3Yr
 zsnQ1XTgQpRwURlSHEgsMXHrplwWHpsfuj7l8lcbA+IsEvUO9lRUDAOH5TTLkVjRCBKDnkDGX/
 kKYXrp+BwX35CgNqDlsy7bHRBZuJlaxqHNF4vlibxWrEFUBhrUFJLqDTiQdlwCFZ/cTFLZ/Srm
 s2LUp0gcnNrMuT7Va1nhi/4o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:48:51 -0800
IronPort-SDR: xOwVe1JhHWaggm9gRRwxWcJnkKjRSB+yeF0dgwj+8YPxrFNsv8MJVdcYQ8/iRAvOGZlOaS1qq8
 k+RZTqlIKRcUucQEiS6QAjqa8/me4USkDfU4eG9URKCcauhKLd0QgIF3smqi7VtQZP1//lIDiM
 iSwvfaB8aJlFhBISIF9XX/KPZBh55huZMBP/NpdXW56yWbJynl+nBAMo5lWgh4q7tL4/ZKtQ6B
 bDPz3vyHO5b5dwAQZZBZEu3+Bb+sEqvxnaBfIXrQQbWRiw4HBKLAVD/MQyx3Fi701raWlOpkFW
 jro=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 04:03:00 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 3/3] dt-bindings: Update Synopsis DW apb ssi bindings
Date:   Thu, 19 Nov 2020 21:02:53 +0900
Message-Id: <20201119120253.390883-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119120253.390883-1-damien.lemoal@wdc.com>
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update the snps,dw-apb-ssi.yaml document to include the compatibility
string "canaan,k210-spi" compatible string for the Canaan Kendryte K210
RISC-V SoC DW apb_ssi V4 SPI controller.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
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

