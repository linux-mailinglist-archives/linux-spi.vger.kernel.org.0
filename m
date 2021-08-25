Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFB3F6FE7
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 08:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhHYHA3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 03:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhHYHA2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 03:00:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75557C061757;
        Tue, 24 Aug 2021 23:59:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so4050673pjs.3;
        Tue, 24 Aug 2021 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EUcLGmwSrg5CUVW3cqmxP8IfXwkpbSUpFunpQ1DtuQ=;
        b=V0lsWCCAyNxu/GvucVEHeGUtPCj/C2fggn06fuN6e1BRCZ0B7jgSZUsnib26Hnt1YF
         maUxEqnfccrj3WgkebyFm2gMxo2WpqYIG+abFWBH96UG4LhX3lq6m+GTk4mYeVdsQ5+3
         EdoQ9+WlqgJJHMX06O5sSD3RllcmZhtU3gK/fJ+WRz6q5bZSM7lnhIyD1a3UVw4EbmIz
         otws2JNdJ0nIDd7ByqBel+pyUZlT2flnQ2SKnpCtsZX1Bzy3nbIWiOXJ7frO0vRqj6TM
         O7yrd6I2V9uAM+W1aJoE6bjQt1icM5ADeu5vzLbdyLigagBGcKl0s/MM5ualE7JkIpZ3
         zkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EUcLGmwSrg5CUVW3cqmxP8IfXwkpbSUpFunpQ1DtuQ=;
        b=VIzrgNQGLdEoa3eGTAwBIZ/HD65zKA4r/EgY/Ce5sk/kxun9OxWqQsL9+t7ZqlnGAS
         6SkH8jBdcByAI49mLVbBnxxBkhgIWPAnRHlisGltmKbmqTbZqR9MSXbDTdFtmEUGoAMa
         SfQx8eSLOq2cU28Q1m5ehkh2kXShdktUnKaFfAI5HZ6aUb3mx9czC/B6UOFEZNsx8Vh/
         K+R+Doi21Li0X1TasSsQLxMOAGLLHqTULKtttW0y7fyEaU5YAu8JlAY13ZMoba3wARN8
         Ft2itFX/QQwGWpAg6+NXbXBPkxikkBpJc8YFENiZLbMeG4PzRecu7BPddVWWIEgp4vFE
         Zd+Q==
X-Gm-Message-State: AOAM532BVedx5B3cRsOsnwrgAg/bTQfKBcPcEP18/ms3NLAzbkMge8Nj
        pPUwSb9aywVKhIEyBd6GQas=
X-Google-Smtp-Source: ABdhPJzejSoaekb3fb6cFFIcZhHJLMkWmrmn9/7N8LwK6O5yQq6vSUSsax80msUXQga+XL2fD05Efg==
X-Received: by 2002:a17:902:ab4e:b0:134:fd88:725d with SMTP id ij14-20020a170902ab4e00b00134fd88725dmr10912843plb.46.1629874782668;
        Tue, 24 Aug 2021 23:59:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q102sm4443109pjq.54.2021.08.24.23.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:59:41 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/3] Add sprd ADI r3 support
Date:   Wed, 25 Aug 2021 14:59:28 +0800
Message-Id: <20210825065931.2111159-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patchset adds new ADI version (r3) support which used on sc9863 and
some other Unisoc's SoCs.

since v1:
* Address comments from Rob.
- Rewrote schema for 'sprd,hw-channels' and hwlocks.

Chunyan Zhang (3):
  spi: sprd: Add ADI r3 support
  dt-bindings: spi: Convert sprd ADI bindings to yaml
  dt-bindings: spi: add sprd ADI for sc9863 and ums512

 .../devicetree/bindings/spi/spi-sprd-adi.txt  |  63 -----
 .../devicetree/bindings/spi/sprd,spi-adi.yaml | 104 +++++++++
 drivers/spi/spi-sprd-adi.c                    | 218 ++++++++++++++----
 3 files changed, 271 insertions(+), 114 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml

-- 
2.25.1

