Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2236C15FD2F
	for <lists+linux-spi@lfdr.de>; Sat, 15 Feb 2020 07:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgBOG7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Feb 2020 01:59:37 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39733 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgBOG7h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 15 Feb 2020 01:59:37 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so4936966pjr.4;
        Fri, 14 Feb 2020 22:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLLoa1HE206JYtCQvu5wW2ZAWORsgXQDP7itOiiFk7I=;
        b=SDH1bF64VdhdHfMBJeZZF2KeRu67V3un9Y24oomrsY7BCJ66wjhBTvayBI5io5knT1
         dIU+e3CrfiMkkjEFag0kSyghEEuV0Mtg9nfskdBEIuO4tdY3Qc5MiLlwkwI/EInzRpXK
         OqzldDxuTvQ7eqt092ZzD87fE5fQKr7usgd+E75erNDpZ8a8YCbgX5a7nwmy2ooLyc95
         GpssJGEWFuFqAwLIiohG1pDuovCwIGth3j2eBNpo+zKxzPbRt0q0+kK1oZR/sVeEYLkH
         b9Nsge6yiyAGrzZMNHrzL1d8nYib8SFl+EBPHgDFR7GWWa60J4PVidKXeve1jvPoBLHx
         q7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLLoa1HE206JYtCQvu5wW2ZAWORsgXQDP7itOiiFk7I=;
        b=kAKSVFr3a0aPK+9bw+iDLgYCHW3dU74fm6aPhoUcrlWYsyvGb7AvxyoR5aL5PS8qP8
         +tyQiNvTRarOd+3M8b7c8h3A2xo1oE99LGaHciKOseWx8y4O5I17rPkYF7MBdvfbrHkP
         4UR7lciKGzOXn9+7x/YaFFugtLfRlimGhuiHnHzPwudAUcwiheGnFj1VvS3kXkkBneTQ
         OFrBJXkrBNtyNmFRTdxmJlT7fjTCSTy9ttqVsu/ZK0D5pZV/SZRXHcWYLLvdK2cJgdW4
         k2zB50kq5KGRYgYg08UQgy64XiwnpiwhLjyJi5ak0jonPZphmbcbDYmmEREiLgf2X9r0
         xpFQ==
X-Gm-Message-State: APjAAAWyAWwQ19T8pfTRSDEUa1dvG5Exw2pvW54Rf+EC6xfxtXs5J8zu
        SNP9Ze02xeDQuzvO4DLyGwY=
X-Google-Smtp-Source: APXvYqyOQOi37sMJScGrWpAIv/XpidYqqZcMorxgbOrmVjYGMGTvBNoQrHg6tbqiIiYO/ZeaH4iSjg==
X-Received: by 2002:a17:90a:3a86:: with SMTP id b6mr8063542pjc.96.1581749976239;
        Fri, 14 Feb 2020 22:59:36 -0800 (PST)
Received: from localhost.localdomain ([240e:379:95a:e780::fa3])
        by smtp.gmail.com with ESMTPSA id c15sm8918140pfo.137.2020.02.14.22.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 22:59:35 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Date:   Sat, 15 Feb 2020 14:58:24 +0800
Message-Id: <20200215065826.739102-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset adds a spi-mem driver for Mediatek SPI-NOR controller,
which already has limited support by mtk-quadspi. For benefits of
this replacement, please check commit message of the 1st patch.

To keep patchset small for easier reviewing, there will be 3 patchsets
including this one.
1. add the new driver, which is this patchset.
2. update existing dts for the new driver:
   spi-max-frequency is missing in current mtk-quadspi binding. Old
   driver parses child node manually so it doesn't need this, but
   new spi-mem driver is probed via spi subsystem which requires the
   presence of spi-max-frequency. Since this doesn't break old driver
   support, I'll send this separately as a standalone patch.
3. removing the old driver. I'll create this commit after 1 and 2 are
   applied to avoid possible rebasing due to any changes in the old
   driver.

Chuanhong Guo (2):
  spi: add support for mediatek spi-nor controller
  dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor

 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   |  34 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mtk-nor.c                     | 689 ++++++++++++++++++
 4 files changed, 715 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)
 create mode 100644 drivers/spi/spi-mtk-nor.c

-- 
2.24.1

