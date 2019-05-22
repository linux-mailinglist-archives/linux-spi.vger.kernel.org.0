Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CDF262AA
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfEVLAi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 07:00:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18815 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbfEVLAh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 May 2019 07:00:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4588mz3Nsdz9v2JK;
        Wed, 22 May 2019 13:00:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AGZZdOV5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1p8m7ConjVBO; Wed, 22 May 2019 13:00:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4588mz28Wtz9v2JJ;
        Wed, 22 May 2019 13:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558522835; bh=k7gXDpgsRbDzPYykyp8yT+pXmsBZ7LxZ7ySJOQkqcXw=;
        h=From:Subject:To:Cc:Date:From;
        b=AGZZdOV5RUVapAjUuLLyoEBn8omopPog2JyYv4LASsAhWoXCdyU9I93TVKTjbPhLx
         BgF3zcvxOIsUMriKEtcbgmJBnzV2xbvEeYGHovscztGKkFIOj3aqmSDax2qJxfIrV8
         fMmKfkOYYtWdG1ZjhuQLnAgi583uvHmh3ojdsWZI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 76CBB8B838;
        Wed, 22 May 2019 13:00:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C2x4lgf7MCwK; Wed, 22 May 2019 13:00:36 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54E698B823;
        Wed, 22 May 2019 13:00:36 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2F081684F2; Wed, 22 May 2019 11:00:36 +0000 (UTC)
Message-Id: <9c1b9545e6683666a795cd89070fa9491f33b9da.1558522754.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] spi: spi-fsl-spi: call spi_finalize_current_message() at the
 end
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org
Date:   Wed, 22 May 2019 11:00:36 +0000 (UTC)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_finalize_current_message() shall be called once all
actions are finished, otherwise the last actions might
step over a newly started transfer.

Fixes: c592becbe704 ("spi: fsl-(e)spi: migrate to generic master queueing")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index b36ac6aa3b1f..7fbdaf066719 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -432,7 +432,6 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	m->status = status;
-	spi_finalize_current_message(master);
 
 	if (status || !cs_change) {
 		ndelay(nsecs);
@@ -440,6 +439,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	fsl_spi_setup_transfer(spi, NULL);
+	spi_finalize_current_message(master);
 	return 0;
 }
 
-- 
2.13.3

