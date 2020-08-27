Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE23254CCF
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH0SS4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0SSy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 14:18:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D839C061264;
        Thu, 27 Aug 2020 11:18:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so4129919pfb.10;
        Thu, 27 Aug 2020 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWEGjrPVeQY7q74ALv9YEvs+7dg18MaH1fONO0hwUXo=;
        b=TvVNg0zLEaMe/if7bHVLqge2Wq5YSHCcoXWdEI7NaQNxXsrF5bxaxu4FCs/CTTaypv
         7NNo87iPUdgYUvV0m6KxvCslkLZCRmZVNRN77P1eQvnIl5XmRDEXwCQus4O58iqOHU1w
         A3tpPuT86C9ReSMobznRt8KLSxWVHZZWJP2+lkDqbiITm0ML7ldqC1RjKZZTJI/2bLjz
         VRNLg5mEW7i7946zyRwvfdQV+5k+eGOUIV87w0RCJODLdxE8gjspNW9BbWFyIiD6qzyI
         RfGCISl+TF1WkKdLP6xmepnMDhdCseM6pEf6tlhqNskSFe89wmjpP82M3XjDW/o77/KO
         R7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWEGjrPVeQY7q74ALv9YEvs+7dg18MaH1fONO0hwUXo=;
        b=ebwFe8M3UmCegyTghaJMsXw02Asbj+zd/RIXdFywKnWbAKVGrzAiCGHk0YPZfhbmZ+
         P3j/Cvo9lyVkMYJMnP/KEw5JpZ6cCcprsKmpv/q9l+pIIOW5YYljJw7P5KfxBdxzHG/I
         XUBJCoboNhbgxrOuSZIg3TjtaMAYaOsseIEWvY+qEtJuljiSbovDxT0H64YauDETM87x
         453LPkV653xoGmU/UhZtiCoXmBpxG0wK+MDvveRRH8FyjuR10Hvj14za385fQPvi1+F0
         Fn6AVgXxx1NykLapP6+8DH5Os8rQDcejR2gKO/GuhQVBSpaFUB7tGTaS/LhsRvNoYC/l
         t/mQ==
X-Gm-Message-State: AOAM533Gjwf0cMiTuh6NQAdap29ot9n/VfsuuUuOma2BKwGjRrv3kg0k
        ejgEFaHUxTUnsJWVtftbBIg=
X-Google-Smtp-Source: ABdhPJzx3hkAE/P+tGjBhOPy9WW8+9VI2y0iNI9hLyVjFfHn8On9W36EQudYnNUXxbLvn4hv4ya4mA==
X-Received: by 2002:a63:4c11:: with SMTP id z17mr15248438pga.152.1598552333632;
        Thu, 27 Aug 2020 11:18:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm3580179pfn.106.2020.08.27.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:18:53 -0700 (PDT)
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
Subject: [PATCH 4/5] ARM: dts: BCM5301X: Fixed QSPI compatible string
Date:   Thu, 27 Aug 2020 11:18:41 -0700
Message-Id: <20200827181842.1000451-5-f.fainelli@gmail.com>
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

Fixes: 1c8f40650723 ("ARM: dts: BCM5301X: convert to iProc QSPI")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 2d9b4dd05830..0016720ce530 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -488,7 +488,7 @@ nand: nand@18028000 {
 	};
 
 	spi@18029200 {
-		compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+		compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
 		reg = <0x18029200 0x184>,
 		      <0x18029000 0x124>,
 		      <0x1811b408 0x004>,
-- 
2.25.1

