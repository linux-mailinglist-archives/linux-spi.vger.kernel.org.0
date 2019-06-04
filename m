Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0621733E37
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 07:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFDFNQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 01:13:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfFDFNQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 01:13:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so11228684pfa.5
        for <linux-spi@vger.kernel.org>; Mon, 03 Jun 2019 22:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwlsJ6CEbpLZSOgtZESJWjm/iL6r1POt1KjyCXghrz4=;
        b=ysNe7bxv9HQql3V8nQpfHP622zxFB4jKmBOdzA6/C7bAx8OIeswyGuLHYj1bPYtCQf
         UaRNH+2rTLfc2bRkRUcdeiiZ3HBME+s8pcTUL6mL4KT+MdIzV/Korn0xAiEBlferxL1l
         r2ew9qSCJMajx+HVaXCFqZ+xHI4MT2oyOj02txBoNyaz4G83AalyVJLL0ZL32ZN1RJ44
         NppDavQibd6erjV9y10F1hPT6JRsgTQS5MQ6Md8P1FDlxQKkKylhAZW8wxA1PAdws08t
         27ugWU5xuzuM0GfEnQX6nAVmXXR57x+hXTBEKk2mmiJJpqka+MlJbqPckBXmW+mVd7Cq
         IdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwlsJ6CEbpLZSOgtZESJWjm/iL6r1POt1KjyCXghrz4=;
        b=qgTely1ai72jDQRlNW402bXq8PncOrrbJRk6GI/m/spaKKA/uOY5pORCiS+Q5lHJuN
         sXNdzjgwkOPjRwBNMAJn6tR19Hr2eWFy0cwUaiu5w6qYbNk4lvGwbpK3gRJa71JY42xK
         ORMcGOODBVn5NKDPDTCZ9ec9srXsuRxxQ9KhxxMHdXS6gPTDGlVI/TYzAu10hNKkuU8z
         5JaqcG99SY3rkwVNIuN2uokGzTsLUK1bPtdPEGbiPOsfI/a4sVRV4Txk/d/V5e3hrD+6
         6Qsd+Ed3X0a3Dl7gLsH1DADrjMDY/qxuRELtYaZM2lRUs0xH/oXt02Nqs8HY+nnhwwEM
         Y+tg==
X-Gm-Message-State: APjAAAV6EUI6Kwl0WEkeNNOC4Snd17lQIX0i65zWnoo7Kv9sqrXCXezF
        Gdt7Vns5fiJvy1JvmQsxXX8oBbwOXVs=
X-Google-Smtp-Source: APXvYqzo4nWZshV/MfR60MlOaqRryD2dFWQv4KdyuBfLcX9zcUe2CgdYRg5Uu8Hcy5wVvp2nmLYk0g==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr24121804pgc.82.1559625195579;
        Mon, 03 Jun 2019 22:13:15 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id j13sm17444152pfh.13.2019.06.03.22.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 22:13:14 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 1/3] MAINTAINERS: Add entry for Synquacer SPI driver
Date:   Tue,  4 Jun 2019 14:12:55 +0900
Message-Id: <20190604051257.14264-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190604051257.14264-1-masahisa.kojima@linaro.org>
References: <20190604051257.14264-1-masahisa.kojima@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add entry for the Synquacer spi driver and DT bindings.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..06c3e03e3c0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14613,6 +14613,14 @@ S:	Maintained
 F:	drivers/net/ethernet/socionext/netsec.c
 F:	Documentation/devicetree/bindings/net/socionext-netsec.txt
 
+SOCIONEXT (SNI) Synquacer SPI DRIVER
+M:	Masahisa Kojima <masahisa.kojima@linaro.org>
+M:	Jassi Brar <jaswinder.singh@linaro.org>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-synquacer.c
+F:	Documentation/devicetree/bindings/spi/spi-synquacer.txt
+
 SOLIDRUN CLEARFOG SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
-- 
2.14.2

