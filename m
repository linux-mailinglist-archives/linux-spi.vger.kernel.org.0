Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A71C2EF6
	for <lists+linux-spi@lfdr.de>; Sun,  3 May 2020 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgECUA5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 May 2020 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECUA5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 May 2020 16:00:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE787C061A0E;
        Sun,  3 May 2020 13:00:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so18423584wrt.5;
        Sun, 03 May 2020 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=QqRdtHtAi8l/8c9aZkszbUa8kmMqeeh3ZFLZmpwUXmw=;
        b=rsR9nTkgNRQ+kOj8RXQMdPcb5bI+0UB8BKi8B9ep9Fqf9BS/e8KvpLxdg1mVz4ugaU
         4APvVLy9nGW/n6+rSDItFmATfsqLJLl/9LICi9eMNdXubXIXs57PsYy93bHAlhPj4mp5
         d1S6ahLhalEtMEIv1t3YNmwqb55REwYOa3Im+f6Daq5d+8T0T0CSmzfFQSXALCv0EeZP
         0KaPRpqYq+BPrpvJP8L1mE/H7707aUlh2To2vNkqES7iOLcW17IKBq6fBR45BHcFRLlp
         0F9RrnhzOnUxXvegK2atG9ikLrHzK5Piz/vCm5cAmlrT58VOwNEDZTGp0vd6RX2PwKCL
         79dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=QqRdtHtAi8l/8c9aZkszbUa8kmMqeeh3ZFLZmpwUXmw=;
        b=Ldw0+G5+nGY42Om1gbI7AUsF8AHFzR7R49GSbpm5StUWB6ss0q4VVcBGP5XMJSeuaB
         3HEUxEWmV9JZG3ULrZ/KLZ7lJwwuXQ5t5DpHLG5EO1rKSijZmOHiB/aVbh6iWOk09nnt
         H1R+5aNwVQ/FKbN95O8CoZ/cUywXSlZkPCMxDztNGh5s4CSU20l/2AIMYptQ3nE8SHXU
         Tb9V23ZO2YtcziA2DEhKjAoG2+tnw/eqnIxS46RpYUhq7ww0SaZfCg55/pyeZKXRyEHx
         xWQt7Yw6tc2Yi3lf1fLzIMushxkq6utvBjDX32NIx5yvbzDrW81w14T5ePa+pGiEC1rJ
         viZA==
X-Gm-Message-State: AGi0Pubrq1ZKlQOf6Uk029Re9sOYzI+ofKFkctvBRApPaqciM5idXAq/
        DtcgI5WWxClDfhL01XOLsOc=
X-Google-Smtp-Source: APiQypJ644QIvHgh2YqgFFZPR//UNfvakJMh9tvgXPWNy87mnUXcL1Kt5Wzc5PopV/ZAmqfmph3Ypg==
X-Received: by 2002:adf:9264:: with SMTP id 91mr2600213wrj.362.1588536055673;
        Sun, 03 May 2020 13:00:55 -0700 (PDT)
Received: from vasteMachine (s559503e2.adsl.online.nl. [85.149.3.226])
        by smtp.gmail.com with ESMTPSA id q4sm9080597wrx.9.2020.05.03.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 13:00:55 -0700 (PDT)
Date:   Sun, 3 May 2020 22:00:33 +0200
From:   Jacko Dirks <jdirks.linuxdev@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm2835: Fixes bare use of unsigned
Message-ID: <20200503200033.GA3256@vasteMachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Jacko Dirks <jdirks.linuxdev@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 11c235879bb7..e10b8f3b4bab 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -191,12 +191,12 @@ static void bcm2835_debugfs_remove(struct bcm2835_spi *bs)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
+static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned int reg)
 {
 	return readl(bs->regs + reg);
 }
 
-static inline void bcm2835_wr(struct bcm2835_spi *bs, unsigned reg, u32 val)
+static inline void bcm2835_wr(struct bcm2835_spi *bs, unsigned int reg, u32 val)
 {
 	writel(val, bs->regs + reg);
 }
-- 
2.26.2

