Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002C03A0A42
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 04:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhFICvj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 22:51:39 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:40880 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhFICvj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 22:51:39 -0400
Received: by mail-pl1-f178.google.com with SMTP id e7so11763649plj.7;
        Tue, 08 Jun 2021 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtsD9Wl4PiCzwJ+AjHCemki/R0XFKsC3fAJOVKuHles=;
        b=ACjwEp9McuoWtf0GsaLxG3hyeLvVzpMa4PiVhvkSulXlyybqhfo/8h1elQQaz+s5Nm
         2YVbjVG5Izuv01+m54q9/3adYM7uXVdsiN1AmmDWBrgJSKbgnYuxjLcpGy9k8vxxX2X/
         K6bLsW87/uMuypQ7p1BrJSHHm0gmsg20cdAzXXutZAGad0iX0BHqF/3vh1dX2Rk/MfvX
         rwUH3+POjEs6R+cfAlOUumd3a54ZiK9xb2jFOtK7jaaHnovUTr2DiHZ5ESz/3cwAM4LE
         ogh+KtHlohT6XC+jXR4WWv0FWm1/4ccTsdppBabvrZdNUjNiFL/H+JoFSQB6fi6L3Ue3
         FLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtsD9Wl4PiCzwJ+AjHCemki/R0XFKsC3fAJOVKuHles=;
        b=nK9YxmjpLqWcDNGguxuuNPBeWT6ASYbupywr0RR8b59DjPPa83RPUcCZVTkiHQMh4d
         Z7ja4LhcjAE6FG8UV7f9NewQZgA/ALmYsK1HIcavPf0YbOoFW8u1aRxwYhgf4veggJxy
         SCGNj1B1akIVCLaypTPKDBJZf2R0QwrdgJcpGYayZLxyQCxfI21ipRj0GsyTaMb8Zu25
         dDs7OVhFLlVRg/JB1lDhLeiOVVlOA4AT9azHWsAOljiK+0mDrG8xZd67L5FOaztmbnlF
         wGiIz7SGcZcGuYQbxUbKwOlxUHjidEjq6yTP6kjkQMYvyZ/OnX3dA5lcuQHe0/fH69SB
         Zbvg==
X-Gm-Message-State: AOAM532se+QbtHziTeneiJPotY+gDmRg1G2JuDTHMxm2VtRG66TJzb2X
        Kgd61nzbVXj+VLXDQeHjk/lsOkflTt2i8gYbhK0=
X-Google-Smtp-Source: ABdhPJzsB+JY5z4t0j0mUuJK6sBM5bxQw/2mh7pSOUNCA5Srll/a2Ufr13J59eCgiZcNtDnCheiU1Q==
X-Received: by 2002:a17:90b:d98:: with SMTP id bg24mr26534224pjb.41.1623206912169;
        Tue, 08 Jun 2021 19:48:32 -0700 (PDT)
Received: from localhost.members.linode.com ([2400:8902::f03c:92ff:fe55:8c1e])
        by smtp.gmail.com with ESMTPSA id 130sm13218444pgc.19.2021.06.08.19.48.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 19:48:31 -0700 (PDT)
From:   zpershuai <zpershuai@gmail.com>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     zpershuai <zpershuai@gmail.com>
Subject: [PATCH v2] =?UTF-8?q?spi:=20spi-at91-usart:=C2=A0Fix=20wrong=20go?= =?UTF-8?q?to=20jump=20label=20when=20spi=5Falloc=5Fmaster()=20returns=20e?= =?UTF-8?q?rror.?=
Date:   Wed,  9 Jun 2021 10:48:14 +0800
Message-Id: <1623206895-8282-1-git-send-email-zpershuai@gmail.com>
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
 drivers/spi/spi-at91-usart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 8c83526..e5c2d2c 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -531,10 +531,9 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = -ENOMEM;
 	controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
 	if (!controller)
-		goto at91_usart_spi_probe_fail;
+		return -ENOMEM;
 
 	ret = at91_usart_gpio_setup(pdev);
 	if (ret)
-- 
2.7.4

