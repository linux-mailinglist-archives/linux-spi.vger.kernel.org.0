Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE34713FF5
	for <lists+linux-spi@lfdr.de>; Sun, 28 May 2023 21:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjE1T7C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 May 2023 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1T7B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 May 2023 15:59:01 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C3AC
        for <linux-spi@vger.kernel.org>; Sun, 28 May 2023 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=NWmRmxfw/wubpKhJ52zXFZDg20szMw4ma7f74ukQbq8=; b=iAPKrjM+NqmdtYPrSkdD3PSp8D
        7mJzGyXnvwG09TBEYU/+bAI+b5W0HVu0a264ilF7IIJZQizsmJ705glLLg+o7mg6MPeoEGMHqQrbD
        eXgqtqiwPGA0iMTagIBlsqK/2xhQZb3Zr7836i0wFrZocNh7SRJlztGBIYkZEWTC7qH3PA/8zEkE2
        NwLwsGpuWCyAdzqBW2jPF66JZE40lVQVG/1QqD84kyPfssFd87+4xVT9egZBat4FkI/4MBBnjUQT4
        oOgWHEI+YcZldkEchW/EtNpo6y3fGlDN44RospGlEAKXomd/Ih9DgmTk3113Ri1YYdEjd9lWRQnjn
        ClCMGVFw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1q3MXb-0005Nn-97; Sun, 28 May 2023 21:58:58 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1q3MXa-000DRD-GO; Sun, 28 May 2023 21:58:58 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-spi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] spi: spi-sn-f-ospi: Use min_t instead of opencoding it
Date:   Sun, 28 May 2023 12:58:29 -0700
Message-Id: <20230528195830.164669-2-lars@metafoo.de>
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

Use `min_t` instead of `min` with casting the individual arguments.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/spi/spi-sn-f-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 39c4df54cdb8..691b6092fb3f 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -566,7 +566,7 @@ static bool f_ospi_supports_op(struct spi_mem *mem,
 
 static int f_ospi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	op->data.nbytes = min((int)op->data.nbytes, (int)(OSPI_DAT_SIZE_MAX));
+	op->data.nbytes = min_t(int, op->data.nbytes, OSPI_DAT_SIZE_MAX);
 
 	return 0;
 }
-- 
2.30.2

