Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B521F264F75
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgIJPdL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbgIJPcj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 11:32:39 -0400
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB63C061372
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:25 -0700 (PDT)
Received: by mail-oi1-x263.google.com with SMTP id m7so4840976oie.0
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fJHhgYEwWxBGPZV0ck5d43o8h1NDMA91jT0wBqCfnwY=;
        b=Zdsfz/texQfzXW2RGAHepIO+zcBnvTWRPvI9uTSQnnv62NJZBg2LJ6xmh15MhBIyrw
         v2XZbgrWLuNbsmf/JyNDTQY9RgOzmk6Cbd/1ypznE5opXiubVRfp31r9c36Og/nxYeMK
         GKaoaYgBHLRuJDDj4YQAG9m6P0os4YS4Trbzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fJHhgYEwWxBGPZV0ck5d43o8h1NDMA91jT0wBqCfnwY=;
        b=YZB0lf+vyfyVcSLfbriAZkiAETSdb+b9Lp2fE2BvLk08HPjJ/c5LUUdqoWkAYer8cP
         U2Ymo2UaShtcoiEkFVbYf87FEUvjigrY8a5UHeyXaD08lROgoMHyL80a37pujkQX+qCF
         EZKA/KEm/gliS5JaBqghFlvJsyXTxwDtl2Qza9GYUcEhYHVEpUAV35iIo4w6d2FJnTO/
         LNGT6WdMRltziXiv37SKBIdztO44YJDQBB7FRFkx6qF4e7dAuSUmde+3gF1RVvhejr9M
         0BU4+5YXqGIpLtTOTWtwLy2USaOLybmSeqbypKWKAermMuSGukg1+4xU9DW22j5IieM9
         8new==
X-Gm-Message-State: AOAM530qWYvzKvBYAWO5OXRZG0xguFqfBwoga7qKaL161pWYpT5hJCs4
        v5ctkKs9xzCVXxRpVZ1g9YTA2A3Bw0TzGxjLu/SJqP+pdgqy
X-Google-Smtp-Source: ABdhPJyG0h05fMgSeA0kb5tHFjfFMkLwJoDKu0c8WIRTzJdH0BccQ194jKVgXJ9oEvffUNNs8qjWbXf25PZO
X-Received: by 2002:aca:d54d:: with SMTP id m74mr336105oig.3.1599751584954;
        Thu, 10 Sep 2020 08:26:24 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 4/4] spi: bcm-qspi: Clean up 7425, 7429, and 7435 settings
Date:   Thu, 10 Sep 2020 08:25:39 -0700
Message-Id: <20200910152539.45584-4-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Broadcom QSPI driver now falls back to no MSPI_DEV support as the
default setting in the generic compatible string, explicit settings for
STB chips 7425, 7429, and 7435 can be removed.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index b78d47a4403c..14c9d0133bce 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1281,18 +1281,6 @@ static const struct bcm_qspi_data bcm_qspi_spcr3_data = {
 };
 
 static const struct of_device_id bcm_qspi_of_match[] = {
-	{
-		.compatible = "brcm,spi-bcm7425-qspi",
-		.data = &bcm_qspi_no_rev_data,
-	},
-	{
-		.compatible = "brcm,spi-bcm7429-qspi",
-		.data = &bcm_qspi_no_rev_data,
-	},
-	{
-		.compatible = "brcm,spi-bcm7435-qspi",
-		.data = &bcm_qspi_no_rev_data,
-	},
 	{
 		.compatible = "brcm,spi-bcm7445-qspi",
 		.data = &bcm_qspi_rev_data,
-- 
2.17.1

