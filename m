Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD532CB11
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 04:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhCDDok (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 22:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhCDDoY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 22:44:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B95C06178A
        for <linux-spi@vger.kernel.org>; Wed,  3 Mar 2021 19:42:32 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y67so67833pfb.2
        for <linux-spi@vger.kernel.org>; Wed, 03 Mar 2021 19:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFDDuuLCKMVUPK4LrKSbpDVOykG8ODUpVOe4CV5ias0=;
        b=1opUXAsn2Kt8qlhlTkZuka8cdGg9pcFuMg87cVSygAl2xQ5X0EAshUWlvWYCdUXMp5
         AWhfN/NOGbE+AQh5ijSGOHHg3jjyH0fd4VMghuOm4V7uABp0spgfMvnIDwKRUAX869G/
         W56G2VbCRO4OEYFtODPVNbJjZh6mwMdU0ouuqzzVtGYppmVCCfeGoIO6RsLHVQHkLkNK
         1ZxI+fVL/wfF2uDsCHOF+HI/Pmd+UC/fXWbqWyKw/AcAenGrPGOFQ9s1JRoC3rGsGD9/
         Rok3iMUTJpkyj69iIt3abyN9gQAvOf7PIDT2Ax8l10B9yQWwO1UJZxh67pP+3qHp+l+d
         kX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFDDuuLCKMVUPK4LrKSbpDVOykG8ODUpVOe4CV5ias0=;
        b=uIRfebMs7Ih7zpvK2ndN+4xGoWMkGtirRk/Yk6D901YBL68ozJJMy6RcTlVcwhLw4V
         iFXDRlKzJpOQ4evKAPqYbN260LCG53YHYfiDjQAqo1v8skqZPwB43yY7QpAP3S3vLUBy
         NavQ+k6u2Pr7lBrAhWPidhoF1oF9KG8tiZsvRc31dLq/ClYFbCm8l5T4u1En8lcOyMmd
         Hai/4xCHRCery3yq/h4yqTx+kOdg8aoM/b2qZ12n3xp8sa2PoPWhBMtGX2kpzwPOqgmc
         fIylJT+fuqf6pq5wV1x7RNm6auueBt7c4sH+EQp4YsYKkD6E8WYJ9hwXndvmWOBkObGz
         4DbA==
X-Gm-Message-State: AOAM530oGpXsghV+0s11yrXz0e9X7dtTH+LHR/QOkoWfH8DqrM6Mysuy
        ZleUZWqDvqQXs5Oq8/JXobzM6Q==
X-Google-Smtp-Source: ABdhPJzLtFoQNkM8z+nPvDTwYRktUQTeKXYN+F/VF6vpP4GvYQVlLQkPZGGit0J8TlMHm+yaO6XMow==
X-Received: by 2002:aa7:8c0f:0:b029:1ed:4d05:218c with SMTP id c15-20020aa78c0f0000b02901ed4d05218cmr2256407pfd.21.1614829352253;
        Wed, 03 Mar 2021 19:42:32 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:31 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm64: Add config for Pensando SoC platforms
Date:   Wed,  3 Mar 2021 19:41:39 -0800
Message-Id: <20210304034141.7062-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add ARCH_PENSANDO configuration option for Pensando SoC
based platforms.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cdfd5fed457f..803e7cf1df55 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -210,6 +210,11 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_PENSANDO
+	bool "Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based Pensando chipsets
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

