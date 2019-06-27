Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1057D63
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2019 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0HoU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jun 2019 03:44:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbfF0HoU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jun 2019 03:44:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5R7gOnU025955;
        Thu, 27 Jun 2019 09:44:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=LDoJwloACDp1lGUZApvN4oyiNkplfSxCLcnyBGjtIdA=;
 b=XrnCaniJnt+gl9vXyW6BD2LVyOZphOSHEMdn+2YU/6WsShJD7mp6zhUBFVzODTt4UUTg
 iKEWCb/XOyPKcyA8uuTRd0+U92x7RurNOaBMUwbUygxEKVjUgMaIhTtq6zq6nuztWrob
 5WI//0387MhTAF7S+ow70dHPr9FL75veV4vs5RL2V4cuHC8lgkI1UOKOnbBH1u4xEoo3
 g0lpxJJT1MMM4E6dJFTuJ8Xa4rQUXKWw8nQAaxzHNY5ezamXC99PJaAG58WMtZ2AU8Rh
 pgLp+LsybXBLgu5dh9vVBKbO50+E9IIKRM1tLKaZ1LJsNwT82bgNFuRxC7W0id95HYy6 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t9d2gn3nd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Jun 2019 09:44:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D8C831;
        Thu, 27 Jun 2019 07:44:06 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA24B157A;
        Thu, 27 Jun 2019 07:44:05 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 09:44:05 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 09:44:05 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] dt-bindings: spi: stm32-qspi: add dma properties
Date:   Thu, 27 Jun 2019 09:43:58 +0200
Message-ID: <1561621439-7305-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_03:,,
 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds description of dma properties (optional).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
index adeeb63..bfc038b 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
@@ -19,8 +19,11 @@ Required properties:
 - reg: chip-Select number (QSPI controller may connect 2 flashes)
 - spi-max-frequency: max frequency of spi bus
 
-Optional property:
+Optional properties:
 - spi-rx-bus-width: see ./spi-bus.txt for the description
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names: DMA request names should include "tx" and "rx" if present.
 
 Example:
 
-- 
2.7.4

