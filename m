Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65922DFCAA
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgLUOPu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 09:15:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9128 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbgLUOPo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 09:15:44 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLEEqBo016490;
        Mon, 21 Dec 2020 09:15:02 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hfa9w6m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 09:15:02 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0BLEF0l4047589
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 09:15:01 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 21 Dec 2020
 06:14:59 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 21 Dec 2020 06:14:59 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLEEqnp030685;
        Mon, 21 Dec 2020 09:14:56 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dragos.bogdan@analog.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties
Date:   Mon, 21 Dec 2020 16:19:06 +0200
Message-ID: <20201221141906.48922-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221141906.48922-1-alexandru.ardelean@analog.com>
References: <20201221141906.48922-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=843 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210102
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Following a change to the SPI framework, providing a value of zero for
'spi-rx-bus-width' and 'spi-tx-bus-width' is now possible and will
essentially mean that no RX or TX is allowed.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v4 -> v5:
* https://lore.kernel.org/linux-spi/20201203140531.74470-3-alexandru.ardelean@analog.com/
* added 'Reviewed-by: Rob Herring <robh@kernel.org>'

 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 5f505810104d..06786f1b43d2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -152,8 +152,9 @@ patternProperties:
       spi-rx-bus-width:
         description:
           Bus width to the SPI bus used for read transfers.
+          If 0 is provided, then no RX will be possible on this device.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4, 8]
+        enum: [0, 1, 2, 4, 8]
         default: 1
 
       spi-rx-delay-us:
@@ -163,8 +164,9 @@ patternProperties:
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

