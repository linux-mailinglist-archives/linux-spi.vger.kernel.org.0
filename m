Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6198582FA9
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jul 2022 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiG0R26 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jul 2022 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiG0R1l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jul 2022 13:27:41 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082C7F51B;
        Wed, 27 Jul 2022 09:47:17 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RFqMDf020021;
        Wed, 27 Jul 2022 16:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=3M3IEzSGWbR/8RQRMU9r6LZ5cPbzCABI9eXCDPIC+0A=;
 b=irFKYHZf3j0596r68gLyksmrnuhDYGopsxMKjLOfBXXo+qlrrjrloplvMM5LUMejhPZm
 JC5EDdiGlVz4ZC/eT7a5oHkYWE3MLTO19khX1TWDINgEBCohMolobTbZz0jOuFhqtYu1
 2jqaeAOj07nrILLO0tKIqlbdXA59MZj+9bGtYwvpaDdsIy+n+xkMGSuDRMCjtqU7cCN5
 j7K4IraU/4mCS+rWRfVju59Iuo1yRoQ3keJG9N5/3xiezISZzG9Xbcxam98B8SpmzYHJ
 UOl9E2hbE8l8ZED0HQ0AcBA2CqXGj/KQe/E7wvqYppKv60O1Aga1NOeveeXvvd1Q/03J 5g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hk8csre04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 16:46:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D006DD2DE;
        Wed, 27 Jul 2022 16:46:42 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 4BC3B801086;
        Wed, 27 Jul 2022 16:46:41 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v5 5/5] MAINTAINERS: add spi support to GXP
Date:   Wed, 27 Jul 2022 11:47:36 -0500
Message-Id: <20220727164736.48619-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220727164736.48619-1-nick.hawkins@hpe.com>
References: <20220727164736.48619-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: 3hm7R5riO-5aoUP3LisAjDx4V2azFJ2J
X-Proofpoint-ORIG-GUID: 3hm7R5riO-5aoUP3LisAjDx4V2azFJ2J
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_06,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=952 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270070
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the spi driver and dt-binding documentation

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v5:
 *No change
v4:
 *No change
v3:
 *No change
v2:
 *No change
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..f87728549ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2140,11 +2140,13 @@ M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/spi/hpe,gxp-spi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
 
 ARM/IGEP MACHINE SUPPORT
-- 
2.17.1

