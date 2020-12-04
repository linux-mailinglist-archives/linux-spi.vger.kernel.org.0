Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB42CF4DD
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 20:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgLDTg3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgLDTg3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 14:36:29 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71448C061A52
        for <linux-spi@vger.kernel.org>; Fri,  4 Dec 2020 11:35:43 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b12so3776744pjl.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Dec 2020 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQOzjOYJXvpHGTBE9J2N6doLl1JsXiSaL28cDlClm0o=;
        b=k8Vt7gP4X6Qp48Jh5479utdPnROY5jhZmrrmJTepylvBPlCg8c6rByT4EhbHgrkLXQ
         Plm5G2PwQwBogJILdnwN11KBn3cQStYVPVQHDZqkv46XiAsS3nelHxKg51KOP1TazQ9Z
         qf/qkPHAJpiWvuDB6+3pM1oOVEII8u5yp1D+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQOzjOYJXvpHGTBE9J2N6doLl1JsXiSaL28cDlClm0o=;
        b=YiXjQdTf/VvfhStYNmhoKrwV2dW7Clh3aae+LPPx87w/p6+Q7nCNJIppcOn0zsRxyU
         QPXAWl/ysJIy/wLTkG1BZsmQeA8A6EKo1mAcyEnx/fpjNrJcezlmGO2cu0d9js3E3U1n
         l6nESVIxJWl1spbuM9VwL1dp+4ViQlkuQt9BC4y2QdlSsGoCosqXsblM+PxcIrTIC37Q
         ltqXGyC1bMkHkPlg4uSpDBsV9JG6JBH+3mWyNYpJ+jhCNcBF280pPrrvOk1d59luF2/Q
         sTmaF6EGDzwHWpiO3IKdQAFeSmROGB3X44QfiiyomPoXewT2H3lHNpR7C/DCudYealDP
         35ww==
X-Gm-Message-State: AOAM5303amuI5ouRONmSxwmqwPlOwZbWQaJmckS9BTWcwynCNfzB9sgl
        ASw3ByTTOTbiNrJBGrAkBIr/Xg==
X-Google-Smtp-Source: ABdhPJwtvKpZoIC5oBwhIilVQuCrqSzkia9n2e/z0noehWkQlZItz341dCblmGV7o4eIGAKr4ZBH+g==
X-Received: by 2002:a17:90a:e386:: with SMTP id b6mr5345544pjz.134.1607110542931;
        Fri, 04 Dec 2020 11:35:42 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g8sm4576548pgn.47.2020.12.04.11.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:35:42 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Akash Asthana <akashast@codeaurora.org>,
        Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 0/3] spi: spi-geni-qcom: Use gpio descriptors for CS
Date:   Fri,  4 Dec 2020 11:35:37 -0800
Message-Id: <20201204193540.3047030-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Collected patches from the two series below and associated tags so they
can be merged in one pile through the spi tree. Merry December!

SPI: https://lore.kernel.org/r/20201202214935.1114381-1-swboyd@chromium.org
cros-ec: https://lore.kernel.org/r/20201203011649.1405292-1-swboyd@chromium.org

Cc: Akash Asthana <akashast@codeaurora.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>

Stephen Boyd (3):
  platform/chrome: cros_ec_spi: Don't overwrite spi::mode
  platform/chrome: cros_ec_spi: Drop bits_per_word assignment
  spi: spi-geni-qcom: Use the new method of gpio CS control

 drivers/platform/chrome/cros_ec_spi.c | 2 --
 drivers/spi/spi-geni-qcom.c           | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)


base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
https://chromeos.dev

