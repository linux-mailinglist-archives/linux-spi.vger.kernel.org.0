Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20A4CDCF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFTMhI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 08:37:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfFTMhI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 08:37:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so2903858wmj.5
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2019 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPD6WWTjH8Ax5as56kI7pGVOzNQxzbf8W5J7T7qdeTE=;
        b=IrOWw/txUNL/7P7EppxJz6xQNsJRwXbqls++G4DQzPLt3dTCu6TkT5S4EdYmzLpk2B
         wPP/g0W+JWR6CrOeADQBM7XW3LKBJi5XgcY06juZoJv2N9TDLGT0uWX8OL+vcXU8g7v0
         2ep8XbvM1a02LnkgsmtM4dLlKbk+BUKw/DU6ak65tojHDPLbznv7uOByzWYY/xDlF2FB
         WBtsSA8G4goWWP7A1P8vIcv7YouPqhgNEGLH/vswXMXjzYvE/7gUtKKL7gZklhe1Z/4O
         2d2jgHQBX5p70o6gCvS7148AXCJKTveFBIwNm8FU6/IfvtozFaERG7yrj+15tDjD+FGP
         BmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPD6WWTjH8Ax5as56kI7pGVOzNQxzbf8W5J7T7qdeTE=;
        b=DBGeGAl27VEDDpxiKQB0dzLqj9u0Opf/O7P77CmVN0tDfcWFWYzU89qaTu/F5/vXyr
         jqUnuf27Qyaay/u5Plms8t3q72XEaFfbg/J9SWJboxvskR+PwbbT94ags2KNtjI7abRh
         td7DuLDQe9uDoJU49mRDbAlIObcLTIyaYO0gyxY6FkSe/GOutNMtVBGO2JeAr4CcLqUt
         J5ZeLOwRI4nc+Op9vtnaT2DlLAKmI6n9C3jxvK1J6CxWFPC6EJ/C/A6y/yvwQ+ek/r4X
         Vi8ppfYla6iXjVwwC1R1tQeqXfAeX2/Du5hwfamrodUdbr9rp+53p5HpBePu6JzOJqE6
         EMcA==
X-Gm-Message-State: APjAAAVjewjwEsGSv8RGc34E+u7eKxCTZco2hVn1GMhQlP8W19J1XFb5
        +sj2+D2gEfdBOMvyEKGe0nYlpoMUzkM=
X-Google-Smtp-Source: APXvYqz8OT58MV1J4Wz/9Q4OEKqqMOOd7xEqoNs/FAbmmGRR8u1YwfpI/+cFSd7ycw/zWBdN66Q+LA==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr2705277wmb.103.1561034225942;
        Thu, 20 Jun 2019 05:37:05 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-10-211.w90-88.abo.wanadoo.fr. [90.88.131.211])
        by smtp.gmail.com with ESMTPSA id v2sm16633457wrn.30.2019.06.20.05.37.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 05:37:05 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] spi/acpi: avoid spurious matches during slave enumeration
Date:   Thu, 20 Jun 2019 14:36:49 +0200
Message-Id: <20190620123649.4492-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the new SPI ACPI slave enumeration code, we use the value of
lookup.max_speed_khz as a flag to decide whether a match occurred.
However, doing so only makes sense if we initialize its value to
zero beforehand, or otherwise, random junk from the stack will
cause spurious matches.

So zero initialize the lookup struct fully, and only set the non-zero
members explicitly.

Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: andy.shevchenko@gmail.com
Cc: masahisa.kojima@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/spi/spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a31e1e291335..4057f256ef76 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1953,7 +1953,7 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 {
 	acpi_handle parent_handle = NULL;
 	struct list_head resource_list;
-	struct acpi_spi_lookup lookup;
+	struct acpi_spi_lookup lookup = {};
 	struct spi_device *spi;
 	int ret;
 
@@ -1962,8 +1962,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 		return AE_OK;
 
 	lookup.ctlr		= ctlr;
-	lookup.mode		= 0;
-	lookup.bits_per_word	= 0;
 	lookup.irq		= -1;
 
 	INIT_LIST_HEAD(&resource_list);
-- 
2.20.1

