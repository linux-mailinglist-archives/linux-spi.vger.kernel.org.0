Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7200848C1E1
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jan 2022 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352368AbiALKBh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jan 2022 05:01:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58424
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349613AbiALKBH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jan 2022 05:01:07 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 34E4E40318
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641981655;
        bh=vkZ3shAsrts82aZQTD9Odzm7oGr7rqF0WKQDjTKTwd8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S7HG6Oi3Xdgd9IQ6IB9xO4/FlOuXdwlL8p1wzr9IojJNAoPTeYo67CeiQ4Mm/5j0d
         msHHEZ4yo7CPwhZd5krDR22Iw0HHyfhXOiqZvcEQoEJWkxQzKTcFci4W94vJy+H51p
         eoxvOHwkhT74ZwkxvVVoS+W6bPbrzwkiU4Dnwak0G7EJhoUZw36e7W6i91NpR4vcCD
         8E5bfO1LETYSLd2qNVh7GM9ye3rrzf+JfQYguNy5W8gr2o3SK2o4nlhxYQuPjd/YVI
         y2vjmevgk2iPzNt3rm2YzD/Y/sWoMdNvgHKDni/q0BqdlQOehu/wKWqsCIhyQBfspA
         4dCcUxe13IWkg==
Received: by mail-ed1-f71.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so1824227edb.4
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 02:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkZ3shAsrts82aZQTD9Odzm7oGr7rqF0WKQDjTKTwd8=;
        b=uGSfc/mx06igDS+hczAy7OaDCYAludSj87ErXZQ05ghR6AkyyaZG89s96cwSygmveo
         hzk5ABNQnhEeijAeITKLwHmNzxPcsjo3uczNm8+1Cxbkg2CD926Uk/q9+uht33ygvutd
         LOjNZbwIU6pDzoDludOpolebsqMG1AqRw+o0Xd2q3BMi/RdgBXi24hcfhmgJJksqBrX7
         OByO2pnjeGVKQVlBJyJztofMSpO5j/n33vR9eoVxij1ZNhwD8fpveQZL8N0iicI85wRs
         8jVD0E4YQItz033Vs369EbvgjHTqxoi4EOksHbfArf1QkC2jic75qtAt8QGc3ZeVMzeC
         /heQ==
X-Gm-Message-State: AOAM533E35AGYc+xvDUHzOi/5Ac28ax7ujrfS6Db5hXHPVwFpSmPo03X
        Jn1//5WlIjXnk2UxRWnRuKOvXyYJjN00beIAmONJEvH66V3WoWjBL9f22PbsMN3dC4nPaEXWj6J
        f+LlxXjTlExqLqh3l0ccLVlOjkmmXXrybNkiUnA==
X-Received: by 2002:a17:907:7295:: with SMTP id dt21mr6749932ejc.453.1641981654826;
        Wed, 12 Jan 2022 02:00:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr7AHmnhL8e6o/jXCWgESvLqrOYDTSQTTXkoaFmOMriyvAZ3QFfDrNia5S1pL4Lx8Q/Cv4WQ==
X-Received: by 2002:a17:907:7295:: with SMTP id dt21mr6749917ejc.453.1641981654645;
        Wed, 12 Jan 2022 02:00:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hb11sm4311083ejc.33.2022.01.12.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:00:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/4] spi: s3c64xx: allow controller-data to be optional
Date:   Wed, 12 Jan 2022 11:00:46 +0100
Message-Id: <20220112100046.68068-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Samsung SoC SPI driver requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..769d958a2f86 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -796,16 +796,14 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-EINVAL);
 	}
 
-	data_np = of_get_child_by_name(slave_np, "controller-data");
-	if (!data_np) {
-		dev_err(&spi->dev, "child node 'controller-data' not found\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs) {
-		of_node_put(data_np);
+	if (!cs)
 		return ERR_PTR(-ENOMEM);
+
+	data_np = of_get_child_by_name(slave_np, "controller-data");
+	if (!data_np) {
+		dev_info(&spi->dev, "child node 'controller-data' not found, using defaults\n");
+		return cs;
 	}
 
 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
-- 
2.32.0

