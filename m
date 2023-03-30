Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83D6CFBAF
	for <lists+linux-spi@lfdr.de>; Thu, 30 Mar 2023 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjC3Ge7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3Ge6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 02:34:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF65240
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 23:34:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 4-20020a251904000000b00b7f75c3cafdso2579977ybz.16
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680158097;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vck4iSDUKZf+JCdPQEvQ4evRUmQTT/pnCnaPcb2eePY=;
        b=K2ZxZT3WU7jTwiesqYy89B7hO2hIOzo/cyknJYK7ErdVGCnBDUUfG4QRbuA6Ew/UBq
         66p3lUcFg9MUziJJhOzBEdwtoHWizDcBeH/DTYEaxot1TqPBH5+aL0CdsjBnbmvOUzPs
         7Y8zHNNN2f4dVVw0lxHFF+QK50cvtKezv9EorSute8ILZpzulv6WjGh1c5lJ4XChhQIP
         XpKniGWjZ9qlHSZBhlbnVPLbb7v6UfT683D2MMxQ2SIwaSNM2mdwMsfZqi01vQJ+DeI5
         tlDdF0MA1Eu4Gjy5GikaRF1fBRHIZo5RvwSskPxUyy9peykfjmREizZyY1Yf8Jm50wAl
         ORVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680158097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vck4iSDUKZf+JCdPQEvQ4evRUmQTT/pnCnaPcb2eePY=;
        b=unuo13VnIt7ENblPeC6+3yQLCS0fC9KbZar84E6FcuCTIxtAP2uY3bIeFnmXfF3Bk5
         2nDXQgNQav1IY7FOE2+MxN8CXrCEzikzXtReOo4/vUmOCF3oSViTQr1tAr3DV9nlqZ0R
         nzS7I7Vm65RcH5R0frMtOV9PWELwjrHa83Eza++4ao3MJ4oebVaEQMx5gsEI5CWrbsvF
         NDB4OyZUeF928++1kHPo5IbidIFcKmIlAHRlbgjTlrz/dwks45tbJ2bfgTmRToJJVdO/
         ZwyxTnSFAnpMb596is57NGJqWuuvCdctLH78NdVuzgJEEJO9XQhPpZdvOCAEyQKfoB11
         mZ+w==
X-Gm-Message-State: AAQBX9cZlNxFBfoAAdgg/PCd12UOqQ0m3GqKJhfaTKmdxy8TbS85nhTD
        Oa1Za9GYj9vpcgpVkoB3mk6OtXMhkv8YZw==
X-Google-Smtp-Source: AKy350Z0cQ23dfmrxicebK+KYirmR35YSZ+pTIA6iDuQB6Y3G/mNGad7wXSF0g8L67pFNpH8xcHoelQKSwTskg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:ae23:0:b0:541:7237:6e6b with SMTP id
 m35-20020a81ae23000000b0054172376e6bmr10436707ywh.0.1680158097247; Wed, 29
 Mar 2023 23:34:57 -0700 (PDT)
Date:   Thu, 30 Mar 2023 06:34:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
Message-ID: <20230330063450.2289058-1-joychakr@google.com>
Subject: [PATCH v5 0/2] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This Patch series adds support for 32 bits per word trasfers using DMA
and some defensive checks around dma controller capabilities.
---
V1 Changes : Add support for AxSize=4 bytes to support 32bits/word.
---
V1->V2 Changes : Add dma capability check to make sure address widths
are supported.
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---
V3->V4 Changes : Fix Sparce Warning
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/
---
V4->V5 Changes : Preserve reverse xmas Tree order, move direction
check before initalisation of further capabilities, remove zero
initialisations, remove error OR'ing.
---

Joy Chakraborty (2):
  spi: dw: Add 32 bpw support to DW DMA Controller
  spi: dw: Add dma controller capability checks

 drivers/spi/spi-dw-dma.c | 70 ++++++++++++++++++++++++++++++++--------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 57 insertions(+), 14 deletions(-)

-- 
2.40.0.423.gd6c402a77b-goog

