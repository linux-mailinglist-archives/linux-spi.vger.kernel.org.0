Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891E7264F82
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIJTou (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbgIJPcw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 11:32:52 -0400
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2260C06136D
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:11 -0700 (PDT)
Received: by mail-oi1-x263.google.com with SMTP id 185so6259115oie.11
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TAjjOvVAHuYufOKkxDIWgneZqY7sSReSHXxF69LgeUk=;
        b=ef6JEEgmO8Bbat620fzmhEP4DAAoGctxfoKgC48sZJe39cxAsZKKJ+6SKqXP+FLZbr
         6VesQPojPH6t+Y8emVnJ+O9gvwAIpHWp2cbREdVKsNw31R/o6Kizo9YKh8caSPcxE86Q
         vtEqoR4k0yyR8PAsyaafhDNsbFUE+lRE+/gZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TAjjOvVAHuYufOKkxDIWgneZqY7sSReSHXxF69LgeUk=;
        b=RJ5RZmKWRn2ILSUa3meW7ZZJHTUaAKvX/aW3V05i/5PYC3CLcoH7kT/ePJGB7z/e/d
         uTLjiAbLQHEr4MMG8TmhjvW8A1O6pGujcH6WSslKRyrJ3o32C5whDPLYNRd2P/ypx1Mz
         Brfa5zC+lm+rJsxkq2Bf2K1UkV45jYbDf7jYWN9MoyYb7Gesu9g12bV1/hmTcYof4Hnz
         c+LU8vUEK5aZ9TNs8PGaRmNeWxnNIYVBe15BXiAH+khXUHeeb9F0GF4eqflIWSG9l/Pq
         6nRC3T4Mbd9SQiur0rff/1unBVoxwQA9PHBYUcPgOuaXP1bLCE3PuLXinCIt6zu/nu5a
         9XLw==
X-Gm-Message-State: AOAM533jq4YoZGkbfgnY88aYBT1VrFjTGGA6qb/sOZW6ND9QlTF5gkY3
        EqMKmaX27UQvgqB8L+ZM+QX+IjN9Sd4YGaDyvegb7YzWSsxI
X-Google-Smtp-Source: ABdhPJxKUzw42D+XPlJKJWoGyUjU8x+sICTg8mVg0T3jhhHLXIY9y81C+5EjNBZp41/FYbR5CqPx15pRIPht
X-Received: by 2002:a54:4086:: with SMTP id i6mr361723oii.66.1599751570606;
        Thu, 10 Sep 2020 08:26:10 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 2/4] spi: bcm-qspi: Add compatible string for BRCMSTB 7445 SoCs
Date:   Thu, 10 Sep 2020 08:25:37 -0700
Message-Id: <20200910152539.45584-2-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for BRCMSTB 7445 SoCs and indicate it has MSPI rev
support.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 681d09085175..c5209b42b0d2 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1293,6 +1293,11 @@ static const struct of_device_id bcm_qspi_of_match[] = {
 		.compatible = "brcm,spi-bcm7435-qspi",
 		.data = &bcm_qspi_no_rev_data,
 	},
+	{
+		.compatible = "brcm,spi-bcm7445-qspi",
+		.data = &bcm_qspi_rev_data,
+
+	},
 	{
 		.compatible = "brcm,spi-bcm-qspi",
 		.data = &bcm_qspi_rev_data,
-- 
2.17.1

