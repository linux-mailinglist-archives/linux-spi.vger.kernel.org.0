Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4960924C3EC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHTRCz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:02:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729879AbgHTRCm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 13:02:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KH29jH036414;
        Thu, 20 Aug 2020 13:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oCVsg2++cVppf7xzarM62n39OmMOblh0KEy36OO4NPs=;
 b=ItWo/q5rfy6itcxUVUvZ97Z6CWpvcgq9bq1N271R4vT5ORDyIyicPigtYOLGKa/puGBJ
 6YeN1yaKG9jLa2oLM3HAYV81KCMR2VT9Z7PZRx0gIOluNPP2kzxH6sI4sOZ/eSysLfYv
 39JdFrHJP/105wSseYCHFPBoMnSho9457HU+LGVPx1xxlGtD+3MkVYMQZUad5wUUjJn7
 wSrwSV4BpflaAIDtUGyrBwa1TQcI1mi+BMj0pP0LiDiHRvx3D0Td5ZEPRsJDYZgBwm9A
 hcsWoJdqC6Gg2PMhSrVaobaYrSI089Hpub1YiNN7VGyHMN/86QmldGfUyZapxF1QJzOv QQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 331uj3kd00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:02:37 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KH0aFt008659;
        Thu, 20 Aug 2020 17:02:35 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3304th5pyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:02:35 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KH2YRb51642670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 17:02:34 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D12A1AE060;
        Thu, 20 Aug 2020 17:02:34 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD37CAE05C;
        Thu, 20 Aug 2020 17:02:33 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.70.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 17:02:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, joel@jms.id.au, bradleyb@fuzziesquirrel.com,
        broonie@kernel.org, robh+dt@kernel.org, arnd@arndb.de
Subject: [PATCH 4/7] dt-bindings: fsi: fsi2spi: Document new restricted property
Date:   Thu, 20 Aug 2020 12:02:25 -0500
Message-Id: <20200820170228.42053-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820170228.42053-1-eajames@linux.ibm.com>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200135
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add documentation for the "fsi2spi,restricted" property which indicates
a controller shouldn't sequence loops and therefore has a smaller
transfer size.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
index b26d4b4be743..0d2fb071fd00 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -24,6 +24,16 @@ properties:
     items:
       - description: FSI slave address
 
+patternProperties:
+  "^spi(@.*|-[0-9a-f])*$":
+    type: object
+
+    properties:
+      fsi2spi,restricted:
+        description: indicates the controller should not use looping in the
+          sequencer and therefore has a smaller maximum transfer size
+        type: boolean
+
 required:
   - compatible
   - reg
-- 
2.26.2

