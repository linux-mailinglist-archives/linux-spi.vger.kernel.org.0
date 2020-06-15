Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994F1F90E7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgFOIDN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 04:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOIDM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 04:03:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9702CC061A0E;
        Mon, 15 Jun 2020 01:03:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x13so16038657wrv.4;
        Mon, 15 Jun 2020 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDP7eI93BA6O8vNpenJlTbc7LwUcGedkrTzHRTDYCp0=;
        b=R0He0pmvK3ON8oQZm76JHE8+ZBhJuGefP3ORNCcxg7vw1Cc/Tgq6pglgsYxeCHt4km
         nCi7LtwAtxz06fouLKCayAojFytnvkIP/GGKF0FMAKcjz8nB99ImspWqyvM8f7mV4Jdt
         wzX/m8qGoAFHXCtLfPyu1wYcsE0+NqIP3ehRgaVb3t4gTEm2yf8fBjJPfVdnEXTRBFwo
         JODnCdBocXtxsMi05fcJl5jRkeCpHhODvaFsVD58GU4DBULfnExVvSkqj9akRFxKmYmj
         +jqw4z0U96PVZ5MsR9RlG2fBce9aNwe92Eiyh3Y5lgdusl4ve2mB4L8FOJTCpkwtVdV6
         MmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDP7eI93BA6O8vNpenJlTbc7LwUcGedkrTzHRTDYCp0=;
        b=VmuulnSwy8cXu1i08PFQXxJxg8tfgMNhQEjVRKtajt4wzjjZvgmiEgERKq0bLoripM
         cvd77IRZk5m3STxz+n2fUUQqoXV7n4CmhLkDw3hi+vK1WAxY2Y1Y9XmAPY3s9/bCKgNG
         zd+3JUJjI3S1xrC+dssidkkyo1EN9QkUV7QxI8HfzfHQoVzqrKHo9uCP1Jq98l2YcfYJ
         xEkWpovPTsG8FmZXaxxfwdPer93vOgrIj7TfRgsansMbFw9pnjuCyMV3h4trO9HNU2q0
         IpSD+q+SHPceM1i844rBXN4a0whiNIW10/NMZ9cvly9ghbboV9F0GFQz+tfUDfCJNmzQ
         vTIg==
X-Gm-Message-State: AOAM532kbqg1ITGtdhYpbAqPgN1939+EVy0RI+7aT8CMH22roNjCoSqS
        cCZnoUJDyYyE9a86oiyEsNg=
X-Google-Smtp-Source: ABdhPJwFV/dnQvP+WYtbJ6DuX19B+uGzQznL4K8oB2ZPk+rsIlgW7MOxwp/PkedE2uCq2eCOa7q5sw==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr27410732wrb.314.1592208191230;
        Mon, 15 Jun 2020 01:03:11 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id d9sm23107054wre.28.2020.06.15.01.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:03:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/4] spi: bcm63xx: add BMIPS support
Date:   Mon, 15 Jun 2020 10:03:05 +0200
Message-Id: <20200615080309.2897694-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

BCM63xx SPI and HSSPI controller are present on several BMIPS SoCs (BCM6318,
BCM6328, BCM6358, BCM6362, BCM6368 and BCM63268).

Álvaro Fernández Rojas (4):
  spi: bcm63xx-spi: add reset support
  spi: bcm63xx-spi: allow building for BMIPS
  spi: bcm63xx-hsspi: add reset support
  spi: bcm63xx-hsspi: allow building for BMIPS

 drivers/spi/Kconfig             |  4 ++--
 drivers/spi/spi-bcm63xx-hsspi.c | 17 +++++++++++++++++
 drivers/spi/spi-bcm63xx.c       | 17 +++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.27.0

