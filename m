Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07E479DF
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 08:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfFQGKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 02:10:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46140 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfFQGKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 02:10:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so5145821pgr.13
        for <linux-spi@vger.kernel.org>; Sun, 16 Jun 2019 23:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MZPuGCyVvonDrs7OcHZvEqrCPe242jhYFHqiG+ThiYc=;
        b=oLmx/hfdh3eYh1yM18gQZEgUb9i0ZKK1+ERI0YW9M4/E9cgj6f/Uf5GVvzwxs95EXY
         3Ie93TFBHY/rteT9ifYdtY4cGObZo9hWhwbCgKo+XVkGe73Mvvl6pDa+hrhZjerB05mr
         075mYbg49/R9h9V0+HqavNq94ll9EIJyE8BpzUOknfugxk58AkKZg0pPFJIbUwFd33eK
         r0qqpO0wTliZ7Aqej9V5/tv+LWTfoz24DUe/hPw5QhBSgO5DLB7rw045w+hpE0XLLdQY
         P0sShsaTKwjL/J7ucmp9/xU3NA9X8m0kJWjVNo6sZjO765AhACZHDsnwMRmvDQFCTubV
         MnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MZPuGCyVvonDrs7OcHZvEqrCPe242jhYFHqiG+ThiYc=;
        b=Gx7jEGrJYIq8odZi5o8gyYj+WiJmbGlZ5fJ0/J6aLIMgudfPdAkNxYYqzG1ROyOaeg
         h32F4FQfP9AojGhixQtb+D9PhAuVdZIDGWrW3Ha2fma6Oc0ow7XscGWjUjPExozp+jQ+
         msBNg7E2R30zRx+6/DpXkOOfxAvWgCQb2PJhwEkKCsNuNgzieAc7wzq3lxTE9lKrOKlD
         lEEsKbymiSHdkNk+Wuvwu1MeEtzrEXSBYii4adLc1tzmP8+ztutbwI84qvDnoBD+byEp
         b9mIUt04AteAhgNm2NPQ1R3Ud92NYr9164DWHyVE6c+YGpcjd8NfO+dMpoSTXqCzekAC
         il3w==
X-Gm-Message-State: APjAAAXwaAQb1yBv8u6mTmd1VOmqsmNLBPUdbfhXiFMunsxGWIAVlCok
        LvSVEtAsDAgpFyBrmfIy8UsFOg==
X-Google-Smtp-Source: APXvYqxcyLU9TwYY78BGl+9GtiBAsDrXSO4GLnlajfBKUSJ8xN18EnOZmexJ1162Q53jj+b+dywcVA==
X-Received: by 2002:a17:90a:37c8:: with SMTP id v66mr24901434pjb.33.1560751823323;
        Sun, 16 Jun 2019 23:10:23 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id a7sm10083949pgj.42.2019.06.16.23.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2019 23:10:22 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     lkp@intel.com
Cc:     kbuild-all@01.org, linux-spi@vger.kernel.org, broonie@kernel.org,
        jaswinder.singh@linaro.org, ard.biesheuvel@linaro.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64 dependence
Date:   Mon, 17 Jun 2019 15:09:57 +0900
Message-Id: <20190617060957.16171-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

kbuild test reported that Alpha and some of the architectures
are missing readsx/writesx functions.
spi-synquacer driver is only targeted for arm and arm64 platforms.
With that, added ARM and ARM64 dependence in Kconfig.
This patch also specifies the default compile type as module.

Fixes: b0823ee35cf9b ("spi: Add spi driver for Socionext SynQuacer platform")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/spi/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ae9c81214298..667d341e8e95 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -736,6 +736,8 @@ config SPI_SUN6I
 config SPI_SYNQUACER
 	tristate "Socionext's SynQuacer HighSpeed SPI controller"
 	depends on ARCH_SYNQUACER || COMPILE_TEST
+	depends on ARM || ARM64
+	default m if ARCH_SYNQUACER
 	help
 	  SPI driver for Socionext's High speed SPI controller which provides
 	  various operating modes for interfacing to serial peripheral devices
-- 
2.14.2

