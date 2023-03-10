Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B166B51D2
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 21:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCJU3j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 15:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCJU3i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 15:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA3816ADD
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 12:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678480133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zmi6jixM9CxhmwfdtelqmeFeZBz+8q+k2mGp4ctKzmQ=;
        b=WqyDzeyNtBmZcI+6dXrkYtAJ2zaPjgAvD8wwFpFxihg5OANNYTVhsGqh5oSwsTDe/bnEz2
        nUgOKWTMBvV7taU0mgXPZaPn4WIfZge6SF5EQzateV4qd4Xne/IQff7zelpo/s4WAKAoTn
        qlQW5S6d1AMrWDGJIhDn8X67ZGjsbOY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-6c0IlejEPL6pmxZTwyhSqg-1; Fri, 10 Mar 2023 15:28:52 -0500
X-MC-Unique: 6c0IlejEPL6pmxZTwyhSqg-1
Received: by mail-qt1-f197.google.com with SMTP id x21-20020ac86b55000000b003c01d1a0708so3532116qts.19
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 12:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678480132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zmi6jixM9CxhmwfdtelqmeFeZBz+8q+k2mGp4ctKzmQ=;
        b=Nt07esq1Iu5lcj26zccFZJOkxQQfZtaLguyP5M5YMtWHBV3dWFoM7d4qFz/KtKZ5sP
         VEdemD7eTkU0kwcndL7dyb/jm97ThegGNE7CTbcRTwoa7oujNf7umzkfVQvJhaMbpf4r
         YS9iMUUXKJU0oVUr4RhjfMlUT3cjWZE822s42Y9/ibv5qGpBY6tqubAGJvrwUZY/ZQZ4
         qNHQ5u4Y1PXGWX088Yhi0f6LVWbwco3HlleH9uqERnR8tvL7XE+H9d8sq0HqFqcqj44k
         ogqh/cuorA3havAyZttB38YMATyjLhactB5u4hGvbtTKWSbUf+lnaFoT7KQ9RfWbhpjV
         yJHA==
X-Gm-Message-State: AO0yUKUzEtfLYRPc3ybrSwpSciDPyvm6lTvaEeLR9J1iQk/YqzqUUU1p
        VFsBJezCWkXJmnz0dK2j/5hh0H8q37zDDiZjbgQZoTo2f4b0SPp3jVXLh9UqOKLo/sVo3gVaOB2
        7eEXUVOED/qdNBoXxtx1y
X-Received: by 2002:a05:622a:13c6:b0:3bf:bee1:1a67 with SMTP id p6-20020a05622a13c600b003bfbee11a67mr44705062qtk.17.1678480132160;
        Fri, 10 Mar 2023 12:28:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+QUlPA7XGJX2VyHl6RmpSZZ0/QpX6sxs3VnYs5R8X8zJsBRulPSYwo83oa4P+rKa9y4x0y7w==
X-Received: by 2002:a05:622a:13c6:b0:3bf:bee1:1a67 with SMTP id p6-20020a05622a13c600b003bfbee11a67mr44705043qtk.17.1678480131940;
        Fri, 10 Mar 2023 12:28:51 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q19-20020a37f713000000b00743838d9f49sm178470qkj.12.2023.03.10.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:28:51 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Revert "spi: fsi: Make available for build test"
Date:   Fri, 10 Mar 2023 15:28:48 -0500
Message-Id: <20230310202848.437655-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit f916c7080d28831493518364492e33fc6a437907.

A rand config causes this link error
drivers/spi/spi-fsi.o: In function `fsi_spi_probe':
spi-fsi.c:(.text+0x2c): undefined reference to `fsi_slave_read'

The rand config has
CONFIG_SPI_FSI=y
CONFIG_COMPILE_TEST=y
CONFIG_OF=n
CONFIG_FSI=n

Building fails unless FSI is enabled, so using || COMPILE_TEST is a mistake.

Fixes: f916c7080d28 ("spi: fsi: Make available for build test")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 36a18c215163..80f3cade6006 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -357,7 +357,7 @@ config SPI_FALCON
 
 config SPI_FSI
 	tristate "FSI SPI driver"
-	depends on FSI || COMPILE_TEST
+	depends on FSI
 	help
 	  This enables support for the driver for FSI bus attached SPI
 	  controllers.
-- 
2.27.0

