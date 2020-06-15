Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6A1F92D6
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgFOJJs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgFOJJr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 05:09:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ECAC061A0E;
        Mon, 15 Jun 2020 02:09:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l11so16271184wru.0;
        Mon, 15 Jun 2020 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWe0dPSepbRkhIrx/P9OFbxlWpLX58b/aaaTuIJ8EVM=;
        b=K1lDEnnWOpcbHlNK13IscIis9/Te0HddSGIP7HnTFsMt7pqvq5BBlytlsGQy2+jsQB
         VHKMhhLmZH5tvVwfDznXMwihpgBkezZVyufBSF4xLD6l0qJoE7HtgnDAYyX/tZKvpyJf
         sbyHb4Wb3y5r3BOIYnnrsxWfWiu7ZiwnGUhjJNARuGNOhrze/e5hFC5DwqqwxPtxZmul
         OpbpqjlEmZ6aF7rJXmhXZLZU30EXDfV4vh4YkSxY6aoEfsvkFTI5RYEB/VUDB05NWCxm
         RzC4pr/UIrwIUgEixToDYnfErKKPBmhF7QhFvqkRB6mVCbNBXxgvjxcZ8sv3ZkaKYytd
         dfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWe0dPSepbRkhIrx/P9OFbxlWpLX58b/aaaTuIJ8EVM=;
        b=OrAB5zEa8h9VRyD2ujXUVK7DLRlOpa5FRZ+vocWfPVPk8mp//GftgOu277m0XHp4/u
         zhu8c2aMbr9wuGLJ1Y94fnrySZkoU51A7Hk/wiLnmBIGIAxkWgkgJcD3uXmthZMQGt9p
         Ok+1/BD6Ck7bQ0N+nq9mznlRq7n/G7YtgjQDyrbFpGZ6RGpyWlCKc6M73LZ8ZD90T22h
         ckQK7kivxFx6SIlgrHE/oOzfF/5wlsAj7I6JjGdYg0YREG3jMQDhACT/3n0Vcf1W5rkc
         Pnoec02ghq83oH9+jmoDdlaYHB2Z4I3OhsK4aoUtfBvemAJXMAQM+kd+5nx3UKQlwpsv
         N+tg==
X-Gm-Message-State: AOAM532onN8C4dlhetSfHAfpCv+i3AR4QwvTHkyPbm/+APhb7pE5+xLp
        PyYE8ijXUluNyIm2pcWhQLmyyYJzmqO52A==
X-Google-Smtp-Source: ABdhPJy16EawT2d8WoSHLA3avvLM4HBMOaqYQGYYaOFDz6vtilAsoS0fwcwoqIg8DSXB4x3S3mAbrg==
X-Received: by 2002:a5d:428e:: with SMTP id k14mr27556780wrq.21.1592212185663;
        Mon, 15 Jun 2020 02:09:45 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id z7sm23109370wrt.6.2020.06.15.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:09:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 0/4] spi: bcm63xx: add BMIPS support
Date:   Mon, 15 Jun 2020 11:09:39 +0200
Message-Id: <20200615090943.2936839-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615080309.2897694-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

BCM63xx SPI and HSSPI controller are present on several BMIPS SoCs (BCM6318,
BCM6328, BCM6358, BCM6362, BCM6368 and BCM63268).

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

