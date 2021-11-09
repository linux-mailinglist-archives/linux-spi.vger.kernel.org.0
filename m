Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932D44B927
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbhKIXCR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 18:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241461AbhKIXCQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 18:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636498767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HsorBG3OhmC1gdGD3R/J+05rQPjLba58q4aGElHCbkY=;
        b=DIumA0qt90LUpq8v1w6ZQd2AimOgdcN9PQUZYJ8I3iBoOhx9LhAFCqfcETQaQG9qWpIDLl
        OARsu4B5qAODcu77jw2CWZYR+uw+ACAH1FGSd+CqRYxXfkOFHy7pqshgOIrCJ8ZE46qOgO
        8y/6ZFJFl4ZANqYvQeqF83SIITRMyO0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-2jgqt4KoPVCzCc8UAzOh9A-1; Tue, 09 Nov 2021 17:59:26 -0500
X-MC-Unique: 2jgqt4KoPVCzCc8UAzOh9A-1
Received: by mail-wm1-f70.google.com with SMTP id b133-20020a1c808b000000b0032cdd691994so2118165wmd.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Nov 2021 14:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsorBG3OhmC1gdGD3R/J+05rQPjLba58q4aGElHCbkY=;
        b=OIn2LdAy6tTBsIEoKT7RSlObcEEmrA+aDEjyhmsRAOAq5JF8B15tHdQ+nO/rse691I
         lZg9jcvgbxoP/lyQLqvIBPnle3HntrmquVIW5kBIv0Yfl0Q+ZeQU8EBW2LYSAr5uWPgO
         fxlyV2r8vU7VsVWjKYxMhltaiNG0w7RG8TmGZX9vTO6pHyzLNKvnUnL2Z7EWHtYJ6k8X
         jnLsXAkWN89F4Jrn3vNlHlTV7MMuTgHkI8XfxR1yPb8LXrGxPdsFjTOmYcipKsZL3pDp
         4YikDXioU3FdJwAIX4R2dyBAe/34jFhSILoXS8xH7FY+pZ/gIiec4Juu7of6UYB9GedC
         x9aw==
X-Gm-Message-State: AOAM531NyWoMR0wecBkqp880JugQbTaF5MqiMq2ORpGXp+KnbOsGHpP2
        4afTABqTPlfYZvQ1m76c8Vaf0LVnZWBPhG84XPB16SV8F7dCSJdRlzR4mHaBQadAm2cHRYjxSOA
        mQKcgQyORV3VzQWODP80t
X-Received: by 2002:adf:d84c:: with SMTP id k12mr14014121wrl.24.1636498765563;
        Tue, 09 Nov 2021 14:59:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEHX/T5zHdYk+ugheuyRiCbyChIuGARQoiUGw6w0JBvfOLdEYpkxN9RISrWa+2z4RDPRVKCw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr14014098wrl.24.1636498765414;
        Tue, 09 Nov 2021 14:59:25 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i17sm3926884wmq.48.2021.11.09.14.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:59:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] spidev: Make probe to fail early if a spidev compatible is used
Date:   Tue,  9 Nov 2021 23:59:20 +0100
Message-Id: <20211109225920.1158920-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some Device Trees don't use a real device name in the compatible string
for SPI devices nodes, abusing the fact that the spidev driver name is
used to match as a fallback when a SPI device ID table is not defined.

But since commit 6840615f85f6 ("spi: spidev: Add SPI ID table") a table
for SPI device IDs was added to the driver breaking the assumption that
these DTs were relying on.

There has been a warning message for some time since commit 956b200a846e
("spi: spidev: Warn loudly if instantiated from DT as "spidev""), making
quite clear that this case is not really supported by the spidev driver.

Since these devices won't match anyways after the mentioned commit, there
is no point to continue if an spidev compatible is used. Let's just make
the driver probe to fail early.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

This patch has only been built tested. I'm posting after a conversation
with Mark and Uwe on IRC.

Best regards,
Javier

 drivers/spi/spidev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git drivers/spi/spidev.c drivers/spi/spidev.c
index 1bd73e322b7b..4cfa250f16d8 100644
--- drivers/spi/spidev.c
+++ drivers/spi/spidev.c
@@ -751,9 +751,10 @@ static int spidev_probe(struct spi_device *spi)
 	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
-	WARN(spi->dev.of_node &&
-	     of_device_is_compatible(spi->dev.of_node, "spidev"),
-	     "%pOF: buggy DT: spidev listed directly in DT\n", spi->dev.of_node);
+	if (spi->dev.of_node && of_device_is_compatible(spi->dev.of_node, "spidev")) {
+		dev_err(&spi->dev, "spidev listed directly in DT is not supported\n");
+		return -EINVAL;
+	}
 
 	spidev_probe_acpi(spi);
 
-- 
2.33.1

