Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C43552AD1
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbiFUGMr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbiFUGMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:45 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD491F62C
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=F15awN8fVr1aUHPApDU8EiblKTOOr8pm7ISa2F3TCnc=;
        b=PaccTgxzx1NsSGCfEAmMo5Uismy91fY8qJlKwCOoxMR9tcGgLP996ZqHIOVX76Hgc/35S9HWGg2lH
         U5AOM6wu9pLrFNP5XsOcQEp56utiJgxzKR6I2Usv5DTZnkWtkxlcnRGywAN+BO6Ew8mprWGH3RxxFz
         GO1uG56wLcwwPKnbU7Qyzfyv9eS0P/rkZ++hA872jGOmu96CIYlK33SUfjs9YiMFFneJsj9rS5aXO9
         TdvW3dSHgR0yt7V5byyynmS3XAG7DdOQ9JxEICB/GjcnqBlEUknsfHROGRQtAGznq75sVnN04hmgWB
         rJ1qDeBBGzpNHWa7O88LmgUXin5q7jw==
X-MSG-ID: 268170e0-f129-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 09/11] spi: Set ctlr->cur_msg also in the sync transfer case
Date:   Tue, 21 Jun 2022 08:12:32 +0200
Message-Id: <20220621061234.3626638-10-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
References: <20220621061234.3626638-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some drivers rely on this to point to the currently processed message, so
set this here also.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 29f42753ef0f..3df84f43918c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3957,6 +3957,7 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 
 	was_busy = ctlr->busy;
 
+	ctlr->cur_msg = msg;
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
 	if (ret)
 		goto out;
-- 
2.32.0

