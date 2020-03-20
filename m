Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B809018D3E1
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCTQN5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 12:13:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37903 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgCTQN5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Mar 2020 12:13:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id l20so6994277wmi.3;
        Fri, 20 Mar 2020 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T/IZAM0hGmcP9+cRiawGBx8BIofo1ODEPgXI0xOz5JQ=;
        b=A41y/OOh+uH341q5nsebQ7GTG7UCgVGB+mpUNhuv8UmKnkO6fL8q+Fqa4mH++LdSoD
         wfS958k2EF6tynHcBsVvBNkydlf720FRBImd4Kseli7Wz+h4BIE48FkMpsu/5MdXizGp
         o/e9Z8KcHHzojXMe9WgwdX3v7nb4GZE9agEGSR2seOenjrJU69IGEURgXhZT945UeEt5
         TqxAgK6q3VZ7Fo8Qt+Z7pJjeKDWK4Yiup7Mbaw2/l//kyxft56YG/R1ik8AcSRpXcpXB
         TLpRAatujT0RxtxgsocUXKNUzHMsTmiapla3Chub1pXR/KQRV7nWji+5dBl2Vd6kcwF5
         ksaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T/IZAM0hGmcP9+cRiawGBx8BIofo1ODEPgXI0xOz5JQ=;
        b=VcL5svevf3m1mpq8LpNrs53nN6Z7IwCuApJjEvG/INx6D35GSdhy8TRQUS1MFAYMUS
         UZKY4G14RLiPL583CtsyKvyWO72t12os196LJilf3hhB0QcSoy3J2yhRUq3jB2IfkhGc
         c7b6+15jQtcoK3FIjFwoZ4FPZOloXpOK0sXX2rIVyuQO+U9lG8cKt6LejnCte0RdWhdH
         C716AFDFWQ2oSXcSk+MWEI0n+tRDJpoflmVFvDfUDu9ssIdlo1gWKC+js7Rm8x7jkOCV
         Ew4xGAtMqxdWQNKNP1Ay3OOB8esZZ5lSF8nHaE/MENn17yuet9K0bVPWWPtxjl66AqFO
         nKbw==
X-Gm-Message-State: ANhLgQ1ehpVny3H2x0/w4XXbbjCSYQpdPa8mbGHXW4tfrvhxaE3Yd+dK
        SOcw/BXO1s/EPmmX58O6/Uw=
X-Google-Smtp-Source: ADFU+vsYtsiOv0xYIgAiB/DAQonqa0r4h7melk2HzMlT4HaABV76dHwG+fxqhV7pYkNS7nGaI+Sjig==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr9219263wmh.104.1584720835137;
        Fri, 20 Mar 2020 09:13:55 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id r3sm9121154wrm.35.2020.03.20.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:13:54 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH devicetree 0/2] Remainder for "[PATCH v5 00/12] NXP DSPI bugfixes and support for LS1028A"
Date:   Fri, 20 Mar 2020 18:13:44 +0200
Message-Id: <20200320161346.14155-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The series with DSPI support for LS1028A was merged by Mark Brown in his
linux-spi tree here:

https://www.spinics.net/lists/linux-spi/msg20842.html

These remaining 2 patches from that series apply on top of Michael
Walle's basic device tree support patch:

https://patchwork.kernel.org/patch/11389157/#23165893

Vladimir Oltean (2):
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |  6 ++++++
 2 files changed, 20 insertions(+)

-- 
2.17.1

