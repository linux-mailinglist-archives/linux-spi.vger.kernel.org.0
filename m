Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18689277544
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgIXP2U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgIXP2U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 11:28:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0DC0613CE;
        Thu, 24 Sep 2020 08:28:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j7so1837557plk.11;
        Thu, 24 Sep 2020 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXVI8blrh+U0tOoKV0mzGc0cowRQ+kIzhBwCV8XERhU=;
        b=AVPMJ1vPOCO3zjmw8Z7m6/mYNu1KEe1IgzVGG93jFNEPlOOjvSfwl0AxUFHapGBpOF
         s4FMD7faMFWHKWoC5jxD3E7HVVjNCsAU0D/aIJ0B5bPkaltCoLnI/9Y4biHsMPNKRs1H
         VSjswkMr+P9b7bq4azdNAPTqv17a9ZeKKDaPH4QS0zp5fcJkCPAX+g9WPc3T55Fovqz6
         o74EVuFmwTUdmzpt9EeFMYl0g6jXMDtSmqByozYqgYI/SUOKLJpCYqxs33c2nS7OJpB6
         YSq8hGuO4e0c415/rz/pHb8bl2++PhugN3Nq2KHszvHIguiUPsjk99+Zr98MM/C4caqy
         YDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXVI8blrh+U0tOoKV0mzGc0cowRQ+kIzhBwCV8XERhU=;
        b=GHU4kQP6OeeWJ16m3h57OnJUteYZkDyN84tdrhj3/tNOSbp0jJU1J6ssDF/PG8YoHp
         nPdiA/c+b/7Rxa998dqL70ntIbzBOxjQyarTcceBoBjKeJsfliUDXrBhGAVzLFdrc3Ca
         FP+EQ/YLmXcKHfOg9H1AK2W2xhIm8U4+fv/+f05R/oHLvLU5nPZuDTyFBf8wh3eJxfWw
         hdD/vM1s3K9HlCCtRGhxWfrihpfwB7SoWv+6vmxirDjgHj81C7Qr3iAFS/sjKODeDDU8
         5gClZ3VoH2FvC3xrsJvia/6UwtN0i2JCk3kVTZHD5I/bD9QUsafRDLBFrJWRek4RJeLO
         t64w==
X-Gm-Message-State: AOAM532CGXfD0UETHpUCo24lyuFH6LFphUmfU8Htz89ZrVoHKKykbfZW
        LXvHsgXSCGbn+X1I0UZwP3JarwzQXuVbyw==
X-Google-Smtp-Source: ABdhPJxsPVRDdPOTyqtqbRcrA2IdHghcS1WT940rlN4wuDV2SJzU2u+ErsOmLk528OoV5ouzqGN8uw==
X-Received: by 2002:a17:902:ba90:b029:d1:e5e7:be6e with SMTP id k16-20020a170902ba90b02900d1e5e7be6emr4990145pls.72.1600961299775;
        Thu, 24 Sep 2020 08:28:19 -0700 (PDT)
Received: from guoguo-omen.lan ([156.96.148.94])
        by smtp.gmail.com with ESMTPSA id e62sm3233212pfh.76.2020.09.24.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:28:19 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        bayi.cheng@mediatek.com, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/3] spi: spi-mtk-nor: make use of full capability of program mode
Date:   Thu, 24 Sep 2020 23:27:27 +0800
Message-Id: <20200924152730.733243-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

"program" mode on this controller can trigger up to 56 bits of data
shifting. During the operation, data in PRGDATA[0-5] will be
shifted out from MOSI, and data from MISO will be continuously filling
SHREG[0-9].
Currently this mode is used to implement transfer_one_message for 6-byte
full-duplex transfer, but it can execute a transfer for up-to 7 bytes
as long as the last byte is read only.
transfer_one_message is expected to perform full-duplex transfer,
instead of transfer with specific format. mtk_nor_spi_mem_prg is
added here to use this extra byte.

Newer version of this controller can trigger longer data shifting with
shift bytes more than PRGDATA_MAX + SHREG_MAX. This patch is implemented
with that in mind and it checks against both SHREG_MAX and PRG_CNT_MAX
for future support of new controllers.

Patch 3/3 is a fix for:
commit a59b2c7c56bf7 ("spi: spi-mtk-nor: support standard spi properties")
which breaks supports_op logic. But it can't be separated as it depends
on patch 2/3. Fortuantely the broken commit isn't in stable yet.

Chuanhong Guo (3):
  spi: spi-mtk-nor: make use of full capability of prg mode
  spi: spi-mtk-nor: add helper for checking prg mode ops
  spi: spi-mtk-nor: fix op checks in supports_op

 drivers/spi/spi-mtk-nor.c | 179 +++++++++++++++++++++++++++++++++-----
 1 file changed, 158 insertions(+), 21 deletions(-)

-- 
2.26.2

