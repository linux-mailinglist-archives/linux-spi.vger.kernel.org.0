Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7780254CDB
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgH0SS4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgH0SSw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 14:18:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C5C061232;
        Thu, 27 Aug 2020 11:18:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kx11so3015213pjb.5;
        Thu, 27 Aug 2020 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CatPPhK9A3iq+4G8OsLNJjr5wv7C3OYfFC9OHG8z8x0=;
        b=q6A4v1REhzHsXoNtbR/YkAu6EirCTqIxVdqQrdtGv88d2YYEly07YjSadVqqijOhcL
         HK1NZA41gHW0VCi00hdDcd2Yiwo3dXPraXqu9x5kH14otsMXVJKOhbZncqwFQ6wtY4MI
         oSApTjReTTfXmUTQORZHLoV0KASDM0AqvRDbT9H2gXkWoHGYdNsKo3LPdM3cUVYG9fhq
         5CBlC4TRalTx2+9jlQO6B1+RnBFc3xU22LauRlPi2ztFSr+HMOSvvvlQAtfm2dV7ZeZ/
         WbA2+ihi007Hhh2PL1/8s8Ogk5vHkVDNLz4XPGeWiEXEJCckiPlkV61H52ONDHum9nro
         Ah+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CatPPhK9A3iq+4G8OsLNJjr5wv7C3OYfFC9OHG8z8x0=;
        b=CimO2tE22TvM2Q7tunc38s26L5xG7JUxZyBiWaYC5pMwZ+gy1kTFerzi5QcBMMmit4
         qJhjBfbQt/nIDBnLs3IKWjHy6ve1NOgaSVDSlSoIfmRmYQhzb6apGhs371t5YoR87mAC
         /rYzHIl/mL4cF+Nzp0AkpdWpdMfeE6nzlg3uo1PZuFgULCAhfnuEYAQ+Wy+bvrX4vx6l
         ZiK06ORjucH6xqn4iH5HPQW5rkwKsCS83gfe3Nhh+pZtzb/ezJ4HVnTLAt9BH71BosrR
         Lm7xuvan35XnJ9r95mwWlNbkfGOnzdaO3mtN18DCNpOJH2qRZGkL8LZyyTQmY2Z92m00
         wmRg==
X-Gm-Message-State: AOAM531ItBMEGWgRqzprTnmElWRcw5DQGvrsGM6FZY/ynjhCS28H27jU
        9PgcHkuzAVlTNLhPKl4/dOg=
X-Google-Smtp-Source: ABdhPJyMqHpvSpd3C9HlHIRazuypsiroUjSp4k/vGcBtgRM2tm00Y+6yPc4yLyhg+f8pNQELqsUljA==
X-Received: by 2002:a17:90a:ad05:: with SMTP id r5mr104112pjq.186.1598552331809;
        Thu, 27 Aug 2020 11:18:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm3580179pfn.106.2020.08.27.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:18:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM SPI DRIVER),
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] ARM: dts: NSP: Fixed QSPI compatible string
Date:   Thu, 27 Aug 2020 11:18:40 -0700
Message-Id: <20200827181842.1000451-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The string was incorrectly defined before from least to most
specific, swap the compatible strings accordingly.

Fixes: 329f98c1974e ("ARM: dts: NSP: Add QSPI nodes to NSPI and bcm958625k DTSes")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 0346ea621f0f..c846fa3c244d 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -284,7 +284,7 @@ nand: nand@26000 {
 		};
 
 		qspi: spi@27200 {
-			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+			compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
 			      <0x11c408 0x004>,
-- 
2.25.1

