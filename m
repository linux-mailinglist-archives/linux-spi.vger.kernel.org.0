Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFF397B04
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhFAUMS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhFAUMR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 16:12:17 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDEC061574
        for <linux-spi@vger.kernel.org>; Tue,  1 Jun 2021 13:10:35 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so591423oiv.1
        for <linux-spi@vger.kernel.org>; Tue, 01 Jun 2021 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1IlgvnVJwHgpqMHaCMFQfQ+LU3PHCxwl3hNw4XjuSw=;
        b=EeNU8PFN5nikWcHPD/AwUBoiScDgl3EWWa8zrjb9U/cIEJaY/YIDjVHe2I+r9DlqRz
         keTAwHu+jIwm+1KlgwWXVTU6efE2liPqXwTj2+SqgtNecF85PawwDOJ+CD2PnjSEJpRM
         Hho76fCx8UppcH6i+Y2LYtrUGMIZjP6pbStqRwo/EEdDqyYlu03GH4zXLTNpxUu7LpW3
         cMCwetoqLRXuJ3YcBIbMVwMtyek4TGjTprNx8g4DQP4ZLQuip7yEDnnBZ+B9rRavhwOu
         5/OsJ2FecXsBtzrQOa94o9MZDjM+jP+O8QLEcDmgLkduywyVbnLhZPmKjpIWuypuioHy
         ZlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1IlgvnVJwHgpqMHaCMFQfQ+LU3PHCxwl3hNw4XjuSw=;
        b=jMWh/DJD3rMOLH+LuvsJyiNJFrnC1MUd5SNunhP7mqBuJ272FlGVQwPA94PEcoiinw
         3EswX1YMeqbgrPazIIMus6XuGsUdL5th7PCEcKUEDRaNpYXqt8Izju0KHHQhHjHylhwD
         yDIKc4KpfcNMES7Ru5N3inuW1A7cz35l2ohcVHhOOQzZyuxGeBNr9b3UsXE6OsAOu3JT
         HGuqELTr2y5CZMaGvbZiiuZVRoVFXLOjHsn9Nsn+Fdy5MfM6oU3qpPK78z6sl7kejZE+
         mIyCVI99uJSFWL/fQ5ZP+4pAdnQKST2UkjFYkObMm1CWSjW2+SGzZpu8epcfbfxj2b3Z
         f4BA==
X-Gm-Message-State: AOAM533ftoW5O3x/iOAV4ix8a6nRQO8qkN9OEdef6mzTzNrc3oqdyfbx
        yTwZlp8E5KaLJFPuVZD+IDb9JoWVAqA=
X-Google-Smtp-Source: ABdhPJz9bgTRA0/4PRS/IEFOuAyN5MObDSPJSbOquTl1lnc/ePqcF0ozUNWfTLHywvolDHjhWICuXg==
X-Received: by 2002:aca:1c18:: with SMTP id c24mr7158644oic.139.1622578234094;
        Tue, 01 Jun 2021 13:10:34 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p25sm468118ood.4.2021.06.01.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:10:33 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 4/4] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
Date:   Tue,  1 Jun 2021 15:10:21 -0500
Message-Id: <20210601201021.4406-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601201021.4406-1-macroalpha82@gmail.com>
References: <20210601201021.4406-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

This enables the Rockchip Serial Flash Controller for the Odroid Go
Advance. Note that while the attached SPI NOR flash and the controller
both support quad read mode, only 2 of the required 4 pins are present.
The rx and tx bus width is set to 2 for this reason.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 49c97f76df77..46f1d2f356cc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -484,6 +484,22 @@ &sdmmc {
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus2>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <108000000>;
+		reg = <0>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
 &tsadc {
 	status = "okay";
 };
-- 
2.25.1

