Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2573B254CD6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgH0STL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgH0SS4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 14:18:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF6C061264;
        Thu, 27 Aug 2020 11:18:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so3051397pjx.5;
        Thu, 27 Aug 2020 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxmULkJUlPJ0j1k6lcIgCZG5M7EGNDQkghcppoKAqWM=;
        b=cIV9jK65cCq1DtQMSLjUfQ078BoS4IFTNZmc0plZjtfXSjK6UECYi+74VZ+YHiVYFN
         h4P3NKLNdBQv22Dl/7fANby7hhpv9vTK/MX2hYrYi00/suujYOUlxLEDxmrB09IxD6AR
         0sDoNy12cSu70635GDgiFbPJL2qpFNa64k2I6Z/VCmjlcKCS2ut/svN7dnj5llIBZlRn
         bs74rGsDy8Ky8lV6vF6dwpjBnGyhmUA9NZLUfIGL3V1RB0Z3J2hJtZ4PUAnrKVmFGthW
         dZvMLyFdxNFP1AfXi6FuigjXTUGivszRpoE8JqGHzcBLruZnjsJVq8h2Qi8/zzJrkm0U
         xhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AxmULkJUlPJ0j1k6lcIgCZG5M7EGNDQkghcppoKAqWM=;
        b=JRHPwW2ytf5mBVeVqoUloniDFbSLOGSOcJplBmP3kPaQxVyOLqS8suxZn1eb7VEAXJ
         ottyu3310UFHg/GP91B/Y7UFp8y9DEqmDnFBMveJGoEKGPOJ2AE/mWINkX6ZAn9Qb16O
         wLcnuLKWPcPOWdcss/B9ywmYxF2xbhbfOWKD3QCf9o/fFD30zJ9kaGs8rcEGAnFi5O76
         4CxkWu/Grwp+j/vyECw+lN4lc/aVtyA9vNhao/jFYZ9RIuvfGT7RgNOyd6IMMWnZZMt5
         Q7i/eHtmvCYw5A3jOgvAAosE7sxrBfOP/ubXw89VvmjOQof/hwKt8rudLx42B6WElAvg
         cH4A==
X-Gm-Message-State: AOAM533RE0QyYz4gUA6uNodiMRXx/PkuRbNKbG5KC4IQdmmTcmI4YRi/
        r8Fv40DBDoUA9JOcPl8gDuY=
X-Google-Smtp-Source: ABdhPJyHl3YlRZvGe3nPyemkInLkd2D+iFh/iW4Fs2NFdP9gnVxtl/xHR1ozdtFi43v4aIOFEkSx4g==
X-Received: by 2002:a17:90a:d712:: with SMTP id y18mr93319pju.79.1598552335285;
        Thu, 27 Aug 2020 11:18:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm3580179pfn.106.2020.08.27.11.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:18:54 -0700 (PDT)
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
Subject: [PATCH 5/5] arm64: dts: ns2: Fixed QSPI compatible string
Date:   Thu, 27 Aug 2020 11:18:42 -0700
Message-Id: <20200827181842.1000451-6-f.fainelli@gmail.com>
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

Fixes: ff73917d38a6 ("ARM64: dts: Add QSPI Device Tree node for NS2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 15f7b0ed3836..39802066232e 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -745,7 +745,7 @@ nand: nand@66460000 {
 		};
 
 		qspi: spi@66470200 {
-			compatible = "brcm,spi-bcm-qspi", "brcm,spi-ns2-qspi";
+			compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
 			reg = <0x66470200 0x184>,
 				<0x66470000 0x124>,
 				<0x67017408 0x004>,
-- 
2.25.1

