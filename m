Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921C1203C89
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgFVQ0T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbgFVQ0Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jun 2020 12:26:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37EC061573;
        Mon, 22 Jun 2020 09:26:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i14so224787ejr.9;
        Mon, 22 Jun 2020 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRSeEGx+iywHLMnsI0Db78lh59FwNXwM+BHCFN43KFc=;
        b=f+NZ8mdCqpTVLxe0XpcWX6E7uh+0QvDFVNbCU9PB5B4i5e02vkxaxW+aSFXxz5fIHW
         pScwkQjC7YTqsVUwQbbjNTS0MAXhFigofiYrVWF31kSDTVZn9O8g5lUSCWyfkSAQ5coT
         Xk1tDsPBAuOVtRD71vCjMQsQH3Jz9HljxZetviSYdJK00R9Sb9dK41zOn3U2Po79yBBQ
         LxWsPsyl11fMbopq2gFSVevQfbZPIW1bkubUuu7gmztEmfNV/aC1wcWCbitTEJxlGoCi
         Vd2XkiVBy3Dd9S3j2NiTk7qkrN+rmsM5gbNlFGfwqBLPQz7CElMHttc4ZS+IyoniuSpg
         wheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRSeEGx+iywHLMnsI0Db78lh59FwNXwM+BHCFN43KFc=;
        b=Jhduz6V/KB+6kU+FbTGSjO/YfDQLJucbBx3qmPLJVxc2T2mCiUSVDQ+HNeRaRCrfPq
         N6eK7XhYDtNF3M4TuQKphIEMJlDeohjR4rxL1L2cQeiWyhsJSzqO7fn+YfE/NRsHVHFL
         xNZGscSiE6aXAcAafpC6mTBXZTjPYGzqjALWf/vh5wCFR99i2VPEiyUCFQY99ge6nJYp
         3t637ZzbfXzl/A4Oi8RFrFxN27gKkzO7YfPmjZKeTdmYRe2zl+lZDlC0NkMfsKEX1rol
         GFU0cTCFMqE43OCGkdptajh4rx/krDXnNmyIMI4x6OENETWE9JEFFpKJfs1D33PEHae4
         +s8Q==
X-Gm-Message-State: AOAM5305VIYJsuuHRAjK4711Kd5zg9X0SqA9JMjBnwT5A9Bg8LdT+N3C
        9BjGCUggVEUy7inxaTnPJ0g=
X-Google-Smtp-Source: ABdhPJwR1x0eenUZ7pJJzQxRie8s6Q1SAZSIMaSKDxT+sCSr1QeFQ5qBZAPEp1gWydFVNWHfkV+PKg==
X-Received: by 2002:a17:906:e298:: with SMTP id gg24mr16183015ejb.120.1592843174601;
        Mon, 22 Jun 2020 09:26:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:74f4:a0e9:488b:65c7])
        by smtp.gmail.com with ESMTPSA id p6sm11948424ejb.71.2020.06.22.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:26:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: fsl: add missing __iomem annotation
Date:   Mon, 22 Jun 2020 18:26:11 +0200
Message-Id: <20200622162611.83694-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The field mspi->reg_base is annotated as an __iomem pointer. Good.

However, this field is often assigned to a temporary variable:
before being used. For example:
	struct fsl_spi_reg *reg_base = mspi->reg_base;

But this variable is missing the __iomem annotation.
So, add the missing __iomem and make sparse & the bot happier.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/spi/spi-fsl-spi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 67f022b8c81d..299e9870cf58 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -90,7 +90,7 @@ static void fsl_spi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 	__be32 __iomem *mode = &reg_base->mode;
 	unsigned long flags;
 
@@ -291,7 +291,7 @@ static int fsl_spi_cpu_bufs(struct mpc8xxx_spi *mspi,
 				struct spi_transfer *t, unsigned int len)
 {
 	u32 word;
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
 	mspi->count = len;
 
@@ -309,7 +309,7 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 			    bool is_dma_mapped)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	struct fsl_spi_reg *reg_base;
+	struct fsl_spi_reg __iomem *reg_base;
 	unsigned int len = t->len;
 	u8 bits_per_word;
 	int ret;
@@ -440,7 +440,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 static int fsl_spi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_spi_reg *reg_base;
+	struct fsl_spi_reg __iomem *reg_base;
 	int retval;
 	u32 hw_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
@@ -495,7 +495,7 @@ static void fsl_spi_cleanup(struct spi_device *spi)
 
 static void fsl_spi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
 	/* We need handle RX first */
 	if (events & SPIE_NE) {
@@ -530,7 +530,7 @@ static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 	struct mpc8xxx_spi *mspi = context_data;
 	irqreturn_t ret = IRQ_NONE;
 	u32 events;
-	struct fsl_spi_reg *reg_base = mspi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
 	/* Get interrupt events(tx/rx) */
 	events = mpc8xxx_spi_read_reg(&reg_base->event);
@@ -550,7 +550,7 @@ static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 static void fsl_spi_grlib_cs_control(struct spi_device *spi, bool on)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	struct fsl_spi_reg *reg_base = mpc8xxx_spi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mpc8xxx_spi->reg_base;
 	u32 slvsel;
 	u16 cs = spi->chip_select;
 
@@ -568,7 +568,7 @@ static void fsl_spi_grlib_probe(struct device *dev)
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
-	struct fsl_spi_reg *reg_base = mpc8xxx_spi->reg_base;
+	struct fsl_spi_reg __iomem *reg_base = mpc8xxx_spi->reg_base;
 	int mbits;
 	u32 capabilities;
 
@@ -594,7 +594,7 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_spi_reg *reg_base;
+	struct fsl_spi_reg __iomem *reg_base;
 	u32 regval;
 	int ret = 0;
 

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.27.0

