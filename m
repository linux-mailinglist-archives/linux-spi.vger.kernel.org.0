Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DA2DFD84
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgLUP0U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 10:26:20 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15438 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgLUP0T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 10:26:19 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLFL2Tm012110;
        Mon, 21 Dec 2020 10:25:38 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hfa9wc7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 10:25:37 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BLFPaPU034392
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 10:25:36 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 21 Dec 2020
 07:25:35 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 21 Dec 2020 07:25:34 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLFPRHM001932;
        Mon, 21 Dec 2020 10:25:31 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dragos.bogdan@analog.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties
Date:   Mon, 21 Dec 2020 17:29:36 +0200
Message-ID: <20201221152936.53873-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221152936.53873-1-alexandru.ardelean@analog.com>
References: <20201221152936.53873-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=737 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210109
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Following a change to the SPI framework, providing a value of zero for
'spi-rx-bus-width' and 'spi-tx-bus-width' is now possible and will
essentially mean that no RX or TX is allowed.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v5 -> v6:
* https://patchwork.kernel.org/project/spi-devel-general/patch/20201221141906.48922-3-alexandru.ardelean@analog.com/
* no change

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

