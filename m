Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6862CCC50C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2019 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfJDVn6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Oct 2019 17:43:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbfJDVno (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Oct 2019 17:43:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so4654789pfn.11
        for <linux-spi@vger.kernel.org>; Fri, 04 Oct 2019 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OowT3FfmgpsalZ+H4UTW7eAiz/m50m9GHtbFWsn29ao=;
        b=BaNIgVZBboERWjdBo4z0+bzfjwVFK7oXUoPtYeSp3dhU9ivCmoJqc3FWGL6jpDNZEZ
         OT8MrTll1xSpSK5ASR70zYupcSfy5A6XkHkQ83rRXOLpWanrq4R11+df6PZ6TNFk4x9T
         iZNrV7pIyf6yy4NiWTsXJ5/NMZAwmJCZrteRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OowT3FfmgpsalZ+H4UTW7eAiz/m50m9GHtbFWsn29ao=;
        b=dyFdriFXE7+4F0tKK881lkct5RLk5l5E+IyClZ8/Bex2J9ao4CAFGdCG1mS7EMrt5g
         57Sdy7o/JPU9jNsP/iImJL10c89ADP9aa3D46hJcEgvJJVhhezlfIjeVhUrFZcpaPhSr
         9HDuM4MWgufkX2cbw/eMjcoG+tNDOu/IOif2gEcrVvQMVnswYy8CljhSG5T6pyf4kTqn
         NlJHalAfJSb7As3lNPB4ssk4qPmk2nfYjJDwQ/hpTW4UOtxOUbIohSeYBsIu1HsdBX+p
         paafXSEiQvjYQSeqvNquX3C+ahBmB3MZ8Jv/+15AW0jL5+bSDR89ayv80RfnXxfNva4k
         t2HQ==
X-Gm-Message-State: APjAAAVr8r4xS4vfq37+bPF9paooq9FRX2VTv5BuwFODmOnzZ+GwWJ+U
        f0acpVdcpWIViR8z2SEkoZrlwA==
X-Google-Smtp-Source: APXvYqwIE1y5GhauzgIz5PlB/zoMd90PsiKcS/ylQRXFDE0camiqcZjS+uVNbTzmgT1OWJo6UlKt1Q==
X-Received: by 2002:a63:c709:: with SMTP id n9mr10346281pgg.35.1570225424015;
        Fri, 04 Oct 2019 14:43:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 08/10] spi: gpio: Look for a device node instead of match
Date:   Fri,  4 Oct 2019 14:43:32 -0700
Message-Id: <20191004214334.149976-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver doesn't do anything with the match for the device node. The
logic is the same as looking to see if a device node exists or not
because this driver wouldn't probe unless there is a device node match
when the device is created from DT. Just test for the presence of the
device node to simplify and avoid referencing a potentially undefined
match table when CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-spi@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/spi/spi-gpio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..42f4d82e9c5a 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -362,9 +362,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio			*spi_gpio;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
-	const struct of_device_id	*of_id;
-
-	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
@@ -374,7 +371,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	if (of_id)
+	if (pdev->dev.of_node)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
 		status = spi_gpio_probe_pdata(pdev, master);
-- 
Sent by a computer through tubes

