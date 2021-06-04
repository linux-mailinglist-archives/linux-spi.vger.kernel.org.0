Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1239BB78
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFDPNS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhFDPNS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:13:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50258C061768
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 08:11:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso9380209otu.7
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Axi/Uev8x89LTj+S3KWC83OqhvyPd7zI+O6x+3a1ANs=;
        b=pXsgNeUzYIDLxE0VMZw/i2wgMFqIy9Z19Bqkdv899couZg+c72RfXzqwdSu3omFeoI
         PQrb79SFQRfagJqIqflH6LZJYfRbAZnqmHFwEromxlDVGVyyFeAR1o1Yk4lUakABVBv0
         gQqLnams5pAE/4prNBFGV2/bWvBoUqLMEzzBQVUP5OD6qxJQV46hguaE6FH3Jw6jpx6A
         zeK6ByWppWhxVI1GuDFvfblpNb8SR1HfQKLJzH56TgKvNIRd1SLD3UNHlkVBdn6Bjobx
         msfvnSbtcBinshoBhZkbG2R/H0GzPLWOELSqQUPnicD7/ZMcCSuwFtwu++1RfzAFeqhi
         8ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Axi/Uev8x89LTj+S3KWC83OqhvyPd7zI+O6x+3a1ANs=;
        b=ujNA/zy6HWa50c70642Cp9RfwIY01fGZI4465wVKUI9sWlVJjyP8dywgj6MXhcTk9w
         /3hzgXYSPXfcN8ZhJO/GHAm5OF9raVRT5WXN4E/R0fhmcpmQ+bsKQLwcjpzhCHU0FyvL
         mAlXVCpYPqm9chLWe/uOmqwrOYXdY5OwtUGcX9AZWe9JVP2hKNv9bgmJFNm5MBO9pL51
         Suvi/+MnaEroQY0pJ3VEnz+ZKNdOEEqgL/qgVwX225QI6479GO/oIwzaSl5dsPs4WZEX
         mkJrhkNg3IU/t9ZQjn8jEj8jT9AnJHAjR8VjeiN19XK/tO+vXS4voZ/IBzAoSJEzxRIS
         QssA==
X-Gm-Message-State: AOAM530Orx7vd0p5LMdfd96YQdnmSyDw6/e5BXyLvgl0Aj9zkFuMhqHJ
        U3fKJ8JoZBxb9Cb55TVEnkp7j74gNXo=
X-Google-Smtp-Source: ABdhPJzus7QkWZolLTF8j8qgAivcqHh94rvtf71D3K1YLdVBaoV9tqY4DxxrBRCgR0aHJ8qJP/vqKQ==
X-Received: by 2002:a9d:355:: with SMTP id 79mr4301635otv.101.1622819478023;
        Fri, 04 Jun 2021 08:11:18 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:17 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 8/8] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
Date:   Fri,  4 Jun 2021 10:10:55 -0500
Message-Id: <20210604151055.28636-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
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
index 49c97f76df77..f78e11dd8447 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -484,6 +484,22 @@ &sdmmc {
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <108000000>;
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

