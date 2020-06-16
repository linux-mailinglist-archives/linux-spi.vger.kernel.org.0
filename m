Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122581FA963
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 09:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgFPHC3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPHC2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 03:02:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0EC05BD43;
        Tue, 16 Jun 2020 00:02:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so19555004wrc.7;
        Tue, 16 Jun 2020 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WZthhuU//B6wQw1RFUk3CQpL8RxxxfDOiN2psXzJ30=;
        b=mR/Rr5NBXyT29lrK1jJ2dX0W50EtQXJGcssYXymYzPi/NbGzH/5jsZiBcVuIeoqSrJ
         M7fkPimXCdKTnzK2D1eIr2EdzEXm/aJhS8B6tjzfUI6fB+8J0Q9pKfXRqZnTteKrgFG+
         LBzJLRXJwFc1d+yRnFCSVjLDnTOHJ4Q3m0lBVWIs5wlExs3t7o+7CeBqby1wl8sKm59+
         1aVUNhSNqGKXQ56GiX13j7GxdIzUCxdZaAz/vUI6zfTxpL3wDSOTRUY2Gp9bLzkRtdWy
         K1zeR4+FL52hB9J0CaGBzgTlpPPE1Ws5NhFvk2AckpIBxQdN5BxLtoxwFSZKyGAeTp4U
         v91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WZthhuU//B6wQw1RFUk3CQpL8RxxxfDOiN2psXzJ30=;
        b=CVBQ9bcsJeLWNeQAoFXTvR/KOFC4+CJLV1/f3lmavRE6ZU/0nTMivg0DW/Lt6ui+TJ
         SNatwYmXObDfZ+at+7dJYZogPfKos1bDx2tQaP+JNwuNo+R/93ozy8gc9GX547lI3UJS
         uN9/Exw4Db//tMm9A3K7Zk012IZYnLJiL7qcwjjUnrTmzB82CAZgWtH0Py/dMSHMGtdU
         PMEFYrQoyU4hznylT0vszucXwAh4m2S3ETZ6786L6+14MZNaPbKzVO/JhgwykLnvEIMR
         7C1a9NwONq5LDSKWrJIlBQ1G5XUmCDs+IsJKgREJU1aZP6s3tUcsZczmgv0eh8/JVwUZ
         RrWQ==
X-Gm-Message-State: AOAM530PFqNAgL/RRhkDQOoMmG8IIJg3njLbChgDRzix2qKopk5u0Tw2
        cUlfG2gKXy7mY2ypyUGEcZI=
X-Google-Smtp-Source: ABdhPJzA4UCgJ2AbMfjQ3ZdhBe0623Lw1JbpKljb0BlnktIWeajUb3wlXXR3PX7lOdwSZ2ZUwPVbsg==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr1450317wrw.260.1592290946770;
        Tue, 16 Jun 2020 00:02:26 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a81sm2792897wmd.25.2020.06.16.00.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:02:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 0/4] spi: bcm63xx: add BMIPS support
Date:   Tue, 16 Jun 2020 09:02:19 +0200
Message-Id: <20200616070223.3401282-1-noltari@gmail.com>
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

v3: use devm_reset_control_get_optional_exclusive
v2: use devm_reset_control_get_exclusive

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

