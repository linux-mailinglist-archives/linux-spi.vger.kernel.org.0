Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47991898
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHRSBa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33951 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRSBa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so1111944wme.1
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cEX3IRodQdRrTVCD4RazfAov85Bp3vh4Yrdyln52Vug=;
        b=n4jnAKE3A7CLiDnHwmJ4JUI8a2wiQdA6H1C6nhlICvxF+o2ymybZEvAQZM1LV0bp/0
         cKkM40zbLjNdT9Mu36xbABLLL31LQhXPiZTW8RqCafymG++2SkT1NUc+igCXFeV7RLdY
         qG/hZ3RYk429dF0NBX5Io/g0aDTuQ/lp/Z9nYxK2ebev/PaHPR8TbW001vqajs+AEH7S
         iZyXdBvsdOQCBqiJ5YQiw7dizKwa2iCn/StCdG5g22/P/Wv2o1LOw0qZd0wsDpy3ODHZ
         YU58Go7aGXGSGzQZ3hWESjmV7S6Jgl0q/3WF1EMMT85rclGDspv7T3Bn32CcBJ++fGgW
         fWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cEX3IRodQdRrTVCD4RazfAov85Bp3vh4Yrdyln52Vug=;
        b=WN6TXTBF0/Fs3vT+oekxYPx0f9EcRFDb4VJgfteL0/PeyXGFZpJCoIsZ5THGhE4mFd
         FM0WL9Vx+BhQh/D7vZj8OomUaW4zHKa87v27feWGPepNglWLs7zrTChAJ7B1Geh6JFP6
         V2AWj2PjebgO9skZX9315pyza6gGBSFzSW8eJ7p0w7ZZy/vWZTkvJ/T49yo8trQ1pEfZ
         eEigcPC/BkXflPFbOA5fBXM3H1b4pW9eCwLtU4SRBIM1IY30MsZu+gbvsYdGg8hkyt2z
         yN4Ag73tJaFWkMI4YdCuxY7p3fJKdAjfnqOXbJZEpdZZr5fNHTbtd0FNoVinjl4ccyxb
         H4OQ==
X-Gm-Message-State: APjAAAVczKWDMhTitHMD1aaaF3S8uuTjk8c1lc2t4pmLuZgyUf3S+iYz
        K5suYY+hHx4Q+r/RXbUvD5I=
X-Google-Smtp-Source: APXvYqzB68ldXNDlxt1J0pJpceJ+PAe+OmFagL2QKAncbl6zAGOb6jER4vyDqkB8n8/N4NI2QSGkBg==
X-Received: by 2002:a1c:dd43:: with SMTP id u64mr16379016wmg.92.1566151287679;
        Sun, 18 Aug 2019 11:01:27 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:27 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 08/14] spi: spi-fsl-dspi: Remove pointless assignment of master->transfer to NULL
Date:   Sun, 18 Aug 2019 21:01:09 +0300
Message-Id: <20190818180115.31114-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduced in commit 9298bc727385 ("spi: spi-fsl-dspi: Remove
spi-bitbang") for less than obvious reasons, this assignment is
confusing and serves no purpose.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c5d99f4d5e3d..753584c4065c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1006,7 +1006,6 @@ static int dspi_probe(struct platform_device *pdev)
 	dspi->pdev = pdev;
 	dspi->master = master;
 
-	master->transfer = NULL;
 	master->setup = dspi_setup;
 	master->transfer_one_message = dspi_transfer_one_message;
 	master->dev.of_node = pdev->dev.of_node;
-- 
2.17.1

