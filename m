Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A92CD861
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbgLCOBj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 09:01:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35346 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389070AbgLCOBj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 09:01:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B3E0cSx022951;
        Thu, 3 Dec 2020 09:00:56 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vjenuxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 09:00:55 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B3E0s6a025117
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 09:00:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 3 Dec 2020
 09:00:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 09:00:53 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B3E0mEA012864;
        Thu, 3 Dec 2020 09:00:52 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <dragos.bogdan@analog.com>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties
Date:   Thu, 3 Dec 2020 16:05:31 +0200
Message-ID: <20201203140531.74470-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203140531.74470-1-alexandru.ardelean@analog.com>
References: <20201203140531.74470-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_07:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=739
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030085
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Following a change to the SPI framework, providing a value of zero for
'spi-rx-bus-width' and 'spi-tx-bus-width' is now possible and will
essentially mean that no RX or TX is allowed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v3 -> v4:
* https://lore.kernel.org/linux-spi/20201127130834.136348-3-alexandru.ardelean@analog.com/
* fix typos

 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1b56d5e40f1f..cf663e4a4afe 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -125,8 +125,9 @@ patternProperties:
       spi-rx-bus-width:
         description:
           Bus width to the SPI bus used for read transfers.
+          If 0 is provided, then no RX will be possible on this device.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4, 8]
+        enum: [0, 1, 2, 4, 8]
         default: 1
 
       spi-rx-delay-us:
@@ -136,8 +137,9 @@ patternProperties:
       spi-tx-bus-width:
         description:
           Bus width to the SPI bus used for write transfers.
+          If 0 is provided, then no TX will be possible on this device.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4, 8]
+        enum: [0, 1, 2, 4, 8]
         default: 1
 
       spi-tx-delay-us:
-- 
2.17.1

