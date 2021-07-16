Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3683CB7FB
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhGPNm3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 09:42:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237892AbhGPNm1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 09:42:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GDcHU2158384;
        Fri, 16 Jul 2021 09:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VTlL4My+pptoWKVEdXz4DaxKF7QUggPsp0oku3RLeP4=;
 b=TiVFDWAvqiOy8LiBwl/3I3BuVlESrA1V3X53z9m6xnFVkw4cabjzCxJTEA2B2Az9vjC7
 QGQlxdGTJCwVu4hCvdzIKr/dEaVoEdV+v5tpYF9QkA8IcSpIN9S4m88ekIweTeifHl0f
 peNZAArClO0zmIoYKyWzU7v94kFo9MPYFHFxqraEnOM545BFXqD5sGrY9FKdu3YH+yIq
 dW7W2HuHQObf1/o2Dqbew7PWgGq9I2OmsRYtv69Q/2UObbTQ4RGsaFkqfo2UKjL8k8Pz
 ICgzrxL26XNUcAqB6p4U1jYB0eP8SyFp0pnol/bfdD7VNxToVMnPUt+nnVd7b3riA7Kr Qw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39twha5kc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 09:39:29 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GDWdhq032171;
        Fri, 16 Jul 2021 13:39:28 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 39qt3etdt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 13:39:28 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GDdRSA34865422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 13:39:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EF636E054;
        Fri, 16 Jul 2021 13:39:27 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B584C6E05D;
        Fri, 16 Jul 2021 13:39:26 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.92.96])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 13:39:26 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] dt-bindings: fsi: Remove ibm,fsi2spi-restricted compatible
Date:   Fri, 16 Jul 2021 08:39:15 -0500
Message-Id: <20210716133915.14697-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210716133915.14697-1-eajames@linux.ibm.com>
References: <20210716133915.14697-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AYx1D1w_qxwQDD4AerFjeQdAtLjTboJz
X-Proofpoint-GUID: AYx1D1w_qxwQDD4AerFjeQdAtLjTboJz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=895 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107160082
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove this compatible string from the FSI SPI controller
documentation, since the security restrictions have been
universally applied to the controllers.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
index e425278653f5..e2ca0b000471 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -19,7 +19,6 @@ properties:
   compatible:
     enum:
       - ibm,fsi2spi
-      - ibm,fsi2spi-restricted
 
   reg:
     items:
-- 
2.27.0

