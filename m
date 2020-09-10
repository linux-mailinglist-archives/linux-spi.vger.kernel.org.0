Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2B263BBF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 06:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgIJELR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 00:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgIJELN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 00:11:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C14C061573
        for <linux-spi@vger.kernel.org>; Wed,  9 Sep 2020 21:11:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m15so270127pls.8
        for <linux-spi@vger.kernel.org>; Wed, 09 Sep 2020 21:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjTp1hGds9ZwoOkcpeoGQakZnJuh6PzHnYd7zFegRU8=;
        b=NRiAcWHkL9seEwOjmyIZa3MCaZMmxBU6gYtM36EnQkvpXPeKcxLiCF/OKJTBvSJ+e9
         Jk44zmGowKGaPR4fIlaRKZhunvN6QMSFIzxG0PZ74x8bt2El2eBZRz7pVHbyykM5Acow
         vDBOeXBT0yHaRFahCLTwhTSWPFU+gcQiUKzBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjTp1hGds9ZwoOkcpeoGQakZnJuh6PzHnYd7zFegRU8=;
        b=QIgC3nvgHIWyfmBRzl6+dAIpsHD7Pggu77zoLXf/jVN3Hw7rxD6D3pm9uPY490vdQU
         ihyZM/6W5daYdiJMcff9qt4PHuq0qDPz72P7v7Auv8CNkWfe7v5b4/D1I4BiTOASN01v
         t4VO4BWeFykcbiIBNo8WgOcb1637mfckuDGV7geap4nenW42oHjulKAD5wBJdmhcixYI
         qIPxj8A0vx6JPQyCK9cbrYg1LcRuS9reY37Y1zMDp9Lqty97LgCfmQ60pFVFv4S63+7K
         HiayQmNKW70RUEyELxj4+ITahwau10/2cpI1HArhN8dZViV89M5sNzRhF/WtCEL5Hl98
         17oA==
X-Gm-Message-State: AOAM532zaOnqS7bXprPTFBpXhpFyEItLbID3s9OOVVAVMrm48v490PJl
        LLS9SNfxy21iJDzkB4jRwsiRoQ==
X-Google-Smtp-Source: ABdhPJy/kt256pAD+9kwVUTT8gpc//AaRJDaKiqodWQDyyYH+29li3hwTA00uoaR3VXRStW5UdRJ1g==
X-Received: by 2002:a17:90a:8593:: with SMTP id m19mr3592561pjn.104.1599711068389;
        Wed, 09 Sep 2020 21:11:08 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id z11sm4266169pfc.181.2020.09.09.21.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:11:07 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] Add 36bit dma support to mediatek spi-nor controller.
Date:   Thu, 10 Sep 2020 12:10:59 +0800
Message-Id: <20200910041101.1695195-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

mt8192-nor has 36bit addressing support, this patch adds 36bit address
handlings to spi-mtk-nor.

Ikjoon Jang (2):
  dt-bindings: spi: add mt8192-nor compatible string
  spi: spi-mtk-nor: support 36bit dma addressing to mediatek spi-nor

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |  1 +
 drivers/spi/spi-mtk-nor.c                     | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.28.0.526.ge36021eeef-goog

