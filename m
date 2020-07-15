Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0735F221038
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGOPGn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGOPGm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E28C061755
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so6165801wmo.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5bZU73kxT5M1JMsvuGC6Lo9dJE8hXmdkV8EdjzvhWs=;
        b=zSvp1cyp9NwMoDYQ099HhmCQeArDGEPwCWKkWWzxkXBbj5HghEulOTG6delZXfRB4V
         7pZwKEOvp46RKySf8Yzgtk9eN3B4BrBHD+xBCvj58iH13cRfFWtS2B5C2Nhix1PIZUxg
         JREpBcxLC3C7l0qnK44ImxJ1a2yrz/6U6//NpLOhRGhvW5Ui21FgwTqGG8Jn0swFlid/
         7fez9lVPIMrbEJ9VMehmmZlRi4gHVJBZjIzmMBGGfGCL5Rt4m8lN9MaPazxs8psW/9VH
         iV600X2ZSWoU8ZSzhXfgAfPccHmAflze7iWKZwsSmgjjO7Pft90i2o6F6TpklayyKXza
         Cw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5bZU73kxT5M1JMsvuGC6Lo9dJE8hXmdkV8EdjzvhWs=;
        b=WSuXqIjjxZuMhjSNR4pY6c/3PYC2GnNf3m+Pp8s4QW9ByiucTU5wqK4bZIn4CL/dDW
         aeXp++u4VbSJwxtsRqPOg5uvQpm9rNJK3lr8r34k+ZZaG9gi9CKQdb5TzFPLTNi7voMK
         N91ekhHfO62jCcwwhipCfO7rEGAZpGytdnb1Fpi0jpW+ckQ25zX+AO1KP6rDQbdu6XWh
         vrenb7taBrTffDHXtwoLzycKGY+hjfBr55H74rHP0OsjjJCZq4jI/DlSy0WLJTBmyDn8
         nMg9RMd+dersHwpt2e0gVJTx2tTcQT3ZTFzwmEqVKP7cUcTqwjLhrCAV5iQDr5Bdn9+B
         xZig==
X-Gm-Message-State: AOAM532MyVdPUYyfT4NNP6hkkpui9yz8+DKs2toU1/XCHKG6YKDKPEDO
        e1Uz1HDGhUJOaGlMyvbHFFlefw==
X-Google-Smtp-Source: ABdhPJyhdfGUmrtF4d7P3vciFQvDcpZfiGbqTTuoOSU/tp9T2pBra1bNvwYIGOrWZFGbTtCfW3Nx+Q==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr8694473wmb.112.1594825600839;
        Wed, 15 Jul 2020 08:06:40 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
Date:   Wed, 15 Jul 2020 16:06:23 +0100
Message-Id: <20200715150632.409077-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-meson-spifc.c:80: warning: Function parameter or member 'dev' not described in 'meson_spifc'

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-meson-spifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index c7b0399802913..8eca6f24cb799 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -70,7 +70,7 @@
  * @master:	the SPI master
  * @regmap:	regmap for device registers
  * @clk:	input clock of the built-in baud rate generator
- * @device:	the device structure
+ * @dev:	the device structure
  */
 struct meson_spifc {
 	struct spi_master *master;
-- 
2.25.1

