Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD1221048
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGOPHO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgGOPGx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564CCC08C5DB
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so5921805wme.5
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI7c50J2x+3VkfEYyAsOrnfGhBXfcF4lm0Ws/hDguDo=;
        b=OeStQ676gkLJC9flvx8uGog1ZO5sbiMnJMlr05Al3vZvFQRZHCm9sU16b+mHbGjiu/
         zQLROHGqy978gbiKFEpIyBMkOKofeVQ/0xUFfYH39mKo7Q/YCUXT4fDwvOGve9NdyaIX
         9oBji0BeVTVDE0SHHoemYV6TVo+WjAKxrdNhNHqSd/H/p+j3DHSbgYtsByjsXwlwg6yh
         B90amTbQ+xuUjsIMEaeQTQ5v1qC2Q60Kfs8TTa513agQ2PQASIWFW+QdgHaZlhk4wKge
         XgSqUFE8pvon3wcWLfW14C76/b7c1rRSMvGnEnSCton+69Vj+u/y5VG7MA4JQqEPS5Xd
         Ycwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI7c50J2x+3VkfEYyAsOrnfGhBXfcF4lm0Ws/hDguDo=;
        b=JBesWAtC1FiyInXitv+oQDht8Z9RX2KVfqI4BhFM6mGD3/+dAfXBaoN9z1t6q99iRz
         TWC5o0IaNIf2KDSjpughDiXvpObUFInCakya5g56jDzfErd6/Zv/mSX2U3IFKAOlwmDD
         nWJ+gtl77BL1VyGe9VaMQ1j056uci72HLZ2Onu8X1TTvO/1qn8TyFkpog/yboMKm1ccV
         2rz2YIxYC+VubOCO53b1axt1qus2Lp3iwZSX9hKvftF1mWTdo1daAbboWKYXKiKseKTN
         OrrISJwxfr6iHj5zFiKYbhZHN1Uco5k2jrQqtu8yX6gs+6cL08D3NM0XXXt5iFMAPYdN
         C/dA==
X-Gm-Message-State: AOAM533naY34KSYDxMq7FnlgYvFys6EhFSlJcysS4619BmR7PoqokE9I
        sCzPUnFjJsLD1ekuWlGTE3VOUQ==
X-Google-Smtp-Source: ABdhPJyBnfjeYbjMACkhjMYXKR10NpPlrtS5qROBcZV5AlpsItZlXQak8hpIg97VCabsero4VDwi7w==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr9230410wme.42.1594825612087;
        Wed, 15 Jul 2020 08:06:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when
Date:   Wed, 15 Jul 2020 16:06:31 +0100
Message-Id: <20200715150632.409077-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
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

