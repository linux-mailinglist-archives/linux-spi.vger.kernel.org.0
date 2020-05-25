Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3881E059C
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgEYDqV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbgEYDqT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:46:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F2C061A0E;
        Sun, 24 May 2020 20:46:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so8135876pgg.2;
        Sun, 24 May 2020 20:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eu+Ho/X9r7MZN52F/RomcQQtgjiQ+X/m9AkGhdRXtC0=;
        b=hlbOLQ3Eyjn+XvXsI6V94Sxye1id84iasnp0uBZIRnBKOkbSU9yUbIlq41keOh/DjV
         M1Ji6ztXni7ait2BVtg15UvWVCX+vU/nFT3K1YarMdgZiYIY/cRoUv0KGgjbkRIZqvSB
         63nHgdS7zUi+wtwJ8SqLo93B3tzLNNoTRj10+QAlVcCSbgjVGTKNRaeGDJTUQETf2BP+
         Lb7gvSbVZhR3G2KTWG73ysbzCiM2NYHYNaz7/L9i2dmlI2vdR+kVt1h9n0FOY+BSUkvc
         d1dqmHCCPP2l9PLtyGm+TcQLTBVFtA8k/HtwXqlArTw8rogH5EMBjOPtBKe3H89ggCO1
         zIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eu+Ho/X9r7MZN52F/RomcQQtgjiQ+X/m9AkGhdRXtC0=;
        b=OeIQd7Sq2yQyTtItuQ9D5hKvJsAIj0eT7Z/3dBpTXK043WIkh6Gs5QjYLpFY6O8HR8
         HItNtSR5FIK5D/tOMK06o41L3QmyeK+rOZgrGPlpqReDYmflLWpdWWM0vIfUpX3Kg0Xj
         atIY+jtjhmdKDUPbZHJYZc5tuCTiZkpnX3nT6PZPt/ztIdnIIccWpOy4TP7tBa544eye
         x5LMSrRBwpZYlp8ml0kVVNG2rLoeT3CKv3ShT7qcb0fz69+cssY5kQjwmfEpLY82k71s
         zgWV5VxCQNa9MnIrJVRTTzP6C6efPXpcl+8Ri1qZawMQ1BFPN6HYc5jUhZRYKMIVqASn
         516Q==
X-Gm-Message-State: AOAM5336p1dcVzMo7EjFVajzuSpzcpLUQp+pxATVkV3XSL9QmMp0ZUlV
        6GVGgcpN3YFIF16UIopSQiw=
X-Google-Smtp-Source: ABdhPJyCVTbNtcFfst1GMI7OlJFQdpx2wRpgu5bLKCThc6j672Jh+qV5W3K7wBvjbpx99E6OdCvgoA==
X-Received: by 2002:a62:8888:: with SMTP id l130mr14964445pfd.140.1590378378954;
        Sun, 24 May 2020 20:46:18 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.46.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:46:18 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 8/8] spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't be coexit with 'SPI_3WIRE' mode
Date:   Mon, 25 May 2020 11:45:48 +0800
Message-Id: <1590378348-8115-9-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

since chip spi driver need get the transfer direction by 'tx_buf' and
'rx_buf' of 'struct spi_transfer' in 'SPI_3WIRE' mode.

so, we need bypass 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX'
feature in 'SPI_3WIRE' mode

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c92c894..f884411 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1023,7 +1023,8 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	void *tmp;
 	unsigned int max_tx, max_rx;
 
-	if (ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX)) {
+	if ((ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX))
+		&& !(msg->spi->mode & SPI_3WIRE)) {
 		max_tx = 0;
 		max_rx = 0;
 
-- 
2.7.4

