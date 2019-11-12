Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F14F8848
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 06:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfKLFyQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 00:54:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37268 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfKLFyQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 00:54:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id z24so11114502pgu.4;
        Mon, 11 Nov 2019 21:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pz2HkKIovaqqpPUupDoBtWK16lPk+o/FyQvbc6QLS5M=;
        b=G0wRXvqOFdEV7bXg4ol9lkWT/y/vj0Xifu6AIvHVi1nknJRc82e9x1LkArp2SxQBtg
         JqdFyXV9JdcTnOUV9Dem46mna+k9ExUpJsKO0ebhXRe/Y0nYkKgwJr0xyYf0FX9yoaSs
         tlD2COgwRJ1DthwQY16mmCT8UrirA1LEePtUUZ3ZOfBeiuE7eXUH1ReY9OBHCXhkIpvg
         izOA9PZVyMWiB3R5la3HTtxCUxBXQGJyDUYXYIXe/fTYiD4iyZN5shm3R5m9p0x8xJBT
         Q6Nbsvnx4SKicAMz6MlgmP3+BVM0eoplSg+c90JBbq+v6DuKZNh3XttE+wQ0WdLHi8Je
         RLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pz2HkKIovaqqpPUupDoBtWK16lPk+o/FyQvbc6QLS5M=;
        b=AekIi2vvPjZjUqRYAAAdiAlJMKYSKYaY4erXyBRziBZjxex8BAnNKsuUOtlz9CWaWe
         eQbf1FS3oZTrpKU7Pb/nd56eut3b7gV4qLanim3tOog6awB2sZkEBOVhsMgGtKLZ/nJE
         yNHiHruTwOXDv70qIrztv/PNoeGNricPzZCxrh5T+XKBDDDvHQ7OpSzMwV1Nqor+28N3
         oayPhEK6FZXLs8TKq0ex2zlLciGKOaYSeafeGTcy3+xyYFkVHmrg2N5VXmccwRDPGNYG
         wc724C4xW8rcNvDkk3N0cTnVDRQwmn6kOFK/F2V+crgQflm/xF6mxyhtIJ/tpAd9IuBl
         BR6A==
X-Gm-Message-State: APjAAAVtBhdqv9F7wG3NNLl2G9ZwXuXTNHqGyNYzhemFGoTu6zn7tHQO
        CuwVdHCRmVdaPuR8yiaRPm0=
X-Google-Smtp-Source: APXvYqwEOsiqa3kenFA+c8Tvhbta0wzdTNEwNzr33dcd1IrpfCj11Xj6mZ5UM98KVW07ldEn1JwkXA==
X-Received: by 2002:a17:90a:ec02:: with SMTP id l2mr3999094pjy.31.1573538055416;
        Mon, 11 Nov 2019 21:54:15 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d139sm23160178pfd.162.2019.11.11.21.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 21:54:14 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 0/2] spi: add wakeup handling to SPI core
Date:   Mon, 11 Nov 2019 21:54:09 -0800
Message-Id: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These patches add wakeup handling for SPI devices to SPI core, mirroring
I2C subsystem. Users can mark devices as "wakeup-source" in device tree
(or using static device properties) and SPI core will mark the primary
interrupt line as wakeirq and mark the device as wakeup enabled.

There is also an option to define a dedicated wake irq.


Dmitry Torokhov (2):
  spi: dt-bindings: spi-controller: add wakeup-source and interrupts
  spi: wire up wakeup-source/wakeirq handling

 .../bindings/spi/spi-controller.yaml          | 23 ++++++++++++++++
 drivers/spi/spi.c                             | 27 ++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

