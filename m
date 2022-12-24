Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811BD655856
	for <lists+linux-spi@lfdr.de>; Sat, 24 Dec 2022 05:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiLXESn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Dec 2022 23:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLXESk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Dec 2022 23:18:40 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B41C117
        for <linux-spi@vger.kernel.org>; Fri, 23 Dec 2022 20:18:34 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g7so5121358qts.1
        for <linux-spi@vger.kernel.org>; Fri, 23 Dec 2022 20:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4vdG/0iY/nb14Dy6MULZKjjLy7LIhTxYUj/A1NLJF0=;
        b=XygGNbk6DiMvx9nSgEoerAkWmIYg2gt6vDmy4BJCTcHTf4tDGBfxpWLyqlHPGpQ43l
         qi2TDjgY0w/LoMXnHUr8gvDVTn/tcifFhduLdrvmHRnq3Y3aAbMqqJ8BM9bSmVoTd1mI
         O9AkypxLBC6SOta+0IOGmt4CzOlNfjGLwmiURNj10TWhHQQPqEUjeeO+A86vE6cBpWX9
         waTm83KYcO7/ocrGMa/79sH6i7iRzNEfXxMkhThcfd4I6aTuj7hyCE/24FbJg8oVxIxy
         srnDOzBAlRJLIQ0jNaRkDHnbiS2G68rqvAieu4cyi/GazZmXnkg855cQ4LgNGBDEr83C
         rGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4vdG/0iY/nb14Dy6MULZKjjLy7LIhTxYUj/A1NLJF0=;
        b=SdIXkjweIPC8r6lzdRIpkOSV7pW3VT5AitRwf6aHn3pBR/EzA03QPcHcdiCmInbtxP
         +6JjKQzjf7/hIfMZFoYQSybd0ue+mn0UNRThsM5Sptpu5C5j/h6/rCXJKsvXMfiCb1Ob
         xYSK1aW2zFBMAo0sMW7n5UM9LZsibxNwl1e2njzN4McIlqgZbBpu0wP33SlmGocgGo9d
         HwzOA4f8EOUEs6b2PMV6wNjrxiXJ2wI0BigC5Wg83kNiTmxNg5n3WZI3LBIC6bzj3MMp
         jyzi0xpK/GNPzU7zPLnhErCCqCtlA3qiOIJt/B4sAC9vGAcobkXkztpy5R6uPnC+eI42
         lN4A==
X-Gm-Message-State: AFqh2krMTUx3unAiVq5id53xPEmxbAmLM7xqXKI60yblNZtYWwXidATG
        KtW2dAu06avo2hkSq3xm5JfQJQ==
X-Google-Smtp-Source: AMrXdXv/CfYBa9UlTcgOyKQB3tKZdlGUfNGw1ZGsyHWELieQ539dm8Y7UNcauHg7NdeEKIkh/MRlTw==
X-Received: by 2002:ac8:51d4:0:b0:3a8:1677:bc46 with SMTP id d20-20020ac851d4000000b003a81677bc46mr15081310qtn.49.1671855513376;
        Fri, 23 Dec 2022 20:18:33 -0800 (PST)
Received: from vtremblay.. (modemcable190.194-177-173.mc.videotron.ca. [173.177.194.190])
        by smtp.gmail.com with ESMTPSA id bm31-20020a05620a199f00b006fc94f65417sm3563630qkb.40.2022.12.23.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 20:18:32 -0800 (PST)
From:   Vincent Tremblay <vincent@vtremblay.dev>
Cc:     vincent@vtremblay.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spidev: Add Silicon Labs EM3581 device compatible 
Date:   Fri, 23 Dec 2022 23:18:25 -0500
Message-Id: <20221224041825.171345-1-vincent@vtremblay.dev>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for Silicon Labs EM3581 device.

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6313e7d0cdf8..319f8cc1cda8 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "m53cpld" },
 	{ .name = "spi-petra" },
 	{ .name = "spi-authenta" },
+	{ .name = "em3581" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -728,6 +729,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "siliconlabs,em3581", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.37.2

