Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953145F120
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 16:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378287AbhKZP5t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 10:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbhKZPzt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 10:55:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D3C0619EA;
        Fri, 26 Nov 2021 07:44:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so7099093wmc.2;
        Fri, 26 Nov 2021 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vwik1mNyYOqHPapDPau3aXiBOWO/s+qGHcQQOuPlOlo=;
        b=lNhEXTCpWNUM0kA/YZetRxWEfoskR9epcAPlrhHy7Eg3wdHRlO9mdyGvSioewMfzov
         KeWFt8hposfcdrE6uHBbN9I1jebhbGRQnga2AdcLnMtwyuPjft4DjR+33ko0Xokw35kA
         N/zAuWvtmOEZpjQcgD6cl828sSjwvlobLf1wztIeWVc4n5xDlQW7elcMzoxyIayVwHJz
         FF8iJ0nFrBPpqDhwYKD6qB7KT+gOCwkcp2D28m2cCAWM40GxNKfVvvWNo9XQ7wiP1Urn
         w4gwy58tq3ORYpoEAYsniInGT9fE7XbEsfsP/yeqdTb9Au2tPlIU4gyPLNAddMpyQ7Ib
         zF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vwik1mNyYOqHPapDPau3aXiBOWO/s+qGHcQQOuPlOlo=;
        b=d3OrJGCxpgl60ChKkQUWcYIBRI5m6gybfXeFplVgLM5AETmtPD3zlBVCZrVLz7LjDb
         6MLbUl4tnReVjOVCfiRuMz6TDi/PbvBDA7/UZtx9f0ots4o+oaupdGaadoeazMU5+4uf
         +VvTOtC3ByqZ34sfuGCl2kFOJXLqbDYUf02noQ0HG0SFri6kBHtR7c1MxtOIqWN+iaa5
         BGPou9qTPpsbT/L/Cbi9EHFhCYoxCrTJ3V/ZcTyIzZi/rWWbguBo33Ip2yKFu8n7M65/
         w0DnWHEQzrugxWIVqfnHmemDoc5qZyxFYCg/wO94PpA1mAt3J+Et2hSIWP4cmplO3u9M
         NA9Q==
X-Gm-Message-State: AOAM531RoqeuH0HN5V5QGBmw+OdTuh1rRM/goh8HbJuMLOiz7G6KxxwY
        Ki1uvENMZNI5ryDwnyEtViU=
X-Google-Smtp-Source: ABdhPJyna8G70WLf5w5vpFT9RgXoRgiwSletYSWvInDUnf9igjG7bcUOLu7KFSJe6TJVbtLbitzkVg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr16095117wmb.174.1637941441249;
        Fri, 26 Nov 2021 07:44:01 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p13sm11372400wmi.0.2021.11.26.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:44:00 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
Date:   Fri, 26 Nov 2021 16:43:42 +0100
Message-Id: <20211126154344.724316-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
References: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
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
2.34.0

