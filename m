Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B839FA21
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFHPRu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 11:17:50 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35534 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhFHPRt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 11:17:49 -0400
Received: by mail-pl1-f179.google.com with SMTP id x19so3664949pln.2;
        Tue, 08 Jun 2021 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYZFzOuf0dBVfSWqlNZ+PwU9Y527Caprq03EBTp/hQc=;
        b=X9FAaZBhybTDaOcaSSavLBR5xhEZ8GbxQ1eYD4vzXVRcwB/YoItvawAv+t8s59xk25
         cy4qTolIajfE7JiorUaS3gOeH4c15SRWEkFVPXCeyy03i16my/JgKcBJgoq3D5VrQNfl
         CBCbajyc10W0/dM9iAe06KBsg+/6ciPvkL50A0b0e3yXS/NSsuMNfhsuz6EOwdCt9MU5
         HmiTouhB7bO5BLzZhpOKgNDbkWX1uSezsNQ9siF5O+a+bwRWi/Wy8dsXz2wVBKZoCt5p
         Q28F1F6Uv1kDireZk9/0gXZ7swnJ36+3G/X21lcZhMf+YiaIEABxbFzHOWNUhsBFZldm
         y1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYZFzOuf0dBVfSWqlNZ+PwU9Y527Caprq03EBTp/hQc=;
        b=jGXY1j8IL/oA3bVyvYDnvllI2nVoHtpkXj/05ZTqUhDXr6FRxdksz5faBtYpPbHmX9
         Ln6pZBq8qpm9yjjR59EVZRo5xVrP6pXeIBFBd6Coj96AaKEGjzqKqOYV5AZ77IMSp8Ct
         NPG/7M0PKGoj72MHASlDuGaEplkIzyuwdWKYbknCWewLtAQ0R5bpXtv2y7fiaMjTbfRQ
         rT/MvUW2b855k/WzUvaEEw1z5CmxH1ZTJRa9NlHaut3lSWSvTnE9tVusbw9zRz7wj7Le
         B42zZCFJYZgdAqq86BqhbYTFh2jysa+TCC8YK0+CauoglvcA7b+TqP7uvPQkUEtd47OJ
         ey+Q==
X-Gm-Message-State: AOAM531heRq7sgCBNRQuHexKgwGQak62DeZXDY1drPhjcwvoj+Wqb/qV
        38TmcVGvxFu78zS7myIe2aA=
X-Google-Smtp-Source: ABdhPJwAk+ydJxes2ggQrBQC5AM+k4o94mm9LV5/fMtmHegyUDh/chiJY0hrTZq1QKQ7ZEk9uy0BbQ==
X-Received: by 2002:a17:90b:3001:: with SMTP id hg1mr5336095pjb.169.1623165284846;
        Tue, 08 Jun 2021 08:14:44 -0700 (PDT)
Received: from localhost.members.linode.com ([2400:8902::f03c:92ff:fe55:8c1e])
        by smtp.gmail.com with ESMTPSA id q12sm2705620pgc.25.2021.06.08.08.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:14:44 -0700 (PDT)
From:   zpershuai <zpershuai@gmail.com>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     zpershuai <zpershuai@gmail.com>
Subject: [PATCH] =?UTF-8?q?spi:=20spi-at91-usart:=C2=A0Fix=20wrong=20goto?= =?UTF-8?q?=20jump=20label=20when=20spi=5Falloc=5Fmaster()=20returns=20err?= =?UTF-8?q?or.?=
Date:   Tue,  8 Jun 2021 23:14:07 +0800
Message-Id: <1623165248-24038-1-git-send-email-zpershuai@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When spi_alloc_master() returns null pointer, it’s no need to use
spi_master_put() to release the memory, although spi_master_put()
function has null pointer checks.

Signed-off-by: zpershuai <zpershuai@gmail.com>
---
 drivers/spi/spi-at91-usart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 8c83526..c8136dc 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -533,8 +533,10 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 
 	ret = -ENOMEM;
 	controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
-	if (!controller)
-		goto at91_usart_spi_probe_fail;
+	if (!controller) {
+		dev_err(&pdev->dev, "Error allocating SPI controller\n");
+		return -ENOMEM;
+	}
 
 	ret = at91_usart_gpio_setup(pdev);
 	if (ret)
-- 
2.7.4

