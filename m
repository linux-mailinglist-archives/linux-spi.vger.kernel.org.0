Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F03183C5
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEICaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 22:30:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54786 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEICaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 22:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ex0qKgiOTe6Vg9vk/qKVNw3/6lYKgjLD06DnzhbEcqM=; b=b4naVgpS98tlkDVyu69qK8HrR
        Z/0r9hkqDoPegvIKE32iZfNI/0xQzsF68o18fCjcDrH2F0g3FbEUnxc4rscfHCW8s+WGpqTjn3GY5
        TIFrUvTweBXs2T8gwpgZcNtCv7qMaOf4/L9VmbCnGJx8GkJUjBdj+nOFsi28x2y0k0API=;
Received: from [2001:268:c0e3:9e6d:fb20:4124:5afd:9c02] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOYp4-0001Qt-VG; Thu, 09 May 2019 02:30:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 684B544000C; Thu,  9 May 2019 03:30:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Fix Raspberry Pi breakage
Date:   Thu,  9 May 2019 11:30:05 +0900
Message-Id: <20190509023005.19290-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit c9ba7a16d0f1 (Release spi_res after finalizing
message) which causes races during cleanup.

Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..8eb7460dd744 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1181,10 +1181,10 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	if (msg->status && ctlr->handle_err)
 		ctlr->handle_err(ctlr, msg);
 
-	spi_finalize_current_message(ctlr);
-
 	spi_res_release(ctlr, msg);
 
+	spi_finalize_current_message(ctlr);
+
 	return ret;
 }
 
-- 
2.20.1

