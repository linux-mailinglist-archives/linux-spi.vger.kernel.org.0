Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D34438D37
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJYByq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Oct 2021 21:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJYByk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Oct 2021 21:54:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2688C061228
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so6818400plk.10
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/bKW8724bofyH45UpBffAFsq0SnSA7YXQrZaejTe+M=;
        b=Ejy6SHcJt2kaxheA/ZQPb1mVzttOuKGW3+jQxI548TaD+OSC12SPFQ5JFEQy0H48K/
         b7pUESLs+YmBJdGs79ZttyMOE82yynS3n6YY2rH4bsgLINdd9U1ZisWi/W/LPtGbQjeQ
         eyq5Ex0SAtRikXZrZxKuzV3Fxx3fdpJP72sPAKad3kS6o9OV2KhGQcBwd0Oztq0KcBvp
         tYs/Pm+03+RzNHHO9PAlxnhPJEcY6btcFPJjXKSYv4avzo3ftEXm4ZVSRLjXY5hTTwyo
         tHFXIhy/erFkytrMhd2mfjNa8NTQdFyAKIgbfiDw52nox+h5nWcVy7DmAOpx+222V5WQ
         Pd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/bKW8724bofyH45UpBffAFsq0SnSA7YXQrZaejTe+M=;
        b=GWT3SkgKD03TrunYMfCRGBEOwMD/Y5ptTWvE6zxBiDx+BpgPgVAexSAVWKa19zkQhD
         6UlYH3xHAgmJe45peknkd3ZaQA0KWzpi0d6d4mwCSd1sNnL0lkBtsHUqlJCVXlRA4/wX
         mLQPu2opU/BtOMREHcT72oERqKmp+tyxtE5HQ0+rNLbtwQlubBkQgyQAk9O55/3qHPTg
         cKO3+hHVt39C+aBC+fbQ/X4cruCTw+UZd5WJObwlE7plAssLK7qJtzCr3WPPPpDEAPBi
         kddvi1EIiNq9moxxvej9P328hg3WcrTU4cOvB0GniYFU6gyEA9ZAh91AH1CDN2tBTmfp
         SJiA==
X-Gm-Message-State: AOAM533I1t1K1Hn07A+XFqiYmq/+0vpblu2WJqlqhtosNTK100bByA6r
        EnR0kYNckCraUbijRGZDjFjTZQ==
X-Google-Smtp-Source: ABdhPJzvIEhz8fkC23WGXbNpQ0aq51Pl8xkXYROnsEN57uY+bFLunQTkyfryRsKLI1G06vs+HcCcTQ==
X-Received: by 2002:a17:90b:1d92:: with SMTP id pf18mr31967519pjb.38.1635126738493;
        Sun, 24 Oct 2021 18:52:18 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:18 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] MAINTAINERS: Add entry for PENSANDO
Date:   Sun, 24 Oct 2021 18:51:51 -0700
Message-Id: <20211025015156.33133-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add entry for PENSANDO maintainer and files

Signed-off-by: Brad Larson <brad@pensando.io>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d118d7957d2..465771d697b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2364,6 +2364,13 @@ S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
 
+ARM/PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <brad@pensando.io>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/pensando*
+F:	arch/arm64/boot/dts/pensando/
+
 ARM/PLEB SUPPORT
 M:	Peter Chubb <pleb@gelato.unsw.edu.au>
 S:	Maintained
-- 
2.17.1

