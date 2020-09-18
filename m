Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4164526F845
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIRIbb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgIRIba (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 04:31:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00594C061788
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b124so2972161pfg.13
        for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2020 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g3/3HRNTSbPMO+XtztpkLjskFShJd05xhi/n73t2b4=;
        b=J3Jq/M3KnJTcWXxQ/OmDCmtw9TKMVom83ObJCwfMadXSAPRuA4l/Jm2QB0eR4ojdNs
         fPQo5XjYTFreg2ms90MvHm4DvWmPFmn67LMERc9pHP3vJ0cCl4LLTglj56jPBMAbtfpq
         rB5yxrY/2z7aI/sV6h7qHpU7ZHO+WQxXuMtTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g3/3HRNTSbPMO+XtztpkLjskFShJd05xhi/n73t2b4=;
        b=ZWEvUmkBkNd7LH3pyxoTERzBiIhNvSSUOysWSmcTnJZjNt1fKrA9EWOaqdPBwmG+XZ
         cJIQjI/gZKyzbEj0z1XCQ6q9b9j1OArCtKCLDPDhPAVTZoqrqnZkW29ko8cE1cyGTLJt
         yYdaIZQx3JXqUFPF+GCnMu0cuwcfW7vS2FDR8mOpxWLtg0QlWkdcba8b7g0Oew+dEyMh
         tg+ZDouGrGB08T7OFd5tT2i+F8N1l9VhtYjF5SSNLNV/tnBYrzNn12aItjrcdH7XRYLa
         F6FkK2CDq+MZTWtO/gg5jm5W/iIU2xdGU+D8ZYC2Op8ay9TzqFDAhkbw8NvseYosn1uT
         7VOw==
X-Gm-Message-State: AOAM533RX7NBKVBhnXCDOgPtLXtq1Mcjkh+qwrnBu2/1+qNijWxFYErk
        fNNdToEljeZ44mYaCtXrvOgqKg==
X-Google-Smtp-Source: ABdhPJyo5ajOR3Sys6kLV1edGsPyxX+u0k7ZFoM2H/iELQtDmH1lb8MEP86ne6oEPQdxsCBI364jDQ==
X-Received: by 2002:a62:3585:0:b029:142:2501:3985 with SMTP id c127-20020a6235850000b029014225013985mr15239835pfa.74.1600417889074;
        Fri, 18 Sep 2020 01:31:29 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id g206sm2193172pfb.178.2020.09.18.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:31:28 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/5] spi: spi-mtk-nor: Add mt8192 support.
Date:   Fri, 18 Sep 2020 16:31:18 +0800
Message-Id: <20200918083124.3921207-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset adds 36bit dma address and power management
supports for mt8192-nor.

Changes in v2:
- Add power management support
- Fix bugs in checking spi memory operation.
- use dma_alloc_coherent for allocating bounce buffer
- code cleanups

Ikjoon Jang (5):
  dt-bindings: spi: add mt8192-nor compatible string
  spi: spi-mtk-nor: fix mishandled logics in checking SPI memory
    operation
  spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
  spi: spi-mtk-nor: support 36bit dma addressing to mediatek
  spi: spi-mtk-nor: Add power management support

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |   1 +
 drivers/spi/spi-mtk-nor.c                     | 242 ++++++++++++------
 2 files changed, 170 insertions(+), 73 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

