Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4022DD05A
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLQL2p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 06:28:45 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43634 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbgLQL2o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 06:28:44 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHBLCkB020616;
        Thu, 17 Dec 2020 03:28:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7YFeqISpAMwfqNx70P2S0xMzISMHHdaO9qYGMyfwudU=;
 b=FMeAgIDyRp00XW6mFTjZpp9Apjcfd0+/uR3+89JRscbdZOuEJXL5f02GnTQPtiRLQBab
 eg3vw3w5MgmKAHeei+AkDzpEYjOupA0JGlqgRi7KPHyVotQuYQUZlZrl6TREt4KB3XT9
 RwUh8Nl8Zen9pC/TJXm63xaHxhaCb3+IWGl2K78oYulu2U/AAReJ0byOq0m7QtLPXERL
 bW9m2/oqfSxJFWUMJbnbCds+9Lodunh6KtfVhTPnCilTYOicEwzwJhc7UIOx9SwrwwyV
 zUXn8oIOgovVE9wdLX2fSvlHr0km+WX+nQqRdw3+gAgz2yeeZTkt9jDkxZ+l+pXqN94N wQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tfcmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 03:28:02 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 03:28:00 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 03:28:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 03:28:00 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id D06A43F703F;
        Thu, 17 Dec 2020 03:27:57 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH 3/3] dt-bindings: spi: add support for spi-1byte-cs
Date:   Thu, 17 Dec 2020 13:27:08 +0200
Message-ID: <20201217112708.3473-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217112708.3473-1-kostap@marvell.com>
References: <20201217112708.3473-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_07:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

add support for enable  switching CS every transferred byte

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 5f505810104d..e6102a29f3cc 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -171,6 +171,11 @@ patternProperties:
         description:
           Delay, in microseconds, after a write transfer.
 
+      spi-1byte-cs:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires toggling the CS for every 1 byte of data
+
     required:
       - compatible
       - reg
-- 
2.17.1

