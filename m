Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D49438D3C
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 03:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhJYByr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Oct 2021 21:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhJYBym (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Oct 2021 21:54:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275C1C061243
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k26so9227207pfi.5
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tsjnvHZxFcx179JrpWdunYzZ7UKY9lDzgpcDpsj+pXk=;
        b=qQ43viDEgEMivLDPyE5NZLmWhHNbaYuCbHP2IFScFlk337biOgwSCx7O4KH5dJ0HWY
         lbSY2TqaEpy+67+XF31S0XkLE/1A3i9SQ3kd/gxfNsVVgO+r7LPJ3lnyWMqCwOjqgwNk
         VZA0r8LxmIQT6cNIUl2dEIYXx2BeSr94LkNATEFbXZD5v1TlZr1cHNxhebjhl1AzbmFK
         dOT1FvW54bs+fZ3i4+0gESBozlCwn6CYOkL+CqZKTgUNmMD6Vl8NNL4qhACLqR438sQj
         PEGckV9F3jQkoP/SZFrWz5u9TJ66A/0kgMOorxwl5QP2PmPlFsImMHh+z0Hg2B8VUQrn
         bjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tsjnvHZxFcx179JrpWdunYzZ7UKY9lDzgpcDpsj+pXk=;
        b=W2YuOQxca4V1oXQQJPdkLfd6ZGcw7uWspbRFdY3ZkSOVu0pxA9Rabz/v/7s54ZWpcc
         9/n/AKAHvg7Ad2f9Wi0cGVvZeAKzkMQMcdKtRHwpQU97LT1S7X4xZP1IljqYT+WR7cAp
         QvMyZzypdm34rAg7BrWkxk+H5dX1aPftzK9z0fnn4UvEVAfvtjbAz+zOF5e5QMQ9OLpd
         ptLM8nUNizh9SF7ZHVqWrBoYf9yRnvGWoxOLtyCyufAc+dx61/kxQE5F84jGmMW2n+IQ
         bnqMtqNxWvCBTwAE+5lnipUDQVD6otcMdb1Ek/hXdy3HFlA0Omgp2FEUAt1+43UNpqwF
         oviA==
X-Gm-Message-State: AOAM531axd6X7H/KnIDtXjM7bFc3+u717W4gXd7jiMUX7PAYGSm7PvmB
        4ZsQlrYlfPL1RAUh5UtjHueUww==
X-Google-Smtp-Source: ABdhPJxRjIGbKgMWaWhG6v2O080ntM4paN+3J2qDrDGHsGlD0a9rlnFPXUQNXcbiMKwvRUG8wgyspw==
X-Received: by 2002:a63:931d:: with SMTP id b29mr8921297pge.162.1635126740708;
        Sun, 24 Oct 2021 18:52:20 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:20 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] arm64: Add config for Pensando SoC platforms
Date:   Sun, 24 Oct 2021 18:51:52 -0700
Message-Id: <20211025015156.33133-8-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add ARCH_PENSANDO configuration option for Pensando SoC
based platforms.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0ce18d4cc98..456404c6e898 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -209,6 +209,18 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_PENSANDO
+	bool "Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based Pensando SoC
+	  family to include the Elba SoC.
+
+	  Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 100 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

