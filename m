Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D545FF2A
	for <lists+linux-spi@lfdr.de>; Sat, 27 Nov 2021 15:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhK0OZA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 27 Nov 2021 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbhK0OXA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 27 Nov 2021 09:23:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D096C061574;
        Sat, 27 Nov 2021 06:19:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so25213182wrn.6;
        Sat, 27 Nov 2021 06:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rs1vltk9uRLtJlv1JN67bIfY9H+/oNUCoFzx5XImALc=;
        b=lusi+qSAJybLG5GOHY9d+VZ66Uvb6zLa8539YNULtqXWBSuk5WXXPn3BsUdtZZGuT3
         0CfE4T2V9zzPfDXaWMF4xzwx2vkdfajS86MxTBFBwE5Xs6X8Jx6qFsIjmNa1GUXKBK0s
         gf4OJNhAI+zdZTKYN6oFIjbF9cqQc/oWqOwFZD9FvScBIZzgol0/bTaXy3I+m/htt+a4
         R8qo2Ibs2xJOHaUmRmQQD3KLOquDhEEFXmrvaKfJ9K1tDQgVktlLOm5Nn1J+aFntgp32
         6EsPcp/2/ZPKTzb7yxdJ5zoilFsU39c21Qpn8zqu5cl5yrVxptaWQ+FxpFiakUxaCFa+
         aR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rs1vltk9uRLtJlv1JN67bIfY9H+/oNUCoFzx5XImALc=;
        b=Te228p8z5eDrm3UUL8+UxSav0ZyqK8+kHY+yOkyct8CRsB5X7MBj8Eo87rkFzbpkFv
         vFDN4vsv+0if1kB+XfbBtNpcV+/jp5CLnQFY/uRWATAhRDySQSxQhuuptBvgx0kdltPI
         2c6MAdVW0pZ4cRWxfOnueEwVZx7kAmQuk4ieakwz9xohzHKf59IzsqeccHSyOizCh8Ej
         qfR9PfYs5rKoDM2sY6cAEt8uO5DcS/P+nx97bwn1uM8Y/H6577kDcRH/78RBTOdLRcsL
         BLcy4WUx4P1vijufUH/8O0PfqI72CUwNXB+4hz1Ls5XtQr6KMkmUCHryZTbyW6cNqETX
         PINw==
X-Gm-Message-State: AOAM5306WEaUY0FDBeuylZJpaLf9pPa76HRLoldGnFRCBtogjkGh8/Z0
        8jl4X3dgFxinULsSN1a7ZFA=
X-Google-Smtp-Source: ABdhPJwGX9REL4Zzk45kInjHUw2v717C7ACm/3cCxTw+9Wo5pJuqqqvZ48rpjvcXVRD0pQUq2QotKw==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr21582797wrt.126.1638022784121;
        Sat, 27 Nov 2021 06:19:44 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1sm8509839wrn.63.2021.11.27.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:19:43 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
Date:   Sat, 27 Nov 2021 15:19:07 +0100
Message-Id: <20211127141910.12649-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds a compatible string for the SPI controller found on
the RK3566 and RK3568 SoCs.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 7f987e79337c..52a78a2e362e 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -33,6 +33,7 @@ properties:
               - rockchip,rk3328-spi
               - rockchip,rk3368-spi
               - rockchip,rk3399-spi
+              - rockchip,rk3568-spi
               - rockchip,rv1126-spi
           - const: rockchip,rk3066-spi
 
-- 
2.34.1

