Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09341CEE45
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgELHg4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELHg4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 03:36:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12941C061A0C;
        Tue, 12 May 2020 00:36:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fu13so8985786pjb.5;
        Tue, 12 May 2020 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oJmUzMw42DTbrXzzUYd7Ks8dtTTCqqycjSbTZSaOap0=;
        b=cCKlHK9w4o+2S8+AIROccI9rcib+ct01tsHVfjDmeGmiPY0Wn0Dc73yHEqH3sN4XQk
         AAIp3z9L5wcSNtfz5GuHrOsNcWQ2KyOnD3Mi+3rQJ0sEoBWI2zysRtB+iQg9+1Az0oKU
         5mDgji33MT0GJE0sltyWnLxivbDrec0xxp5llL9doCR9UattDLmvRJZA3E9cQ5Nh7y4z
         0KrhW+XCAj7kNMMAE0Hv36lDa+4DAVCVTwdoCieHnyRhaoVzpSBcSfY/3/29ZqBdYYIY
         rtcUQe5HLpU0QMXT3xVnsISP5f39SHz3Q6vhH9mXoYgiTZOhIjiDwgnZ6DipQhF8ulxU
         1jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oJmUzMw42DTbrXzzUYd7Ks8dtTTCqqycjSbTZSaOap0=;
        b=eaSVwOb+xd1mdunXUeHY4oNDYKmjes7nxzGBXZ5JTJhCnLVh/ULXWhU1AHu/hKjKZT
         FqLJ1c4/KU1PrtDzoHzHNWULPY2zjuEN2sWNXbjyH/40L6mGmooLTu66A7uKRGCZ0G+L
         f+/Ci0OGSmbq88ZUE7S+6kjHXAHW+Ph2mpW6HUAp0KFdH6Mv4cgzU8C4bikIMEZYCyMs
         6Gg8eka0t1LacBuXWnVPtHinJzE90du2/NN10ECQWUgK3SKDUqKWK2TWjgnM9z1mlcd2
         7IEhr0GWFFcWJtzSTVkkjueblYUe6h67YjAFh2b+3k00r8qxWOwIucYctkhe+yXLnm4o
         rElg==
X-Gm-Message-State: AGi0PuY3PI1sn8sO2LlTahNWhrMaIXwUYQPNX0OxdcsE0TXBFWiMK14o
        i/b+2Q/Ed0YpI1WTGaiI+G9Zv9zDCLQ=
X-Google-Smtp-Source: APiQypKmaZEGYk0fHOt/kEOG6LJdizurDE2nYIhhfFMWLuELWHUAe3JTjq8LUtwXSDcZzGgVK06Iag==
X-Received: by 2002:a17:90b:78e:: with SMTP id l14mr27370151pjz.144.1589269015605;
        Tue, 12 May 2020 00:36:55 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 5sm11732471pjf.19.2020.05.12.00.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:36:55 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon.minfei@gmail.com
Subject: [PATCH v2 0/3] Enable l3gd20 on stm32f429-disco board
Date:   Tue, 12 May 2020 15:36:47 +0800
Message-Id: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset is for enable l3gd20 on stm32f429-disco board
has following changes:

V2:
    1, insert blank line at stm32f420-disco.dts line 143
    2, add more description for l3gd20 in commit message

V1:
    1, enable spi5 controller on stm32f429-disco (dts)
    2, add spi5 pinmap for stm32f429-disco  (dts)
    3, add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4

dillon min (3):
  ARM: dts: stm32: Add pin map for spi5 on stm32f429-disco board
  ARM: dts: stm32: enable l3gd20 on stm32429-disco board
  spi: stm32: Add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts  | 25 +++++++++++++++++++++++++
 drivers/spi/spi-stm32.c                | 29 +++++++++++++++++++++++++----
 3 files changed, 67 insertions(+), 4 deletions(-)

-- 
2.7.4

