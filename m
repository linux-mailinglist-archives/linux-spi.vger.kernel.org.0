Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0614A331EB4
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 06:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCIFcu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 00:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhCIFcZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 00:32:25 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C409C06174A
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 21:32:25 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvkP23Btsz1ryX8;
        Tue,  9 Mar 2021 06:32:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvkP234vvz1qqkj;
        Tue,  9 Mar 2021 06:32:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 53zdUOVpmrEF; Tue,  9 Mar 2021 06:32:21 +0100 (CET)
X-Auth-Info: Kk/tfIKVoE3gisiB43eb9Uu9r2xxhBNBTWDPjwc95Tg=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Mar 2021 06:32:21 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 29B931836B1;
        Tue,  9 Mar 2021 06:31:20 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 1F61B1A0092; Tue,  9 Mar 2021 06:31:20 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller
Date:   Tue,  9 Mar 2021 06:31:14 +0100
Message-Id: <20210309053116.1486347-3-hs@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309053116.1486347-1-hs@denx.de>
References: <20210309053116.1486347-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

add compatible entry "nxp,imx8mp-fspi" in NXP FlexSPI controller

Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
index 7ac60d9fe3571..fd5f081f6d91b 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible : Should be "nxp,lx2160a-fspi"
 			    "nxp,imx8qxp-fspi"
 			    "nxp,imx8mm-fspi"
+			    "nxp,imx8mp-fspi"
 
   - reg :        First contains the register location and length,
                  Second contains the memory mapping address and length
-- 
2.29.2

