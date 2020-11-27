Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87DA2C6660
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgK0NIu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 08:08:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730148AbgK0NIt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 08:08:49 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCUrcr007370;
        Fri, 27 Nov 2020 08:08:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y0p8k45m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 08:08:48 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ARD8k6I049549
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 27 Nov 2020 08:08:47 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 27 Nov
 2020 05:08:45 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 27 Nov 2020 05:08:45 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ARD8dKJ026672;
        Fri, 27 Nov 2020 08:08:42 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <broonie@kernel.org>,
        <andy.shevchenko@gmail.com>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties
Date:   Fri, 27 Nov 2020 15:08:34 +0200
Message-ID: <20201127130834.136348-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127130834.136348-1-alexandru.ardelean@analog.com>
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=615 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270078
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Following a change to the SPI framework, providing a value of zero for
'spi-rx-bus-width' and 'spi-tx-bus-width' is now possible and will
essentially mean than no RX or TX is allowed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1b56d5e40f1f..f1aaaf9b3709 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -125,8 +125,9 @@ patternProperties:
       spi-rx-bus-width:
         description:
           Bus width to the SPI bus used for read transfers.
+          If 0 is provided, then no RX will be possible on this devices.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4, 8]
+        enum: [0, 1, 2, 4, 8]
         default: 1
 
       spi-rx-delay-us:
@@ -136,8 +137,9 @@ patternProperties:
       spi-tx-bus-width:
         description:
           Bus width to the SPI bus used for write transfers.
+          If 0 is provided, then no RX will be possible on this devices.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4, 8]
+        enum: [0, 1, 2, 4, 8]
         default: 1
 
       spi-tx-delay-us:
-- 
2.27.0

