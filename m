Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FE3F8449
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhHZJRD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbhHZJRC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Aug 2021 05:17:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F91C061757;
        Thu, 26 Aug 2021 02:16:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 7so2209465pfl.10;
        Thu, 26 Aug 2021 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoWaaAteGY1zBeIqGiGUYhidikPShu+XFTkg/eebEDo=;
        b=Y9whYsSgxNo7tuphW30gOpMpv8w9gOERTCOOPAlitCBaA7nXjA0X/F1nfxKyh7JFFG
         rcNlMITi7y07EsWmhi7EcfBl3BEmrj1uDB14wJ6rHg3GkvqLuHCwYoGu/6RqkMC9CEcf
         UH7YIjpCovknnjPw28nVeJX0YZYLDlaLquEDhg0YUJJJ9uCqjOgS8x2sq7GVDLPdZdZn
         j8P/eTcpXPivpfdC+lzIo/Ono1A6fm7iPUWFRn0ia4W3b9FUDLvFaKLZPUnMlJh37Mhr
         jhskIk/h9Iw140779ksJQdEM25gdXbRgjpYLuAMmnFqWUYHNgQ8mCy3U2dSf9Yz2XANy
         IpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoWaaAteGY1zBeIqGiGUYhidikPShu+XFTkg/eebEDo=;
        b=e4MmesJpPLknyMUUCQiMOtwd1b1pCTbJELFb4ut+8YSuxTVqa+3RLnGpywH0iY3orp
         O3NYiU3DqK3DMTnWci6uKh9yyIiW20EM7gzumH32sAt+xa0ZeQGKHRREbdAwuFif2oO9
         9qB9EjNgZUxrCY/ctM5VD0JqMYWtF6mO/P7UGd6OCPXvsg2eyH05Bpw3BunyjCHQJ8LY
         UgGIHbM1AY2gLUB02cnpBKiEW36e23OUroxkcMvuL7mZbI7F3BcKooDCDHA/l9eUt6cw
         np1d4xiThOn5kjUyU8WvUIwO+oj3miodl2PWHp8plHW5Epv/f1X+xpgIRwpQ9SIjSlV1
         gYOw==
X-Gm-Message-State: AOAM5330HaAaCYr9CalR9cYOkiKChQeFebjuATde1K44SXGkbpr8kBHb
        dnZ6sCOh+0jVsTogJbq/EOHqxODDc2Q=
X-Google-Smtp-Source: ABdhPJx6M+BRAc//cAsjvfUihW3g/noSoWdGRsvxhFe9rVaVxTKXns55hdb13yYJ0bZKGNrz3PH5kA==
X-Received: by 2002:a63:f80a:: with SMTP id n10mr2476225pgh.303.1629969375377;
        Thu, 26 Aug 2021 02:16:15 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm2777569pgb.2.2021.08.26.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:16:14 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 0/4] Add sprd ADI r3 support
Date:   Thu, 26 Aug 2021 17:15:45 +0800
Message-Id: <20210826091549.2138125-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patchset adds new ADI version (r3) support which used on sc9863 and
some other Unisoc's SoCs.

Since v2:
* Added Rob's and Baolin's Reviewed-by;
* Seprated a stable patch for wrong macro fix from the last version patch 1/3;
* Removed redundant empty line from spi-sprd-adi.c.

Since v1:
* Address comments from Rob.
- Rewrote schema for 'sprd,hw-channels' and hwlocks.

Chunyan Zhang (4):
  spi: sprd: Fix the wrong WDG_LOAD_VAL
  spi: sprd: Add ADI r3 support
  dt-bindings: spi: Convert sprd ADI bindings to yaml
  dt-bindings: spi: add sprd ADI for sc9863 and ums512

 .../devicetree/bindings/spi/spi-sprd-adi.txt  |  63 -----
 .../devicetree/bindings/spi/sprd,spi-adi.yaml | 104 +++++++++
 drivers/spi/spi-sprd-adi.c                    | 217 ++++++++++++++----
 3 files changed, 270 insertions(+), 114 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml

-- 
2.25.1

