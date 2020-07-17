Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8601E223D74
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGQNzR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgGQNye (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C13CC0619D7
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so11258082wrp.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0v3MpsT0EiR8b5Jx0N89c4SZ6k9ifhqdf8ekF4nSQ4=;
        b=Lnb0CtVbWRFsYcq4I5p0F1kPtzqlpb6+B4HmHr3H+ScjOsj6hVQKmo+YIsjT/9/1Wb
         Yy2UgzVEDRWavrWMKex3LUCcFe52iG62z/WvSEZ3zI6juSVZPj/pEqEXhfaMh3gIozlj
         t7HNZjapNynHgojy1h7+YTFwv7Qum3LB6AZh/SMfJecVuhCDb/bMSGw8ZfBrXf59OnzV
         lZiGC+oV1HLtzifxh7cQfiIOF4+ng7vsehMXUj6Q9InmFvkFup9vjes56JwEP1rkc5bM
         WAUuYaXko7tWKb7ZE114QTBu1M2OSz72GYWTnkhCU/cozXoZHojS11ZFxsEZ3fmtGekd
         nM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0v3MpsT0EiR8b5Jx0N89c4SZ6k9ifhqdf8ekF4nSQ4=;
        b=j9wr1rZqw8MDI0BiMAaOTXiJMs1/eqxuerNaQ9P1kih38pmrjwIE2JVyH/k1mjy01V
         KVK3x8DmBzj1fHvkVCQ7olxRTpykE1O5fLu5oLuxnZOgtng7vAdfaJWI31p/B8jtpu2U
         JbioxiZgB0UGSGqeTk4/DCFRZM/vPUnj9pKylB6nBeTGE77WjEMIAenacYq0CHDBtP6+
         zO1KPXqcAdJLhtPrxWcF6UMpec+ZXaGBt3GR/j0ZZ+Rww+ca2putDcPnn4edjQBsJJk+
         DKKJnTOvID2NI47M56WjUFXlYcOZjEMIVvcxEvbN80B8lXHvQj49rbUPZMaHjEvIx1r2
         a23w==
X-Gm-Message-State: AOAM533LjLgxP9bs/dJHs4L1N2z+8b9x8nkd6hYW02+a1yafQh8KdW3T
        ZMVmWNGWsIjBI3jzWM+xQlfPNg==
X-Google-Smtp-Source: ABdhPJyWncy34Npy4rilSJUIpPISij8gKpvR0Ke699A8H9i1pMrCUYIxVOaCspw8BGlBJb6OzBknuw==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr9770503wru.147.1594994070888;
        Fri, 17 Jul 2020 06:54:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH v2 04/14] spi: spi-ep93xx: Fix API slippage
Date:   Fri, 17 Jul 2020 14:54:14 +0100
Message-Id: <20200717135424.2442271-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ep93xx_spi_read_write() changed is parameters, but the function
documentation was left unchanged.  Let's realign.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-ep93xx.c:227: warning: Function parameter or member 'master' not described in 'ep93xx_spi_read_write'
 drivers/spi/spi-ep93xx.c:227: warning: Excess function parameter 'espi' description in 'ep93xx_spi_read_write'

Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index ae7c79a062084..aa676559d2738 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -214,7 +214,7 @@ static void ep93xx_do_read(struct spi_master *master)
 
 /**
  * ep93xx_spi_read_write() - perform next RX/TX transfer
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  *
  * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
  * called several times, the whole transfer will be completed. Returns
-- 
2.25.1

