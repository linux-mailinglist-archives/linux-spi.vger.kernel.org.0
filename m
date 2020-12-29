Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E22E6DB7
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 05:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgL2EF5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 23:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgL2EF5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Dec 2020 23:05:57 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC244C0613D6
        for <linux-spi@vger.kernel.org>; Mon, 28 Dec 2020 20:05:16 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p14so10573719qke.6
        for <linux-spi@vger.kernel.org>; Mon, 28 Dec 2020 20:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PbPeedzCm2Guxkr5q43kmdxoOUXy9Fl34ROpdYq8v9U=;
        b=SzWrDevT1OHDtFzfT12NfBDpYb5qjmwHidm5uEcCGbaRoGmkEwGZH7T6/uddEvcnw7
         EHZd12nDG9vtMRAyeKoMaJx/taSbj1F/9SM9sv0i08Zgc6nKkXakCIewT597/gV861DA
         dj7dgEwZR/nQi9asf8cU01FPilvP3chsXIxt1+vA4NkWg45w9lJ+H7HybJW2HIJCpR3M
         gPT5H7TNkNagez4JlrZCxX9XIMX1zb0iME3pGYdDlgqzhptK4DufiM3/Nq6F1iv7zdYB
         3RCTyfhSrM6NKX0vVYIoSrHalZUUdhxOpJvZvYicld5fMqmbcjxyzgkf4ZRHLntTsDMv
         deNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PbPeedzCm2Guxkr5q43kmdxoOUXy9Fl34ROpdYq8v9U=;
        b=DMbmfRjK5mFIoM7nP8DMjfWITf7Owr0G9kFBV34Qme1dYWHOCQuGAHPFREVVcgr+uB
         dNVIhI+5hcUT0kXw03pV2AhkkmFYOMq0WfXnBwCWg3QLQfkTWsp4Wok7iD6Ih2SpmVb+
         1Ayp1izSkbz1DWtfSfP3ljlDRMxJ0eqbNpiGSqb6hiyMx6KUqFSSkMe8JVtvutxZAscu
         hqw0wNDq/D3Wr46UE7ambjmTJDoeuZTislJmiQ8Or/9MNGgE901xUqztwlVLWBYwga8z
         wvuuf3+GxiATevU6EnkrmSQe2kcZyRzB3L9WMLAGXC+ChfbfKMGk+hEeMkEt+iMkokEK
         MVOg==
X-Gm-Message-State: AOAM533J5mglldFFf6lMpC6/1TLsR9mCiXIIjYtuSMyG3F6bd/mN0Eay
        cipmJUr1inASQkBAh0VydB4=
X-Google-Smtp-Source: ABdhPJy1VN6msOFtsxAZ4VVaKBP6vi1JnqCB8yZQ9SEf/0nFcQCp+5EFMxmpGe0MWz7UXbYNiO5SfA==
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr48399108qkg.184.1609214715657;
        Mon, 28 Dec 2020 20:05:15 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a80::1001])
        by smtp.gmail.com with ESMTPSA id w33sm24408503qth.34.2020.12.28.20.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 20:05:14 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] spi: Fix regression when the SPI controller does not pass max_speed_hz
Date:   Tue, 29 Dec 2020 01:04:50 -0300
Message-Id: <20201229040450.10052-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 9326e4f1e5dd ("spi: Limit the spi device max speed to
controller's max speed") the following regression is observed on an
imx6q-sabresd:

[    3.918284] spi_imx 2008000.spi: cannot set clock freq: 0 (base freq: 60000000)
[    3.925953] Division by zero in kernel.
[    3.929831] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-next-20201223 #276
[    3.938565] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    3.945124] [<c0111a68>] (unwind_backtrace) from [<c010c068>] (show_stack+0x10/0x14)
[    3.952925] [<c010c068>] (show_stack) from [<c0e11540>] (dump_stack+0xe0/0x10c)
[    3.960279] [<c0e11540>] (dump_stack) from [<c05d471c>] (Ldiv0+0x8/0x10)
[    3.967026] [<c05d471c>] (Ldiv0) from [<c089b044>] (mx51_ecspi_prepare_transfer+0xfc/0x17c)

The spi-imx driver does not fill the max_speed_hz field, so we get:

spi->max_speed_hz = 20MHz
spi->controller->max_speed_hz = 0MHz

which will result in spi->max_speed_hz being 0, causing the division by
zero in the spi-imx driver.

Fix this problem, by checking if spi->controller->max_speed_hz is not
zero prior to assign it to spi->max_speed_hz.

Fixes: 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Do not add unneeded parenthesis.

 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c004fbab..e786a94960d5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3380,7 +3380,8 @@ int spi_setup(struct spi_device *spi)
 
 	if (!spi->max_speed_hz ||
 	    spi->max_speed_hz > spi->controller->max_speed_hz)
-		spi->max_speed_hz = spi->controller->max_speed_hz;
+		if (spi->controller->max_speed_hz)
+			spi->max_speed_hz = spi->controller->max_speed_hz;
 
 	mutex_lock(&spi->controller->io_mutex);
 
-- 
2.17.1

