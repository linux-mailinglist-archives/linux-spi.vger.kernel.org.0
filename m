Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5123740E36D
	for <lists+linux-spi@lfdr.de>; Thu, 16 Sep 2021 19:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbhIPQsR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Sep 2021 12:48:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58246
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243420AbhIPQqQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Sep 2021 12:46:16 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0326840192
        for <linux-spi@vger.kernel.org>; Thu, 16 Sep 2021 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810695;
        bh=Yhq1G2QXar0r4cFBybO4NSb08NdrU83GE13JnS/45A0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QHdhHDshyXPoc4UWXDDNwjIG89n0WPstOlHIeDmhe/SyIAcWFK1fn/wXwUB9kSUzo
         scu1nxq24HwlXWRaOmV20vGgO81k/hIY7wtzRazX+1ZGjFTLWaHJPv2kKdQRrBh3O3
         TMRyJSAXezgbwthpxG5rmlBpGp+u1TvHo+JId5dEXIRFny4+1+vVbtpZohoX6nYifb
         /EyMWsKb9ABnaaiVXs32J/k6ehjAQrXluIZVS3AjxWarXFnsATtM2ikZmjWX7VwHrI
         F1c/CxIfElQ8ZiSfefJ8/NRS/AoJ0cw9ZoXfFdGvFYtCTuzr9FS6zAkVx26/i73zrv
         TaVvvF2UlUJMQ==
Received: by mail-wr1-f69.google.com with SMTP id x7-20020a5d6507000000b0015dada209b1so2659967wru.15
        for <linux-spi@vger.kernel.org>; Thu, 16 Sep 2021 09:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhq1G2QXar0r4cFBybO4NSb08NdrU83GE13JnS/45A0=;
        b=DlOFZiVCFIqjWoUKtLEVcFseHneQjKL8UBnV1G/VE3xI/4kYXPZ+UF7cr5gZSEVHlb
         8v/xgPf2p6nYfiDgy5FsxLAn1dKw+E5rYnEY8haRmJY9kz5VhAhEUdgBxaiDLgNo+i/f
         r9WhdzkbTv8XTir55Eyt4gB0MX5W1MtEw0+g87ZnTyJCy+9I7weEmjnXvqhyIY8YO1DM
         7DvAtQlIhHQHFQqF5DTJDItAVFygXBLOCI/qzoWc20eJ8bFfUcoyoe2MaoN8S9Vze9PN
         kpq1Vb/qlvd9Al/bzqqgfYwRLTZFltbb1St6th0+jKjFeTQMbBOjwdMadcEApxIG0Yho
         4RPQ==
X-Gm-Message-State: AOAM5321udbpgMHfoveNf6bHHvAxyWH/JzYS3ffolAtekLXF7AOpWsh5
        ndzbmJK7NO3+oQARepE2cpZZt1oLavms8oMlIf95QnqWyS6uy9LuDjkxALBNqG6VcVFNTyLT+xg
        GNhLvu6Q/AYN2/9ovuVERlIud0PC9ECI2Ye36ag==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr7308615wru.324.1631810694785;
        Thu, 16 Sep 2021 09:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq1vH8eOT/ND9983ROgnkLW8+rrOrnWScKkcM9yJPGmqu5fYfpiRgvk8b/7xrBhLqmDA3GYA==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr7308582wru.324.1631810694438;
        Thu, 16 Sep 2021 09:44:54 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 129sm3747538wmz.26.2021.09.16.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:44:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] spi: sh-msiof: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:44:23 +0200
Message-Id: <20210916164423.134603-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
References: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-sh-msiof.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index f88d9acd20d9..d0012b30410c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,4 +1426,3 @@ module_platform_driver(sh_msiof_spi_drv);
 MODULE_DESCRIPTION("SuperH MSIOF SPI Controller Interface Driver");
 MODULE_AUTHOR("Magnus Damm");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:spi_sh_msiof");
-- 
2.30.2

