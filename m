Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D4685EB0
	for <lists+linux-spi@lfdr.de>; Wed,  1 Feb 2023 06:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjBAFFH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Feb 2023 00:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBAFFF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Feb 2023 00:05:05 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767A4F344
        for <linux-spi@vger.kernel.org>; Tue, 31 Jan 2023 21:05:04 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so6099284oti.5
        for <linux-spi@vger.kernel.org>; Tue, 31 Jan 2023 21:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFYcNel/Q2GQJL9XoH2s47LEJcta3F35GHGftrB3A3w=;
        b=Ea5i83I2CXZqQXspWK2Ax27Zy741SAd0GXG5IexoQd7CE1sWpvXfSrzfQuP8JwghAS
         4rLbzbinfuVbqeG3+bSWjrKbiJuIfQW17m7xEO2eOyEbEQ4QKfQzpMoxvgJMfE+f6fwv
         2J1OisSAZHh0hrF8mw5f9IS4TtUagLrGa5TxVxzTsSubSq9gpA/LqwBFc8FwdZXuwyfL
         XXM68ffecTfDYGIE4Eewyh+CQ3TwIJPeSJX7yJgrrFRORBpCCa4L0q/HDsiRoU7wVdqf
         8jTrYl7zJlf0QyKZuJTB7U/KLzYpif8/5cuVM+WakcOlRanGj1Qel6n0YgNj2W5m7Kjz
         unVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFYcNel/Q2GQJL9XoH2s47LEJcta3F35GHGftrB3A3w=;
        b=nSyVeOF/q8vmJkSRrZqRp+0MpIuxVhe6npZ8+PP5P4hq6/6KiM5HrYS1TwWYCvuEjO
         llShrG/9GWyXUTPaVkFdN/jIp1vNmzNijimHaU9dcLGA1lDdJ2F9itE7tQ3RNLx13dxi
         o4XECTBCV0l/z1SOcZieYV40kdst+DMqBXff3dzO3Q3HtSCV6oBSyoZWI6p5MR0w2MNG
         cuzuKeJrSl3WMuwX30MlkyHx2skSnvlJ91QVLsCG9NJsgs2z07ZU6+WMiB9xRLItguB9
         uJEveckWRb6Lt4TkM+1kBCZtjv+0PS5kqzkO3upOJDxE9jpaD/cJUMHlau9eni9AX5P7
         KbZg==
X-Gm-Message-State: AO0yUKVg4CSDn5aSRZHmj+ApTNsWTbL4SwGGZijN9Aq9sM3OERDAMb+I
        QK23vdMi9z00uQRuAaIx0y4DoEvX5p28sr1P
X-Google-Smtp-Source: AK7set8KeuNtvBFotSzeEtOdjHVaV5Th4l75UFiGeDLXMeuzJcMuKyU4woiV+JArxxJz/h4vGD42Jw==
X-Received: by 2002:a9d:560c:0:b0:671:cacb:681b with SMTP id e12-20020a9d560c000000b00671cacb681bmr555143oti.22.1675227903841;
        Tue, 31 Jan 2023 21:05:03 -0800 (PST)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id cd26-20020a056830621a00b0068be61a7ac6sm1123445otb.56.2023.01.31.21.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:05:03 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 0/2] spi: intel: PCI driver housekeeping
Date:   Wed,  1 Feb 2023 02:04:53 -0300
Message-Id: <20230201050455.505135-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Found some controllers' private data that were wrong according
to the documentation. Also, the number of Protected Regions from 
BXT types was changed.
The second patch adds more Device IDs to the module table.
Probably good candidates to stable?

Mauro Lima (2):
  spi: intel: Fix device private data and PR_NUM for BXT
  spi: intel: Add support for controllers

 drivers/spi/spi-intel-pci.c | 13 ++++++++-----
 drivers/spi/spi-intel.c     |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.39.1

