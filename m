Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEED6E9746
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 08:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJ3Hia (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 03:38:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43181 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3Hia (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 03:38:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so1458597ljj.10
        for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2019 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLT2aJmyIBipkobiVKjOD3D+xARbiMMLNEpfLkE6WIw=;
        b=anGqsARCFXV34dsRpSzKtnFqfJrHNEoO72qnoKUUGS/5NJgmKiLFvDG+WJxxfoclJ0
         OhiJgjRegvPen5B8IUxKVWaW1CJ1TAfVLDhUjVFON2xgpXTZdpmJA7oaDEX9i8fXyuko
         Ydq8Sd1yBC7Hz4g8xeP1pcnfOn+3fu5H2Ej5uw7IY4SS1c110RaGDbM9xmYSYtxPzkmu
         y9J09I9JND/MA/P1Fdb2hsQ+NI7OkC/FrhmabK6/vDYEnxNxYOldF4jKTcQ6jZOHLrYf
         ZXF8UQfd7pKGUfq7OB4P7voUrFwNCiEFrPN7wA182rpe2NkRWocpVdz/n5CsFh0eJhvg
         ahuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLT2aJmyIBipkobiVKjOD3D+xARbiMMLNEpfLkE6WIw=;
        b=tXEM3yesUJL7v4sSAO/Hmc92SaP8wuPWRbA++VHqMUi0QNMJ7tVCG/rz9MfRTr/Ism
         HHy5HWS5AM/hMPqT82/V0OUFWq3T1xp5nmRJMkBT1ufv0RMaSU9OJoAfXTk7X/FW+u0M
         3U42OhdE0fw5WChJLajZgJd7TCKhaEtKlYxInDP3JfKivf0Yy56R6bYtqevtuupKxYhF
         QhJCVlpUYE0h51sLtofV5Ss4aGr8BpE8Om50uGpYRv+PZTN+qpOCs46aZTMHeVhPJ0KG
         1fs3xTX9exxxWHRR0eMH48a+NtCcZ3L7iOJm8EVV25REZZSqxFl6Q7+C4AiBavgw0Wsp
         B+nw==
X-Gm-Message-State: APjAAAWWFqDmKBv+g/Mjhde2MUB4II/AJpauVrnTr3oMRDtzWiK8FBkH
        DLDsJl+MN0G1T41HDT6ksRaWQw==
X-Google-Smtp-Source: APXvYqyTat7r/x/jyQ3p5exvMBC2Bl3hV+C8x/dcGwdozw5z9olIYJVezIsqQmCHbjuondwZ9GrYSw==
X-Received: by 2002:a2e:481a:: with SMTP id v26mr504190lja.41.1572421107969;
        Wed, 30 Oct 2019 00:38:27 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id x12sm573408lfq.52.2019.10.30.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:38:26 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: zynq-qspi: Drop GPIO header
Date:   Wed, 30 Oct 2019 08:36:24 +0100
Message-Id: <20191030073624.23974-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver does not use any symbols from the legacy GPIO
header so drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-zynq-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 5cf6993ddce5..8786054f4869 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -7,7 +7,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.21.0

