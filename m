Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2235A221036
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGOPGm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgGOPGl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DEC061755
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so5921081wme.5
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0v3MpsT0EiR8b5Jx0N89c4SZ6k9ifhqdf8ekF4nSQ4=;
        b=oiEqOrmX2BCeuQ06E7MkwpKIP4Kzg4tSFdZCvp67JPPy3zuGG0hk8ZwYm+YrTRxez3
         S9iEWCUA4c2hahIplVrfA69MF6/SQ7MGCu8MTU6oORMVoTfX2qt9tENX5pAEPb8hOZkU
         wj1Sj899IJnMTKboN+ELSEphoncvVC/TXnLx/5IQ2kO8/5kezYniQGyN11ps1lBIbxrr
         BLYu+c4DRt4uLJAX55f/u/3j2cQ9oI0CFD9/99mXFEMRYQIMXVmKdYhG8xCLiWqH1Ow8
         a+ZTDoMSBYXrgIEpzWnr3w8dC3epdyq67iz9Tn+SpBspYuSNkyDDy8a/fdyP4HOLQd2j
         o5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0v3MpsT0EiR8b5Jx0N89c4SZ6k9ifhqdf8ekF4nSQ4=;
        b=aM+6yNVRGFVeXC0oxVIXiUZnPRXH9v0MB1pih5AMauLFtWDKmiEgYVVJQf3ObWwESM
         y72I0rlUrebSn3dhvSAPPeDbiA+oTF30f1hIoeVQMLnGoUVzEXl5YoUwaBvgLaKNa2Z7
         CdwPe0Vu/kcUVpXT2W/Hv5wKbvMKgocGzttR91f0F2flWWwnY3S0ED3eCut3JPvlpeR7
         iov0DvDWP/iQ6W0JNnh/ruWBjzGmUsdD3glDektrEboQe4nU/KQIXPTHFlZJzgXLcNX2
         ZtRch/KIktvQnkCnvwnM/4vwHLGuuLuOTidppdxu4SnDV6fIHD+QzkIeE+HzFLmuFetD
         dpRA==
X-Gm-Message-State: AOAM530o9P9Aeg/Oypq4q9v5P5UCSeqQvQVxU/fsoVh97jOFadxuVQHY
        oh5BYWealr8XPZXkC+/C4dlwXg==
X-Google-Smtp-Source: ABdhPJzEuvQZZCCGKOKNb4JQQwMdZwBlgkjQDqt0GAJkyBKy+DD1uRuFH0A3VbTwcFKQG0BKip3Drw==
X-Received: by 2002:a1c:e383:: with SMTP id a125mr9253712wmh.11.1594825599646;
        Wed, 15 Jul 2020 08:06:39 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 04/14] spi: spi-ep93xx: Fix API slippage
Date:   Wed, 15 Jul 2020 16:06:22 +0100
Message-Id: <20200715150632.409077-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
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

