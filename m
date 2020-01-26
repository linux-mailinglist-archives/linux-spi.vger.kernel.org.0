Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70A149AF4
	for <lists+linux-spi@lfdr.de>; Sun, 26 Jan 2020 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgAZOJg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jan 2020 09:09:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42084 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgAZOJg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Jan 2020 09:09:36 -0500
Received: by mail-yb1-f195.google.com with SMTP id z125so1532051ybf.9;
        Sun, 26 Jan 2020 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=daWWos5KtEMJA9FX6DD1ge3+gsTuCafldU15qCzNObg=;
        b=JBg6jHKqCfQ/EPovFt5dmZcVRxMFRPh8xCo34IYw8p/FF56RVql3n/M0SsO4INFDCR
         te2K8GaEWuhx+Ancr5eGaWriyJ72lmhYBW5sAi9WbkZn5KEOw+UgzL/A7MoC+DvaNijP
         izDIGH2klMvbB+ZbGcr+KZydyTsmDuK5VboPPHhXV0nAD6fO57Q+keFVe9yZMYHHpa1b
         EyAPIfHZdRSIfX37fE6fezEJ7jYQeE11WqBzts6+KUapnfFV1EWWMtwBCAaitVCfov5M
         82DrpIgm44Ov44l+bRUeSRJAiJ+/0sOc4DfSU89F+IDqcdOwV/IYx6/Ptq6pnJE0slYF
         qsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=daWWos5KtEMJA9FX6DD1ge3+gsTuCafldU15qCzNObg=;
        b=ExQypC1AINuUIIZT6xHzD0GVwva9KDb5Jb3lNMsCiHom0JKGulIqsKgiNoi40olCG6
         IfhIL76gUSui7qbIJ9/aJuvZlfPLvA0h228DmVi5bsKai2O0DYjMHMKZFrkHuswoH48E
         P9CaDxr/CZmiQ9sUD4bEHL4bztOG/6o/WDflQqNvxGByGEaJ5CLLEa9Fa4NNdyAWNUvm
         8B3sbAhkYGcB4N9nXV9xf3BYLqhuPJIeua2TcqsBxORQYB5KvCJXB7Ed/JM8FpZsi/WH
         RATNY+jpqC2zRSHnOrM4UuUf3D3PSp1TvATTlJxDtKEXe3w0e9N8Co4+KfTpkyfdzJRE
         SVYw==
X-Gm-Message-State: APjAAAXQgoUD9qVIXtK3zjYRK2xcfh6/tKVtjgCvVbeomzVFwtydxoDl
        njmm01l3HyXdr+LMSkv3lWjUZzfMXAk=
X-Google-Smtp-Source: APXvYqxbwclW7C7Ka+4RV7Kdv3OLTse91pIEErfd8duwb0LYIXWxyxCJjLGPfw2Do4AwA4IIR6O3pw==
X-Received: by 2002:a25:d4c4:: with SMTP id m187mr10061540ybf.109.1580047774540;
        Sun, 26 Jan 2020 06:09:34 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id a12sm5237214ywa.95.2020.01.26.06.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 06:09:34 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] spi: spi-nxp-fspi: Enable the Octal Mode in MCR0
Date:   Sun, 26 Jan 2020 08:09:10 -0600
Message-Id: <20200126140913.2139260-3-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200126140913.2139260-1-aford173@gmail.com>
References: <20200126140913.2139260-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Apply patch from NXP upstream repo to
Enable the octal combination mode in MCR0

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 23abf5ae318e..019f40e2917c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -913,8 +913,9 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
 
 	/* enable module */
-	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) | FSPI_MCR0_IP_TIMEOUT(0xFF),
-		 base + FSPI_MCR0);
+	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) |
+		    FSPI_MCR0_IP_TIMEOUT(0xFF) | (u32) FSPI_MCR0_OCTCOMB_EN,
+		    base + FSPI_MCR0);
 
 	/*
 	 * Disable same device enable bit and configure all slave devices
-- 
2.24.0

