Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F71545DC3
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiFJHs0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbiFJHsR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 03:48:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF40015351D
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 00:48:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cx11so23394528pjb.1
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwNedQtGOZXHXrHclp0knXCOxOkJDdvfjVXBpc4Ke9U=;
        b=hHvfCnoUqcNw9dd11VWopU7ksI+F8D23d4JnaKSbox5rgaZkmf2VLMPCHqGARu8NNa
         gkPmi16g1BpC5FYyqRX9uMYMxgBZXNVaWYaKagHQt5oz4YhEFQWV9K6LYxLOn6uRHrCP
         t3nmi4VUckKKnfAHYuvqz+TehSlBLUTNP3hRa92w9QV5YgG4Uoa/9dpSKhNlNm8XDr87
         icJUK+94cWYSIRC1TtengKcmhKayBMgoBN7g7qQXDe72gnMI6Q2c2hdKvN70WbDjEZ9p
         aRAioCdmdQNm3cNP6alX6Mt5r+dJRjI1pOL+zZ47SxgrPIFzc6K3hjYzrnIK8GtKbqIR
         SkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwNedQtGOZXHXrHclp0knXCOxOkJDdvfjVXBpc4Ke9U=;
        b=s0ozflLNPdC7FvVZeNLUWIeU19t0WoXIjAes8ibvChmx8R3j/Hvais7hc5BDz2Uk/n
         YvpVBPdNBbQcyvTJcHy7dpYSFC2KeL4RA8gEDlbx8pO+jzQJH+UZLfesslLdVqVgokXH
         7IXzN+j2u+mRAt7R+Y+A5/Xf+U6cgWPExxQyd+F+K1jaQdv/Wia3pwLRwY7i5/PgftVw
         e2W2WpFV83U3Zxcv4/l3XoJ61F/SWvtGyE4RNwEp2NiZTRF4NU0nL1+Z5MqnIPHffsUB
         kCyKqWV4omrK9lsgqs02t+mtNJFPt4FTRWKfxSqFXRxZzeY+HFTA7w1VRAPRUFAwvHxD
         6mmw==
X-Gm-Message-State: AOAM530GPDMOKvRayWgHnDyh9lpU8HGJ0K+nGY30nIFgYBEk1INroiRT
        zeWovRITNOGn4nI0rBZ2uW4qXA==
X-Google-Smtp-Source: ABdhPJwJWAfaspiqoR+Yu/SQptPCml+Zlui2mwQ9BihL1m/z6FGRlh8JFZn9PaBqRFOeWBrle3fHaw==
X-Received: by 2002:a17:902:ea0b:b0:164:595:affa with SMTP id s11-20020a170902ea0b00b001640595affamr42313653plg.22.1654847295344;
        Fri, 10 Jun 2022 00:48:15 -0700 (PDT)
Received: from archlinux.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id r72-20020a632b4b000000b003c14af5060fsm15902394pgr.39.2022.06.10.00.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:48:14 -0700 (PDT)
From:   Andy Chiu <andy.chiu@sifive.com>
To:     broonie@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH next 1/1] spi: sifive: add PM callbacks to support suspend/resume
Date:   Fri, 10 Jun 2022 15:44:59 +0800
Message-Id: <20220610074459.3261383-2-andy.chiu@sifive.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220610074459.3261383-1-andy.chiu@sifive.com>
References: <20220610074459.3261383-1-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/spi/spi-sifive.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index f7c1e20432e0..e29e85cee88a 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -427,6 +427,44 @@ static int sifive_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int sifive_spi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
+
+	/* Disable all the interrupts just in case */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+
+	clk_disable_unprepare(spi->clk);
+
+	return ret;
+}
+
+static int sifive_spi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(spi->clk);
+	if (ret)
+		return ret;
+	ret = spi_master_resume(master);
+	if (ret)
+		clk_disable_unprepare(spi->clk);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sifive_spi_pm_ops,
+				sifive_spi_suspend, sifive_spi_resume);
+
+
 static const struct of_device_id sifive_spi_of_match[] = {
 	{ .compatible = "sifive,spi0", },
 	{}
@@ -438,6 +476,7 @@ static struct platform_driver sifive_spi_driver = {
 	.remove = sifive_spi_remove,
 	.driver = {
 		.name = SIFIVE_SPI_DRIVER_NAME,
+		.pm = &sifive_spi_pm_ops,
 		.of_match_table = sifive_spi_of_match,
 	},
 };
-- 
2.36.0

