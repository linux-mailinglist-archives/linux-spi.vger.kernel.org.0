Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5334C1B4
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 04:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC2CAR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhC2CAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Mar 2021 22:00:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07DCC0613B2
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 19:00:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5201825pjb.0
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUT/fx38q5jzHp0KnGD15nyHtPKW1998V0+UJkFXEGk=;
        b=Fatmgx4bbKgLWkUqRoiO8p/pewMHfBVdaojdQ8DnCIAerwmYI168oyuDMwEC046Dkm
         abax/+QVucUuZr6HMyxsyxoV2bp8YOzt7wZStiliDGPY/FMZMWKLCj42wq6hu4JTHdE9
         qd4VArE7xvCnu9/Ddnx9HsL0GVjdLqrKqMuUZD+3vvygCHFDmPDAO2zNpMhsdPZIfwLS
         +3MnxcxKkh3beRViCgwbPVYABlOiRJOB4+QQmUpCvBuQUNnLxV/4LKOzzvCjhmQimQXo
         P9ppgVDwaAm4xzplaUoVrnJWCvluAnQxTbAXcVtgcuDcmnNOGlgqx2F2WZMJQviIRtZV
         tzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUT/fx38q5jzHp0KnGD15nyHtPKW1998V0+UJkFXEGk=;
        b=Me2aQZV3cfLCNHgQEV1GnRXBwDQCotnW1A3NIZj6xp/RvCTZ/kzifCET6B2i2vuvvc
         Knfnvq65xAYCVX97+jKg9RBoMNz5lAq5xDXQvhFwp0yLBRX9vh+sFiv68oe7FAHOesnd
         krWFXsU3gHeLPrydddgbRPWsij6tomwR/6hCCF41SSXjdvP2WsM1hKnFJj09yLF1w90d
         nnGiu0up96KNt98vOrEPkubmMa4y+4e0Ys7+2F0YPPoOPdOBigAFCkMZ0Ad7FowzY/XP
         zFoKw132STBtFsh2lH/w4lIltYiQ/YY1ZU3LtxlyCY3zYjTeLwjyNjMZzBYi7y4e7a8D
         x6mQ==
X-Gm-Message-State: AOAM533PzSP0WN1kHBCvnnjQxLeXkWh208C7oU8T4UYjLvmj9PvtIgY2
        qFHac4Jg3GaxMuz995eE7mJC8Q==
X-Google-Smtp-Source: ABdhPJyVsLefzEtdM9V5TgiaRr9fa4c2/h685XCffpBKXzNUaBp5HAE7FMtuN8Bx6CudThzRHfR2Zw==
X-Received: by 2002:a17:90a:d41:: with SMTP id 1mr24992479pju.232.1616983204271;
        Sun, 28 Mar 2021 19:00:04 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.19.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:03 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
Date:   Sun, 28 Mar 2021 18:59:38 -0700
Message-Id: <20210329015938.20316-14-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

New drivers should include <linux/gpio/driver.h> instead
of legacy <linux/gpio.h>.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/gpio/gpio-elba-spics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
index 351bbaeea033..c0dce5333f35 100644
--- a/drivers/gpio/gpio-elba-spics.c
+++ b/drivers/gpio/gpio-elba-spics.c
@@ -6,11 +6,10 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/init.h>
-//#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-- 
2.17.1

