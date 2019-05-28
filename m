Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A852C328
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 11:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE1J12 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 05:27:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43375 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfE1J12 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 05:27:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so11109925pfa.10
        for <linux-spi@vger.kernel.org>; Tue, 28 May 2019 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WSzNCT45W84aER1GYHZSzkW24AjjUqqyhWIxjsh7obs=;
        b=wslbgFOvjUP0aerph9iUxwYQYyARgXZyXqnXjyYn0zbtJUvvQkjVTtghh83uuP7VRC
         gTbug+Czvqgbf7HbpuCuR4Cpm+v7zNcnr8FQqZGLx3irDEs9NPWl/A+HHbp0ZrtH+EFr
         10PScoCwNXXGRFFyyNiNgd14Zzi0EJLSlaOsp7JCgklsF1R0IdoT1oHFkR2IBWY2pzCZ
         wHbmnClhbo6/UvZsh1QkiGyN3HKSZxVQrpI7cSi/86f+QzVgPdG1+2iisZ4yUxGqwhKC
         FCmo770tMHLfTUh0GWlbZTjb4nmR/5hWe5un/L0VbzZ+AP35jmW06TD3ZqbtBUr2+8/1
         Ji4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WSzNCT45W84aER1GYHZSzkW24AjjUqqyhWIxjsh7obs=;
        b=BhwlJQZ0xXoA5D+BpaE/8DXEnIXpzV2gubGQlOZB7FqXJ7eR05lISMKKIa2AsWhQNf
         gz+RaMHZhFetBw3+Vee6hc9Co43mMPKpx3pFE4XN9Qzru5iAQgQa+/tY/TwJIBJXzPQJ
         IY0Rs88nEOHP2SRpCF7qJ8lIk5Bj8BBtyYT5pp6+6ZW7z6l/4SN+Jb2SbaZwkjcX+DEK
         QEYUhaO3KQd1I6nNKLcBzow69iaNqmGmOBO2uObNcPY8Hi1Ke+qLjr+aiMVEtJKWQVM4
         jXyXt5cV50b3L/qDO2+Dq1Ny1HT/PxvZUeIVpL6DTGKqNMu+tlfzEZ7aY6b7UNqgvTEC
         sWjQ==
X-Gm-Message-State: APjAAAUcMWOo4FlEaQy4CcxeRCEQfaZUBr/aHn1w6uC3GCVOnabLi7M1
        xFeW9IBAOLLW1NW0lC/cOfpzyIfdSKHjbw==
X-Google-Smtp-Source: APXvYqxJ1P0Sk25ftW5GpA2FEsGV5/k/jpFRnQiTXDS6XiohJeJmcfv6MY3ECObROVRAv/5ynmv5Qw==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr4516908pjr.73.1559035646972;
        Tue, 28 May 2019 02:27:26 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id w4sm13196848pfi.87.2019.05.28.02.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 02:27:26 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 1/3] MAINTAINERS: Add entry for Synquacer SPI driver
Date:   Tue, 28 May 2019 18:27:11 +0900
Message-Id: <20190528092713.10516-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190528092713.10516-1-masahisa.kojima@linaro.org>
References: <20190528092713.10516-1-masahisa.kojima@linaro.org>
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

