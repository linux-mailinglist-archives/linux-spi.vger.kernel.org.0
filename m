Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB415636C2D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Nov 2022 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKWVRU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Nov 2022 16:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiKWVRM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Nov 2022 16:17:12 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A9A314F
        for <linux-spi@vger.kernel.org>; Wed, 23 Nov 2022 13:17:09 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l2so8530qtq.11
        for <linux-spi@vger.kernel.org>; Wed, 23 Nov 2022 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aqA0Mj3WFRM9SvHIljdHQ8+p96l5z6GhwHZgBiTLAE=;
        b=HOfGOF/KzrNbTIEs25w7CIh7DweUpRjCaPuDjlosBtlXKTk5QqFEzt3NJlVaE74iA+
         jA7UAv8BMJsiduZ2LNB6LjS1SQ3WuyoMibpm7eolcRqsiqLLvyhUKhSNeEF4sUsGESwh
         n+QZCA9GvgGW7ATurAKm+W2fnWmcLbPdkaWDw+LVsC2p4hEzmgOAnczFW9efTzBhqi9w
         pGreWtPd65aM7ysQ+zIW0zT8Giv73OPlqvwvs64u+gAwgRbZ59rlJq3oQfikHxObzYjT
         LRppuKzblg5+Qk6uqK2hM6hItqAFhcw94hgYsYMjILCR13DJUb7ZnTQsRERX5hOSc2Gn
         xsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aqA0Mj3WFRM9SvHIljdHQ8+p96l5z6GhwHZgBiTLAE=;
        b=TMyW8NJ7MrZDcrpxcT/0FxQej324PUB3WS5aOvoGcmFAWZCltIsnOg4NhFLWyr0RQq
         Gp8PFk4/QSfPAKTiAs0LCc6yVUb9JYKvLsWzk8IOm/4w1qoaWRWM2xT8cV/DaHZPPEjL
         22C5kJjHVGfNfroBvaShhFucOil/LmzGbNDHy8XH21dCvcw1canSHunYa7pSr61EcyKc
         Wz3J9zZWWfk19la7c77FsJ8ufWd1NB+mFtq1BmphT9A5C1s2BCSsY+PbdovCYrARzpXW
         aCmvdAHu2grwQ+YYhEFDjUxmhSmH1FXfUkx2itZINl6CfhxkijQPddcSu9WvQw/t2tpb
         8NbA==
X-Gm-Message-State: ANoB5pnrsZqpiGkfot0Hw5HpZN3grVtEZSPv0r0M1ldqaG9LNN/BuLYE
        h1GYAjcE2K0/awBcoK3mHvGztGBiTuBm4BWc
X-Google-Smtp-Source: AA0mqf4OXplR5mPC7T71BzFi9Tan1aVm5pq33+5u3HIsJmIGGOTjUuPwUlTFhECijGg6dxTzh4uCpA==
X-Received: by 2002:ac8:4d4f:0:b0:3a6:1dea:8c1c with SMTP id x15-20020ac84d4f000000b003a61dea8c1cmr18403042qtv.157.1669238228695;
        Wed, 23 Nov 2022 13:17:08 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id o22-20020ac872d6000000b00399edda03dfsm10203066qtp.67.2022.11.23.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:17:08 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: cadence-quadspi: Add upper limit safety check to baudrate divisor
Date:   Wed, 23 Nov 2022 16:17:05 -0500
Message-Id: <20221123211705.126900-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

While bringing up the cadence-quadspi driver on a customer board,
I discovered that the baud divisor calculation can exceed the
peripheral's maximum in some circumstances.  This will prevent it.

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447230547945..250575fb7b0e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1119,6 +1119,10 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	/* Recalculate the baudrate divisor based on QSPI specification. */
 	div = DIV_ROUND_UP(ref_clk_hz, 2 * cqspi->sclk) - 1;
 
+	/* Maximum baud divisor */
+	if (div > CQSPI_REG_CONFIG_BAUD_MASK)
+		div = CQSPI_REG_CONFIG_BAUD_MASK;
+
 	reg = readl(reg_base + CQSPI_REG_CONFIG);
 	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
 	reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
-- 
2.30.2

