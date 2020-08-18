Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5172490F9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHRWfe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRWfa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Aug 2020 18:35:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CCBC061389
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2020 15:35:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x6so10396432qvr.8
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2020 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FKW2AsEGrqOkUGisBBsOWQZvgPJeV2KTWyYv1yn5u8A=;
        b=eLGXHWANOpQrO7jl5NqdmdOcOIZMJkYDIR2raD0IHDoBLpfgUMlS02MCpWVmR4/mI9
         X0gQYtqcfj89cVpksx8cJ5NMGdJnosKyQC8/pe4bjGlfzXYqD1D24/uZkJ9SQeuAFhQB
         BvCo6Arg0PRyks7pBSf3ceuuMLEyaA5xuTPK7HWbG+3gRjY3DFoKzALtINVL88h2C/pV
         dYZFfLyFBaKoz2gPlFuQX2X3ZuujDr3PAK6fAlw21Ks8edy0Xigp6muefDs/wRMCveDL
         i3sipuIynPmz2T5+IINIjt4GW1Uvz/1WXye/KgO6NWTD2/SEDYCbB32Vg/MrkXW/RpZi
         Fxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FKW2AsEGrqOkUGisBBsOWQZvgPJeV2KTWyYv1yn5u8A=;
        b=JZDk9mZ2aECT4nt2mJJGcynw3W41rIWr0eCazZKN2J0cdeA2q6/6exSCnz+hWKB3zu
         SsHjfYBCFtqp3KipWUOOXIOG7Zm2QUwdBscIHbnFRryCfwJuUpQU2bTOYZZaEoERmizq
         SAvEZlg5mdSe9SmC26kOG71vBw53mQ0jOpiYkMDz9EnN2cUY1D8qDdtLP50NEDt1if4k
         YpaSpIj+BASlI+ZM91/ZtdNpPC8q8FRsywHqtGUMk42+/17DMSicSTMWS5mGFz+gjcGv
         2youGwhS3P95a8qAUCOhfiRLj5tAchRZ0zvU5PxWZK2WJZsz1EpCMTBypnDnzJu8zT/1
         ZpJw==
X-Gm-Message-State: AOAM532Qbv/OG3T8lKqdcMKp/cul26iOEXqFk0WrSdIzx+xwBzQumDdy
        gNSaRlzc14goVwoKcfJUBxI=
X-Google-Smtp-Source: ABdhPJys7DviPVv1yFhFIwYvOnyMURKO0q33QD5nRC0Fy1snmdqy/IV4pP5hW7KpgHZcESqrq/nhog==
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr21050041qvy.233.1597790128814;
        Tue, 18 Aug 2020 15:35:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:4fb::1000])
        by smtp.gmail.com with ESMTPSA id t25sm24459478qtp.22.2020.08.18.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:35:28 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] spi: imx: Do not print an error when PIO is used
Date:   Tue, 18 Aug 2020 19:35:18 -0300
Message-Id: <20200818223519.8737-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are cases that DMA is not used and the driver gracefully
falls back to PIO mode.

Do not treat it like an error message and move it to debug level instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fdc25f549378..a06679ab64f9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1693,7 +1693,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 			goto out_clk_put;
 
 		if (ret < 0)
-			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
+			dev_dbg(&pdev->dev, "dma setup error %d, use pio\n",
 				ret);
 	}
 
-- 
2.17.1

