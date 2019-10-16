Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F889D9A84
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2019 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfJPT5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 15:57:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfJPT5c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Oct 2019 15:57:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so29458158wrp.1
        for <linux-spi@vger.kernel.org>; Wed, 16 Oct 2019 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NG+1N8pqfTQP+Jc9hKyg5BqhDrJd8BVaVZCbMzcwzpQ=;
        b=YOxOhnYlgzS2Tk4VK481ftR03oNVQw/9Gepa5WfUSzlqM+BqFzjdDM+kWHO2jePcGR
         1gDaEiYOejp+n93yW2HQFyRFRpAx7JDMeWoWz3Twfzv4Uhk8qXrU22BVHzR13vWuKqrK
         2u/LkjnBoN7Ec2egjOnU/zC9SUKH+fi5FsSCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NG+1N8pqfTQP+Jc9hKyg5BqhDrJd8BVaVZCbMzcwzpQ=;
        b=sbUOcFanC+TNZpennPkQ36KgzA1eNEkv0WDiQTeyfgyAOCGs9g3eUY/yqgwfWBrrD8
         w89+XeVcZQvCdBwdcAE2AzjMZxB3/RVMXbbzuvDsWv+z1l5W9dKEH1CWZvPtrqeVid29
         WVKYmn25FmL+aePEWrzugyNmx/OhFjm2LYu8X6fM3zTBVhM2nTY/2pgbFZ9mWJN6o/x2
         8+z6QvmaCkDqUaEYOIPpSqaGfSjIti+sQIf8cb5nOrjaRhfcxLaO8mTgVcGX2VP0ctL1
         VqoEw2VwqjPtmu91jp/BkAsOutis+bV1OH0efDyUglnIc+/Z3q32varGqHYIx4XFjqA6
         1rYA==
X-Gm-Message-State: APjAAAXb/TtxPn7QgwnaHdliv1Fn/tBcVo6J4NsW8fYddUn57+Z47ZG7
        r4K6M5oxrv+fHkT/umqMROzb2A==
X-Google-Smtp-Source: APXvYqzEDG6NFRpskcNp9TxpoXWvKld+9QHPgfTTWr0lWHp9luHTpO7e8V8TrlMGUFE74OMWti9u+w==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr4197296wrr.76.1571255848864;
        Wed, 16 Oct 2019 12:57:28 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id t13sm52362928wra.70.2019.10.16.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 12:57:28 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma mode
Date:   Wed, 16 Oct 2019 21:57:21 +0200
Message-Id: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In DMA mode we have a maximum transfer size, past that the driver
falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
Falling back to PIO for big transfers defeats the point of a dma engine,
hence set the max transfer size to inform spi clients that they need
to do something smarter.

This was uncovered by the drm_mipi_dbi spi panel code, which does
large spi transfers, but stopped splitting them after:

commit e143364b4c1774f68e923a5a0bb0fca28ac25888
Author: Noralf Trønnes <noralf@tronnes.org>
Date:   Fri Jul 19 17:59:10 2019 +0200

    drm/tinydrm: Remove tinydrm_spi_max_transfer_size()

After this commit the code relied on the spi core to split transfers
into max dma-able blocks, which also papered over the PIO fallback issue.

Fix this by setting the overall max transfer size to the DMA limit,
but only when the controller runs in DMA mode.

Fixes: e143364b4c17 ("drm/tinydrm: Remove tinydrm_spi_max_transfer_size()")
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Reported-and-tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-spi@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index bb6a14d1ab0f..f77201915033 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1707,6 +1707,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
 			controller->max_dma_len = MAX_DMA_LEN;
+			controller->max_transfer_size = MAX_DMA_LEN;
 		}
 	}
 
-- 
2.23.0

