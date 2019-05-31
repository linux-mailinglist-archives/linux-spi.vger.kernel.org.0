Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31D3107C
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2019 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEaOqv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 May 2019 10:46:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53498 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfEaOqu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 May 2019 10:46:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id d17so6236747wmb.3
        for <linux-spi@vger.kernel.org>; Fri, 31 May 2019 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIhSvs2DPNa6pwhyPdTAckU0464fTVxVs7zCZ8vky70=;
        b=NqsDcGgPdxWylte/nrdudw12e2+Lm9TK+16YOs/Xt7XNSRBfKmr1cSde/9z6YrLsqW
         qvy5SdwAE1oNTb2/Aw5EI9qwCXSrgrYHBXY2H3cNvfYX+azTYlDkSH5oOZXLUb7y9vwb
         MLLKoaxvYUsZEtDR5kA4DyRdw64SrVjDBfI23SaBLa+RK9OodhW6geypt3wpvkkq8liW
         VerDWaNO1aoyDCoeChV3PoAsQIg/rFZpZ1Qh7bgRHhz/EyrwIEH6tEG84umRDECnY+b4
         1nAoqj01kBPcL8cHQkfgg0+VF1zGFrnY2yJS5BBi4APh0k0tWijNZyavtlrohOIE9HeB
         0Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIhSvs2DPNa6pwhyPdTAckU0464fTVxVs7zCZ8vky70=;
        b=Yf8ISdeq9Q6gvSXzQJa9U+60+ZmwaIFl5SLovlp4zcZyQIY+mkKWgK/0VntAQDlPqE
         blxPDoRzBGX8zk+lg0TuDAukw4E9ZO0ePjv4G1dnUBbgqFyoXDqfFDNhljYRocsFS90E
         IwhPqlihgDaenWrRapR55weomtc+SrPPd1PkBPG530p1JaY6gKHu/3aE/lKTaJE1dQmF
         IhmzlUIhxpIWwU2jhZaQBNaOLKQrIZRRYzSd0eE8S/HowZBhWlbDy/6U/RTMU8wH1ZH2
         a0ECzdm+dPhr0Q0g1OK9NPf6+fgQ0NYCXAoxVPP+94g/9ZDFN18DkTBM0ucI4/mhdu8H
         L7iw==
X-Gm-Message-State: APjAAAUB8wE25+PQY9GcIXrrBDr+Y0AMd2g5pqR66HmpeGwGuT6IPCta
        m2g08GGeWJA1Hxhzhnbg3lILKA==
X-Google-Smtp-Source: APXvYqwI8n2+PwrOnHJByfCo543Na2TAdtFA/adEgwqWRwyrJZLjkqUNX2TJsQI7YW8gPuN6N0EwFw==
X-Received: by 2002:a1c:a387:: with SMTP id m129mr2075250wme.15.1559314009130;
        Fri, 31 May 2019 07:46:49 -0700 (PDT)
Received: from localhost.localdomain (233.red-79-146-84.dynamicip.rima-tde.net. [79.146.84.233])
        by smtp.gmail.com with ESMTPSA id k185sm12752374wma.3.2019.05.31.07.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 07:46:48 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: qup: remove unnecessary goto
Date:   Fri, 31 May 2019 16:46:36 +0200
Message-Id: <20190531144636.27843-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove unnecessary condition check and associated goto.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/spi/spi-qup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..314d91b95a16 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -842,10 +842,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	else
 		ret = spi_qup_do_pio(spi, xfer, timeout);
 
-	if (ret)
-		goto exit;
-
-exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
 	if (!ret)
-- 
2.21.0

