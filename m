Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF927A4CF3
	for <lists+linux-spi@lfdr.de>; Mon, 18 Sep 2023 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjIRPoO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Sep 2023 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIRPoL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Sep 2023 11:44:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3A19A
        for <linux-spi@vger.kernel.org>; Mon, 18 Sep 2023 08:41:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1c66876aso579403966b.2
        for <linux-spi@vger.kernel.org>; Mon, 18 Sep 2023 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695051410; x=1695656210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeueOuoVmZw39cDuG06Cps8ippAl5MH5eqOWbaiqh3g=;
        b=O03tAsYuZgh17ip9imdRq1XXZ9z374kma6GNh1xLkkKOCe4RpoZ50tZ1ek5zaNgyWG
         OX4ofRQHxgvI29FUn4Uy0KsW0oFh3HPUmfeJZJAWd7vWXd1MOi0kK6nvbsbLIMjyNiL5
         q/QYHGVoErzFsu2gICxxlFNcUA9457O3n196QTlTADJEweGYCyrEdnjCXFiWliofyhXQ
         efn/080xUDPG3Bgs1IN0ph1gsMQA5S4Ed0Fhq6O9Mfebw39xS4CiI6+aeBy5l3xr0OLG
         U15iJuc00uWtE2LNlUYq7ybDEOrDoYZV6IxsLclgKktBJ2m4JPe9G1/q9USR/yvBev7I
         JjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051410; x=1695656210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeueOuoVmZw39cDuG06Cps8ippAl5MH5eqOWbaiqh3g=;
        b=Kc2EIcy0yEkf796eGwL/0HkGhPdzNTHg8mGz6fvgVU3Sk0RB4U3zGD8a5bNcZPnn2T
         6Sad0Pi+qx71nXRGonJR/whEYK5ZKucYzaaQrV6JtPCMKdAFXntXt//q+aL1ZlJ1gYaE
         HOMSNE7c84aW2PCeaRA02uldC0h+bY6cI72nRIe70BbhkEawOvchPhMiMSrqjzIh2xJU
         9HBIsMMykrYyh8tPEkAqmNQ415ZmRVuS5szKYpFcDgfCi3qBfAcjm6xTxhCTyHvqN8oB
         pZhfg9NaqbxPYYXc20VAfUOpwpLYmH71aA1WZkM4ssiM7tjRg5QRWvTbRL8LdgCQGgnq
         8d4Q==
X-Gm-Message-State: AOJu0YxAmKTCAnfB40FhUw0lwVGglMUKawPSfBHjka3sxIiTYfYgA++f
        t+FpUFxeO+qToCFozqfN5l8=
X-Google-Smtp-Source: AGHT+IFZYtiXR+P1knqibZRMm1T1pxSsbkRkUGR7rpBw/Pa53Fn/CSLhIEK79eGfj57Tw2LyMDmTIg==
X-Received: by 2002:a17:907:a05a:b0:9ad:a003:6558 with SMTP id gz26-20020a170907a05a00b009ada0036558mr6687181ejc.5.1695051409986;
        Mon, 18 Sep 2023 08:36:49 -0700 (PDT)
Received: from localhost.localdomain ([109.38.133.69])
        by smtp.gmail.com with ESMTPSA id oz11-20020a170906cd0b00b009ad850d4760sm6556534ejb.219.2023.09.18.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:36:49 -0700 (PDT)
From:   Stefan Moring <stefanmoring@gmail.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxmp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sre@kernel.org
Cc:     Stefan Moring <stefanmoring@gmail.com>
Subject: [PATCH 1/1] spi: imx: take in account bits per word instead of assuming 8-bits
Date:   Mon, 18 Sep 2023 17:36:33 +0200
Message-ID: <20230918153633.2198-1-stefanmoring@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The IMX spi driver has a hardcoded 8, breaking the driver for word
lengths other than 8.

Signed-off-by: Stefan Moring <stefanmoring@gmail.com>

---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a8a74c7cb79f..498e35c8db2c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -662,7 +662,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 		if (spi_imx->count >= 512)
 			ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
 		else
-			ctrl |= (spi_imx->count*8 - 1)
+			ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
 				<< MX51_ECSPI_CTRL_BL_OFFSET;
 	}
 
-- 
2.42.0

