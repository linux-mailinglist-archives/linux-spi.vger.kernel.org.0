Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9B4131E3F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2020 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgAGEJb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 23:09:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41100 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgAGEJa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jan 2020 23:09:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so27921432pfw.8
        for <linux-spi@vger.kernel.org>; Mon, 06 Jan 2020 20:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UbDGfz+Zv6xQM4bcQDYbb7lyZLmyc5f8z1Itmiihj5E=;
        b=P7ZzXL12d6nzFrfsOQH7cZ60lX/Skm8S2B2/8CYu7pgFaR84V4+X0XLgWZsQAIYV9Z
         kXS9/VEgm5233KKw8jzFsG/PQgNvohqYMLSu6XS2HwF3LnGptQlDpDQ9/IGNmlV+sjTR
         gwwTyZTy7ZKUbZIPS3eKJqDd6csG9+QyEImwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UbDGfz+Zv6xQM4bcQDYbb7lyZLmyc5f8z1Itmiihj5E=;
        b=I6OmUqPeiF294QKZF3fJZCD4J6XpKDXKZwUoM7P89YWp+/kVPApcvgJTn5Gvs4hcw5
         T4vzFb3wBXG6BzDzKC4ZYKRx17lf3Xh3rj8FmTCf+HWuMtPLYtxMIN+69w/5Mo79dXGj
         XnsZaQykUIjLfTFW+aZnAwWRUD5rW2jdD2Hnm1QdrzzLsz0vpazi7NoyG2W8MUIImWOV
         TBKpoQtVjxZIP0mWlZuu31BHtMw/11eQXLSFel+yR2i+PjxEfd/klWOL6QtXOllOzivo
         7tj8b0jqKzI7R4F4Cbu9svk2kSoCW9+CbkZ9f1nVo83PaL+RmOT5no551307CEMre/hQ
         V5/Q==
X-Gm-Message-State: APjAAAWavCgpjG69fTQ61Dcmol7ioLw8cYe2y/wSYZH6u7sIKbJjtP3J
        he1tvduo6Y7GZRL2/Ovr7ComuA==
X-Google-Smtp-Source: APXvYqwCRqwSnTJPSRlsXvvZZojFZ5FxBSbE1N3+S2c5ISE5p/eR35zjbZydfXoqInwd86TvLoWRrg==
X-Received: by 2002:aa7:874a:: with SMTP id g10mr94042109pfo.205.1578370170296;
        Mon, 06 Jan 2020 20:09:30 -0800 (PST)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x65sm82920355pfb.171.2020.01.06.20.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:09:29 -0800 (PST)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Use platform_get_irq_byname_optional() to avoid error message
Date:   Tue,  7 Jan 2020 09:39:12 +0530
Message-Id: <20200107040912.16426-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use platform_get_irq_byname_optional() instead of platform_get_irq_byname()
to avoid below error message during probe:

[3.265115] bcm_iproc 68c70200.spi: IRQ spi_lr_fullness_reached not found
[3.272121] bcm_iproc 68c70200.spi: IRQ spi_lr_session_aborted not found
[3.284965] bcm_iproc 68c70200.spi: IRQ spi_lr_impatient not found
[3.291344] bcm_iproc 68c70200.spi: IRQ spi_lr_session_done not found
[3.297992] bcm_iproc 68c70200.spi: IRQ mspi_done not found
[3.303742] bcm_iproc 68c70200.spi: IRQ mspi_halted not found

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 85bad70f59e3..23d295f36c80 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1293,7 +1293,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		name = qspi_irq_tab[val].irq_name;
 		if (qspi_irq_tab[val].irq_source == SINGLE_L2) {
 			/* get the l2 interrupts */
-			irq = platform_get_irq_byname(pdev, name);
+			irq = platform_get_irq_byname_optional(pdev, name);
 		} else if (!num_ints && soc_intc) {
 			/* all mspi, bspi intrs muxed to one L1 intr */
 			irq = platform_get_irq(pdev, 0);
-- 
2.17.1

