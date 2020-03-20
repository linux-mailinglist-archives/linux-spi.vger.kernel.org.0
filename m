Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955D518D3E9
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCTQOB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 12:14:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgCTQOA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Mar 2020 12:14:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so6992595wme.1;
        Fri, 20 Mar 2020 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HRtu8AVeAHAknZ42KPGSxOplwEGK88Q8JlmoyejiN4s=;
        b=kVG/0xG2cW1hqWykmx5+YgTdm28vSFNmahqvgTBCKwahH4cTylfhP7akPciw+IfbPK
         7WixZ89wvUJ0DZQ6OlctkE6biuZWJCOfgJcaqAbEopobqJPksRB+h1ti0eHk5u1r0WHU
         m3HW0aNQmQWabF8iKT9Jo5MrjAlAUDNf02W79uuYAi71biLqqzcwYlkNqD6fEGnNEt/K
         FWlpd6wZD891rZz5GWrtvSMtXhqTFzLQ9sS85GsbTyPlLl9WBPGo86gNLdKSXajARruP
         cYQ1g4ljz7+iVlM0Qe8C1nWSvO8MfIT7dreF3OkPL3hNZJ3MlBVlCPl0bMDaPAzFTqME
         4kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HRtu8AVeAHAknZ42KPGSxOplwEGK88Q8JlmoyejiN4s=;
        b=OPFpXXUZejFvHGSFmoBkphGYqIljiFf6SZckJjo2y56xzpu037xHFbO86zmK9/cNbl
         khOm/GYX6z4zSJvW3eFP1S4exXvuZPY44kXe7L7o5qR9RU9cuOxTdoPS1xTvAOp+R7X7
         mScdlU07oMGWPDwUjElLRWc3Cf4z75gkE8NGT5rSHQ5LNtSd+RQRTg3BA5eaR1Z64T1Y
         g/kf7m4BhtzVZ/RqL+2bMVknjnQGITVPjxDUrAnYBVJBPayJamXByCJapW+MMDk2vu0g
         VaYi4jHpElvmE4DfcS+QwJpvtRx9mWwJN+aY3+EEsuPe2qljI7lKWDhtY8QmHcCAwQ+t
         FOEw==
X-Gm-Message-State: ANhLgQ1V0UagMOJ3Rm2MXK/iYxpsC/I7ZIAlqZx9kTtWybKjyIZXEFL+
        XMrXNoy3w8EnlyNzn1ZwFb4=
X-Google-Smtp-Source: ADFU+vs7DqXV+eSKaMKmdVHkPIZZzsNFvLxil12cr4cwWhr5KaXH5uTtC2urbVKUjK98J0uHPcgCFQ==
X-Received: by 2002:a1c:23ca:: with SMTP id j193mr11341609wmj.111.1584720837718;
        Fri, 20 Mar 2020 09:13:57 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id r3sm9121154wrm.35.2020.03.20.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:13:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH devicetree 2/2] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
Date:   Fri, 20 Mar 2020 18:13:46 +0200
Message-Id: <20200320161346.14155-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320161346.14155-1-olteanv@gmail.com>
References: <20200320161346.14155-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

For debugging, it is useful to have access to the DSPI controller
signals. On the reference design board, these are exported to either the
mikroBUS1 or mikroBUS2 connector (according to the CPLD register
BRDCFG3[SPI3]).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 6d05b76c2c7a..0d27b5667b8c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -83,6 +83,20 @@
 	};
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	/* mikroBUS1 */
+	spidev@0 {
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <20000000>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <100>;
+		reg = <0>;
+	};
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.17.1

