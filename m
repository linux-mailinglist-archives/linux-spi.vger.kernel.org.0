Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB51F90EF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFOIDa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgFOIDO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 04:03:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C2DC061A0E;
        Mon, 15 Jun 2020 01:03:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so15994617wru.12;
        Mon, 15 Jun 2020 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9j15buHhd4MKiI4Z3W6luNAtm0Ob/ZJTryZmnMV59NY=;
        b=tuxtRsJpBCC8hJ2ghKhM7f9YV3ySoYO4eBPB/Y4VIPmWwyaVL9hiX9POpvkdaHrw0y
         J7WmzDSdaWFgcz9vrNERXvOUtplVmkQzQAGgxeyKMTpSlUt6wi3jO+/UqtFFzFs07SGW
         tTxgd9WT7riJQ8rse1SaO0n4DfkBv2gpVERAPg6ygOnKi0xInK6VnS/SgRESLQN3nVRE
         iW85QSm8caxEXuBqMJZHgpsoLgIwnJgE7Te6HkeJaccvKV64qug/03RrOoW9qPtl93MF
         EcL9bLCWm+U1mHtWOV8KpN8e5AWNBiBowFxRSGss+hxdBylEVP8/JYcj3BM5cn3A3JLh
         JB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9j15buHhd4MKiI4Z3W6luNAtm0Ob/ZJTryZmnMV59NY=;
        b=f3bERTwA1YyyZMn84R3wBzRo1kv4c9fUpTeJg5h9OuzuYFmXiUU67jzc2xyPnCPsRA
         9MAb/t6W7JShXpSbQdXKb8eIYu18zbHVkVmRdKoRuONhoyIhLz+KcloicLhxngSSym/h
         lv+faRnONYXPasIeiVjg0wQuskkldOvMQh4YzOx6ok7H2cF1J50EPiBOZC0y/0CbJRep
         46DwSwZVQqy50FpzbRNo5UMquA9WPzWzhD2ll1Aq/TPwJtfTvUuhM9K5lqevMhZZUUs9
         I1y3bJOhSNGNh3kDgkyRaum0ZQeGDiZKWm5QhTtT0YK5mPKC1pkgUCgQcK3bILINwOrI
         34Kw==
X-Gm-Message-State: AOAM530OdzD/6GRBNGg5H3JGLT8Pa7HPCrqiahxxqAI+Hq6eRUBnwedx
        5ppOuY2N9eOchoVAHy2k0d0=
X-Google-Smtp-Source: ABdhPJyeyKfGDyTdOzNRz2x3lHRjgrXZmAham+P818HmOVjjddX+R87QLRQVlvHCPqimUKeT3cJ7DQ==
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr26527669wrq.267.1592208192924;
        Mon, 15 Jun 2020 01:03:12 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id d9sm23107054wre.28.2020.06.15.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:03:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/4] spi: bcm63xx-spi: allow building for BMIPS
Date:   Mon, 15 Jun 2020 10:03:07 +0200
Message-Id: <20200615080309.2897694-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615080309.2897694-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bcm63xx-spi controller is present on several BMIPS SoCs (BCM6358, BCM6362,
BCM6368 and BCM63268).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8f1f8fca79e3..a9896e388355 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -149,7 +149,7 @@ config SPI_BCM2835AUX
 
 config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	help
 	  Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
-- 
2.27.0

