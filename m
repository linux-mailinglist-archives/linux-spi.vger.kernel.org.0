Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8234A221054
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgGOPHe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGOPGj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF1C061755
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so3660546wmm.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+k3VcTxp8QDyMoYM0yDw+EEU9DorBAQ7cdSI3O9/bb8=;
        b=o9rdZT8Hx4ZSY0QyT7IkQ4ORw3I2KhdkBi8D9WD0aKlkOqwzLlsY+8wGm3MgZELZEZ
         eoxZGyF0WYg3vLxEQtGzR1mPRhYBeowAwZG5Q1ohDhRTF6B7aI/kDZ5zE1rHynHqdjwD
         Y54oXUrHFNGOjkRgk4fKPU/YwFrCG6KHOLta5pTY2GQOAgYV/hWW7p7fvAIj9huteoSQ
         oR5UJ1GnrJrbbh6QbH915oTx/e/2TW3Tlgbng7XupxpuplJjwr3xz7gWkoAfFDYwk3yU
         T/n29AgXpPcokXXb+lnNSy//o0npV250DhZ5HWTzVSajBjsCeZ+1+gxceNq9A5EviKhl
         XrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+k3VcTxp8QDyMoYM0yDw+EEU9DorBAQ7cdSI3O9/bb8=;
        b=nyH/xzSqdNNyYVD/7zh1JXXlGlyW/+GN/gGXt3uLnUCjWdXa/a/ghMMRjkdCUfCE7L
         qKoMpR+bHwp32p1XBy2lsiu0nHPn3e6huENg/lhy8Bf6aOxcAF7I2/8/p4evoB2EP4WP
         vrGgs4Ewc1HH0LOEawBc2MWq7KO+H+zFVAQ5C1hsLNy+rBpbGnutzG2zaI2QcoSDfNUp
         XY7kp3btkLZiihXDpg6lBPkuB17BU4OrgviBheSuxgjcqFD+ZIre8QhXtIvlzfLxPsid
         OQsCcL4o003zsDFQmqd0qLs//q8vrk9iQMXr5e8gJMlzHwk39tvlpbtdpTTf++i+LvER
         3oZw==
X-Gm-Message-State: AOAM530hvSAk3uNpp54tk2rAIQ4SSqE785u+JcEnBSMz6YjoXbM35g7j
        9AT98jnJPQMSbuVidjyctApI7Q==
X-Google-Smtp-Source: ABdhPJx9OHW5pgfjAQYGs6oy+4+393KILVPwhdW2gMjyprB70ILbgU/eATaVe2aWskjv61M55Cm5OA==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr9762032wme.91.1594825597387;
        Wed, 15 Jul 2020 08:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Wed, 15 Jul 2020 16:06:20 +0100
Message-Id: <20200715150632.409077-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-bitbang.c:181: warning: Function parameter or member 'spi' not described in 'spi_bitbang_setup'
 drivers/spi/spi-bitbang.c:215: warning: Function parameter or member 'spi' not described in 'spi_bitbang_cleanup'
 drivers/spi/spi-bitbang.c:434: warning: Function parameter or member 'bitbang' not described in 'spi_bitbang_stop'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-bitbang.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 68491a8bf7b5b..1a7352abd8786 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -174,7 +174,7 @@ int spi_bitbang_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup_transfer);
 
-/**
+/*
  * spi_bitbang_setup - default setup for per-word I/O loops
  */
 int spi_bitbang_setup(struct spi_device *spi)
@@ -208,7 +208,7 @@ int spi_bitbang_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup);
 
-/**
+/*
  * spi_bitbang_cleanup - default cleanup for per-word I/O loops
  */
 void spi_bitbang_cleanup(struct spi_device *spi)
@@ -427,7 +427,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_start);
 
-/**
+/*
  * spi_bitbang_stop - stops the task providing spi communication
  */
 void spi_bitbang_stop(struct spi_bitbang *bitbang)
-- 
2.25.1

