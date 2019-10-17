Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0902DA5BC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfJQGof (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 02:44:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfJQGoe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Oct 2019 02:44:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so512131wrb.2
        for <linux-spi@vger.kernel.org>; Wed, 16 Oct 2019 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NqQBX25YVDLNUmJ5qwwRNJKu5MUMZp6/p5wXw7x9Fk=;
        b=bUOLmcmWgwe5oaYDwztL6kX7PXhjSj+7QZRk+PFutXcsJ4FkPo2TsjMRYuuxeeznJZ
         0S3zVqKNaMvE2ivqJpJVqWOqhro+SpQrVcnL6X+75OLyfcdsy3yJCIRqTrHaADxb/2JM
         gYzUnTdOycuiV0X8iuxO02z4ao2J/1nL89JXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NqQBX25YVDLNUmJ5qwwRNJKu5MUMZp6/p5wXw7x9Fk=;
        b=NoDoM5+9NXSjZnpMy5RxBcKnHMcisYXySS/2jGvLPFyutkZs/esAA/K1ncK20Ax7+F
         L9AwJMz/y0zp8iuDPjf+VsQY0vERf8GIhEJnmPPHQGWRQOMts4MKZbI8xXaVOohHvlXZ
         8p+6kExobM07hHAicQiowcLgbVEYbyWQp+cOlWXE8t/j9sie1zACYakGeLIlPaHuHrrt
         mL58rhOAVKbxcY1LhCrLo1Q9HzpEz5oeXezNibT85lsinGKhas+CvAozqstU77B/HQoe
         AbuH6V2TGqjB0TH5m/APbA/u5IFksCiq4HhCRoh9r1LB6NMX8kfLiqAROl7jz2klznKt
         Iqag==
X-Gm-Message-State: APjAAAWtDXonsbypa0AybsPckqi3XllU4bN6M1at4xZAA96vSdqXqPv+
        Po/71nb8Vzy9M58CH8T693NuOQ==
X-Google-Smtp-Source: APXvYqz2kPDXlDVZbxM6aJgjeeWUQFslwpeRiXPDGJF58Hm1esq8NuQYOCFwwfVKkw374xKe+hUwqw==
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr1505529wrs.131.1571294672094;
        Wed, 16 Oct 2019 23:44:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u1sm1122798wmc.38.2019.10.16.23.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 23:44:31 -0700 (PDT)
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
Date:   Thu, 17 Oct 2019 08:44:26 +0200
Message-Id: <20191017064426.30814-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
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
--
v2: Brown paper bag edition, it needs to be a function ...
---
 drivers/spi/spi-pxa2xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index bb6a14d1ab0f..068c21037679 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1602,6 +1602,11 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 	return cs;
 }
 
+static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
+{
+	return MAX_DMA_LEN;
+}
+
 static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1707,6 +1712,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
 			controller->max_dma_len = MAX_DMA_LEN;
+			controller->max_transfer_size =
+				pxa2xx_spi_max_dma_transfer_size;
 		}
 	}
 
-- 
2.23.0

