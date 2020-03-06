Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3517B8A5
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFIvi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 03:51:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41165 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCFIvi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 03:51:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so767138pgm.8;
        Fri, 06 Mar 2020 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KktHYfzCrBS8kPiYs9+pEgMzyzX984i5dmj0nJ9JysY=;
        b=M+RYqjqz1PqntT8vZIEeUK1Lq7/juK/t7qda5QlSqOWKHI773pXI3Z4nOznRH5Zybr
         TqgoDoEy/BB2YcceZ7MPrKVAbLbOb+yyH+c5kSVv4BwG9elregK1zFuQplg//TPMwKbK
         kNAeK5OkinC6a+R+vB8jWP+FluttBYE0GpR0P8O2CWPkaubQ0OiqMcOwUxQ6OcQAzcaz
         EEGJIGpAlcIcbH3UFl9YnRHPkuzZxEvXZDEceAXtwwENfPdJbEQfDQFR+mGQPg/34+R+
         LVhNxxk/5oKgFPr2Ru183itm63XZeAxEovwA2DDpv+tOqi42MMYoEMiWQbURjG2Matnr
         xqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KktHYfzCrBS8kPiYs9+pEgMzyzX984i5dmj0nJ9JysY=;
        b=HzQTr+3ZofIc+UDTL8EOdZ7r1lUre8Sjv6W6KwR1YGSsPmC7ptCaL0xFqjFFYghQqw
         m2lLtHHzhzi/v9+CsY7MBy15BGDzpBaAg8y11pL1Xfyjs+IYjrbZaBeqqsQTWAjfrIDW
         PbZZQe3yeWFUrjj+8J0ZA9cfEi78zwqmRkEyoqZ/x4vIVFvZiefLTke+PEW8JZ1lAVUX
         CejKXjrFDwCMc0YLQ28mywXyeShe4ainD8PS5Q4yy/RTMLnAg8Etu9AdkGgKFU+3cLNi
         48NWKOIBAvFD5VNu8Ev/HzVvw580dOPhbxmGamNJoFO3zoTdnJpUi9aFoSgHQjGoqLnZ
         GLqA==
X-Gm-Message-State: ANhLgQ1YpsAk1c7NocjuE4cDGjut1jT1TW5FmOmYnesvPUmGQVVe+aIh
        eSRggRFF62T48LeStsRanF8=
X-Google-Smtp-Source: ADFU+vvlagy4Ao6KsyQAplR0VBd9/BzhRXGrNvL42TrLHKgeU0S1Y8qBfwhjGq0U3pCP4+wfTR3rBA==
X-Received: by 2002:a63:5713:: with SMTP id l19mr2356319pgb.216.1583484697054;
        Fri, 06 Mar 2020 00:51:37 -0800 (PST)
Received: from guoguo-omen.lan ([240e:379:94a:b53:8200:7767:6b7e:4da3])
        by smtp.gmail.com with ESMTPSA id s23sm8527334pjp.28.2020.03.06.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 00:51:36 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/4] rewrite mtk-quadspi spi-nor driver with spi-mem
Date:   Fri,  6 Mar 2020 16:50:48 +0800
Message-Id: <20200306085052.28258-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset adds a spi-mem driver for Mediatek SPI-NOR controller,
which already has limited support by mtk-quadspi. This new driver can
make use of full quadspi capability of this controller.

1st new commit makes spi-max-frequency optional to match current
binding doc and make this new driver compatible with old driver dt
bindings.

Change since v2:
 revert binding example replacement and add a dummy irq binding

Changes since v1:
 two new commits.

Chuanhong Guo (4):
  spi: make spi-max-frequency optional
  spi: add support for mediatek spi-nor controller
  dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
  mtd: spi-nor: remove mtk-quadspi driver

 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   |  15 +-
 drivers/mtd/spi-nor/Kconfig                   |   8 -
 drivers/mtd/spi-nor/Makefile                  |   1 -
 drivers/mtd/spi-nor/mtk-quadspi.c             | 565 --------------
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mtk-nor.c                     | 689 ++++++++++++++++++
 drivers/spi/spi.c                             |   9 +-
 8 files changed, 708 insertions(+), 590 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (75%)
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/spi/spi-mtk-nor.c

-- 
2.24.1

