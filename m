Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82167223D5E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGQNyo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgGQNyn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD0C0619D7
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so14957971wme.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=bpNzeGQ2MR4hr80NvQhU98nD3GgSa4EDbYmGyWnchS5R3CJAZ9DaK36qm+qmXP2F+E
         V8YBOYQySCSk1JLCHed2FvU7RP1NEE94M+Kde0STUOJGfkONWj4s0Uc+QjarvN2q4NtN
         AsmqgLlDKAu8qLK16LPIIt5kXHR1qcZnoUFm4pHV/kl5ScEHKkKwzKmyOBCfwPguiP/z
         GSwuDGCDy1Ku3Ybl9ASlfk+YTrI0hfqVKnazspGNqYP19fvdKf5StJnn1HUViiHCURQ2
         0VEZEE2oky80AyF2bpL0dAxjuoS1yacbs+7svgQv8gFOU0JezgrR8a7YMHfLdNtQBFns
         rT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=ZeaNTvmCp7Vlu2DAeeHVwt8iuTY2y0JoHcO9ho+HECWO9heRVl2Kx7OozYHzjB0v/h
         FWTZlJ/uaMlVVxOvd50k1KiP23eBrMMULTQBYir6AWXCYiP3yj8pQiy+/1k6UkSivd80
         xdrRgpcNqhbytqBWMMrz1rhMetWYhkF5j2fAY99ERGFUBeMym2L9eIm0RHDbcPfFnsni
         QmqxhvY7hlhYn+bmSlI/UKeozlZnZ1VaoTAbANEhWmuyIM9wf+FEc8ZvtObHDeqR/2k4
         UyikHxod8vdlhgRLcbGwgHXh2d+nB2qxx5JJA5ApnFGArmeomPGGHiQ36e4lfPYo4hIv
         BuaQ==
X-Gm-Message-State: AOAM530QTJW3hhau00lNy/IE6Kvp21yBVwkK3B6a8j29a7UseklIVSnR
        zr+5jTukq11HVZI0WqvXYQ8YxA==
X-Google-Smtp-Source: ABdhPJwGwZMyZOKEAjKXmjbfGVU0S7+YF4JdD8KyDcLgCtRvve1JosJQWI81wjFZ79tXlavUy9Wvog==
X-Received: by 2002:a1c:31c6:: with SMTP id x189mr8995770wmx.182.1594994081433;
        Fri, 17 Jul 2020 06:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 17 Jul 2020 14:54:24 +0100
Message-Id: <20200717135424.2442271-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct 'spi_acpi_match' becomes defined but unused.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-amd.c:297:36: warning: ‘spi_acpi_match’ defined but not used [-Wunused-const-variable=]
 297 | static const struct acpi_device_id spi_acpi_match[] = {
 | ^~~~~~~~~~~~~~

Cc: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d0aacd4de1b9e..7f629544060db 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -294,11 +294,13 @@ static int amd_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
 	{ "AMDI0061", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
+#endif
 
 static struct platform_driver amd_spi_driver = {
 	.driver = {
-- 
2.25.1

