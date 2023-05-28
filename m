Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DD713FF6
	for <lists+linux-spi@lfdr.de>; Sun, 28 May 2023 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjE1T7D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 May 2023 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1T7C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 May 2023 15:59:02 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90AA8
        for <linux-spi@vger.kernel.org>; Sun, 28 May 2023 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=UXudmQeh7gfIyadWcjx5EnvHJKgAxM35HUX3B2ZYOJo=; b=kp/ow0B9PiadbsdGqCSVgkMD6y
        j5b/6HtGGoqbLbugxnJXFPwQd3qq3CjXnd+pBPnUR1uQjENH9Huz785s4qPN36+66bemWP7kj1zP+
        kwM30WpMRQqN0XFM1yKMen7aAe0Gs1hWrnxUTOTDujqQ2f+ryPoYOQ81MuJ4Qmc7xix6ir+WV+AG8
        aIuoxRbpZlj7XLuGIxTDiEOsjPoN2JeL3/DNjoagG9tmrj0x8zWpRqIMMixgfAP1B9osqYzcIJRRx
        j357YAWqa859pPPmkhuQOemaJa+0g5egtujcS1oPurUt1WC5enBEKGbpvpOscfU6mK3800EkLzLWd
        67X0UrKg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1q3MXc-0005O5-HC; Sun, 28 May 2023 21:59:00 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1q3MXb-000DRD-Nz; Sun, 28 May 2023 21:59:00 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-spi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] spi: spi-sn-f-ospi: Make read-only array `width_available` static const
Date:   Sun, 28 May 2023 12:58:30 -0700
Message-Id: <20230528195830.164669-3-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230528195830.164669-1-lars@metafoo.de>
References: <20230528195830.164669-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26921/Sun May 28 09:22:09 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The `width_available` array is currently placed on the
`f_ospi_supports_op_width()` function's stack.

But the array is never modified. Make it `static const`. This makes the
code slightly smaller and more efficient.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/spi/spi-sn-f-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 691b6092fb3f..d64d3f75c726 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -526,7 +526,7 @@ static int f_ospi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 static bool f_ospi_supports_op_width(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
-	u8 width_available[] = { 0, 1, 2, 4, 8 };
+	static const u8 width_available[] = { 0, 1, 2, 4, 8 };
 	u8 width_op[] = { op->cmd.buswidth, op->addr.buswidth,
 			  op->dummy.buswidth, op->data.buswidth };
 	bool is_match_found;
-- 
2.30.2

