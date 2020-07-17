Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4843A223D62
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgGQNyw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGQNyl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D18C0619D4
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so11205565wrp.7
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI7c50J2x+3VkfEYyAsOrnfGhBXfcF4lm0Ws/hDguDo=;
        b=BJWYGXYq1pgsO4ivqCiR82eR35O7gSNMT6QzlxPG0J5WFo7f9l9ct2/Tj5hbius4wJ
         Z3Nj9oYaqBKMg1Xoi6M4UZkmmfrLIkOblh0TJcSGnmWoWrAo6+546QwFRUIZFYt0uk9F
         P4n6sI1WeB+yEJLGruWOY5oFh5vAAwBE0sSKpokIUpMVYM0U5mlq0hoKOTFrP6pj1ogt
         qBVxuMuEOaLVOwxwyszj1rDIl05cV1teNU20ANvSq5UID796wEmfuWiVh9kq+r3ORgD1
         CKk+4gQ6lc1SCsduPRjx9fMiZ8f6nvrTSL7uHPXLrhtjK2mTSQcMBXQMTJfGqOP5i/M3
         qjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI7c50J2x+3VkfEYyAsOrnfGhBXfcF4lm0Ws/hDguDo=;
        b=B2F0kofOwNPuPZegVOA3XfoBVvdKA4GSGI5UgkbniZgJ6juHDIG/iVDENFSFvQuP38
         cweAqnv8mJf/MTgkmtH/Cg9tqAZSRGUXh/+zmP843gvFq6/5uE2cAAgLzrLJdmolS6wX
         uX2Z+9p9nwZUFUanx1Nd11AJ4bx4GQCeaP4rCTwCvinIb72e22lLSzqtS3qfmNglOkAZ
         BO4wGfNkfqz8sUDmblnL1EWEU5cK8tBBS2Xg11i2yY5/truZ3eDePiDAgt/tJlWUI7lD
         aV0UeQM7B7GYGulvsVtdvPQVQnxiVhNJceDrrChY3cXbcnByMdQ6JzyK/UkpznzPGixC
         ItbQ==
X-Gm-Message-State: AOAM530mlgwOOEnpCT2KCImwIiCkqFEivgBgWVgELJYjGUMtvZ9ktRcP
        q7zVe5NFkxuQ5Re/eUmjgn7I5Q==
X-Google-Smtp-Source: ABdhPJzcxiqCEsLDkUJ5mleRr1Wv9TnyI904k47F56Gh6ETTAgfzBGp386wph9T+fLWOu0SbjVA3ng==
X-Received: by 2002:adf:f104:: with SMTP id r4mr10951860wro.90.1594994080427;
        Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 17 Jul 2020 14:54:23 +0100
Message-Id: <20200717135424.2442271-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct 'pxa2xx_spi_acpi_match' becomes defined but unused.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-pxa2xx.c:1435:36: warning: ‘pxa2xx_spi_acpi_match’ defined but not used [-Wunused-const-variable=]
 1435 | static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0040362b71622..814268405ab0b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1432,6 +1432,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "INT33C0", LPSS_LPT_SSP },
 	{ "INT33C1", LPSS_LPT_SSP },
@@ -1442,6 +1443,7 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
+#endif
 
 /*
  * PCI IDs of compound devices that integrate both host controller and private
-- 
2.25.1

