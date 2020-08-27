Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69173254CDA
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgH0SSz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgH0SSu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 14:18:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4403C06121B;
        Thu, 27 Aug 2020 11:18:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so2926016pgl.2;
        Thu, 27 Aug 2020 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FN2Vt2rHiJQZJYxgYpljdZm5xb4qlIG3AYHexM9U5WA=;
        b=RDKLzb11Hj61/atBaOUJPwGPTh+Sv/rC0am9Wg7Dot0WSdR9StL4Bg1+hvobCWrhED
         gB07sWEi982VmuDQTj2yxoxnzbQ7feb/nnqMs9CzhtWb5LFFTJA3aryFBDAVlwSJOgwc
         zzdOPtDXuVKUzsUUBdI91HaPXuuwWNSQf6lHmgtligMCd6S8x/utCWVW2iQKNh1DBt6M
         XTokU7NbxR0X1qTYMxLQhnn+huwRzd74UZ4QYhjtzXPIofmJb2y+8tgara7dc9IjmTOI
         JOTVjwOfvx07jNfNzwydY82VzU3zqKhLBk7OEXxSClUS6iv9nCJqtDuiBW3Z6wCo/xXM
         f25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FN2Vt2rHiJQZJYxgYpljdZm5xb4qlIG3AYHexM9U5WA=;
        b=aecdBvTIT+KqLO86iNH/ups+5N9MpN3gY8qJvLXVYEp0McSRydUSkXGOjG9FhzfJA2
         wayHoSPnViC+85nC33w+g6wJrYdw6vKupzDfB66ChtQiuIguw6FheHgAdWNZERUY/9Yj
         4U+aLXEEIkpfCtTdk2P/1hKHEKg+ccoNyBzvtpNNp5WXTdqW81BKWHB+3+Qy2N2Hv7Ys
         E0OPdZH3XHbk/rSxgjl1uKiIvTNRHiPumxbXvlxUgolBo7F2MD8YMF5zz+ejVjIu/c0I
         pjcWV06JJB2Hey13zQbqZF5sMCGSJaPIliUqTnFKA7ocBDvX+rxZATTckdmYzZvvCPhA
         AIFA==
X-Gm-Message-State: AOAM532p22nN+bgiBGf+9hdfIop4JVtok6blOk8JOmsDBUva3jTw8955
        ADU47gW8KKdgUgEf/2Ag0Lg=
X-Google-Smtp-Source: ABdhPJzwV+iNW5pVpRaP+ZVWMf2SduozLYmTfWtf+YyK2Lb5zSVMuUlCR+CPXCVjr4/wJoTnuKt+9A==
X-Received: by 2002:a63:cd0b:: with SMTP id i11mr8264867pgg.306.1598552330187;
        Thu, 27 Aug 2020 11:18:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm3580179pfn.106.2020.08.27.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:18:49 -0700 (PDT)
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
Subject: [PATCH 2/5] ARM: dts: bcm: HR2: Fixed QSPI compatible string
Date:   Thu, 27 Aug 2020 11:18:39 -0700
Message-Id: <20200827181842.1000451-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The string was incorrectly defined before from least to most specific,
swap the compatible strings accordingly.

Fixes: b9099ec754b5 ("ARM: dts: Add Broadcom Hurricane 2 DTS include file")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index cbebed5f050e..e8df458aad39 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -217,7 +217,7 @@ rng: rng@33000 {
 		};
 
 		qspi: spi@27200 {
-			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+			compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
 			      <0x11c408 0x004>,
-- 
2.25.1

