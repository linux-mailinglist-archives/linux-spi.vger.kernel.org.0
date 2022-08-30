Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06335A63C3
	for <lists+linux-spi@lfdr.de>; Tue, 30 Aug 2022 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiH3MpL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Aug 2022 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiH3MpJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Aug 2022 08:45:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A1193F7;
        Tue, 30 Aug 2022 05:45:03 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-062-005.ewe-ip-backbone.de [91.96.62.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C11D6601E7E;
        Tue, 30 Aug 2022 13:45:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661863501;
        bh=2VRCEincVJjT627e3Nw49HHXJWUdruE/J5OpojuwlDg=;
        h=From:To:Cc:Subject:Date:From;
        b=PY8+M/HLYy844jYchmDmj30gZp1VxCjOid7+REt9WtFD9iaX3XtaI2AmqVgbUTwUz
         pg0BbTXqbw700etFM2n2n+kx8DXfu8UWWoQD3Dgl0avjGm6CI6zHuAEjEXFAGEHnkr
         D0KvlB+DAgn7BD572H0kxaqN8bGBJvagVNfGvUvU3t2dHtoJ+3qCeG2lcS6nT532GQ
         1sRCWfUKSn/TTmmkVx7Gkzpar25GMiI9UR7HKPExn0w0lAGF6VTfPfeqxJGofD/Mk8
         xiNzbs4ZOmAZFJycbu1uvrGg+H3mOqcxtKtqr22jLZjBjswuTfeqjVOkvxHDZlK/DA
         l9bUI5y7E+o2w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5BD1E48015C; Tue, 30 Aug 2022 14:44:59 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/1] spi: spi-rockchip: Add rk3588-spi compatible
Date:   Tue, 30 Aug 2022 14:44:52 +0200
Message-Id: <20220830124452.33561-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds a compatible string for the SPI controller found in
the RK3588 and RK3588s SoCs.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
No driver changes are required for rk3588 SPI support.
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 52a78a2e362e..21f2de785102 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -34,6 +34,7 @@ properties:
               - rockchip,rk3368-spi
               - rockchip,rk3399-spi
               - rockchip,rk3568-spi
+              - rockchip,rk3588-spi
               - rockchip,rv1126-spi
           - const: rockchip,rk3066-spi
 
-- 
2.35.1

