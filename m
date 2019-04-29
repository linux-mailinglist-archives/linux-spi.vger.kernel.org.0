Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D558BE7A8
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2019 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfD2QXA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Apr 2019 12:23:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42189 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfD2QW4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Apr 2019 12:22:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so5303034pln.9
        for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2019 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4f6WrzyzuO2F1bDTPxHcLE3z/+pAjPfe9qLmvK4A6as=;
        b=vPpCrKUW2ez99jzndfqZtu6JNvWNanlUzH3AuveO0GSSRCCQl72+NIdUPDxp4e1j2D
         oR+KD27SMnporP7BtqsmFOHrHH48hM80JhZBbvQFxbgs9ZmuljJwGNsbO97maHqcUfjg
         8wSXcpfVKMB8tCe4gXP+HgKsW0HJtYjx0dBSpNwC87IzbXqY3gwaTJ7c+snUOwGxdTSd
         2zD9P9f8ZXZjyRLibwYBPF9JXLqNVcGKoIVvLYRLSDdEH/zokklEz+pbZ4uhjxbg/sSw
         527JDJwiLrfS+2iiWXbdKDp8JItn+dGur5RpDU6TA35z23hVVY64OqVnxcZtB9i0suTd
         njtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4f6WrzyzuO2F1bDTPxHcLE3z/+pAjPfe9qLmvK4A6as=;
        b=qHCN210hf1TKBO/0url43Gx5ql6j8UcUEjFhptU4sdUQE8J1MMJ4JJR4RJWp0u+9vc
         DHVtz7KG4CFZHBVHYwlIgbPzmMRSFr+gjrjoWfU+uCSUkW0iN5JBW/0edA2iR/qjXS6Q
         f/p0D46LXtr47hH7zijgkklEe7MtF9ypaA8ipqdOadx7wbRQgjRxr9z70WxMxbSG6yYA
         m7QTnIeRGlrpwd6L6vhbDOALkJzLYFrndWw+wYS39XCGVjKhFlGdceO7zlZBwW9V1M14
         e9xYGe/LIvQs6gd/NBK/ziYKqI5YdVxH1gNm5O83ppl1I179l2rgOvzsIcRkxjdymrcC
         QdTg==
X-Gm-Message-State: APjAAAUq6MVdA+IMfl8n9z9duDSsZqOURYIJbM3AbwHEkn2OQIlIaAui
        9Qov6n+sYF/J856mcUCqQkw07sPsQQzaYr7c
X-Google-Smtp-Source: APXvYqzYEA3pbS2iE2gKVdOlfQIPiAhmrRB708Vt+S0UrPEJo1az+L1keMZHjy1L2zZAifx1wHJpAQ==
X-Received: by 2002:a17:902:b605:: with SMTP id b5mr24397547pls.206.1556554975840;
        Mon, 29 Apr 2019 09:22:55 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id g10sm39691003pgq.54.2019.04.29.09.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:22:54 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     linux-spi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] spi: zynqmp: Fix build break
Date:   Mon, 29 Apr 2019 09:22:46 -0700
Message-Id: <20190429162246.6061-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
References: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Missing include:
drivers/spi/spi-zynqmp-gqspi.c:1025:13: error: implicit declaration of
  function 'zynqmp_pm_get_eemi_ops'; did you mean
  'zynqmp_process_dma_irq'? [-Werror=implicit-function-declaration]

Fixes: 3d0313786470a ('drivers: Defer probe if firmware is not ready')
Cc: Rajan Vaja <rajan.vaja@xilinx.com>
Cc: Jolly Shah <jollys@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/spi/spi-zynqmp-gqspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index d07b6f940f9f..9850a0efe85a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.11.0

