Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF02CF4E2
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgLDThF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgLDThF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 14:37:05 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB5C08E85E
        for <linux-spi@vger.kernel.org>; Fri,  4 Dec 2020 11:35:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so3689942plo.6
        for <linux-spi@vger.kernel.org>; Fri, 04 Dec 2020 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLsx5vVuUCPRsEhZl6FaNYVhvrSnAx3P4TPwOM+YKjI=;
        b=EIj5KpgF9tseDgO+Vv6rRaCFuZLSRi9JZbJm4JZSurBPJ+8A2N9qHkTQ9q2eNsk8uo
         i2fm+pGhYslCHJoEqkv2Km4XZFq095EU+0QlmnLYOi5CDRXxecQ1WeHnFDX/Mb5MR2hS
         abrArIEdHM3VcxdsG8L3q/i8V8HFEGxMHWZO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLsx5vVuUCPRsEhZl6FaNYVhvrSnAx3P4TPwOM+YKjI=;
        b=KUeKbdXOt/FJRbulN17oY+LCTLDsnDxxROpiUCY9MLmevqj2vQG32E2SlUbF0LbdYh
         sCJKwLeH3EUS99Xcgk/TrjVL+8FymxyNEv7TcDihY6SSAHgVwlJ37y8UuyMAcX6V3xpY
         i9EBIz+o7ur5JU8epVh2YKC4jNX0PPts+VkNldyLJ/ixAEHubBiGXhMicNr93wHTQHqS
         Kw79C/S9z7qn0UJZ5PpYTzYkpufJAnUvBQjKItxsW9rgKzMYZWUB6YvfpGcShG/Sdota
         GH76tSMuveWvd5Kkm5XPd400Q6GePxvYotLoJCXfEpRA5eiLQUlXpQhYiQnrHjF75uXT
         aN7A==
X-Gm-Message-State: AOAM533o0sPJoz3CcnWv60NY1hpkJhVptXqnpKco6kguO9npIz3O3M1A
        zbrSUgmeoBqXonle1sa8C8elZA==
X-Google-Smtp-Source: ABdhPJyLxHobwqXis3U8gHN9sAqxP1e9stcIpd/P4vWXMjWVB05VxeGgscZGw83QTCfowLd+/lvpAQ==
X-Received: by 2002:a17:90b:2285:: with SMTP id kx5mr5596316pjb.104.1607110545594;
        Fri, 04 Dec 2020 11:35:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g8sm4576548pgn.47.2020.12.04.11.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:35:45 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 2/3] platform/chrome: cros_ec_spi: Drop bits_per_word assignment
Date:   Fri,  4 Dec 2020 11:35:39 -0800
Message-Id: <20201204193540.3047030-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201204193540.3047030-1-swboyd@chromium.org>
References: <20201204193540.3047030-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is already handed by default in spi_setup() if the bits_per_word is
0, so just drop it to shave off a line.

Cc: Simon Glass <sjg@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index f9df218fc2bb..14c4046fa04d 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -741,7 +741,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	struct cros_ec_spi *ec_spi;
 	int err;
 
-	spi->bits_per_word = 8;
 	spi->rt = true;
 	err = spi_setup(spi);
 	if (err < 0)
-- 
https://chromeos.dev

