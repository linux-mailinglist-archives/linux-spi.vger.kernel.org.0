Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81815254CCC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgH0SSs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgH0SSr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 14:18:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330BC061264;
        Thu, 27 Aug 2020 11:18:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls14so3015609pjb.3;
        Thu, 27 Aug 2020 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzplqZpUWJg+UmQwey/x6RphVUW+awblL5IuecDIzI0=;
        b=go1nmKtWWgGZ3kW2g9FiK3bZiCSoxdxSKqHKlJ+S+OD3MdLhVL0wGrM3Qa5gWyh1Ey
         VsTZYbOSuqZg8uCCNj6+VghI0dKjk8Zs1uvqxy5xGwaLFxxoQdtIjTb4Ba52Ku4WUc7O
         sXazylyJuNC3ToATqO3lppxB3aRw54iWAH5iJY0VwJ7+GBJlrJ9/JjZtJiSwC0TSroqq
         vvrIpgMrn6DwNSfK29GFCsZI+RLZjXKk6Kk2DrZ8wm3/H10nctFbvffAxv1ayVIypYoo
         d9OSDTAOW6YbnqQN+ceVLEbUK6OTlDvN/hQVSNzpSo9fwO9OySS6fOOLE9KOS7i35aMC
         y5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzplqZpUWJg+UmQwey/x6RphVUW+awblL5IuecDIzI0=;
        b=OBQmcrDAgurTsnfD68fvVgd2GtZsr4b08hHI+eemThO9CqFimQaruZTPdvjFSgiB6p
         zWmPj/MabFly8V/sYuYoLkyaaV41htWVILklCkmvZA2FZDZsLkXouUJ09kCmHj6/imJK
         gERHVa3IE83LpPm7aBdzVYbMaD8iaFVza4JPZGO1K1nvGDKeNS8w9Dta8CsNH0x+/XT+
         wzzKxmM4xxW4SYIb1zudkWpcYkz/A4uVBvAompkspAQFMRlVMldub+XeNaDoOtx0miPk
         Ra/4cYuNhrWwvKc6HSrEBaLtX7/t95lS8s6R2Eb8FjOxO540xTxqphNcD8VQPVxQwVsO
         aGsg==
X-Gm-Message-State: AOAM530CVpQ1W4EgAw9QSYUL+ObWPD35Btp5nHzG73M2l261V/uwHoTJ
        v4O9aesiiFCpA/1DRsM8WdI=
X-Google-Smtp-Source: ABdhPJyNWwuvPIA9EDQkvsagVGkqnrgia8Y47+2tHmT2iIFXNFMuVBFIAJnLnw6rcvsASOFE0hcTlA==
X-Received: by 2002:a17:90b:30c6:: with SMTP id hi6mr111707pjb.172.1598552326889;
        Thu, 27 Aug 2020 11:18:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm3580179pfn.106.2020.08.27.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:18:46 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM SPI DRIVER),
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] qspi binding and DTS fixes
Date:   Thu, 27 Aug 2020 11:18:37 -0700
Message-Id: <20200827181842.1000451-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi all,

This patch series fixes incorrectly defined compatible strings for the
Broadcom QSPI controller which resulted in the strings not being
ordered from most to least compatible.

We will need to apply some changes to the spi-bcm-qspi.c driver in
the future to assume no revision register exist, and these patches
are a preliminary step towards that goal.

Florian Fainelli (5):
  dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
  ARM: dts: bcm: HR2: Fixed QSPI compatible string
  ARM: dts: NSP: Fixed QSPI compatible string
  ARM: dts: BCM5301X: Fixed QSPI compatible string
  arm64: dts: ns2: Fixed QSPI compatible string

 .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
 arch/arm/boot/dts/bcm-hr2.dtsi                   |  2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                   |  2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                  |  2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1

