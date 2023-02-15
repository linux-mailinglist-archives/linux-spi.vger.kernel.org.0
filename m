Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C94697DFA
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBOOFm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 09:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBOOFl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 09:05:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD72940C;
        Wed, 15 Feb 2023 06:05:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so19247958wrb.11;
        Wed, 15 Feb 2023 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=972VoMBEa6AEd5FN2/lOAlKbuTVirIIEUgWJdtgNhrk=;
        b=Z7AuVxpZ7+aG0J9RWhAOeJi0WARhsOmwTKIEwiYdmZxKNXWs17jhMu6vhl7Yb7zQIS
         PVvzOF0m35YOTUHVrPJ9Dio5MHGBtUn1Wzv/dL3SNvaktz4lASes5LymX7/yUjSU5Gc9
         tu5FZ+ODhoFRYZHdkGufVEJ9p798YxJkswsUpV95faWq8jxmtq9bL4ZMC/k31bYKXTSC
         P7fmUWxuhLfjp0EtNpM5Vt0FJ1OqAc5bUU3SxQI26VYv0qA8vKQDI//xJ3jEFvmQdpNp
         jjQzhaGsZsYv0RRJmgRLJKqtZTG5briVYJ7yZ3GlLrg4zi0jHOpzTZI6+MWisdl+7Y3z
         o2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=972VoMBEa6AEd5FN2/lOAlKbuTVirIIEUgWJdtgNhrk=;
        b=EIUsclFhvnbjc/qYSNqxdAreidaBSg0ohJ8cqg1sIrgdIEt/3poJqQLlHGsFjWyqa2
         XITvoSzALMc6yFif0Vg2l7YP/xU4ROXpHvAhtJFpvo3Zae7Py73tp2N0fhZ4jRQK2ATN
         tnBT5MurcICaHbVedsqjYpyeya2Qp2z9gfh3J+j2sQqBQTDX3USfCxrP0vq4CjSJms10
         3BuoaxPOBrQP98v7gCmwNcgD9fAEm0vMAM9LRKxiZVt761/itlxlSKk8z9hvKNr7n3q9
         bU7fzwqSXUcBJmFoDwGl+l/B6U3T5CU/ff2ioAm7j4eJBdVppR2SePadDjYcN9BOm8iu
         3I9g==
X-Gm-Message-State: AO0yUKXY3xnR99hhPilaZ3aIJ8VTNk4ex9m2H9IdjVjyA753JAVC/t4w
        IYj38h9hOrakWGW8onomopI=
X-Google-Smtp-Source: AK7set+GLef0sPdlxOXpLIRtTD1n07tDrM5SLCe5jLJ5Z6ny0t+62MBEXleQXABcfzSRt+rTFLDVBg==
X-Received: by 2002:a5d:564c:0:b0:2c5:5ef8:fa36 with SMTP id j12-20020a5d564c000000b002c55ef8fa36mr1579131wrw.70.1676469938528;
        Wed, 15 Feb 2023 06:05:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h12-20020adff4cc000000b002be505ab59asm15882649wrp.97.2023.02.15.06.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:05:38 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:05:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: bcmbca-hsspi: Fix error code in probe() function
Message-ID: <Y+zmrNJ9zjNQpzWq@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This code accidentally returns success instead of a negative error code.

Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI controller")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/spi/spi-bcmbca-hsspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index d58033251c02..c14c1969e2cb 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -546,7 +546,8 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	if (sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group)) {
+	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
+	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
 		goto out_pm_disable;
 	}
-- 
2.35.1

