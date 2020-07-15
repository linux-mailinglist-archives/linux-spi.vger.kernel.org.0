Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0D221047
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGOPHM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGOPGz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C8C08C5DB
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so3064118wrp.7
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=BYmhvu/PhXomekAXRVNla/c/6EiDYkDyIEEP+MnOTHWaO96GdMvSUBbWJS2c9+d7Jk
         VRcp05/uXtkltdnBCD3P4U/6uWXmTugA1wexZ81oTwI5iXU7B5eDg18v1fmgG2gpnKrY
         it07272+neTo2ZgSdaMpbMxWIRl/CJYkeFY2bH2Qc3ma0Q8+h02ZtLTMWgAnGuztvZYn
         ugk+ds7CLMSz5QoMkAHIgg+y7QLjfsXOlV07N2pPDjgbpagdKNJ8+SYYTPvMc5djiWwH
         5awGcZaMqjxnB/PtmoiA5Wx4+EdazDc9VX+/311LH/1OaZcHs/cKfKmw2aCAutzqfQJB
         lAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=PZbkgJntwgcT5VC3nAZVsk3WVGfT90ERwjMbSJfnqfAJw/9QvC2ArF4YJ6rfK/pLqn
         VwBRniJNnpA1qPY8Ij+BmO41/dXvCThvgP/EympLyiPmZnPfdxJeSc3su/uXML8uqshg
         uQKP75nKS7b1HxweVATKLRv67X0N4wUYDowuR/0d9rZfiYYtWOL8HkS6mOD02uiFRTZx
         GjDz/hb1a+HVEkqKCx6Gf/LJQ+SEl/6swrjWWIO5FpM/BlrZkCmX0oAruCRSerWZoCf/
         v7whRZaezPj7Bg5lha5NVZrUwdBTLzZ+gZaVZXptFc+RR+ZFxpPVp4Ena+e0+0DwFHIG
         LLzA==
X-Gm-Message-State: AOAM531mJ75Pf5S0rVK2jjS7GE23FiaqcQOfbkwOlE0mXIH2lk6TlN6I
        wQWmXDmuEhVQqEntZqj3g0HnIQ==
X-Google-Smtp-Source: ABdhPJzKOkWoJ5Xd1No49tmC7h+p+Lj1YSarlHghqR0fzO+t7pGvO0lAkoOgf54GCL5hcHwEPQMssg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr11810561wrp.100.1594825613486;
        Wed, 15 Jul 2020 08:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when
Date:   Wed, 15 Jul 2020 16:06:32 +0100
Message-Id: <20200715150632.409077-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
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

