Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C024E73
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfEUMAa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 08:00:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35204 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfEUMA3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 08:00:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id p1so2972649plo.2
        for <linux-spi@vger.kernel.org>; Tue, 21 May 2019 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WSzNCT45W84aER1GYHZSzkW24AjjUqqyhWIxjsh7obs=;
        b=IkS85lbYVaWWd/yJiDguqFGYHKQbp6L7nlZ4siblXOnlrm1tqw7U8NrNVBtOB8Rya+
         fJb7P8uVWVVKbsHuM2oHvwBpK8ChMTPSps7mqxqXzb+i2b696+HZqfTXX4SD+z2n/uHZ
         AtJdAlDnWMpx9uJzj/hK2LoM0zFymkqcATOI26VpKD1wvSmY0Lz3kXAhyHgK+/+zZZ1Z
         +002Cn8a6Ifi65rKb7ZQ8lGpuvfBci/BAhy1qmuho8o+qiEoZmSUn4+Cnxo6CUnwsJmZ
         +f4erOHGDTiWuoCckQKs48CqcqgK1ZxpbhPnBUlAfRpn6BFJzxvCbKRgwskcKT6Zfmo2
         05Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WSzNCT45W84aER1GYHZSzkW24AjjUqqyhWIxjsh7obs=;
        b=NPgbvQxIg6Zl3HE+eWChaxQqlDed/BefhIPp0AP2tdb1YIPvsjR+US6rAedIEmaKYa
         4ixxFbLwpbYa6nqpFLAAc7h/fdqgZT3OrJ/vaUW92ezKnJ6dw1tTzP5urazCpZ8BxHK8
         wayX70cg4cLGgmtT9XwJHUY7maQSju2nVZJgyhsVzM7G9ZMEY+wt5PGg7iPSJJsC56Yk
         WDNiQavcWW+X9PNPVrRYTJKifeX2X9bogRtdZL2KWUcuHaecxzqA0OeAli3OfvkWG1xw
         Ru92Yt4a3LrPw1rXQXPoZZEjYv5CTtYxLlOMIXbtJMJd4QC+UuAdB0eKDO6b74g5Wgfg
         nRaQ==
X-Gm-Message-State: APjAAAUaGZ5rklCuLE+rnDu6mbXIdUPvSFjdsER3pn3e3xcVQ6LwH3dv
        /ZPDrpKI+aqocMZxkMrJL+Y/dDSRPFR6gA==
X-Google-Smtp-Source: APXvYqyFGmEetP/nU0M2ZF21rWhkzbGvQOdqOxrVSlbdBldQohKv7o3KpsXCkG18r/o9zoP301OuDQ==
X-Received: by 2002:a17:902:848c:: with SMTP id c12mr32760824plo.17.1558440028783;
        Tue, 21 May 2019 05:00:28 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id 85sm15198121pfa.131.2019.05.21.05.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:00:27 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 1/3] MAINTAINERS: Add entry for Synquacer SPI driver
Date:   Tue, 21 May 2019 20:59:56 +0900
Message-Id: <20190521115958.22504-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190521115958.22504-1-masahisa.kojima@linaro.org>
References: <20190521115958.22504-1-masahisa.kojima@linaro.org>
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
index 0c55b0fedbe2..a4970349ef4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14597,6 +14597,14 @@ S:	Maintained
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

