Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6368333114E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhCHOzh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCHOzb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC01FC061763
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h10so15164889edl.6
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJxdRpdzofsaI6pJC87KN8qfD7oiIuHmhf+Ws3rK5bo=;
        b=MTQFoIjgyIhVpuBWjNoJU3fO+5NyJAQOscZ0AdWbRLqL1HdjvnrdB3/XxCfdMJJn56
         bDPG9W0kPMVeyC58dnlnVBca784ue4kWFPXvaXSEfFdn9Tj3qTtg4RotQD5idpaVH7SL
         URqCkfltpUY/xyaBJlhc8SRDGn02/O7WZJvHB/VXkbTHqtEV8vEwxZIxINl3ftaK207d
         LSHGATqqKJlme/7/BqKSKs8KGoyGOGtbkCXXwN+E/OPGxumgQNBVj1H4TPnKMLvtg6fD
         9FYM+6AKbruxKNEfadoYb/EudkSTyPH1m/pS5dxVx+CpKfXemde9q2WnUZZItwajJHhZ
         Gr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJxdRpdzofsaI6pJC87KN8qfD7oiIuHmhf+Ws3rK5bo=;
        b=iknTKdC4nfonF5o+BsHmUBcV/DsRexyO18srD7TlO/RRSEF203n6vCHnxezdDGpalx
         iDTECIbcNdnf4MrDmC9AOS751i+cGxFJTrOu3/HiOI9Oc8KsS7CjhsMa0d6vfTD6AgGn
         Tt9LDBcqRlpV39kGD4w3vRm8xUN5J1KX/o9jk800SpuFNjLvWtybbffataB7Qx++6OHq
         aI2irUKBvuNUvtPDOZEgDOtPhJTSur+dyRu6f/jI39/dDCUJu2kpW7RfmTzYJPuYd4ed
         NrT01Bw53zvvmN7F/VU+KPVxmLfFrJAtZo5jRmY3Ek0DCCLWKk4B2j3/0/ZykJsG3x8x
         kClg==
X-Gm-Message-State: AOAM5309+deuuUcBIX5ee/CcODdBCOLQy0tgRQBBTgv+0Uy89F9XX5B/
        eq875KjSseySVwXQLKVrJqofxziFMtf7ARohQGo=
X-Google-Smtp-Source: ABdhPJwlgot4NbjzzuYuRheze893HpYfgoXITowLPS3t6zG7Qok0RqmnNpkbz3PPbWWOQb7cwfKxaw==
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr15045774edu.241.1615215327135;
        Mon, 08 Mar 2021 06:55:27 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:26 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 01/10] spi: spi-axi-spi-engine: remove usage of delay_usecs
Date:   Mon,  8 Mar 2021 16:54:53 +0200
Message-Id: <20210308145502.1075689-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'delay_usecs' field was handled for backwards compatibility in case
there were some users that still configured SPI delay transfers with
this field.

They should all be removed by now.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-axi-spi-engine.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index af86e6d6e16b..80c3e38f5c1b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -170,14 +170,10 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
 	unsigned int t;
 	int delay;
 
-	if (xfer->delay_usecs) {
-		delay = xfer->delay_usecs;
-	} else {
-		delay = spi_delay_to_ns(&xfer->delay, xfer);
-		if (delay < 0)
-			return;
-		delay /= 1000;
-	}
+	delay = spi_delay_to_ns(&xfer->delay, xfer);
+	if (delay < 0)
+		return;
+	delay /= 1000;
 
 	if (delay == 0)
 		return;
-- 
2.29.2

