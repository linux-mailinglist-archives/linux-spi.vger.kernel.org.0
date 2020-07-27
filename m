Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1E22E670
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgG0HXf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0HXf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 03:23:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4FBC0619D2;
        Mon, 27 Jul 2020 00:23:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so7534752plr.8;
        Mon, 27 Jul 2020 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtLi8w57gnnmKubQpAlKgfo+luXCSY1x3qq8plEtTes=;
        b=J1xJZnJm2yihRu1lA/bmmScLbqa/2ZgzmMZlarNvKpsHmq6BxTUMhPwrwzn/lWoGEW
         pUUSIdv0Rjpn5oVK9RgIcA9SrGFKbsG2Lw0nPW284Mr5tOub8xhjGHc0J+qrvJj4bj79
         76FTxixvq67AltH2bbSVWk2jKNopAKQ7RLK/SVRmy5LekFy1eBh5d2/nTxtIRuAlZ/+7
         peO452HbvzeYv6MLXQympD/1AXwd3iqbpDvH0ymGcX6Omfngqp1nxm7vuFmu+1P4EPES
         MFOK/LKTLOwSJxm4Zi/+CCYZQ9k805cxW1SamTIfWlbk2O6tryhbk/siKs+8PVHjbVCz
         EJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtLi8w57gnnmKubQpAlKgfo+luXCSY1x3qq8plEtTes=;
        b=OcBu1xO91B8GM0t/KP3l6WRYLag+igsfg1xE/2bqj5Jlxpc/KTnaVtyjb9VRtKB/GB
         yu9Ajfa18Rx/Ww0QKlft5Lr8tnWTLViSNWZT9aeMZA8atZXoYq6fmyXnbIJt5GkQ+8qn
         NYA/7BAKC+xLUEsQl0rULA2L2Wumy049WjGIRtB71vrwDkHY1Ugzmli4HfIArbvamc+q
         xrO266C0RyBtaiw/TwjFv5iRHtZwb4TNx9qKkGz/Yuj+7CWqygsUsDmn2kTApXD6+T7a
         pRAJO/1UitGjDfE9LPtJy11pw3Hhc3srsXIMrbcUsqvD51QRZN/FMPoFdlHpebHXgmCR
         5UEg==
X-Gm-Message-State: AOAM533/rHtxwLzghtYg4wdNqmChoh0VXbmf7QWzVyA7zSBTRhosy2Mq
        Sr6TlsZsh87PgQ7XJSmnc1U=
X-Google-Smtp-Source: ABdhPJzfVEhUcVaZLk/pm7cyXJlrTQYqJd65h6yHKTNEwXlpe+fRk3ZpHXbX+9mcNDdx7cK88Ye02g==
X-Received: by 2002:a17:90a:628b:: with SMTP id d11mr9192420pjj.167.1595834613946;
        Mon, 27 Jul 2020 00:23:33 -0700 (PDT)
Received: from 119-18-5-146.771205.syd.nbn.aussiebb.net (119-18-5-146.771205.syd.nbn.aussiebb.net. [119.18.5.146])
        by smtp.gmail.com with ESMTPSA id my16sm10695118pjb.43.2020.07.27.00.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:23:33 -0700 (PDT)
From:   Jonathan Liu <net147@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jonathan Liu <net147@gmail.com>
Subject: [PATCH] spi: sun4i: update max transfer size reported
Date:   Mon, 27 Jul 2020 17:23:28 +1000
Message-Id: <20200727072328.510798-1-net147@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-sun4i driver already has the ability to do large transfers.
However, the max transfer size reported is still fifo depth - 1.

Update the max transfer size reported to the max value possible.

Fixes: 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO size")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/spi/spi-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index cbfac6596fad..1fdfc6e6691d 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -198,7 +198,7 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN4I_FIFO_DEPTH - 1;
+	return SUN4I_MAX_XFER_SIZE - 1;
 }
 
 static int sun4i_spi_transfer_one(struct spi_master *master,
-- 
2.27.0

